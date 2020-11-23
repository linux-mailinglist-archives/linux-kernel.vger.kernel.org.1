Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA882C12F4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 19:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbgKWSQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730522AbgKWSQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:16:07 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937ABC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 10:16:05 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id u184so3273093qkf.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 10:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n6ql3VbjYT3UQMZEAEWSAAKb2v1qSJpb45k+j/2GXXM=;
        b=eJDt8chJwEwQb4BqRB/iAFPtMcipaJigu/nYu8excAJUkwmXCUx6VWL5tq6do8TxUw
         waCqY2pD3H+R3Rzt+uIAEvZbMoTJC7awNdirtc9o8kDQetJtFoiDi7ADcyjHE8tdPPoJ
         eUMYCpGe+EFBMX59FUX8gLbOFc4s11FEExP2QDvzgBatfT4sO43Ym6R7qFHqxgHg9uTb
         PnLcVq4W3VPSplFkW1+FjxZaTYIenVx7c3wUuQMpoOibEb8y+R5T2VRxqe+7l5efNOlD
         JISITbdHvCG9YCyAjIXiogEbYeGg7LhsYKv64cMVxTG5oAKDMM4B63YudPJlBKu4YikM
         YQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n6ql3VbjYT3UQMZEAEWSAAKb2v1qSJpb45k+j/2GXXM=;
        b=KiS5cq3wYa9b5Upkn9EIZSXISChJkupWA2uTIN0XF2osqhOQPWLJ7TSnfFz/1o3H5c
         HRgdqc4j4S1NPFbJnt0cZlTxQJLVvR+jAtXli4xxYYFmabKQPVpbfIePxb7HbFbsnTSr
         4Q1P2Vt63zTjUOkhtCNCXxyPQVl8FaFkl8ITxRPBeV4dkVkbD4jLTb7dBHOE3AimcHci
         dGHNIkoNV4xmsltFwUvD76qGKcNDow9BuF9toXbFav7uvbjiKfG/DGjhvvRy13v6C4Am
         GsMi2oHMcGT/xeHflLEfz/vyMzPW9ZLGkGxskFTQMjQ2olABs6yGWlG/TmsfRJfq1b7J
         Ph0Q==
X-Gm-Message-State: AOAM533S5n1KO4UH/IKd7vCtJBEbwPGWAtRhj2YoSW2rUEmOGog3uoD1
        NQUzjARI9yUudNinkUmwB8E=
X-Google-Smtp-Source: ABdhPJzycUOxZG+7eq7Vxqy//dkWVKBJkpC4RER+mv98oDlBI9Mb3knAdF14SNIlusDqgX4QSGG/JA==
X-Received: by 2002:a37:e40b:: with SMTP id y11mr744826qkf.29.1606155364813;
        Mon, 23 Nov 2020 10:16:04 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id g9sm10211626qti.86.2020.11.23.10.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 10:16:03 -0800 (PST)
Date:   Mon, 23 Nov 2020 11:16:02 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Antony Yu <swpenim@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [RESEND,PATCH] ARM: fix __div64_32() error when compiling with
 clang
Message-ID: <20201123181602.GA2637357@ubuntu-m3-large-x86>
References: <20201123073634.6854-1-swpenim@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123073634.6854-1-swpenim@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 03:36:32PM +0800, Antony Yu wrote:
> __do_div64 clobbers the input register r0 in little endian system.
> According to the inline assembly document, if an input operand is
> modified, it should be tied to a output operand. This patch can
> prevent compilers from reusing r0 register after asm statements.
> 
> Signed-off-by: Antony Yu <swpenim@gmail.com>
> ---
>  arch/arm/include/asm/div64.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
> index 898e9c78a7e7..809efc51e90f 100644
> --- a/arch/arm/include/asm/div64.h
> +++ b/arch/arm/include/asm/div64.h
> @@ -39,9 +39,10 @@ static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
>  	asm(	__asmeq("%0", __xh)
>  		__asmeq("%1", "r2")
>  		__asmeq("%2", "r0")
> -		__asmeq("%3", "r4")
> +		__asmeq("%3", "r0")
> +		__asmeq("%4", "r4")
>  		"bl	__do_div64"
> -		: "=r" (__rem), "=r" (__res)
> +		: "=r" (__rem), "=r" (__res), "=r" (__n)
>  		: "r" (__n), "r" (__base)
>  		: "ip", "lr", "cc");
>  	*n = __res;
> -- 
> 2.23.0
> 

I am not sure that I am qualified to review this (my assembly knowledge
is not the best) but your commit title mentions an error when compiling
with clang. What is the exact error, what configuration generates it,
and what version of clang? We have done fairly decent testing for
32-bit ARM, I would like to know what we are missing.

Cheers,
Nathan
