Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078112F3732
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbhALRcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbhALRcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:32:20 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992C3C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:31:40 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l23so2129691pjg.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gszL2E3VdL8RsIgnFpVUkcrAEKhs/wMGNVMIkIbtCio=;
        b=kXriF6lXXgicCw5/Lb3CqFuEtYLcY/CIJbgbkwvRS82DfY2tqQoot3SCGYJmO+caZc
         DlsJizP1kcplvgKi2Kxlnwio7DPWXT1k8qtzDAesiJCdc++uwb9iJa9Q1otIrNOpuhV0
         vjEsgrkFMeOj8tkTeSppZ2fh8AfPQpkrrx8fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gszL2E3VdL8RsIgnFpVUkcrAEKhs/wMGNVMIkIbtCio=;
        b=I7VNW5Z7hosVxFKa1tz84ylVLYK/BFMsEQldFL+fk/KOd8yce39+vj/HFbHlUUuHd2
         XHcY1s+3URqsmUSY5Pd7oXV58fabSbSPdUP4eqzxK2uOf5QO8slyRxAT/rPvzxwWN7L6
         xXRl062N0aFuvQjtVkuzu05G+mGyo6Eykam9eOTn0uO1eOhZc0t0FgGAsCwrgBxPjYc1
         ksiEIrSJE3kyajQN5n5ya6gMw5Ai/0t7F+Kfs+AXH9bsUXplNf8pzO9gpR0TbUy//Fyh
         WXmAPYaF7TaWmdNe8Vk/sPxRITS533towPjrY9mmE/r8JO5Xsx+TtEHYIXisDq0uxUIL
         lnvg==
X-Gm-Message-State: AOAM533YwJSwIc5/z/alC6WYVs54HFLKi8Tw3w2K+KO6fQusfXzdV1c6
        Hq1NQcq0CaKfJ8jY2+AvsU0wKg==
X-Google-Smtp-Source: ABdhPJzrXTULtYCmxU7ZcNLU+k1uU5R8ekYs05eVYzYNSKiNNUMcSUwzfdVTV8Hd2GEWEO5pt7JrwA==
X-Received: by 2002:a17:90a:bf88:: with SMTP id d8mr194231pjs.124.1610472700173;
        Tue, 12 Jan 2021 09:31:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k125sm4726237pga.57.2021.01.12.09.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 09:31:39 -0800 (PST)
Date:   Tue, 12 Jan 2021 09:31:38 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 45/51] gcc-plugins: fix gcc 11 indigestion
 with plugins...
Message-ID: <202101120931.61C1F0B@keescook>
References: <20210112125534.70280-1-sashal@kernel.org>
 <20210112125534.70280-45-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210112125534.70280-45-sashal@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will need an additional fix, so please don't backport it yet.

On Tue, Jan 12, 2021 at 07:55:27AM -0500, Sasha Levin wrote:
> From: Valdis Klētnieks <valdis.kletnieks@vt.edu>
> 
> [ Upstream commit 67a5a68013056cbcf0a647e36cb6f4622fb6a470 ]
> 
> Fedora Rawhide has started including gcc 11,and the g++ compiler
> throws a wobbly when it hits scripts/gcc-plugins:
> 
>   HOSTCXX scripts/gcc-plugins/latent_entropy_plugin.so
> In file included from /usr/include/c++/11/type_traits:35,
>                  from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/system.h:244,
>                  from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/gcc-plugin.h:28,
>                  from scripts/gcc-plugins/gcc-common.h:7,
>                  from scripts/gcc-plugins/latent_entropy_plugin.c:78:
> /usr/include/c++/11/bits/c++0x_warning.h:32:2: error: #error This file requires compiler and library support for the ISO
>  C++ 2011 standard. This support must be enabled with the -std=c++11 or -std=gnu++11 compiler options.
>    32 | #error This file requires compiler and library support \
> 
> In fact, it works just fine with c++11, which has been in gcc since 4.8,
> and we now require 4.9 as a minimum.
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Link: https://lore.kernel.org/r/82487.1609006918@turing-police
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  scripts/gcc-plugins/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
> index d66949bfeba45..b5487cce69e8e 100644
> --- a/scripts/gcc-plugins/Makefile
> +++ b/scripts/gcc-plugins/Makefile
> @@ -22,9 +22,9 @@ always-y += $(GCC_PLUGIN)
>  GCC_PLUGINS_DIR = $(shell $(CC) -print-file-name=plugin)
>  
>  plugin_cxxflags	= -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPIC \
> -		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++98 \
> +		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++11 \
>  		   -fno-rtti -fno-exceptions -fasynchronous-unwind-tables \
> -		   -ggdb -Wno-narrowing -Wno-unused-variable -Wno-c++11-compat \
> +		   -ggdb -Wno-narrowing -Wno-unused-variable \
>  		   -Wno-format-diag
>  
>  plugin_ldflags	= -shared
> -- 
> 2.27.0
> 

-- 
Kees Cook
