Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC3E285845
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 07:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgJGFxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 01:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJGFxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 01:53:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A038C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 22:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=dMgDek2qfxDXt5KRIJzWX8HE5kLI0vm+FklHHFh5l6E=; b=BfORlm65MZZQ9xnzTcsxhPUfnk
        ynTHhCXSkDcPqNG/RPbEVo9l2ueTeOonbPlbaqNCnwcYUx/Z0OWy+wsyAXqrCbgsa1uICiNe9TiSj
        Tkn37VQKPjEaDQiGGw2HZMaZPPi6LMI6G6paho9T+2d0nD8tjmJvV2gq1S/Kn31QT0JbW9kxsxG+4
        DX3t5QKZ9s6ScI34s239ujhJVY13VkFRzDwFqAIDXjrWarKGQtyKGqnB/k3ST8NBzpASmhW7fCyPA
        uXu5LH89BCgbRaEk/QjUB70KVeC4yqBrOocK8IVbX/iJmQDBrnZ+V0n4W5cQp+N9Q93co07OxCxgH
        MJ5CKe7A==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQ2O5-0004aj-Et; Wed, 07 Oct 2020 05:53:17 +0000
Subject: Re: [PATCH] misc: Kconfig: add a new dependency for HISI_HIKEY_USB
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org
References: <CALAqxLU672fOHudfvZWDEoO=fHYt79isz35e9EaJAsvTCg5How@mail.gmail.com>
 <0e49432d0db9ee8429a9923a1d995935b6b83552.1602047370.git.mchehab+huawei@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9baa3873-d5c7-20c9-4ab1-6dfe2f3a82af@infradead.org>
Date:   Tue, 6 Oct 2020 22:53:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <0e49432d0db9ee8429a9923a1d995935b6b83552.1602047370.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/20 10:09 PM, Mauro Carvalho Chehab wrote:
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

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

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
>  	help
>  	  If you say yes here this adds support for the on-board USB GPIO hub
>  	  found on HiKey 960/970 boards, which is necessary to support
> 


-- 
~Randy
