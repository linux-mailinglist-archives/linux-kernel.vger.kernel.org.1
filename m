Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0412EE7EA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 22:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbhAGVuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 16:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbhAGVuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:50:03 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E24EC0612F6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 13:49:23 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id j13so4875071pjz.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 13:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UTTy0WEJkMO0H2XumjV4y9QZB0fFUlY6gs6jKFnkPCs=;
        b=UgSAXxRcqgWDyOOtEvj9pyh3d/6tivv5BUeekYoFX9DpvpDSdK5CDcjpGyaOlBwMFK
         nSzen8slLXit0KPM6i7GnXZXh1ZjrfZKfAmcyvgw/vV5upbdruwILeYp8xm533pQMB2c
         06qd9EgZCg7V3/GYV0mSRPxfP68Bxoj4ACUx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UTTy0WEJkMO0H2XumjV4y9QZB0fFUlY6gs6jKFnkPCs=;
        b=ruZCHF7qssQYBB/DpG8fWyKbTqdHSEIBE+QrGSatxbKoRVEGxlmiBGZIbBspV/wIYf
         Ou+Mb8gMpNUDnNmbutO0a3TxCrv4hwb5QAWX1S6z3nBMJcqc5KHgCTk36j9HjVHjpm4N
         ZhKGrfvqa/xYYA1jBPOXzIwOatncyt1Og4vxr9Zov/vBnMTqxPKEJxe0h0+vAEIW/d5r
         RufumShI8Z3kE6pxWGLuJXUG7SgNoZwx/5r6xH/l3yeZo03XybEAyi5BiOVl1MIYNX8J
         4CziLl8/X4xeb577yA8CmLHAxzTx1h7pWBwTm9euPI+s0UT6Hi+xOZ1dh7Nle2G/iSSi
         9pvg==
X-Gm-Message-State: AOAM532qqfq7iGPAPqqFpDsmTZ6WxW0lK6OUbP1BMfKKICg8wSeHGG7P
        ZYD3fF/9RusPEeCYWtmama5WHw==
X-Google-Smtp-Source: ABdhPJy7dqWS0KXS0gjfLEG7NjdBnTj4gGePU9Vljy5VYJdnOkLbAUkmKEts1AwkoPsJxhBNhTjIPQ==
X-Received: by 2002:a17:90a:67ce:: with SMTP id g14mr473825pjm.33.1610056163137;
        Thu, 07 Jan 2021 13:49:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p187sm6618865pfp.60.2021.01.07.13.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:49:22 -0800 (PST)
Date:   Thu, 7 Jan 2021 13:49:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Pei Huang <huangpei@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Corey Minyard <cminyard@mvista.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, stable@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v4 mips-next 5/7] MIPS: vmlinux.lds.S: explicitly declare
 .got table
Message-ID: <202101071349.260EC64@keescook>
References: <20210107123331.354075-1-alobakin@pm.me>
 <20210107132010.463129-1-alobakin@pm.me>
 <20210107132010.463129-2-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107132010.463129-2-alobakin@pm.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 01:20:49PM +0000, Alexander Lobakin wrote:
> LLVM stack generates GOT table when building the kernel:
> 
> ld.lld: warning: <internal>:(.got) is being placed in '.got'
> 
> According to the debug assertions, it's not zero-sized and thus
> can't be handled the same way as .rel.dyn (like it's done for x86).
> Use the ARM/ARM64 path here and place it at the end of .text section.
> 
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
