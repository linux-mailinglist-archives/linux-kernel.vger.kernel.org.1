Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAEF2ACA86
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 02:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbgKJBeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 20:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730035AbgKJBeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 20:34:22 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87779C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 17:34:22 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id d28so4938087qka.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 17:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=10Hl6Ts9GS4xnp8YyN8GkEdT4icF3hx2dzGGYENprl0=;
        b=OCA2WaDJIem7cTicNyloGzI8+NoNA+QNIXuzrg2q54Wwa1foQajmlrejv7+PfkNlni
         pJQW2sNszmbPTuXZo2qDBKr/54+D4TJ/E49qNpSHIXeHN5FdD95mwR9KbL5ulGTNMEnq
         80ffbQ8Ns3MjskdNJPXAWptUoKEq/kyE8trvk2SE5vqeprzVL5moLCxEULpjs7pxndIm
         APLJRmE7IEMBh4wb5iZoxbxWjHH2tr40TCp7yUbPstFttheBEt8t/1dIKhsazbC8iZGj
         Ut2osPWuDCUXDzaDkscgM7An4y3RdOgni1uIaQ31I88peotx2PdyXdjYaOBiH04DAUsS
         puAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=10Hl6Ts9GS4xnp8YyN8GkEdT4icF3hx2dzGGYENprl0=;
        b=qy2cPUgsLe2QjYy6DHP4sbnAcpSyQgEXePJkMBRXOFcjmyKmACBJS9jeYHaMTk/rSX
         tVxHU0iu2zoFY9zQBnQfETk9IcrcP8jgjQ5v65c8ch2tDrIOvdubgHnHqoHhksHv5xoP
         2yh17hqgXpBfiLCET9aX73eKOna+39z1580f43xqSOd6bqhNDWTDVYS6sq9zlMka4T9V
         1WUaabAQhjR+5ZaV64XxZsTz7MRhrqucXCgnCjqkeNrSjYK5qbmXmRbPfTEb23gdIbgD
         gMHgdYt7Bialpc7yxbXFxs5w/Ex49573NyAqDpXF3TP/ygMudCTJi4J+dlflNGX3b5cB
         RT+Q==
X-Gm-Message-State: AOAM530HQpYhjAf+4+0WX0ackneewkgB5Hgdc6RWMc3NGvIvPhc8afN+
        e8kaFqyWW6pAAs3FwhoEGgI=
X-Google-Smtp-Source: ABdhPJzUNkFITAFNxhcLgQQS9Ml9daL9QjGCaeyUlX39XuMJYBan90w/ldLzLrSRssb57sLtcE51bg==
X-Received: by 2002:a05:620a:22d4:: with SMTP id o20mr16383285qki.151.1604972061776;
        Mon, 09 Nov 2020 17:34:21 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id v78sm4864976qkb.128.2020.11.09.17.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 17:34:21 -0800 (PST)
Date:   Mon, 9 Nov 2020 18:34:19 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Fangrui Song <maskray@google.com>,
        Jian Cai <jiancai@google.com>,
        Peter Smith <peter.smith@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ARM: Kconfig: CPU_BIG_ENDIAN depends on !LD_IS_LLD
Message-ID: <20201110013419.GA2443932@ubuntu-m3-large-x86>
References: <20201109224713.16308-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109224713.16308-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 02:47:12PM -0800, Nick Desaulniers wrote:
> LLD does not yet support any big endian architectures. Make this config
> non-selectable when using LLD until LLD is fixed.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/965
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

I tested allyesconfig, allmodconfig, and about ten to fifteen
randconfigs and never saw CONFIG_CPU_BIG_ENDIAN appear.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  arch/arm/mm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 65e4482e3849..02692fbe2db5 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -743,6 +743,7 @@ config SWP_EMULATE
>  config CPU_BIG_ENDIAN
>  	bool "Build big-endian kernel"
>  	depends on ARCH_SUPPORTS_BIG_ENDIAN
> +	depends on !LD_IS_LLD
>  	help
>  	  Say Y if you plan on running a kernel in big-endian mode.
>  	  Note that your board must be properly built and your board
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 
