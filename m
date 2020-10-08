Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F058286E69
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 08:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgJHGOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 02:14:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgJHGOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 02:14:02 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30B2020782;
        Thu,  8 Oct 2020 06:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602137639;
        bh=vYXy6Uc6b5xyr/26Dw1YYbYrFHcPMX/s11AKY/pH/no=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YCMrleuRxG3wSqbocUGvEP90p04NChRbWm7grW+7qcyXBGa2FA1LJwBO/TSrn6VyG
         QbGFlVwRia509wK5C0CCrho1Jve/gQt8mXtemgRoGdI+78ob0pn6yAh5fb8SAvDqMy
         hq5KA8of1mKmQeX6A6m/JIujdffbsIQdwnICdm6U=
Date:   Thu, 8 Oct 2020 08:14:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] misc: Kconfig: add a new dependency for HISI_HIKEY_USB
Message-ID: <20201008061443.GB172088@kroah.com>
References: <fed9c0d3538eae7adf9e876fd4c93c2afb3ac31b.1602135021.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fed9c0d3538eae7adf9e876fd4c93c2afb3ac31b.1602135021.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 07:30:27AM +0200, Mauro Carvalho Chehab wrote:
> As warned by Randy:
> 
> 	on x86_64:
> 	CONFIG_USB_ROLE_SWITCH=m
> 	and HISI_HIKEY_USB=y.
> 
> 	ld: drivers/misc/hisi_hikey_usb.o: in function `hisi_hikey_usb_remove':
> 	hisi_hikey_usb.c:(.text+0x61): undefined reference to `usb_role_switch_unregister'
> 	ld: hisi_hikey_usb.c:(.text+0xa4): undefined reference to `usb_role_switch_put'
> 	ld: drivers/misc/hisi_hikey_usb.o: in function `hub_usb_role_switch_set':
> 	hisi_hikey_usb.c:(.text+0xd3): undefined reference to `usb_role_switch_get_drvdata'
> 	ld: drivers/misc/hisi_hikey_usb.o: in function `relay_set_role_switch':
> 	hisi_hikey_usb.c:(.text+0x54d): undefined reference to `usb_role_switch_set_role'
> 	ld: drivers/misc/hisi_hikey_usb.o: in function `hisi_hikey_usb_probe':
> 	hisi_hikey_usb.c:(.text+0x8a5): undefined reference to `usb_role_switch_get'
> 	ld: hisi_hikey_usb.c:(.text+0xa08): undefined reference to `usb_role_switch_register'
> 	ld: hisi_hikey_usb.c:(.text+0xa6e): undefined reference to `usb_role_switch_put'
> 
> Make it dependent on CONFIG_USB_ROLE_SWITCH.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/misc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index e19e1dcceb41..d5ce8082b0a0 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -459,6 +459,7 @@ config PVPANIC
>  config HISI_HIKEY_USB
>  	tristate "USB GPIO Hub on HiSilicon Hikey 960/970 Platform"
>  	depends on (OF && GPIOLIB) || COMPILE_TEST
> +	depends on USB_ROLE_SWITCH
>  	help
>  	  If you say yes here this adds support for the on-board USB GPIO hub
>  	  found on HiKey 960/970 boards, which is necessary to support

I can't rebase my tree, so can you send the fix-up patch instead, with
the proper "reported-by:"?

thanks,

greg k-h
