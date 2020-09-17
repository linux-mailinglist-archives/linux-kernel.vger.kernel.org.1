Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E681026DDA9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgIQOMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:12:06 -0400
Received: from vps.xff.cz ([195.181.215.36]:33788 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbgIQOKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:10:48 -0400
X-Greylist: delayed 568 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 10:10:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1600351277; bh=qnHYhaaKVCCwO/ktdRKTzt/AgnNkQWX8+dKtOxokgRg=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=hLZ44t05ZmSFhok+LIFpDP7ZwXbyXheWfWYKIsYp4atU0ouWzSERQn/ZtReSUQ5hB
         gsfAyEsohXkb4W2IR+gGoTMEb0LP3gKztArv/hoUrQWI9BUN1OzngrNVdwaanLjuSd
         m1e+uSO33pzUbZuhdz1MbF1q26H0M23HYm/IQu5k=
Date:   Thu, 17 Sep 2020 16:01:17 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-sunxi@googlegroups.com, Lee Jones <lee.jones@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: sun4i-gpadc: Interrupt numbers should start from 1
Message-ID: <20200917140117.jowpyurs5pjyr2if@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Maxime Ripard <maxime@cerno.tech>, linux-sunxi@googlegroups.com,
        Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200912112200.226530-1-megous@megous.com>
 <20200917131904.d7yqpa2sucerg2nm@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917131904.d7yqpa2sucerg2nm@gilmour.lan>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maxime,

On Thu, Sep 17, 2020 at 03:19:04PM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Sat, Sep 12, 2020 at 01:22:00PM +0200, Ondrej Jirman wrote:
> > mfd: sun4i-gpadc: Interrupt numbers should start from 1
> 
> Why? An hwirq with 0 is totally fine
> 
> > This avoids a warning:
> > 
> > [    2.891592] ------------[ cut here ]------------
> > [    2.895052] WARNING: CPU: 0 PID: 149 at drivers/base/platform.c:317 __platform_get_irq_byname+0x7c/0x8c
> > [    2.903212] usb 1-1: new high-speed USB device number 2 using ehci-platform
> > [    2.908930] 0 is an invalid IRQ number
> > [    2.911425] Modules linked in: sun4i_gpadc_iio(+) r8188eu(C) lib80211 ohci_platform ohci_hcd ehci_platform ehci_hcd cyttsp4_i2c cyttsp_i2c_common cyttsp4_core g_cdc usb_f_acm u_serial usb_f_ecm u_ether libcomposite sunxi phy_generic musb_hdrc udc_core usbcore sun5ieink
> > [    2.934048] CPU: 0 PID: 149 Comm: tablet-init Tainted: G         C        5.8.0-rc2-00316-gc6a5213fdeba-dirty #8
> > [    2.943027] Hardware name: Allwinner sun4i/sun5i Families
> > [    2.947204] [<c010c080>] (unwind_backtrace) from [<c0109ee4>] (show_stack+0x10/0x14)
> > [    2.953714] [<c0109ee4>] (show_stack) from [<c012cd04>] (__warn+0xc0/0xd8)
> > [    2.959364] [<c012cd04>] (__warn) from [<c012cda0>] (warn_slowpath_fmt+0x84/0x94)
> > [    2.965599] [<c012cda0>] (warn_slowpath_fmt) from [<c0592a60>] (__platform_get_irq_byname+0x7c/0x8c)
> > [    2.973480] [<c0592a60>] (__platform_get_irq_byname) from [<c0592a80>] (platform_get_irq_byname+0x10/0x48)
> > [    2.981896] [<c0592a80>] (platform_get_irq_byname) from [<bf1142f0>] (sun4i_irq_init+0x38/0xe0 [sun4i_gpadc_iio])
> > [    2.990923] [<bf1142f0>] (sun4i_irq_init [sun4i_gpadc_iio]) from [<bf1145cc>] (sun4i_gpadc_probe+0x234/0x308 [sun4i_gpadc_iio])
> > [    3.001152] [<bf1145cc>] (sun4i_gpadc_probe [sun4i_gpadc_iio]) from [<c0592edc>] (platform_drv_probe+0x48/0x98)
> > [    3.010051] [<c0592edc>] (platform_drv_probe) from [<c0591074>] (really_probe+0x1e0/0x348)
> > [    3.017152] [<c0591074>] (really_probe) from [<c05912e8>] (driver_probe_device+0x5c/0xb4)
> > [    3.024081] [<c05912e8>] (driver_probe_device) from [<c05914e0>] (device_driver_attach+0x58/0x60)
> > [    3.031696] [<c05914e0>] (device_driver_attach) from [<c0591540>] (__driver_attach+0x58/0xcc)
> > [    3.038966] [<c0591540>] (__driver_attach) from [<c058f418>] (bus_for_each_dev+0x64/0x90)
> > [    3.045886] [<c058f418>] (bus_for_each_dev) from [<c0590490>] (bus_add_driver+0x15c/0x1e0)
> > [    3.052892] [<c0590490>] (bus_add_driver) from [<c0591dc4>] (driver_register+0x7c/0x114)
> > [    3.059731] [<c0591dc4>] (driver_register) from [<c0101674>] (do_one_initcall+0x44/0x194)
> > [    3.066696] [<c0101674>] (do_one_initcall) from [<c01946e8>] (do_init_module+0x5c/0x220)
> > [    3.073568] [<c01946e8>] (do_init_module) from [<c0196a3c>] (load_module+0x20ec/0x2380)
> > [    3.080340] [<c0196a3c>] (load_module) from [<c0196e04>] (sys_init_module+0x134/0x154)
> > [    3.087020] [<c0196e04>] (sys_init_module) from [<c0100060>] (ret_fast_syscall+0x0/0x54)
> > [    3.093852] Exception stack(0xc8ea7fa8 to 0xc8ea7ff0)
> > [    3.097649] 7fa0:                   00000000 00000000 b6fe2000 00003b14 00031284 00000005
> > [    3.104596] 7fc0: 00000000 00000000 b6fe2000 00000080 00052220 be9fd940 00052246 0000002e
> > [    3.111626] 7fe0: be9fd79c be9fd780 00015bd0 0001dcf4
> > [    3.115468] ---[ end trace df4dd47fb61bf5a4 ]---
> 
> In which situation?

During boot.

It's a new check added in Linux 5.8. https://elixir.bootlin.com/linux/latest/source/drivers/base/platform.c#L317

> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > ---
> >  include/linux/mfd/sun4i-gpadc.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
> > index ea0ccf33a459..021f820f9d52 100644
> > --- a/include/linux/mfd/sun4i-gpadc.h
> > +++ b/include/linux/mfd/sun4i-gpadc.h
> > @@ -81,8 +81,8 @@
> >  #define SUN4I_GPADC_TEMP_DATA				0x20
> >  #define SUN4I_GPADC_DATA				0x24
> >  
> > -#define SUN4I_GPADC_IRQ_FIFO_DATA			0
> > -#define SUN4I_GPADC_IRQ_TEMP_DATA			1
> > +#define SUN4I_GPADC_IRQ_FIFO_DATA			1
> > +#define SUN4I_GPADC_IRQ_TEMP_DATA			2
> 
> Where is it coming from, and why is it the proper fix?

Actual numbers seem irrelevant. It's just an index into this array:

https://elixir.bootlin.com/linux/latest/source/drivers/mfd/sun4i-gpadc.c#L27

The array will get sparse, but that doesn't seem like an issue to me,
because the irq code handles the holes in the list if mask is 0.

Not sure it's the best fix.

regards,
	o.

> Maxime


