Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E956E286DD1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 06:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgJHExw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 00:53:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgJHExw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 00:53:52 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E87D2087D;
        Thu,  8 Oct 2020 04:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602132831;
        bh=iqmUTBIDdUuqz2KotJy15SIZ9KrQbHnFX5lfzKeQ8X8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zktop6C6VdZF/5FN0Eciv9w+xFxDlnIdaILb/s9qtZBfyPx+q5D3Sx9GI8PWc20Ps
         hQlfzjctLAfe24Xcx/x3YsBmwEXtfmsGTxshPYNsdm44s7rvq2yGH0WFz6SZxj+TlJ
         op+mPvbi9XEOBV2WGzA2IQYp+l4tIcPrSXFrIOis=
Date:   Thu, 8 Oct 2020 06:54:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] misc: Kconfig: add a new dependency for HISI_HIKEY_USB
Message-ID: <20201008045435.GC163423@kroah.com>
References: <CALAqxLU672fOHudfvZWDEoO=fHYt79isz35e9EaJAsvTCg5How@mail.gmail.com>
 <0e49432d0db9ee8429a9923a1d995935b6b83552.1602047370.git.mchehab+huawei@kernel.org>
 <20201008021802.GA2858196@ubuntu-m3-large-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008021802.GA2858196@ubuntu-m3-large-x86>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 07:18:02PM -0700, Nathan Chancellor wrote:
> On Wed, Oct 07, 2020 at 07:09:54AM +0200, Mauro Carvalho Chehab wrote:
> > As warned by Randy:
> > 
> > 	on x86_64:
> > 	CONFIG_USB_ROLE_SWITCH=m
> > 	and HISI_HIKEY_USB=y.
> > 
> > 	ld: drivers/misc/hisi_hikey_usb.o: in function `hisi_hikey_usb_remove':
> > 	hisi_hikey_usb.c:(.text+0x61): undefined reference to `usb_role_switch_unregister'
> > 	ld: hisi_hikey_usb.c:(.text+0xa4): undefined reference to `usb_role_switch_put'
> > 	ld: drivers/misc/hisi_hikey_usb.o: in function `hub_usb_role_switch_set':
> > 	hisi_hikey_usb.c:(.text+0xd3): undefined reference to `usb_role_switch_get_drvdata'
> > 	ld: drivers/misc/hisi_hikey_usb.o: in function `relay_set_role_switch':
> > 	hisi_hikey_usb.c:(.text+0x54d): undefined reference to `usb_role_switch_set_role'
> > 	ld: drivers/misc/hisi_hikey_usb.o: in function `hisi_hikey_usb_probe':
> > 	hisi_hikey_usb.c:(.text+0x8a5): undefined reference to `usb_role_switch_get'
> > 	ld: hisi_hikey_usb.c:(.text+0xa08): undefined reference to `usb_role_switch_register'
> > 	ld: hisi_hikey_usb.c:(.text+0xa6e): undefined reference to `usb_role_switch_put'
> > 
> > Make it dependent on CONFIG_USB_ROLE_SWITCH.
> > 
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  drivers/misc/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index e19e1dcceb41..7cee2b72c09e 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -459,6 +459,7 @@ config PVPANIC
> >  config HISI_HIKEY_USB
> >  	tristate "USB GPIO Hub on HiSilicon Hikey 960/970 Platform"
> >  	depends on (OF && GPIOLIB) || COMPILE_TEST
> > +	depends on CONFIG_USB_ROLE_SWITCH
> 
> Shouldn't this be
> 
> depends on USB_ROLE_SWITCH
> 
> ? Now it will never be selectable.

{sigh}

Yes, that is correct.

Mauro, can you send a fix-up patch for this, as your original is now in
my tree.

thanks,

greg k-h
