Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F3D2BAB22
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 14:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgKTNbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 08:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbgKTNbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 08:31:37 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57623C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 05:31:37 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id t9so9515163edq.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 05:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V2LVrCoXAZgfkykMj7CvkovonpKX+foU2OBadTMRae4=;
        b=ZeRvPdovjk2Uug9lZhJB9OGJEBjTmTqmeknhMOx4GUXoO8fXL1pI1WNRy3VPkawi46
         y9cSgnHGu786guwBmgIjisJ1qTGzBalxS55zWFQMVTOAuYcqwaGQ1wMAw0peVIlgEiMn
         6HdlEk4/QOTWHPAbqIApChLHIcPTXdVPwrKxbfz4VF0FSGEk6+KbSpKGgLxvWkRDiy4d
         HwqA1Bsv5Pc2GIqFtwxu4//CCDRct7FMtJhMqwuRzyzTZ2nmRGecgUbvm7zNIYlekHRB
         sD/fGLpbjM/EWSrm+Z0M0oiADsJyzFSPhhF09LE3OvXoGqrfZ2m8BAImLkvIAJIyFU9D
         AB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V2LVrCoXAZgfkykMj7CvkovonpKX+foU2OBadTMRae4=;
        b=A5+Su4dkU+NPX2eFkgDgeQY/WF9raRY3JvAW5OxxurG5pEeaIKiZB+urXOc0zacnFd
         lfl5pr3IrnK6wmPv6zNWAgWrsomVFMKmSBsozEC9Wu7ZSE7Vy58yP18MGA5OQVezYb9a
         Pm6cDhfn7TkSEQOx8mA6BicVhT0iGMr0buo+e+EdJ1d2f4O5kMjbU5Z4JZUlfvSvCdkE
         TyTLzNuiEkK0NygeK9APOhlkHdtaiQlSls9DdK3EGO42yZPoqiLz/LWFPsbWZgYGfcks
         vr1ifAuZ7yl7xyqb/cr+UVwyLv8OyKbfJRgNKpTuKH0pV0SKWMRP2Kf3xmrkZiL2fwhz
         HF4A==
X-Gm-Message-State: AOAM5322rqjA7JsbCWfzCDMNivuFjy44/3uqrESBv2aSsMQC3a+pSm+q
        zqBJ62JXom7EO69UhJ1uKTbW2Omo4KTHWSfu
X-Google-Smtp-Source: ABdhPJwJpbV82H8ilmC18oT4LOrQqTTkOO8hBblXFsSFKb2F/1FLikMJQ8Dvo9MsPYs1grtzaptJLA==
X-Received: by 2002:a05:6402:1d82:: with SMTP id dk2mr13293791edb.366.1605879095666;
        Fri, 20 Nov 2020 05:31:35 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id x20sm1130500ejv.66.2020.11.20.05.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 05:31:35 -0800 (PST)
To:     Youling Tang <tangyouling@loongson.cn>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org
References: <1605750037-433-1-git-send-email-tangyouling@loongson.cn>
From:   Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH] microblaze: Use the common INIT_DATA_SECTION macro in
 vmlinux.lds.S
Message-ID: <d513f0d1-1cfd-9f71-f12e-1b53689ef073@monstr.eu>
Date:   Fri, 20 Nov 2020 14:31:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1605750037-433-1-git-send-email-tangyouling@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 11. 20 2:40, Youling Tang wrote:
> Use the common INIT_DATA_SECTION rule for the linker script in an effort
> to regularize the linker script.
> 
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>  arch/microblaze/kernel/vmlinux.lds.S | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)
> 
> diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
> index df07b3d..527ebfc 100644
> --- a/arch/microblaze/kernel/vmlinux.lds.S
> +++ b/arch/microblaze/kernel/vmlinux.lds.S
> @@ -96,10 +96,7 @@ SECTIONS {
>  	__init_begin = .;
>  
>  	INIT_TEXT_SECTION(PAGE_SIZE)
> -
> -	.init.data : AT(ADDR(.init.data) - LOAD_OFFSET) {
> -		INIT_DATA
> -	}
> +	INIT_DATA_SECTION(0)
>  
>  	. = ALIGN(4);
>  	.init.ivt : AT(ADDR(.init.ivt) - LOAD_OFFSET) {
> @@ -107,25 +104,6 @@ SECTIONS {
>  		*(.init.ivt)
>  		__ivt_end = .;
>  	}
> -
> -	.init.setup : AT(ADDR(.init.setup) - LOAD_OFFSET) {
> -		INIT_SETUP(0)
> -	}
> -
> -	.initcall.init : AT(ADDR(.initcall.init) - LOAD_OFFSET ) {
> -		INIT_CALLS
> -	}
> -
> -	.con_initcall.init : AT(ADDR(.con_initcall.init) - LOAD_OFFSET) {
> -		CON_INITCALL
> -	}
> -
> -	__init_end_before_initramfs = .;
> -
> -	.init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) {
> -		INIT_RAM_FS
> -	}
> -
>  	__init_end = .;
>  
>  	.bss ALIGN (PAGE_SIZE) : AT(ADDR(.bss) - LOAD_OFFSET) {
> 

Thanks for the patch but I can't accept it because recently we found
that there needs to be some resorting in linker to be able to boot.
The issue is that INIT_RAMFS_FS section is text/data/init and bss.
But because microblaze in early code is using two TLBs (16M) each for
early mapping and you have big initramfs bss section is unreachable.
That's why these sections needs to be swapped.
Maybe bss section can be moved up before INIT_DATA_SECTION maybe even
before INIT_TEXT_SECTION and we should be fine.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



