Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA0A2EFA60
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbhAHVYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbhAHVYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:24:50 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57401C061786
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 13:24:10 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q7so6527520pgm.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 13:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXhZ728/q6Uo5WIgNruf81h0fqXJVTEcW5f5eeageBQ=;
        b=VqzD82yXJfOmBagZ9ORhbg/MoZj2O0543WpKtM3DlsSr51kE4vDTwVs3642NiQwEDH
         1zTxRTZOt/v3lJz5f2XqdX6dfShlwy+W+Lup4Rcx9Vv7qTfhJMvEeL4l6FLxG+yLRmBV
         al5SnoGST8nzQm+J/ueTr9rP1oNXCGL47fllh7mJNLnOL6vIDd5Rt/gKQdP+PQ9unWES
         /0s8XwBSaU0hUwBIEwmJ/ojTbDahdgNrktWE/92f8jF7aVU3kJk4tsVQ5bcocj9SylxJ
         6kT+80pTGSdI2GDMwpvoWNZoU5HJexdZznltFVqbjHz962iYOwSWprCqb3hqEtPLXpog
         jXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXhZ728/q6Uo5WIgNruf81h0fqXJVTEcW5f5eeageBQ=;
        b=mcmxdr2JNg3k8YSDtIVJ+eu3dmBe5OCuqKZggcenigCZP8sod+Q8Ek2wKm28gs69o8
         T6ZpNJize83Uf0sLtgtr3AxO6FHRmDNAk1XXRSExF5JcYt//CK5XOm4Ctk/Xpy6cwWs3
         XuPK53XAefK9CZyMS99rdILCrYqLy8ikeJ00OxTeTJ7pHXectUIjzeC4HrY9rpJMM9Yx
         Flqyiola49KTxmTpqUBiOWgprhcrTxGVphKI3mtU6UFXtFZVtYZ0QHqviMNqgxmWLV0S
         A2OWfA2h4sE8Iz6/wGHk8b/l5zlGEwVYz6C9PiBInDQnDvYdVISzj/ME6VCkoe2tc2ZN
         c1bg==
X-Gm-Message-State: AOAM533au75W98UEt3nrV/s1OHhCUhiMBBQKbjnkbq5wPe5wi4dBRTTT
        wTGLzR5j56QWP8mwzeRUZzb4xEjs76FNgXKIHtpWdA==
X-Google-Smtp-Source: ABdhPJznVuBLE0Y/KOfnwW+Tb3nLZGgFDiTyiQNkKueYB3rN6uQaJZtkNQwuxLH3n5KWE9Xse4Bg1LsKd4sAvAR+1y0=
X-Received: by 2002:a63:1142:: with SMTP id 2mr8978911pgr.263.1610141049735;
 Fri, 08 Jan 2021 13:24:09 -0800 (PST)
MIME-Version: 1.0
References: <20210108092024.4034860-1-arnd@kernel.org> <20210108093258.GB4031@willie-the-truck>
 <CAK8P3a27y_EM6s3SwH1e6FR7bqeT3PEoLbxSWPyZ=4BzqAjceg@mail.gmail.com>
In-Reply-To: <CAK8P3a27y_EM6s3SwH1e6FR7bqeT3PEoLbxSWPyZ=4BzqAjceg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Jan 2021 13:23:58 -0800
Message-ID: <CAKwvOdkrfFXoZs8_xSJMhEFs7XQw6KKcu_JRT7_rUnHNR7A5qQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: make atomic helpers __always_inline
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 2:27 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Fri, Jan 8, 2021 at 10:33 AM Will Deacon <will@kernel.org> wrote:
> > On Fri, Jan 08, 2021 at 10:19:56AM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > With UBSAN enabled and building with clang, there are occasionally
> > > warnings like
> > >
> > > WARNING: modpost: vmlinux.o(.text+0xc533ec): Section mismatch in reference from the function arch_atomic64_or() to the variable .init.data:numa_nodes_parsed
> > > The function arch_atomic64_or() references
> > > the variable __initdata numa_nodes_parsed.
> > > This is often because arch_atomic64_or lacks a __initdata
> > > annotation or the annotation of numa_nodes_parsed is wrong.
> > >
> > > for functions that end up not being inlined as intended but operating
> > > on __initdata variables. Mark these as __always_inline, along with
> > > the corresponding asm-generic wrappers.
> >
> > Hmm, I don't fully grok this. Why does it matter if a non '__init' function
> > is called with a pointer to some '__initdata'? Or is the reference coming
> > from somewhere else? (where?).
>
> There are (at least) three ways for gcc to deal with a 'static inline'
> function:
>
> a) fully inline it as the __always_inline attribute does
> b) not inline it at all, treating it as a regular static function
> c) create a specialized version with different calling conventions
>
> In this case, clang goes with option c when it notices that all
> callers pass the same constant pointer. This means we have a
> synthetic
>
> static noinline long arch_atomic64_or(long i)
> {
>         return __lse_ll_sc_body(atomic64_fetch_or, i, &numa_nodes_parsed);
> }
>
> which is a few bytes shorter than option b as it saves a load in the
> caller. This function definition however violates the kernel's rules
> for section references, as the synthetic version is not marked __init.

Interesting, I didn't know LLVM could do that.  Do you have a simpler
test case? Maybe I could just fix that in LLVM. (I would guess that
when synthesizing a function from an existing function, the new
function needs to copy the original functions attributes as well).

-- 
Thanks,
~Nick Desaulniers
