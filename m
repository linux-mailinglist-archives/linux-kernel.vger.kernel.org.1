Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96667286E23
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 07:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgJHFff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 01:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgJHFfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 01:35:34 -0400
Received: from coco.lan (ip5f5ad5d8.dynamic.kabel-deutschland.de [95.90.213.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1264E2173E;
        Thu,  8 Oct 2020 05:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602135334;
        bh=Ic98mOfd8ebs7YEQON4Ia2bQdUNG7KyXDI/VEuyis9I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jPMmd4Vu3PDxQnKT03ISmLlTJWkAxaJv3QTCha9QPDYIDue1MNT6Qo/dQYKeTjfRQ
         FyoTnX62SoO4uP7Z/rFHX5NquLngipNIBo2LxRQjIt09OkCHWbrjVbAPMq5hSLgrlZ
         4XGsTa9Y3zk9M8AVaiwr+OLXEpju+5YQ2noug0xA=
Date:   Thu, 8 Oct 2020 07:35:28 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: Kconfig: add a new dependency for HISI_HIKEY_USB
Message-ID: <20201008073528.6cc14961@coco.lan>
In-Reply-To: <2992583d-1954-b329-86bc-c61aa35040dd@infradead.org>
References: <CALAqxLU672fOHudfvZWDEoO=fHYt79isz35e9EaJAsvTCg5How@mail.gmail.com>
        <0e49432d0db9ee8429a9923a1d995935b6b83552.1602047370.git.mchehab+huawei@kernel.org>
        <20201008021802.GA2858196@ubuntu-m3-large-x86>
        <2992583d-1954-b329-86bc-c61aa35040dd@infradead.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 7 Oct 2020 19:52:56 -0700
Randy Dunlap <rdunlap@infradead.org> escreveu:

> On 10/7/20 7:18 PM, Nathan Chancellor wrote:
> > On Wed, Oct 07, 2020 at 07:09:54AM +0200, Mauro Carvalho Chehab wrote:  
> >> As warned by Randy:
> >>
> >> 	on x86_64:
> >> 	CONFIG_USB_ROLE_SWITCH=m
> >> 	and HISI_HIKEY_USB=y.
> >>
> >> 	ld: drivers/misc/hisi_hikey_usb.o: in function `hisi_hikey_usb_remove':
> >> 	hisi_hikey_usb.c:(.text+0x61): undefined reference to `usb_role_switch_unregister'
> >> 	ld: hisi_hikey_usb.c:(.text+0xa4): undefined reference to `usb_role_switch_put'
> >> 	ld: drivers/misc/hisi_hikey_usb.o: in function `hub_usb_role_switch_set':
> >> 	hisi_hikey_usb.c:(.text+0xd3): undefined reference to `usb_role_switch_get_drvdata'
> >> 	ld: drivers/misc/hisi_hikey_usb.o: in function `relay_set_role_switch':
> >> 	hisi_hikey_usb.c:(.text+0x54d): undefined reference to `usb_role_switch_set_role'
> >> 	ld: drivers/misc/hisi_hikey_usb.o: in function `hisi_hikey_usb_probe':
> >> 	hisi_hikey_usb.c:(.text+0x8a5): undefined reference to `usb_role_switch_get'
> >> 	ld: hisi_hikey_usb.c:(.text+0xa08): undefined reference to `usb_role_switch_register'
> >> 	ld: hisi_hikey_usb.c:(.text+0xa6e): undefined reference to `usb_role_switch_put'
> >>
> >> Make it dependent on CONFIG_USB_ROLE_SWITCH.
> >>
> >> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> >> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >> ---
> >>  drivers/misc/Kconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> >> index e19e1dcceb41..7cee2b72c09e 100644
> >> --- a/drivers/misc/Kconfig
> >> +++ b/drivers/misc/Kconfig
> >> @@ -459,6 +459,7 @@ config PVPANIC
> >>  config HISI_HIKEY_USB
> >>  	tristate "USB GPIO Hub on HiSilicon Hikey 960/970 Platform"
> >>  	depends on (OF && GPIOLIB) || COMPILE_TEST
> >> +	depends on CONFIG_USB_ROLE_SWITCH  
> > 
> > Shouldn't this be
> > 
> > depends on USB_ROLE_SWITCH  
> 
> Obviously. Thanks for catching that.
> 
> > ? Now it will never be selectable.

Thanks for catching this one! Sent a v2 fixing this.
(and double-checked that the driver was built after the
changes).

Thanks,
Mauro
