Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82F12F49F2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbhAMLVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:21:47 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:19072 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbhAMLVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:21:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610536732;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:From:
        Subject:Sender;
        bh=nsDb8x4hTCohhBNqJWCQzT458Xwpc2DEiFndwzvFoM8=;
        b=cbSDaLs/8QIPmCBKwRr5OR58ygkja13qckibRjC2bsz07/NsYgKQXwQ5wgcqJAEZJ7
        LUSOvG2R0IDUOjdb72OITriru2xlbw3Pl0yRQy3NadDlT4MrofdfvScWBRHa3cptlI+2
        f4Cyhb9Wm+QCLmYcIgG5BLODGLXNYeJ0lU0mg4kI/vZLyFZNAN/AqUk8+mooYcPLajOE
        yp4fAeYSLBsQo+i2MxmQAph+wpjkkbGNvUuch+WEXY8jjYMMs9lYZ0ALnrEZFqj2XiNg
        qh4zsnksqEb14toFgX6Cvox9IdWly7uP5RuAa6ZV4jqemXyNeY1/K5jR3+9HxvFnAC2O
        D0Gg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j4IcrMBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id R0a218x0DBIkSXJ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 13 Jan 2021 12:18:46 +0100 (CET)
Date:   Wed, 13 Jan 2021 12:18:35 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Thierry Reding <treding@nvidia.com>
Subject: Re: Infinite recursion in device_reorder_to_tail() due to circular
 device links
Message-ID: <X/7XCzdDG7kbiNfM@gerhold.net>
References: <X/ycQpu7NIGI969v@gerhold.net>
 <CAJZ5v0gAsZ45O8mv-gz0UvbyxnKA6fQBYvambBYEH6OSk3-m3g@mail.gmail.com>
 <CAJZ5v0h8bNp-=1zVfY5gZ1ezr8JRV4L8cEV45e+0f-aRSJnb1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h8bNp-=1zVfY5gZ1ezr8JRV4L8cEV45e+0f-aRSJnb1A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 07:24:24PM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 12, 2021 at 3:32 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, Jan 11, 2021 at 7:46 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> > >
