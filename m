Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E93F286CAC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 04:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgJHCSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 22:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbgJHCSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 22:18:06 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBE7C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 19:18:05 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r10so2924345pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 19:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pCWWklQEyD5Vd4vsnaVJ4OFsn4I4bE1lumwE1Rw3LSc=;
        b=rgcNadTcAnKk4qrLOVs5Bk9jzPmRkEnNISULAdjbKtSUhfz00T5fXyXEQlcIhCzMXa
         9e3wdQ1qKL8RDN5oIi2xot8OEhjQEierRvsS/IgK8nmxBd6wWjCHiX8dFtm5yIVrJBPO
         SPJJIB76133Cx7xeBt2qO3RYJJ9Ikf5TEurrEemPV09ZuPAN4IK6xYD6C8o7dI5DRUsM
         oZtjt73coXSRTHBG5rti2D3scn3yVwXYOzsSjFfB6Tbyhe2FNgPbLDMpGSUvPIsJzuGq
         aJ4V5zKq68f8x+5yYBKAZImrLxATYaxZ9CM+iBuFlHf7WsIIq8gGeZJUV9N+10du8cLu
         H7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pCWWklQEyD5Vd4vsnaVJ4OFsn4I4bE1lumwE1Rw3LSc=;
        b=Sr3RlxxUywjD68mKDQlQJrEutR1zqv1m/tRAIaLoCuLifeMHrsi3qToo0jbqE3z5Mb
         /h+0k1inckOqs6Cs7t29PYZdjAtxpEWhzqdo96BTE8cF7EWppmsu+QWUL8Atj9lyWL+N
         eTRW5nFYVNlWuaNnQVlsFgfJl7N+ncic28opJawUJZAtc4dWk6nisTf5dR2aIc3ZBymn
         aJ1878bbhcsK+OKaFr4sxXzgJw3pV94bdj0ZifPWY3Cum0inQr+oXEDljNcKD8BDXiMS
         vQnrnpEHZnGS4HxIel7p1IRlTBvu9p5eRDyrNxYY6SflW3+PaHSxXTZ7Ql8X2/A6QJtG
         0Qwg==
X-Gm-Message-State: AOAM5312hmPWKWXckfFWeIKhraKSUH6lUD+lkpNaPZej4cUB9wM40kFb
        VwSwNHZNsckaxflBEFn2HUw=
X-Google-Smtp-Source: ABdhPJxF5opWhjNJ3D5s79NuaU4uPN/lWVmthXW9rbwv7q2I841fCiNAUOmNswoKibQ2elgPiP6UPA==
X-Received: by 2002:a63:24c2:: with SMTP id k185mr5624166pgk.421.1602123485239;
        Wed, 07 Oct 2020 19:18:05 -0700 (PDT)
Received: from ubuntu-m3-large-x86 ([2604:1380:45e1:2200::1])
        by smtp.gmail.com with ESMTPSA id 14sm4280965pjn.48.2020.10.07.19.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 19:18:04 -0700 (PDT)
Date:   Wed, 7 Oct 2020 19:18:02 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] misc: Kconfig: add a new dependency for HISI_HIKEY_USB
Message-ID: <20201008021802.GA2858196@ubuntu-m3-large-x86>
References: <CALAqxLU672fOHudfvZWDEoO=fHYt79isz35e9EaJAsvTCg5How@mail.gmail.com>
 <0e49432d0db9ee8429a9923a1d995935b6b83552.1602047370.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e49432d0db9ee8429a9923a1d995935b6b83552.1602047370.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 07:09:54AM +0200, Mauro Carvalho Chehab wrote:
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
> index e19e1dcceb41..7cee2b72c09e 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -459,6 +459,7 @@ config PVPANIC
>  config HISI_HIKEY_USB
>  	tristate "USB GPIO Hub on HiSilicon Hikey 960/970 Platform"
>  	depends on (OF && GPIOLIB) || COMPILE_TEST
> +	depends on CONFIG_USB_ROLE_SWITCH

Shouldn't this be

depends on USB_ROLE_SWITCH

? Now it will never be selectable.

>  	help
>  	  If you say yes here this adds support for the on-board USB GPIO hub
>  	  found on HiKey 960/970 boards, which is necessary to support
> -- 
> 2.26.2
> 

Cheers,
Nathan
