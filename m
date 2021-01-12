Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DAE2F32FB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731627AbhALOc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:32:57 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:35465 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbhALOc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:32:56 -0500
Received: by mail-oi1-f180.google.com with SMTP id s2so2526582oij.2;
        Tue, 12 Jan 2021 06:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IZuk/mHOHv9oOqm9OEs9XAwwEghxNlX5dG9b71FQWz8=;
        b=K/Hip4zDO1oaDaMlPM4D49dRqVDEdkVvb5l7/zv8xt/z13C+FU9z2n2Q0kqGlwuSGy
         fTPESNi+vQEel7vLclxlrwEWx8Zn4iT+7BQlHjzaS/AEmwH2CexeO6hZ3k1qvIOc4kEo
         gWMHbMyr+LEpsLCi74jOuP4QIzijBeKY/8tzeaDuobsOQR+BpRg4328ea81hc6xwr6eT
         XSA5ZrxLiK9fJsKJVbV8JOgnbhl81/zfHHIaN+lI445xlVz9QvVfaTA6tV8tyyIz/Xz9
         FxdpOCQS+39lRUW09RkxCNBV/yu4hZSpLWaP+m5K8VnkqJkLznmDfdSaBhJFhk1h5lGE
         Iq9g==
X-Gm-Message-State: AOAM530xsNNanCZldZSuCjfQtiLPYP+29jYQhbdZDshHAZa1WYNHuhbv
        FrcCgosPFu1Z8KzIyo9dsSOl5+YTbfaSkCUQDBk=
X-Google-Smtp-Source: ABdhPJwfXOujSxa/8EU2DdeDHzNZyY5y1pLT+qIzFNlgCU7jqkfp4b/X5RHCbD6MHekNLkabS3k/9hR0g9APD/UMLqg=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr2348858oig.69.1610461935229;
 Tue, 12 Jan 2021 06:32:15 -0800 (PST)
MIME-Version: 1.0
References: <X/ycQpu7NIGI969v@gerhold.net>
In-Reply-To: <X/ycQpu7NIGI969v@gerhold.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Jan 2021 15:32:04 +0100
Message-ID: <CAJZ5v0gAsZ45O8mv-gz0UvbyxnKA6fQBYvambBYEH6OSk3-m3g@mail.gmail.com>
Subject: Re: Infinite recursion in device_reorder_to_tail() due to circular
 device links
