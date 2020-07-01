Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE042110D7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 18:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732486AbgGAQjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 12:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgGAQi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:38:59 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910FFC08C5C1;
        Wed,  1 Jul 2020 09:38:59 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id k15so14055236lfc.4;
        Wed, 01 Jul 2020 09:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fS8Kbbr6u+Qt+wSwfOlztvSKvUpRcBAxdtJAIiraa8k=;
        b=XZM+72gciw9nF4OsUTlGCo821BFfCQbfWMzTG2s4XnB101NtlMstykJPODwJQkbk95
         ulAI4EpcU7fehmEn2OJ4hmH8jDQ3XUNp6wW631Zg/hLtnJKYYL3+untAdAvh1/2h4CHE
         Lh9Bbm1CmxMLsT/L4DDWco0F6ND+AFm+pljhj1WkhvSFKl/D82mKul+DFdHfQLZgsW/y
         tVXDXcRv5gLENn581TARIKvIeyvWyxbAYDXimInWetyiF1Q3I10t2k7nuQwrqWDIAfCH
         2FXDP4ok4ms1Zb2j1UZZbjokcvm5RNJEcKmP/XvftY1TPqLWeJtapVke08xVAMuAaW5X
         2Gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fS8Kbbr6u+Qt+wSwfOlztvSKvUpRcBAxdtJAIiraa8k=;
        b=KlhZSUdmkQXDS+h6VwLHour9kknDEjG/c8uKw/CFR12YUbMt0YRT0ea0gjH/ppiAT4
         AVjpNIgDe/hKa1SguqgpyUpiBw3+wXGk6QRPLGzPgrHFtjdR0WtINjXiQV8YF3OPN1GH
         TRNAP1Jl8JWWyLqzriu/LNg52z1u+aVtkCAfncxktjKiQNgZXV4FMjxmdp3QayJORUxl
         Hu7TSxAw+ph+kUD5Av00MLfGa7XrPLscmTMrQCoxs131mlpmyemuNHu829jspDX1K9EQ
         I4sFMrEt9Gi16ozA6seRT6GHn7lxOHISFKsiFZx6j0yF+Q6sCH4aHCUaidB7YsWKKMS3
         kyVg==
X-Gm-Message-State: AOAM531SYukelTA6FvXI5/4v5V0fplHS+dlmZNbMjjTQnMWJFCSvLh4F
        zoNwpc7odjg79B7H5uDgqhPbWQmVxgdkB+gtzLVK5A==
X-Google-Smtp-Source: ABdhPJzhx/RMYa6L4vtQ0mrLwEP+eiVOtfSbexChh9nnu3NLhEZwqxpST5gp2Olwx3jPShY2dcl1VBrf6CxD/I+pfWE=
X-Received: by 2002:ac2:5e29:: with SMTP id o9mr15143828lfg.196.1593621538016;
 Wed, 01 Jul 2020 09:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200630173734.14057-1-will@kernel.org> <20200630173734.14057-2-will@kernel.org>
In-Reply-To: <20200630173734.14057-2-will@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 1 Jul 2020 09:38:46 -0700
Message-ID: <CAADnVQJ5kZRT+H7MZWKcJ6HqCGR54Y4zdk67KZO3=ho6Kab5fw@mail.gmail.com>
Subject: Re: [PATCH 01/18] tools: bpf: Use local copy of headers including uapi/linux/filter.h
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Android Kernel Team <kernel-team@android.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Xiao Yang <ice_yangxiao@163.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 10:37 AM Will Deacon <will@kernel.org> wrote:
>
> Pulling header files directly out of the kernel sources for inclusion in
> userspace programs is highly error prone, not least because it bypasses
> the kbuild infrastructure entirely and so may end up referencing other
> header files that have not been generated.
>
> Subsequent patches will cause compiler.h to pull in the ungenerated
> asm/rwonce.h file via filter.h, breaking the build for tools/bpf:
>
>   | $ make -C tools/bpf
>   | make: Entering directory '/linux/tools/bpf'
>   |   CC       bpf_jit_disasm.o
>   |   LINK     bpf_jit_disasm
>   |   CC       bpf_dbg.o
>   | In file included from /linux/include/uapi/linux/filter.h:9,
>   |                  from /linux/tools/bpf/bpf_dbg.c:41:
>   | /linux/include/linux/compiler.h:247:10: fatal error: asm/rwonce.h: No such file or directory
>   |  #include <asm/rwonce.h>
>   |           ^~~~~~~~~~~~~~
>   | compilation terminated.
>   | make: *** [Makefile:61: bpf_dbg.o] Error 1
>   | make: Leaving directory '/linux/tools/bpf'
>
> Take a copy of the installed version of linux/filter.h  (i.e. the one
> created by the 'headers_install' target) into tools/include/uapi/linux/
> and adjust the BPF tool Makefile to reference the local include
> directories instead of those in the main source tree.
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> Reported-by: Xiao Yang <ice_yangxiao@163.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Acked-by: Alexei Starovoitov <ast@kernel.org>
