Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD692D627D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392172AbgLJQvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392166AbgLJQuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:50:52 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0709DC061793
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:50:12 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id w3so5468270otp.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UBLaL7YZ1GGECPgOBT1EJ5LhKuRi5V9cp7gn+yeFOUQ=;
        b=P+uvOS9+LWsyGj+Wq3aGAouUojcU+dMLpTEvls3nCRHYK1Tuv3ZAkcvpXT/uMW8LUb
         jk8bV/PA0c3iZZWdfTICdTr72D0JsAi9UVuXSckNlemsQ6/ZL9R+sBSwUlQXn5g/1jRg
         DgBl4R+/kdP4/zoj4k+42Q9IPFRT2qvqguJX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UBLaL7YZ1GGECPgOBT1EJ5LhKuRi5V9cp7gn+yeFOUQ=;
        b=EHyp5MyW+B5imqmuTqmtpsOvxBF5ThXcIDVE/k9cwH9cUlYAtnlIyayoTgrxiYtUQK
         rtUKh53IoYVS7oXSOCJNAZQrB8boVdnFuEqAsUHee0xxMP/e42LOT++iaxiOllhNZ42y
         tdlH1/jD/hxLS73p0vhlECfjDe6vYqeklW1TGCnM2PceLi9ro9mcj75Km2qHr05/w3ps
         6EEdrOekktA+1a7nDN72oMn4yYRqDq7P5d4txf7scTrvpTCMoVJlyb6HbPQ/vzzRGKYU
         +NCS34+NI+yUqBEmNw+VYs2qxAQ5AKYoKfGZXJ2QyNw40LWHugY+NGHwy1LYn92KREC6
         hsGQ==
X-Gm-Message-State: AOAM533IIaRhCDuttUQ7NQ32+U1sgY0GU2dRAvnCQtQ4QYIkoT5uV47Y
        EOd+VYJErlJSsTdAkyD/9yCt9bTZsaTCC/aflR8ydQ==
X-Google-Smtp-Source: ABdhPJwrnnHRRE6j2JA6cxdDRMX5rfza9+UwCzUpuWTkRvvPfxu3RJBlliAH2d+LUdiOjMEq4L7zuzPKY4ehrd1qF/k=
X-Received: by 2002:a9d:4e08:: with SMTP id p8mr6463548otf.188.1607619011364;
 Thu, 10 Dec 2020 08:50:11 -0800 (PST)
MIME-Version: 1.0
References: <20201208044446.973238-1-bjorn.andersson@linaro.org>
 <X891/LvEJT1bLtjH@ulmo> <X8/36HXL1IYPXA0J@builder.lan> <20201208235249.GD401619@phenom.ffwll.local>
 <X9EzYtuR+EwliYrv@builder.lan> <20201210101538.GD401619@phenom.ffwll.local> <X9JQeYim6TQIPD1P@ulmo>
