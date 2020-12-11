Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97292D7F82
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 20:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392882AbgLKTjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 14:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390353AbgLKTjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 14:39:16 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BC9C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 11:38:35 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id b26so7618602pfi.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 11:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VNfUmoHugTzMNVPlGX+wnRh5Cf/stQAzYSuLpPo56Do=;
        b=FEC9uEup9Neav9R+6U+sr3qeNh7Pg8WcbZYYXZwTn8O8CiG2ftP1IPYk0zCyjiYFSF
         c94oFOC9/6e94fHGubU93cGjPF1HGZHYHPragsSfEBUJ7FdZnpViexh6U4PPA/zRRum+
         eJUlsS8wc4R+iMPuouzj/+4aQfrfbSeOVoqX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VNfUmoHugTzMNVPlGX+wnRh5Cf/stQAzYSuLpPo56Do=;
        b=Q4QFue6VGH/9CK8Rdfgz5OKdi4YE5w4B4CnGV9D9exX+Beor7JuSAUYILoEX929LMu
         y5OFxw07uO9bnsSRy1CU9Yf38v37wmIQGZKyXsZZyg7N5on4FrUPH181O3LhWHORp3jk
         jyrVz7iURTwYenJop4mN8xFLVPes4gFFBpj8LDrc9v+NMZwSOKPtbA7Jn5+y8UdoovyD
         58NJejvb8L7KHUIdzASDBfsNwYbRjAI+8ubSLGVR1/N7GBrK5mBE0HhN8bahIV25OJ14
         TVmyWwiAOrvfL6GSN+3X6KHw1fLNXOj4UeX/EiyDp8PzNhI6Qm1ycTPMvZKePVdEay2f
         m1QA==
X-Gm-Message-State: AOAM533AgUK662qRFX9qM3it1/ZHuZgZnzyDISO1Wq71PPS1c2yZV5aM
        4xkQNByYHMOHLk+QD/trOyGWVg==
X-Google-Smtp-Source: ABdhPJyVEoQImRCMu3zSXvZnm5dHPPI8XqAV4RWpzzfXPBlCN0XEN9HOeEk46yg5rZ5bTGUzmtXFMg==
X-Received: by 2002:a63:f456:: with SMTP id p22mr13270729pgk.360.1607715515417;
        Fri, 11 Dec 2020 11:38:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h11sm11456024pjg.46.2020.12.11.11.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 11:38:34 -0800 (PST)
Date:   Fri, 11 Dec 2020 11:38:33 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 00/16] Add support for Clang LTO
Message-ID: <202012111134.209A6D311@keescook>
References: <20201211184633.3213045-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211184633.3213045-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 10:46:17AM -0800, Sami Tolvanen wrote:
> This patch series adds support for building the kernel with Clang's
> Link Time Optimization (LTO). In addition to performance, the primary
> motivation for LTO is to allow Clang's Control-Flow Integrity (CFI)
> to be used in the kernel. Google has shipped millions of Pixel
> devices running three major kernel versions with LTO+CFI since 2018.
> 
> Most of the patches are build system changes for handling LLVM
> bitcode, which Clang produces with LTO instead of ELF object files,
> postponing ELF processing until a later stage, and ensuring initcall
> ordering.
> 
> Note that arm64 support depends on Will's memory ordering patches
> [1]. I will post x86_64 patches separately after we have fixed the
> remaining objtool warnings [2][3].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/lto
> [2] https://lore.kernel.org/lkml/20201120040424.a3wctajzft4ufoiw@treble/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=objtool-vmlinux
> 
> You can also pull this series from
> 
>   https://github.com/samitolvanen/linux.git lto-v9
> 
> ---
> Changes in v9:
> 
>   - Added HAS_LTO_CLANG dependencies to LLVM=1 and LLVM_IAS=1 to avoid
>     issues with mismatched toolchains.
> 
>   - Dropped the .mod patch as Masahiro landed a better solution to
>     the split line issue in commit 7d32358be8ac ("kbuild: avoid split
>     lines in .mod files").
> 
>   - Updated CC_FLAGS_LTO to use -fvisibility=hidden to avoid weak symbol
>     visibility issues with ThinLTO on x86.
> 
>   - Changed LTO_CLANG_FULL to depend on !COMPILE_TEST to prevent
>     timeouts in automated testing.
> 
>   - Added a dependency to CPU_LITTLE_ENDIAN to ARCH_SUPPORTS_LTO_CLANG
>     in arch/arm64/Kconfig.
> 
>   - Added a default symbol list to fix an issue with TRIM_UNUSED_KSYMS.

This continues to look good to me. I'd like to see it in -next ASAP so
we can continue to find any little needed tweaks. Since it works in the
general case, we can add on top of this series once it's in -next.

Masahiro, let me know if you'd rather I not carry this in -next. AFAICT,
the bulk of the changes in the build system continue to be confined to
the LTO-only cases, so it should not be disruptive to anyone doing
non-LTO builds.

-- 
Kees Cook
