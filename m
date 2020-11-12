Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2185A2B0C1E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgKLSBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgKLSBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 13:01:37 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB88C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 10:01:36 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id j31so4614151qtb.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 10:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U/n0GaULRIPoW1TWIaMvg2AjJJpGn7IEqvwF77+rhVY=;
        b=OjmTkPxL6pUQKN4d+tiqTrfq1FM1TDEsWnn0GF4+v6FSghv0yXVf3Xixg36v44Op+n
         d3jlRbOwcH6R6gSABo1E7qSoSoEftfr58Xx/7DsWU1pyvkQ6c15pmy5SLEIdbouiOflO
         WRZ6sPSZ38i+GorunQ9krGpx50C5bc6EU9wj6wwH7CD40RoOeygiYXaf2TWjtMPqxJu5
         QeLK3UmEHpwGiarWfRbpjDdGoyh9+wznwJJPU619INsWbvoBuxWEPYQXVbSiwxn9fGxN
         Dj9AK0NUxP3vGANLBFPSkzPda0DyJvhTpECHP2W6WMaeCs9zIgsFMSLIFGBShpu6UcSQ
         9UfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U/n0GaULRIPoW1TWIaMvg2AjJJpGn7IEqvwF77+rhVY=;
        b=jwfI7xLUI6ZcCBW579t93chOyrPAqMBPOsVPTDEVV/wfsiIrjs0MY0ow3EkkxWQ/sT
         2ipvSDp9NEGvGyZIx9xuOUNC2KvOe2g+Ms6rYellnf8XS/qhvBUmtDr17VAEo4sCwKlt
         ZijUgpGZjCa5cAa8p6qq7xIu7nqeORH5Q21AB3LbS4B5d6QDleSpcMUQ5T/Hq7LOjJF5
         2/utFhxBV5iPGCAx14iwHQsa6tsV4eH+HATxxpIFgdpEVc1wkrufI5B2TmwTHRWyAoBz
         BqZ3xlQCH76NiI7PyV5ImipU26K2G+gHNKIqNHA9WMi7O38TRN5uIWr77bogE5oBmBkd
         D1Ag==
X-Gm-Message-State: AOAM533V6m0yxAuJcggnmJudIy5ApoJMKmpQQLtaEYVLmFPLOQ/Fz6pw
        kNyOnHxAblHjAv6MD+8P9Ac=
X-Google-Smtp-Source: ABdhPJxntIcXZu1zMPdLwAjh6OHWOPanbHQmI+P4WX2+xor9ZXSXWfsHkyF87qBmXVw/SUsrZZutFw==
X-Received: by 2002:ac8:6799:: with SMTP id b25mr337543qtp.115.1605204096085;
        Thu, 12 Nov 2020 10:01:36 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id d82sm5244325qkc.14.2020.11.12.10.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 10:01:35 -0800 (PST)
Date:   Thu, 12 Nov 2020 11:01:33 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        clang-built-linux@googlegroups.com,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: unwind: remove old check for GCC <= 4.2
Message-ID: <20201112180133.GB934688@ubuntu-m3-large-x86>
References: <20201111025120.1694158-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111025120.1694158-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 06:51:20PM -0800, 'Nick Desaulniers' via Clang Built Linux wrote:
> Since
> commit 0bddd227f3dc ("Documentation: update for gcc 4.9 requirement")
> the minimum supported version of GCC is gcc-4.9. It's now safe to remove
> this code.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/427
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  arch/arm/kernel/unwind.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
> index f35eb584a18a..59fdf257bf8b 100644
> --- a/arch/arm/kernel/unwind.c
> +++ b/arch/arm/kernel/unwind.c
> @@ -18,9 +18,6 @@
>  #warning Your compiler does not have EABI support.
>  #warning    ARM unwind is known to compile only with EABI compilers.
>  #warning    Change compiler or disable ARM_UNWIND option.
> -#elif (__GNUC__ == 4 && __GNUC_MINOR__ <= 2) && !defined(__clang__)
> -#warning Your compiler is too buggy; it is known to not compile ARM unwind support.
> -#warning    Change compiler or disable ARM_UNWIND option.
>  #endif
>  #endif /* __CHECKER__ */
>  
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 
