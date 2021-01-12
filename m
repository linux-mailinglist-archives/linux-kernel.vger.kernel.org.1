Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CC02F408F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393544AbhAMAm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 19:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392050AbhALX5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 18:57:08 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DC6C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 15:56:28 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id x18so33259pln.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 15:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=egOxKkqbyBetrH7WixXhoHmmhlfHD6VlkXXUud3e8MY=;
        b=CoB30TPkpx5II4Bf1rlIwVyGwIMVhZ+JcO/QyF1yO2SSxH//4Su+perjdar3gSdoGv
         asS5BOJv/yDzbfdry/poG8UwtgE3vEXJwxjmz6HNfg5J7CJBldZ0YG+s+5iWyaET+aoN
         lhrrO2MCrzr+NWwjAQAWu8RkBeZcJWCjyoy9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=egOxKkqbyBetrH7WixXhoHmmhlfHD6VlkXXUud3e8MY=;
        b=P+LOiv7btYg9EKLCz4vyG8tz+KBWdPfIvhlEH/gqeN3ItwTk/8mMqc9xzPP5bmjf7H
         vY/Ru9ZiLL6vScq2dNs4zCCgl4OUSa5yjGsRBYsZ07O+0/uu/wutMhndtEDc2+Ldy0TI
         nbHU2hMJ37dGynNnOr7JKXnTA0g3euev5j4ibf2Ju+60X8DSPIeRqhGAOXfGt6KSCmLE
         3+i2cgTyTutosLsmG9zglrRthYF8Rf1MvzdA4/QeR4mWpjN6TNeEL03DY0jsG6eXYXbA
         RVdB/y/AXciLrcp24bPAOWDoaExSJC22e2X4aijn8Sh0l11HyISQQSZQRx71fc/FIHgu
         Zhcg==
X-Gm-Message-State: AOAM530fAGnSGFuggevNoI36hnbJbv+fYoIVtTLbcVtCLh1q7XMh9i9U
        gnwjirJPbHppsIN4XpP3/2chrAszjD8dQg==
X-Google-Smtp-Source: ABdhPJxMuIuqd+xZ1SYb3WTdxeq1FlrLTrwOvMASWD17NzC5GZtcbJdRWG77XpaJM1B6hchHX+CCew==
X-Received: by 2002:a17:90a:c789:: with SMTP id gn9mr141503pjb.101.1610495788184;
        Tue, 12 Jan 2021 15:56:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z11sm224715pfj.191.2021.01.12.15.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 15:56:27 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:56:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] ubsan: Implement __ubsan_handle_alignment_assumption
Message-ID: <202101121555.C929315@keescook>
References: <20210112205542.1375847-1-natechancellor@gmail.com>
 <CAKwvOd=yrVKBn9TN2cP8SiB7A8=c2g41PyodKGJu+xEQwAmnDA@mail.gmail.com>
 <20210112213703.GA1376568@ubuntu-m3-large-x86>
 <CAKwvOdkA5kmXhKFDFTApLyT5LcUX2-Xr6vJJ0b8wePunMpLu0g@mail.gmail.com>
 <20210112220634.GA1377517@ubuntu-m3-large-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112220634.GA1377517@ubuntu-m3-large-x86>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 03:06:34PM -0700, Nathan Chancellor wrote:
> On Tue, Jan 12, 2021 at 01:53:30PM -0800, Nick Desaulniers wrote:
> > On Tue, Jan 12, 2021 at 1:37 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > > if real_ptr is an unsigned long, do we want to use `__ffs(real_ptr) +
> > > > 1` here rather than ffs which takes an int?  It seems the kernel is
> > > > missing a definition of ffsl. :(
> > >
> > > Why the + 1? I think if we use __ffs (which it seems like we should), I
> > > think that needs to become
> > 
> > This came up recently in an internal code review; ffs and __ffs differ
> > in output by one.  See also the definition of ffs for alpha in
> > arch/alpha/include/asm/bitops.h.
> 
> Interesting, thanks for bringing it up! Looks like ffs returns 1-32 and
> __ffs returns 0-31. I think that we want __ffs here because we are
> shifting (1UL << 32 overflows on 32-bit architectures) and the code in
> LLVM appears to agree. LeastSignificantSetBitIndex evaluates to
> __builtin_ctzl, which is the asm-generic implementation of __ffs.

Sounds good. With __ffs, consider your v2:

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
