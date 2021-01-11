Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A752F1FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391257AbhAKTxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388625AbhAKTxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:53:14 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FA4C061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:52:34 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id e2so41229plt.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b3ASHNv4fQafYtJYhutvA+h2vhozaX/2DMehAnSz5ag=;
        b=dW6jgffvZLGUy04LN8THQEQVkw8PZoYf7VCu8HYZ0EbxlMOQa0n1xsd3ykJxC8dkU+
         2r63KPURs47LuomEfnIVbg/C6LlHNcg/yMHwtGt0A6ILr1p49332svKJcVIPu1R1xiLM
         4/+kG3X8WNUNmKnN2u8p+saFA3f0T8Vw4ueAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b3ASHNv4fQafYtJYhutvA+h2vhozaX/2DMehAnSz5ag=;
        b=AhQyPJi5A7oUVA0v2o8k6gYi+FLrmW5RCNa0kzWVuo/m2/47zPKmsAkqs4wRUsDJWq
         IqUQ8CQlcM+FtxcpOkS+yWGwlC39A89xyCksf/nsU3UM7bRhkznBfAn6GYRhEKB5bwhB
         FDsYubw3/eM46ABJtzOlffqQPZH6/P4wVXVzNIvGXCL0xbfoMfzqrjYZ6kEPfxJi3aiM
         8fimzLxYq/LOfMCnIFfKFluL8/n0n0vfGNdvkgFzsqaR8PCGt9r8eZg3USHXFqVl0ADH
         /rWoU2ntXocbIQkERs/VrzsYfanA9cti1nvd/cM2jYX7Xd1VOWGRJA250QBBw9Ubq+HH
         POmA==
X-Gm-Message-State: AOAM533rYDm26H7RLOb2GlRMLIDGBWTe+FPWqJlaJ1AVvOK9kKEtZQgi
        Qom7Zw3R9DFtV+uaoAKoXkfGFQ==
X-Google-Smtp-Source: ABdhPJzY/E1MTdTcsgHlXSz53z7Qe5MDkWrc4R6K55+zVZdVCYMLpf+kLnTKc8vOT3KmQRbGPlNpmg==
X-Received: by 2002:a17:902:5997:b029:da:a1cd:3cc2 with SMTP id p23-20020a1709025997b02900daa1cd3cc2mr916063pli.80.1610394753608;
        Mon, 11 Jan 2021 11:52:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d10sm420631pfn.218.2021.01.11.11.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:52:32 -0800 (PST)
Date:   Mon, 11 Jan 2021 11:52:31 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jinyang He <hejinyang@loongson.cn>,
        Ralf Baechle <ralf@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        linux-mips@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH mips-fixes] MIPS: relocatable: fix possible boot hangup
 with KASLR enabled
Message-ID: <202101111152.CBF4BEDB@keescook>
References: <20210110142023.185275-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210110142023.185275-1-alobakin@pm.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 02:21:05PM +0000, Alexander Lobakin wrote:
> LLVM-built Linux triggered a boot hangup with KASLR enabled.
> 
> arch/mips/kernel/relocate.c:get_random_boot() uses linux_banner,
> which is a string constant, as a random seed, but accesses it
> as an array of unsigned long (in rotate_xor()).
> When the address of linux_banner is not aligned to sizeof(long),
> such access emits unaligned access exception and hangs the kernel.
> 
> Use PTR_ALIGN() to align input address to sizeof(long) and also
> align down the input length to prevent possible access-beyond-end.
> 
> Fixes: 405bc8fd12f5 ("MIPS: Kernel: Implement KASLR using CONFIG_RELOCATABLE")
> Cc: stable@vger.kernel.org # 4.7+
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
