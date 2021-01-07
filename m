Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBE52EE7E3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 22:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbhAGVt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 16:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbhAGVt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:49:58 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798E1C0612FB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 13:48:55 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id i5so6178592pgo.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 13:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M2y5ldgOdSGehetTiBK+U8i5swyTNR/kRJ3FUEfcFsM=;
        b=PV5pr53syG3dJsfA06CxIQT0gd9pQVQsuR4CvYMsj3OJ+auH8BqHVAvz2r/fIBJU8/
         XShYvN5UqNLnFx2Bm/nywgy5zgJN8CqkWY58vc97jKtFG4u28IOAf1lOB32Bw2kAPnEk
         ZkNpANy4OUDLzobPKA1GBex5W1U6laQmIc84Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M2y5ldgOdSGehetTiBK+U8i5swyTNR/kRJ3FUEfcFsM=;
        b=o3dcZyGIGYqLmUrOOhAMxRNworcKZqu3jQhPG6OHdgomGIIy9n9NfGv0xFg91weRIw
         Syf3rCypoXIzTIKVhH64WoKzlSZNmqboZHJb+rAqyfpofgVlOp3u3ITgPsAGEwEyEeLk
         xO+b7hBsrqv8j7FR65yhqORik/oVlZaw4A15AsESTMy3a0XopfCLxvpbzVocv6PpFeMH
         +PenMecc8J6q818wv69ca+BbLSVaBAChYByt9vMW7PnEoyr8xyU2IL88vkSZcre2FzYm
         g1k0PDC7O0PdAKKr+fNJfgM+aitWhuUMwBOe298ZARc25RgReHb8r6VWCfjNRbxbB0rC
         nFDA==
X-Gm-Message-State: AOAM531d7MGH2ngz5AZfpfnTvMLINzrJNX4Niaeabd//Z9BLfswNqgYM
        /+wtBQqOB5g1ABV2oCcq7ACalQ==
X-Google-Smtp-Source: ABdhPJwbQHso1tC0FO/UsuRezTvfVCAcWK00QzM7FO5Ywnbq4jpwL9pZJqkwZtGQFsNAvJTtD8KjZQ==
X-Received: by 2002:a63:720c:: with SMTP id n12mr3815960pgc.97.1610056135097;
        Thu, 07 Jan 2021 13:48:55 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 17sm6393784pfj.91.2021.01.07.13.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:48:54 -0800 (PST)
Date:   Thu, 7 Jan 2021 13:48:53 -0800
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
Subject: Re: [PATCH v4 mips-next 4/7] MIPS: vmlinux.lds.S: catch bad .rel.dyn
 at link time
Message-ID: <202101071348.301DA51@keescook>
References: <20210107123331.354075-1-alobakin@pm.me>
 <20210107132010.463129-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107132010.463129-1-alobakin@pm.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 01:20:33PM +0000, Alexander Lobakin wrote:
> Catch any symbols placed in .rel.dyn and check for these sections
> to be zero-sized at link time.
> Eliminates following ld warning:
> 
> mips-alpine-linux-musl-ld: warning: orphan section `.rel.dyn'
> from `init/main.o' being placed in section `.rel.dyn'
> 
> Adopted from x86/kernel/vmlinux.lds.S.
> 
> Suggested-by: Fangrui Song <maskray@google.com>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