> > > Hi,
> > >
> > > since 5.11-rc1 I get kernel crashes with infinite recursion in
> > > device_reorder_to_tail() in some situations... It's a bit complicated to
> > > explain so I want to apologize in advance for the long mail. :)
> > >
> > >   Kernel panic - not syncing: kernel stack overflow
> > >   CPU: 1 PID: 33 Comm: kworker/1:1 Not tainted 5.11.0-rc3 #1
> > >   Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> > >   Call trace:
> > >    ...
> > >    device_reorder_to_tail+0x4c/0xf0
> > >    device_reorder_to_tail+0x98/0xf0
> > >    device_reorder_to_tail+0x60/0xf0
> > >    device_reorder_to_tail+0x60/0xf0
> > >    device_reorder_to_tail+0x60/0xf0
> > >    ...
> > >
> > > The crash happens only in 5.11 with commit 5b6164d3465f ("driver core:
> > > Reorder devices on successful probe"). It stops happening when I revert
> > > this commit.
> >
> > Thanks for the report!
> >
> > Greg, please revert commit 5b6164d3465f, it clearly is not an
> > improvement, at least at this point.
> >

Thanks a lot for the quick reply and for reverting the patch!

> > > But I don't think this commit is the actual problem...
> >
> > Well, it may not be the root cause, but it is a change in behavior
> > that exposes the breakage and this is not the only problem introduced
> > by it.
> >
> > > It's easy to reproduce on any device based on the Qualcomm MSM8916 SoC
> > > by adding a random regulator to the USB node, e.g.:
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > > index 3a9538e1ec97..9f43fce9e6e3 100644
> > > --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > > @@ -372,6 +372,7 @@ codec {
> > >
> > >  &usb {
> > >         status = "okay";
> > > +       vbus-supply = <&pm8916_l5>;
> > >         extcon = <&usb_id>, <&usb_id>;
> > >
> > >         pinctrl-names = "default", "device";
> > >
> > > I searched for problems in the regulator core but the problem actually
> > > has nothing to do with regulators: The additional regulator supply just
> > > delays probing of the USB driver long enough to trigger the issue.
> > >
> > > Adding some debug output to device_reorder_to_tail() reveals that it
> > > keeps recursing over the same 4 devices:
> > >
> > >   msm_hsusb 78d9000.usb: device_reorder_to_tail()
> > >   ci_hdrc ci_hdrc.0: device_reorder_to_tail()
> > >   qcom_usb_hs_phy ci_hdrc.0.ulpi: device_reorder_to_tail()
> > >   phy phy-ci_hdrc.0.ulpi.0: device_reorder_to_tail()
> > >   msm_hsusb 78d9000.usb: device_reorder_to_tail()
> > >   ...
> > >
> > > The device hierarchy of these is (children devices):
> > >
> > >   78d9000.usb -> ci_hdrc.0 -> ci_hdrc.0.ulpi -> phy-ci_hdrc.0.ulpi.0
> > >
> > > ci_hdrc.0 calls phy_get(dev->parent, "usb-phy"). In phy_get(),
> > > the phy-core then attempts to add the following device link:
> > >
> > >   phy-ci_hdrc.0.ulpi.0 -> 78d9000.usb
> > >
> > > The device link creation in phy-core is optional (see commit 1d7cb11e1090
> > > ("phy: core: Fix phy_get() to not return error on link creation failure"))
> > > because this device link is circular in case of ULPI PHYs (like here).
> > >
> > > And indeed, creating this device link usually fails (as it should).
> > > However, adding the "vbus-supply" changes probe order in some way that
> > > this circular device link ends up being created:
> > >   /sys/class/devlink/phy-ci_hdrc.0.ulpi.0--78d9000.usb/ exists only when
> > > I add the "vbus-supply" as in the diff above.
> > >
> > > Apparently, there is a special situation where device_is_dependent()
> > > does not work properly, and therefore the driver core allows creating
> > > the circular device link.
> > >
> > > To show the problem, I enabled some debug messages and added the
> > > following log message:
> > >
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index 25e08e5f40bd..ff1344eabb31 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -3089,9 +3089,11 @@ int device_add(struct device *dev)
> > >         }
> > >
> > >         bus_probe_device(dev);
> > > -       if (parent)
> > > +       if (parent) {
> > > +               dev_info(dev, "add to parent %s\n", dev_name(parent));
> > >                 klist_add_tail(&dev->p->knode_parent,
> > >                                &parent->p->klist_children);
> > > +       }
> > >
> > >         if (dev->class) {
> > >                 mutex_lock(&dev->class->p->mutex);
> > >
> > > Running this with "vbus-supply" (where it crashes) produces:
> > >
> > >      bus: 'platform': probing driver msm_hsusb with device 78d9000.usb
> > >        <some probe deferrals while waiting for the regulator>
> > >      bus: 'platform': probing driver msm_hsusb with device 78d9000.usb
> > >      bus: 'platform': probing driver ci_hdrc with device ci_hdrc.0
> > >      bus: 'ulpi': probing driver qcom_usb_hs_phy with device ci_hdrc.0.ulpi
> > >      phy phy-ci_hdrc.0.ulpi.0: add to parent ci_hdrc.0.ulpi
> > >      qcom_usb_hs_phy ci_hdrc.0.ulpi: add to parent ci_hdrc.0
> > >  (1) msm_hsusb 78d9000.usb: Linked as a consumer to phy-ci_hdrc.0.ulpi.0
> > >  (2) ci_hdrc ci_hdrc.0: add to parent 78d9000.usb
> > >      Kernel panic - not syncing: kernel stack overflow
> > >       ...
> > >
> > > Note how ci_hdrc is added to the children list of 78d9000.usb (2) after
> > > the device link was already created in (1). This is why device_is_dependent()
> > > does not realize the devices will eventually be dependent on each other.
> >
> > Well, it cannot know beforehand that the consumer is going to be
> > registered as a child of the supplier.
> 
> I've got it the other way around, so it should have been:
> 
> "it cannot know beforehand that the supplier is going to be registered
> as a child of the consumer."
> 
> Sorry.
> 
> That said, device_is_dependend() doesn't really check for "family
> connections", so to speak, which it should do in principle.
> 
> That is, it should return "true" if "target" or any direct ancestor of
> it is any of the devices that depend on "dev", not just when "target"
> itself is any of those devices.
> 
> Let me cut a patch for that.

Thanks!

While initially debugging the crash I naively(!) tried the following
two diffs:

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 14f165816742..3864af018834 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3088,10 +3088,10 @@ int device_add(struct device *dev)
 		fw_devlink_link_device(dev);
 	}
 
-	bus_probe_device(dev);
 	if (parent)
 		klist_add_tail(&dev->p->knode_parent,
 			       &parent->p->klist_children);
+	bus_probe_device(dev);
 
 	if (dev->class) {
 		mutex_lock(&dev->class->p->mutex);

or alternatively

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 14f165816742..268b88ce3df7 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -218,12 +218,16 @@ int device_links_read_lock_held(void)
  */
 int device_is_dependent(struct device *dev, void *target)
 {
+	struct device *target_dev = target;
 	struct device_link *link;
 	int ret;
 
 	if (dev == target)
 		return 1;
 
+	if (target_dev->parent && device_is_dependent(dev, target_dev->parent))
+		return 1;
+
 	ret = device_for_each_child(dev, target, device_is_dependent);
 	if (ret)
 		return ret;

Both prevent the circular device link and therefore also the crash.
I didn't mention it because it was really just a naive thought and
I'm sure they might cause other problems. :-)

Also, on a completely different note I looked again at the chipidea USB
driver that produces this situation. To request the PHY (which ends up
in the circular device link) it does:

	/* Look for a generic PHY first */
	ci->phy = devm_phy_get(dev->parent, "usb-phy");

To me it doesn't really seem great to use the devm_* helpers on the
parent device either, so I will check if I can refactor this somehow.
Perhaps this situation can be prevented entirely.

Thanks!
Stephan
