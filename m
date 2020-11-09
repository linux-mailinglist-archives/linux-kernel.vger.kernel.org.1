Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D562AC248
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbgKIRaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731963AbgKIRaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:30:23 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1867C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 09:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=FZOT73lbMAFEKrGbrMeabXGp+60AMfcqRIYD1WOf6RY=; b=g5WZ2UpS2+NiIsgWDSI8fmjIVN
        ya4aLUvL6IRwZs5PQHR6d2c0bZxYWLcyYiBC+FI0Xf9IK+G97hnV5K98bQ+UVA3Ih2YQ8gz9JFhcr
        +DJyQwZFrZBreW4ar3mnDQB/+7sTUyqmFFJXhAtnjVDIjYxsvWP9izbVeBPiwtZIUN83MpxvRfNjB
        HPLv4mNkmlbjmpVCJw/B9Bs+nKA+hANM++llfTENNucjkeMae9aaIsnBhh24hvXUr9m2KZ55+8amP
        6cOWWMCOTOY/4PeOZJWGzCmp+i6hghGiPk1/7+f9+Wo96QpSRt8+3JrXzAcPUiykE5MarlbBLFiTt
        UQT+5AVQ==;
Received: from [2601:1c0:6280:3f0::662d]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcAzk-0004es-TH; Mon, 09 Nov 2020 17:30:21 +0000
Subject: Re: [PATCH] auxdisplay: hd44780_common: Fix build error
To:     poeschel@lemonage.de,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <76f9cd1b-3ace-e8a8-aaee-8d64e0900603@infradead.org>
 <20201109093154.1080024-1-poeschel@lemonage.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9afaeba0-6e83-cdc2-07f8-3bac5553208b@infradead.org>
Date:   Mon, 9 Nov 2020 09:30:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201109093154.1080024-1-poeschel@lemonage.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/20 1:31 AM, poeschel@lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> 
> When building the hd44780_common driver without a driver that actually
> uses it like panel or hd44780 you got a build error, because
> hd44780_common uses charlcd, but did not select it. It's users did
> select it.
> This is fixed now. hd4478_common now selects charlcd in Kconfig and
> panel and hd44780 do not. They only select hd44780_common.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/auxdisplay/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
> index a69623124a26..a2b59b84bb88 100644
> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -27,6 +27,7 @@ config CHARLCD
>  
>  config HD44780_COMMON
>  	tristate "Common functions for HD44780 (and compatibles) LCD displays" if COMPILE_TEST
> +	select CHARLCD
>  	help
>  	  This is a module with the common symbols for HD44780 (and compatibles)
>  	  displays. This is the code that multiple other modules use. It is not
> @@ -37,7 +38,6 @@ config HD44780_COMMON
>  config HD44780
>  	tristate "HD44780 Character LCD support"
>  	depends on GPIOLIB || COMPILE_TEST
> -	select CHARLCD
>  	select HD44780_COMMON
>  	help
>  	  Enable support for Character LCDs using a HD44780 controller.
> @@ -196,7 +196,6 @@ config ARM_CHARLCD
>  menuconfig PARPORT_PANEL
>  	tristate "Parallel port LCD/Keypad Panel support"
>  	depends on PARPORT
> -	select CHARLCD
>  	select HD44780_COMMON
>  	help
>  	  Say Y here if you have an HD44780 or KS-0074 LCD connected to your
> 


-- 
~Randy
