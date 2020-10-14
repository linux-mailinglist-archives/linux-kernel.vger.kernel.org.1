Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BE328EB21
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 04:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbgJOCYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 22:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729901AbgJOCYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 22:24:37 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F7FC05BD31
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 15:49:12 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gv6so629093pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 15:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=73JDK6v9QIywlQAL1ojHAWu8vRvKniVaMQhT9AVQkgM=;
        b=Xiw0SX12te2H7unG0PW7k/KDxUZJqZb5kGC4j352+pdUtyhY3eZe/RclVKos04VObp
         mf+x2YyvDzI5Ik3UZzDFmDrX7FcS/7sA3PxWZ6U5hpwDTt9i4/2blfvsBVY9nqQH/5rp
         HouHNDN1JpRuMXtKKKFag3SRoJuNJQv3vA0zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=73JDK6v9QIywlQAL1ojHAWu8vRvKniVaMQhT9AVQkgM=;
        b=tPP4koK+j3kdD9+uVUQYesuEZ23do05zIUsRQbS94FmX3UwVJ7U6qe1lYkvpWDJsX5
         IgIXlI/33qytkSYepSejtWIYzeivOQKyokNKtPg70S8J6nj/ZQ3gw2tbgDWOcKAKoAqQ
         X0RVUPxeT4QCUetepJYzALrLFW6n14kTCGWSqADtr1cSjsuqNGdY3MogmfkTs2Rdb6ys
         vdGCKMfQjAulaxUQiHInlNKy9tBwnBSBNmoP0PunxYJhds8UJvp1yC8xRv1XPxn0Y81W
         xUes8exO9kr+EnEcmwo5e6g0RTtjhd7aWHrQVaRB12TGs81BSXfzx2jKsZZAUrPAPX+T
         rcRQ==
X-Gm-Message-State: AOAM533hTxrDF+8vku+Rhr3FN0X6BqoGQLRWv+aJtR8dIBlQX/Mevug8
        AueEA+PGPnnDvzvJkTM3lLwF4w==
X-Google-Smtp-Source: ABdhPJxSM90nZhUVG0O6sO50Xgaa+D7fRK95gdDff9gylp7HlrlNT4+Iuxg9mylfSVrF1VzMLrV6Tg==
X-Received: by 2002:a17:90a:f685:: with SMTP id cl5mr1325486pjb.210.1602715751992;
        Wed, 14 Oct 2020 15:49:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e16sm675880pjr.36.2020.10.14.15.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 15:49:11 -0700 (PDT)
Date:   Wed, 14 Oct 2020 15:49:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v6 13/25] kbuild: lto: merge module sections
Message-ID: <202010141548.47CB1BC@keescook>
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-14-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013003203.4168817-14-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 05:31:51PM -0700, Sami Tolvanen wrote:
> LLD always splits sections with LTO, which increases module sizes. This
> change adds linker script rules to merge the split sections in the final
> module.
> 
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  scripts/module.lds.S | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> index 69b9b71a6a47..037120173a22 100644
> --- a/scripts/module.lds.S
> +++ b/scripts/module.lds.S
> @@ -25,5 +25,33 @@ SECTIONS {
>  	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
>  }
>  
> +#ifdef CONFIG_LTO_CLANG

In looking at this again -- is this ifdef needed? Couldn't this be done
unconditionally? (Which would make it an independent change...)

-Kees

> +/*
> + * With CONFIG_LTO_CLANG, LLD always enables -fdata-sections and
> + * -ffunction-sections, which increases the size of the final module.
> + * Merge the split sections in the final binary.
> + */
> +SECTIONS {
> +	__patchable_function_entries : { *(__patchable_function_entries) }
> +
> +	.bss : {
> +		*(.bss .bss.[0-9a-zA-Z_]*)
> +		*(.bss..L*)
> +	}
> +
> +	.data : {
> +		*(.data .data.[0-9a-zA-Z_]*)
> +		*(.data..L*)
> +	}
> +
> +	.rodata : {
> +		*(.rodata .rodata.[0-9a-zA-Z_]*)
> +		*(.rodata..L*)
> +	}
> +
> +	.text : { *(.text .text.[0-9a-zA-Z_]*) }
> +}
> +#endif
> +
>  /* bring in arch-specific sections */
>  #include <asm/module.lds.h>
> -- 
> 2.28.0.1011.ga647a8990f-goog
> 

-- 
Kees Cook