To:     Stephan Gerhold <stephan@gerhold.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 7:46 PM Stephan Gerhold <stephan@gerhold.net> wrote:
>
> Hi,
>
> since 5.11-rc1 I get kernel crashes with infinite recursion in
> device_reorder_to_tail() in some situations... It's a bit complicated to
> explain so I want to apologize in advance for the long mail. :)
>
>   Kernel panic - not syncing: kernel stack overflow
>   CPU: 1 PID: 33 Comm: kworker/1:1 Not tainted 5.11.0-rc3 #1
>   Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
>   Call trace:
>    ...
>    device_reorder_to_tail+0x4c/0xf0
>    device_reorder_to_tail+0x98/0xf0
>    device_reorder_to_tail+0x60/0xf0
>    device_reorder_to_tail+0x60/0xf0
>    device_reorder_to_tail+0x60/0xf0
>    ...
>
> The crash happens only in 5.11 with commit 5b6164d3465f ("driver core:
> Reorder devices on successful probe"). It stops happening when I revert
> this commit.

Thanks for the report!

Greg, please revert commit 5b6164d3465f, it clearly is not an
improvement, at least at this point.

> But I don't think this commit is the actual problem...

Well, it may not be the root cause, but it is a change in behavior
that exposes the breakage and this is not the only problem introduced
by it.

> It's easy to reproduce on any device based on the Qualcomm MSM8916 SoC
> by adding a random regulator to the USB node, e.g.:
>
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> index 3a9538e1ec97..9f43fce9e6e3 100644
> --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> @@ -372,6 +372,7 @@ codec {
>
>  &usb {
>         status = "okay";
> +       vbus-supply = <&pm8916_l5>;
>         extcon = <&usb_id>, <&usb_id>;
>
>         pinctrl-names = "default", "device";
>
> I searched for problems in the regulator core but the problem actually
> has nothing to do with regulators: The additional regulator supply just
> delays probing of the USB driver long enough to trigger the issue.
>
> Adding some debug output to device_reorder_to_tail() reveals that it
> keeps recursing over the same 4 devices:
>
>   msm_hsusb 78d9000.usb: device_reorder_to_tail()
>   ci_hdrc ci_hdrc.0: device_reorder_to_tail()
>   qcom_usb_hs_phy ci_hdrc.0.ulpi: device_reorder_to_tail()
>   phy phy-ci_hdrc.0.ulpi.0: device_reorder_to_tail()
>   msm_hsusb 78d9000.usb: device_reorder_to_tail()
>   ...
>
> The device hierarchy of these is (children devices):
>
>   78d9000.usb -> ci_hdrc.0 -> ci_hdrc.0.ulpi -> phy-ci_hdrc.0.ulpi.0
>
> ci_hdrc.0 calls phy_get(dev->parent, "usb-phy"). In phy_get(),
> the phy-core then attempts to add the following device link:
>
>   phy-ci_hdrc.0.ulpi.0 -> 78d9000.usb
>
> The device link creation in phy-core is optional (see commit 1d7cb11e1090
> ("phy: core: Fix phy_get() to not return error on link creation failure"))
> because this device link is circular in case of ULPI PHYs (like here).
>
> And indeed, creating this device link usually fails (as it should).
> However, adding the "vbus-supply" changes probe order in some way that
> this circular device link ends up being created:
>   /sys/class/devlink/phy-ci_hdrc.0.ulpi.0--78d9000.usb/ exists only when
> I add the "vbus-supply" as in the diff above.
>
> Apparently, there is a special situation where device_is_dependent()
> does not work properly, and therefore the driver core allows creating
> the circular device link.
>
> To show the problem, I enabled some debug messages and added the
> following log message:
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 25e08e5f40bd..ff1344eabb31 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3089,9 +3089,11 @@ int device_add(struct device *dev)
>         }
>
>         bus_probe_device(dev);
> -       if (parent)
> +       if (parent) {
> +               dev_info(dev, "add to parent %s\n", dev_name(parent));
>                 klist_add_tail(&dev->p->knode_parent,
>                                &parent->p->klist_children);
> +       }
>
>         if (dev->class) {
>                 mutex_lock(&dev->class->p->mutex);
>
> Running this with "vbus-supply" (where it crashes) produces:
>
>      bus: 'platform': probing driver msm_hsusb with device 78d9000.usb
>        <some probe deferrals while waiting for the regulator>
>      bus: 'platform': probing driver msm_hsusb with device 78d9000.usb
>      bus: 'platform': probing driver ci_hdrc with device ci_hdrc.0
>      bus: 'ulpi': probing driver qcom_usb_hs_phy with device ci_hdrc.0.ulpi
>      phy phy-ci_hdrc.0.ulpi.0: add to parent ci_hdrc.0.ulpi
>      qcom_usb_hs_phy ci_hdrc.0.ulpi: add to parent ci_hdrc.0
>  (1) msm_hsusb 78d9000.usb: Linked as a consumer to phy-ci_hdrc.0.ulpi.0
>  (2) ci_hdrc ci_hdrc.0: add to parent 78d9000.usb
>      Kernel panic - not syncing: kernel stack overflow
>       ...
>
> Note how ci_hdrc is added to the children list of 78d9000.usb (2) after
> the device link was already created in (1). This is why device_is_dependent()
> does not realize the devices will eventually be dependent on each other.

Well, it cannot know beforehand that the consumer is going to be
registered as a child of the supplier.

> Without "vbus-supply" (2) happens before (1) because then the PHY driver
> requests probe deferral a few times while waiting for regulators.
>
> I'm not really sure what to do here, any suggestions how to fix this properly?

Clearly, device_add() needs to check if there is a device link between
dev and dev->parent, but it is not so clear what to do if such a link
is present.

I would make it return an error in that case.

> (In case it helps, I have attached an example kernel module (circdl.c)
>  that allows reproducing the exact same crash.)

IMV the bug is in the code that attempts to create a device link
before registering the child and it clearly shows that creating device
links from unregistered consumers is not really a good idea in
general.

In principle, a device link creation flag to instruct
device_link_add() to fail if the consumer is not registered can be
added and it can be used by the code in question if that helps.
