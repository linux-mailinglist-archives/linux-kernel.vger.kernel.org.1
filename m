Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD872ADC9A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 18:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbgKJRH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 12:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKJRHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:07:55 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EDEC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 09:07:55 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id ay21so13544743edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 09:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2DzsxEVUbZIb01puXVW/bT3rEmRoPOpSkxNXqK+jRRY=;
        b=TdNHMW555gDky6SjR0G58meQPRqlxg1JQ1rt3295aYJO+Gw/LpbN9GuUZx2QGDlqgl
         wz6Rhyx27WSTiqj91khzN/mLXv6gmBf0zphzCz7zkGjlrH39CZgxSIDkjyM8lT/azwTD
         pmmWwb+s1/hS+nP/tuS/FZPkpejRpOuWcADgBInMAW5i2VZz1pOtzh2g3vh1Jx73TZmA
         x60uaS8hwcFowq045Tp5lc7vfqM14UEckO88ky0ZzmlBEHgvNJYszLYQY/N7vR2Z68ka
         yxM6Y9hO94JTwUpst08taegwSdDWDe+p/7A7hVQjTvPo8MboFNYwgHpvCg4bVUycy7DJ
         ut7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2DzsxEVUbZIb01puXVW/bT3rEmRoPOpSkxNXqK+jRRY=;
        b=D1e7GphjWkAXbvErEg809jeQQlVjnN/Cq/Z4WD97cJAK1MDn2j1S0vNYEB9w5EgsyH
         nNOgJW3U3/YPHqTyhlAuOvf6YCopX/Pbuaooi2+nv29MSKwHd0IXOey9cI7+uRoBTygw
         pcgeXlGq3YNlys9fBTPJoJ8TB8tYBi9C1cc+KQpRZ21qGrOSKDHwhGvgyXnTekRyzZBl
         FJHNA83pUsd8LBmbSHVZySoIGPjVH1IytJ4K6jeNnVPy7KLI/GHbHhKXEkZHW4+POXUW
         PRwCS/xFOyVs1V5URoKrAzyCv/h8K4o2RmHpuEdITfioq5Ietyr1VUnAf5xh04Wc07kh
         5VrQ==
X-Gm-Message-State: AOAM530PGw+FTTOw26RxJuLS/JRkZvTiYQLS0h/1O7a7zbv7e9XSLDWx
        owJ30cHilmtMKPKVLHGK8AoCjA==
X-Google-Smtp-Source: ABdhPJylWuiruvazVv99WQxmOkSKdiwJnj6Rtz31tRZOOPYXcUNuCp2KZ0oGRI2yXj5u69At4sCxYg==
X-Received: by 2002:a50:e183:: with SMTP id k3mr306629edl.111.1605028073766;
        Tue, 10 Nov 2020 09:07:53 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id d2sm5318702ejr.31.2020.11.10.09.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 09:07:52 -0800 (PST)
Subject: Re: [PATCH resend v2] microblaze: Replace <linux/clk-provider.h> by
 <linux/of_clk.h>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
References: <20201110154851.3285695-1-geert+renesas@glider.be>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <dc5ce0ab-289d-7fa4-97f5-ced102afbfbf@monstr.eu>
Date:   Tue, 10 Nov 2020 18:07:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201110154851.3285695-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10. 11. 20 16:48, Geert Uytterhoeven wrote:
> The MicroBlaze platform code is not a clock provider, and just needs to
> call of_clk_init().
> 
> Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
> v2:
>   - Add Reviewed-by.
> ---
>  arch/microblaze/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
> index 333b09658ca89105..7fcf5279ad15f61f 100644
> --- a/arch/microblaze/kernel/setup.c
> +++ b/arch/microblaze/kernel/setup.c
> @@ -9,7 +9,7 @@
>   */
>  
>  #include <linux/init.h>
> -#include <linux/clk-provider.h>
> +#include <linux/of_clk.h>
>  #include <linux/clocksource.h>
>  #include <linux/string.h>
>  #include <linux/seq_file.h>
> 

Applied.

M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