In-Reply-To: <X9JQeYim6TQIPD1P@ulmo>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 10 Dec 2020 17:50:00 +0100
Message-ID: <CAKMK7uGGnt6A89OohW8mi4pSvjvemW-=_oAOFUVye+qxnO5W=g@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/panel: Make backlight attachment lazy
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 5:44 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Thu, Dec 10, 2020 at 11:15:38AM +0100, Daniel Vetter wrote:
> > On Wed, Dec 09, 2020 at 02:28:18PM -0600, Bjorn Andersson wrote:
> > > On Tue 08 Dec 17:52 CST 2020, Daniel Vetter wrote:
> > >
> > > > On Tue, Dec 08, 2020 at 04:02:16PM -0600, Bjorn Andersson wrote:
> > > > > On Tue 08 Dec 06:47 CST 2020, Thierry Reding wrote:
> > > > >
> > > > > > On Mon, Dec 07, 2020 at 10:44:46PM -0600, Bjorn Andersson wrote:
> > > > > > > Some bridge chips, such as the TI SN65DSI86 DSI/eDP bridge, provides
> > > > > > > means of generating a PWM signal for backlight control of the attached
> > > > > > > panel. The provided PWM chip is typically controlled by the
> > > > > > > pwm-backlight driver, which if tied to the panel will provide DPMS.
> > > > > > >
> > > > > > > But with the current implementation the panel will refuse to probe
> > > > > > > because the bridge driver has yet to probe and register the PWM chip,
> > > > > > > and the bridge driver will refuse to probe because it's unable to find
> > > > > > > the panel.
> > > > > >
> > > > > > What you're describing is basically a circular dependency. Can't we get
> > > > > > rid of that in some other way? Why exactly does the bridge driver refuse
> > > > > > to probe if the panel can't be found?
> > > > > >
> > > > > > In other words, I see how the bridge would /use/ the panel in that it
> > > > > > forward a video stream to it. But how does the panel /use/ the bridge?
> > > > > >
> > > > >
> > > > > Yes, this is indeed a circular dependency between the components.
> > > > >
> > > > > The involved parts are:
> > > > > * the bridge driver that implements the PWM chip probe defers on
> > > > >   drm_of_find_panel_or_bridge() failing to find the panel.
> > > > > * the pwm-backlight driver that consumes the PWM channel probe defer
> > > > >   because the pwm_chip was not registered by the bridge.
> > > > > * the panel that uses the backlight for DPMS purposes probe defer
> > > > >   because drm_panel_of_backlight() fails to find the pwm-backlight.
> > > > >
> > > > > I looked at means of postponing drm_of_find_panel_or_bridge() to
> > > > > drm_bridge_funcs->attach(), but at that time "deferral" would be fatal.
> > > > > I looked at registering the pwm_chip earlier, but that would depend on a
> > > > > guarantee of the pwm-backlight and panel driver to probe concurrently.
> > > > > And the current solution of not tying the backlight to the panel means
> > > > > that when userspace decides to DPMS the display the backlight stays on.
> > > > >
> > > > >
> > > > > The proposed solution (hack?) means that DPMS operations happening
> > > > > before the pwm-backlight has probed will be missed, so it's not perfect.
> > > > > It does however allow the backlight on my laptop to turn off, which is a
> > > > > big improvement.
> > > > >
> > > > > But I'm certainly welcome to suggestions.
> > > >
> > > > Entirely hand-waving, why doesn't the following work:
> > > >
> > > > 1. driver for the platform device which is the bridge loads
> > > > 2. that platform driver registers the pwm
> > > > 3. it registers some magic for later on (more below)
> > > > 4. panel driver has deferred loading until step 2 happened
> > > > 5. panel driver registers drm_panel
> > > > 6. the magic from step 3 picks up (after having been deferred for a few
> > > > times probably) grabs the panel, and sets up the actual drm_bridge driver
> > > >
> > > > Everyone happy, or not? From the description it looks like the problem
> > > > that the pwm that we need for the backlight is tied to the same driver as
> > > > the drm_bridge, and always torn down too if the drm_bridge setup fails
> > > > somehow for a reason. And that reason is the circular dependency this
> > > > creates.
> > > >
> > > > Now for the magic in step 3, there's options:
> > > > - change DT to split out that pwm as a separate platform_device, that way
> > > >   bridge and panel can load indepedently (hopefully)
> > > >
> > >
> > > This is an i2c device, so describing it multiple times would mean we
> > > have multiple devices with the same address...
> > >
> > > > - convert bridge to a multi-function device (mfd), essentially a way to
> > > >   instantiate more devices with their drivers at runtime. Then the actual
> > > >   pwm and drm_bridge parts of your bridge driver bind against those
> > > >   sub-functions, and can defer indepedently
> > > >
> > >
> > > But, this sounds reasonable and would rely on the existing probe
> > > deferral logic and if there's ever any improvements in this area we
> > > would directly benefit from it.
> > >
> > > > - we could create a callback/wait function for "pls wait for any panel to
> > > >   show up". Then your bridge driver could launch a work_struct with that
> > > >   wait function, which will do the bridge setup once the panel has shown
> > > >   up. The pwm will be registered right away. It's essentially hand-rolling
> > > >   EPROBE_DEFERRED for work_struct in drm/panel. Maybe we might even have
> > > >   that exported from the driver core, e.g.
> > > >
> > > > register_bridge_fn(struct work *)
> > > > {
> > > >   do_wait_probe_defer();
> > > >   panel = drm_of_find_panel_or_bridge();
> > > >   if (!panel) {
> > > >           schedule_work(); /* want to restart the work so it can be stopped on driver unload */
> > > >           return;
> > > >   }
> > > >
> > > >   /* we have the panel now, register drm_bridge */
> > > > }
> > > >
> > > > - cobble something together with component.c, but that's more for
> > > >   collecting unrelated struct device into a logical one than splitting it
> > > >   up more.
> > > >
> > > > tldr; I think you can split this loop here at the bridge by untangling the
> > > > pwm from the drm_bridge part sufficiently.
> > >
> > > Yes, it seems like a reasonable path forward. But I wanted some input
> > > before refactoring the whole thing.
> >
> > Yeah it's unfortunately a bit of work. But I think it's the proper
> > approach since EPROBE_DEFERRED is fundamentally linked to struct device
> > and bound drivers. So we do need a struct device for every part in our
> > dependency graph to make sure we can resolve the dependencies all
> > correctly with reprobing.
>
> Can we not turn things around and make the bridge driver independent of
> the panel? To me it sounds like these loosely follow a hierarchy where
> it makes sense to probe the bridge first, without any dependency on the
> panel that's being used. I think this makes sense because this example
> shows that panels may depend on resources provided by the bridge. In
> this case it's a backlight, but I could also imagine the bridge
> providing some sort of I2C bus that the panel driver may need to use in
> order to query the panel's EDID.
>
> The way I imagine that this would work is that the panel would probe
> separately from the bridge driver but use the OF graph to look up the
> bridge that has the resources (backlight, I2C bus, ...) that it needs to
> proceed. As long as that bridge has not been probed, the panel would
> need to defer, which is the standard way that provider/consumer pairs
> work. Once the bridge has probed, the panel can also proceed to probe
> because it can now find the necessary resources.

Yeah that might be the other option, treat the panel as a bridge (we
have the panel bridge already), then build up the entire thing as a
bridge chain. Not sure how much this is "just works" territory or not.

> The only missing thing that I don't think we have right now is a way for
> the panel to then register with its parent bridge, but that should be
> fairly easy to add. I suspect this might get a bit tricky around the
> connector state paths because we can now get into a situation where the
> connector can have a complete bridge path set up but may be missing the
> panel (which I think in the current model can't happen because the
> bridge always relies on the panel being there, although it sounds like
> it could happen with Daniel's proposal as well). But that ultimately is
> not very different from how we deal with monitors on more standard
> interfaces like HDMI or DP where we emit a hotplug event when the
> monitor becomes available, so perhaps that infrastructure could be
> reused for this.

Generally we try really hard to make sure panels are always there and
never hotplug in/out. Not sure whether there's even userspace/desktops
relying on this. So hotplugging the panel later on does not sound
good. Bjorn's patch here does a light version of that with the
backlight, and we're having this sprawling thread because that's bit
suboptimal - userspace could boot real fast, see there's no backlight,
and then not expose backlight adjusters if we're unlucky.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
