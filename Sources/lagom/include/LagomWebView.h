#ifndef LAGOM_WEB_VIEW_H
#define LAGOM_WEB_VIEW_H

#include <AK/RefCounted.h>
#include <LibGfx/Color.h>
#include <LibGfx/Point.h>
#include <LibGfx/Rect.h>
#include <LibGfx/Size.h>
#include <LibWebView/ViewImplementation.h>

#import <Cocoa/Cocoa.h>
#import <swift/bridging>

class WebViewBridge : public WebView::ViewImplementation
    , public RefCounted<WebViewBridge> {
public:
    virtual Gfx::IntRect viewport_rect() const override { return viewport_rect_trampoline(); }
    virtual Gfx::IntPoint to_content_position(Gfx::IntPoint widget_position) const override { return to_content_position_trampoline(widget_position); }
    virtual Gfx::IntPoint to_widget_position(Gfx::IntPoint content_position) const override { return to_widget_position_trampoline(content_position); }
    virtual void create_client(WebView::EnableCallgrindProfiling) override { create_client_trampoline(); }
    virtual void update_zoom() override { update_zoom_trampoline(); }

    Function<Gfx::IntRect(void)> viewport_rect_trampoline;
    Function<Gfx::IntPoint(Gfx::IntPoint)> to_content_position_trampoline;
    Function<Gfx::IntPoint(Gfx::IntPoint)> to_widget_position_trampoline;
    Function<void(void)> create_client_trampoline;
    Function<void(void)> update_zoom_trampoline;

    static WebViewBridge* _Nonnull create() { return new WebViewBridge; }

} SWIFT_SHARED_REFERENCE(retain_WebViewBridge, release_WebViewBridge);

inline void retain_WebViewBridge(WebViewBridge* obj)
{
    obj->ref();
}

inline void release_WebViewBridge(WebViewBridge* obj)
{
    obj->unref();
}

namespace Ladybird {

Gfx::IntRect ns_rect_to_gfx_rect(NSRect rect)
{
    return {
        static_cast<int>(rect.origin.x),
        static_cast<int>(rect.origin.y),
        static_cast<int>(rect.size.width),
        static_cast<int>(rect.size.height),
    };
}

NSRect gfx_rect_to_ns_rect(Gfx::IntRect rect)
{
    return NSMakeRect(
        static_cast<CGFloat>(rect.x()),
        static_cast<CGFloat>(rect.y()),
        static_cast<CGFloat>(rect.width()),
        static_cast<CGFloat>(rect.height()));
}

Gfx::IntSize ns_size_to_gfx_size(NSSize size)
{
    return {
        static_cast<int>(size.width),
        static_cast<int>(size.height),
    };
}

NSSize gfx_size_to_ns_size(Gfx::IntSize size)
{
    return NSMakeSize(
        static_cast<CGFloat>(size.width()),
        static_cast<CGFloat>(size.height()));
}

Gfx::IntPoint ns_point_to_gfx_point(NSPoint point)
{
    return {
        static_cast<int>(point.x),
        static_cast<int>(point.y),
    };
}

NSPoint gfx_point_to_ns_point(Gfx::IntPoint point)
{
    return NSMakePoint(
        static_cast<CGFloat>(point.x()),
        static_cast<CGFloat>(point.y()));
}

Gfx::Color ns_color_to_gfx_color(NSColor* color)
{
    auto rgb_color = [color colorUsingColorSpace:NSColorSpace.genericRGBColorSpace];
    if (rgb_color != nil)
        return {
            static_cast<u8>([rgb_color redComponent] * 255),
            static_cast<u8>([rgb_color greenComponent] * 255),
            static_cast<u8>([rgb_color blueComponent] * 255),
            static_cast<u8>([rgb_color alphaComponent] * 255)
        };
    return {};
}

NSColor* gfx_color_to_ns_color(Gfx::Color color)
{
    return [NSColor colorWithRed:(color.red() / 255.f)
                           green:(color.green() / 255.f)
                            blue:(color.blue() / 255.f)
                           alpha:(color.alpha() / 255.f)];
}
}

#endif
