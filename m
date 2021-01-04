Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63C12E9D53
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 19:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbhADSsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 13:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbhADSsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 13:48:12 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3528C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 10:47:31 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id u21so19149221qtw.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 10:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YmvW4Q6DWWO7XERZwXDi7sTEzjHDHI29ZxH9utRkJCM=;
        b=EBM/hk2nhQ4J48ezLfFfCkm5dKQxYyzGCrogV5kL9CaYw0D6dAwRhptWoY/kRgoom0
         XkG4QOHsneGYnb/mbXdiTggPEN8IVM1huhhH3Vo2H6pQZtqoVsz9+GV3PDKajqXoqXN6
         EXNjwlknsRTx4YjbZNoNyV+/SbAdX1ecQayTlmJjUT5LJqPQ01FEt/lhrTKD02iZHG8w
         /OClIEmkI8RLOZallh8ae5/vqEpAXjFEK/2sW1aCee9hK/a0NIsljaocpiYLN1eBwH5k
         kBsvEd3HSkXj32Pp7B5Zjkd1p/x5Y9OEiBvCuL6rOv7tQ0MhQSJIY+Ili39RZ+AP1eqy
         ylAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YmvW4Q6DWWO7XERZwXDi7sTEzjHDHI29ZxH9utRkJCM=;
        b=oX+lFz+YSiPruBeGked3nZvmbZRfTGFOMnRf9JrO4nvxiR34cKmgxLQk/zx/+qxvxi
         vOVmelRD8MMCL2McrAre72jVacP/MZM9cM521nCtt6OsXCHPkURjv4k4V8pvH085cI7E
         LoTHOgZIe5zuDOGPrD6eanpwyntVrk+V8fE7z4DpfiI4qQgWZXkLHOIm7lc9RpD6+8cg
         TqlgQqjjAoP+RFm66w1+JvJyRzl1d/q0qWC73rTRC6jxKTX2C6NDCo7QjNYD2fMbnDDR
         SYbUvwKWSCnHnBD/rIfSc3q+7Ma+ziLwCxTML2junGdsljhYmoIaRp0FqZHuARzlIgKx
         wrXw==
X-Gm-Message-State: AOAM532TtI1HUWASyEb0/qyWi0ojjK55AFYvEgLtINAgZTZRh2r0na/9
        YP8Og5YjHtKVBWlHnl4M18Tc8G6VUfA=
X-Google-Smtp-Source: ABdhPJy/6MoXAYle0sVOq7389gCshw8yO8XNjT6bcEtotwh8mwW9uPkacWY9DSJe20+vPymYDiCnMA==
X-Received: by 2002:aed:2cc5:: with SMTP id g63mr71971517qtd.327.1609786050961;
        Mon, 04 Jan 2021 10:47:30 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id q3sm37748990qkb.73.2021.01.04.10.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 10:47:30 -0800 (PST)
Date:   Mon, 4 Jan 2021 11:47:28 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Mordechay Goodstein <mordechay.goodstein@intel.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: Re: drivers/net/wireless/intel/iwlwifi/queue/tx.c:310:18: warning:
 result of comparison of constant 262140 with expression of type 'u16' (aka
 'unsigned short') is always false
Message-ID: <20210104184728.GB243045@ubuntu-m3-large-x86>
References: <202101030910.Lehj6xQW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202101030910.Lehj6xQW-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 03, 2021 at 09:51:17AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3516bd729358a2a9b090c1905bd2a3fa926e24c6
> commit: 0cd1ad2d7fd41e0de4969fd1dd0aa846c99830d1 iwlwifi: move all bus-independent TX functions to common code
> date:   3 months ago
> config: powerpc-randconfig-r001-20210103 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 20670ba44066df0aae536822b7f7834ee3198c0d)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install powerpc cross compiling tool for clang build
>         # apt-get install binutils-powerpc-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0cd1ad2d7fd41e0de4969fd1dd0aa846c99830d1
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 0cd1ad2d7fd41e0de4969fd1dd0aa846c99830d1
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/net/wireless/intel/iwlwifi/queue/tx.c:310:18: warning: result of comparison of constant 262140 with expression of type 'u16' (aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]
>            if (WARN_ON(len > PAGE_SIZE - sizeof(void *))) {
>            ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/asm-generic/bug.h:188:25: note: expanded from macro 'WARN_ON'
>            int __ret_warn_on = !!(condition);                              \
>                                   ^~~~~~~~~
>    include/linux/compiler.h:56:47: note: expanded from macro 'if'
>    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
>                               ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
>    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
>                                                       ^~~~
> >> drivers/net/wireless/intel/iwlwifi/queue/tx.c:310:18: warning: result of comparison of constant 262140 with expression of type 'u16' (aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]
>            if (WARN_ON(len > PAGE_SIZE - sizeof(void *))) {
>            ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/asm-generic/bug.h:188:25: note: expanded from macro 'WARN_ON'
>            int __ret_warn_on = !!(condition);                              \
>                                   ^~~~~~~~~
>    include/linux/compiler.h:56:47: note: expanded from macro 'if'
>    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
>                               ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler.h:58:86: note: expanded from macro '__trace_if_var'
>    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
>                                                                        ~~~~~~~~~~~~~~~~~^~~~~
>    include/linux/compiler.h:69:3: note: expanded from macro '__trace_if_value'
>            (cond) ?                                        \
>             ^~~~
>    2 warnings generated.

This warning happens due to PAGE_SIZE being 256K, which is larger than
u16.

$ rg "PPC_256K_PAGES|PPC_PAGE_SHIFT" .config
CONFIG_PPC_256K_PAGES=y
CONFIG_PPC_PAGE_SHIFT=18

On most configurations, which will use 64K or less, this check is valid.
I am not sure how it should be dealt with, aside from increasing len to
u32.

Cheers,
Nathan
