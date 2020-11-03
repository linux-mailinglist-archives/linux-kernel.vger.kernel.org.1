Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BBA2A3CDF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 07:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgKCGiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 01:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgKCGiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 01:38:18 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC3FC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 22:38:18 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id j12so2756129iow.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 22:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Hqxtx5ajWvQQEKJyoleM3jwGkL8tLKvH6bJZ4hHFfLI=;
        b=XItdZxU9ChknovZtaiQRApg3jDfvenyloElwbNkKaybyi6Q79S3FZ8s25ySNSl0LVe
         qY5mLqhiz5NbQ1DUbOpMJpxjhWRo+NB0Ms8Y2DmuoursU3q3X8KYU2fF7FUAhAccsrHl
         2dXf9ZiaehRFORIsdlzoGS/m81iCcwdam2p2nr30/taMMKG2R3b22C/yVuH2MRo6gR+j
         AwaGBoJQXVAtxTiV4jL/7LVYLYtcAaFg7MqHDqCQSWavmj46GmR12YFCpKEV/ZMcj1Rt
         SBptVU5Pb5wMaDPUUAv/ja3BAQ9UnOEH/zQllIeEf5x7pFkvsgZMLCufrMawi9TSbmqW
         cPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Hqxtx5ajWvQQEKJyoleM3jwGkL8tLKvH6bJZ4hHFfLI=;
        b=Kpo4ZLE/LMiyOJoJ/8/xI+usLXYnSnReeb6NvsNkvLRPiMTGGyOBO6kgu7eEr6yA0a
         f2StkKMo905KIU4Dtx6ADqm0LJ6FoQaFAT3xuZH8pwFuHzsDJlH9P7lBGZ7W4MftJgJV
         vv2jbgSbe/VtkoINn5cYXLDiqoD9aJzTECB5kUs011Z07g0GPieIF1ESTF2b8s2e46em
         eEj1iKrM4uCZfdxAIS41H2J4e2KpM+JBgjtoR5KAmFhx7lIM3JmXor8Xp9cphOL3/luB
         yBelOd9pRR+yabrEiy7XpV84KrtXjwBsA7/WiDLLkcLxxJzeB/9TE0sTXFi5b5BTT2h3
         QvlA==
X-Gm-Message-State: AOAM531duO0fS4++RRNx88o/Pclk2Z9vImvV1oXzqIpwuiYXeinHisgb
        OA1TlhHaxetVhHjYXCkNNrE=
X-Google-Smtp-Source: ABdhPJwUYLRtVApgCgs152m8+68FP3dn9m/PKsRdWPSAAWqcH5SfnsgQfAVHuaYLTOULTWnbPtxSrg==
X-Received: by 2002:a05:6602:2d4e:: with SMTP id d14mr13420142iow.105.1604385497350;
        Mon, 02 Nov 2020 22:38:17 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id j10sm2095428iop.34.2020.11.02.22.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 22:38:16 -0800 (PST)
Date:   Mon, 2 Nov 2020 23:38:14 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux@googlegroups.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] compiler-clang: add build check for clang 10.0.1
Message-ID: <20201103063814.GA647990@ubuntu-m3-large-x86>
References: <20200902225911.209899-1-ndesaulniers@google.com>
 <20200902225911.209899-2-ndesaulniers@google.com>
 <20201103045521.GA58906@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103045521.GA58906@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 06:55:21AM +0200, Jarkko Sakkinen wrote:
> On Wed, Sep 02, 2020 at 03:59:05PM -0700, Nick Desaulniers wrote:
> > During Plumbers 2020, we voted to just support the latest release of
> > Clang for now.  Add a compile time check for this.
> > 
> > We plan to remove workarounds for older versions now, which will break
> > in subtle and not so subtle ways.
> > 
> > Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> > Suggested-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> > Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Acked-by: Marco Elver <elver@google.com>
> > Acked-by: Nathan Chancellor <natechancellor@gmail.com>
> > Acked-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/9
> > Link: https://github.com/ClangBuiltLinux/linux/issues/941
> > ---
> >  include/linux/compiler-clang.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> > index cee0c728d39a..230604e7f057 100644
> > --- a/include/linux/compiler-clang.h
> > +++ b/include/linux/compiler-clang.h
> > @@ -3,6 +3,14 @@
> >  #error "Please don't include <linux/compiler-clang.h> directly, include <linux/compiler.h> instead."
> >  #endif
> >  
> > +#define CLANG_VERSION (__clang_major__ * 10000	\
> > +		     + __clang_minor__ * 100	\
> > +		     + __clang_patchlevel__)
> > +
> > +#if CLANG_VERSION < 100001
> > +# error Sorry, your version of Clang is too old - please use 10.0.1 or newer.
> > +#endif
> 
> 
> I'm trying to compile a BPF enabled test kernel for a live system and I
> get this error even though I have much newer clang:
> 
> ➜  ~ (master) ✔ clang --version          
> Ubuntu clang version 11.0.0-2
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
> 
> Tried to Google for troubleshooter tips but this patch is basically the
> only hit I get :-)

Do you have a .config and command to reproduce the error?

Cheers,
Nathan
