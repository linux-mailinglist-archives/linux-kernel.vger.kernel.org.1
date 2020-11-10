Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBB62AE30D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732204AbgKJWPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731805AbgKJWPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:15:15 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049DDC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:15:15 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id y197so13176044qkb.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uIOzI8x2X1SZGvfM2NfEeGZjOdYhmoI7amgUKQgpunY=;
        b=K/LL2lfALMmOHYaFluLeF7ajWtNG/IZxN6cpjSQUl3oKYuF63EVb6hnPmRksiKpikc
         zDvm4gP8LZe6+aH1RbfsNB6+sxlL+B0R+KvW5rfZKSYa98ZYNCzi0sbUfyQAWvSrMu2t
         Q9H9n35b1vXgQvF1teMaaJLsdL1hOytCQujaFVLB+jZGuBaKBipBV9OtcFmzp6reMSHv
         U/le7QaCI6uxNFLwbK4l2INR/SQriinbei2NJXAyNLba8+eiI/zIzU5MFUfGonx1QLyL
         hkS6uhZxrnn3xzXvuYIdCMwqyj4vYDeg/ozt+G+2MKMR8lNcwYD6fVo7ZxUxwTN0Vo+1
         1ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uIOzI8x2X1SZGvfM2NfEeGZjOdYhmoI7amgUKQgpunY=;
        b=I1h7WESmj1koaBtReLkbItuBmDGd60/XeWExJ6lenOt6+LtA198zVVvOmPzmuGHJby
         EjM1e7Ztn0cyQuEKEKS7qsZjfOAbCDr6E4XoZAq46bVLXh+dZ6wl0k7BICPUB9y8FakH
         eAfi2zDu5uPzjE0++RpPJHqO0AO/SQRQNJ8ECleCkoaED28Wk1jt9L3cfeElocKqclrC
         58YnH9zzXqqIaz9FfRg573ybpI/y7ooTkEwWKUW7XLRfIXmAo6mZRJGfYK8ciorAH+1d
         tfuLmWJJyRDvXBGW50/NJxV99HTf0LT2aD46Z0Bx5wbg7AImHDQK8ftndUw2/9K0Oglv
         ogqA==
X-Gm-Message-State: AOAM530MRFyPeHCfzNV1mgXYwx+kW8g7OJH9AwGPk0kcBPRgv7bJ0sC/
        uFVpSxvRFdT/pu/87PgwM4I=
X-Google-Smtp-Source: ABdhPJxJVjhLD6VaxM0tXb7NyppHqncBfJwFgOko/fVzM69cKPtOKyHEp8DOvei2rH9hArmCIjlM5g==
X-Received: by 2002:a37:7ac3:: with SMTP id v186mr21828124qkc.451.1605046514064;
        Tue, 10 Nov 2020 14:15:14 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c76sm189612qkb.20.2020.11.10.14.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 14:15:13 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 10 Nov 2020 17:15:11 -0500
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 2/2] arm: lib: xor-neon: disable clang vectorization
Message-ID: <20201110221511.GA1373528@rani.riverdale.lan>
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
 <20201106051436.2384842-3-adrian.ratiu@collabora.com>
 <20201106101419.GB3811063@ubuntu-m3-large-x86>
 <87wnyyvh56.fsf@collabora.com>
 <CAKwvOdkodob0M0r_AK_4nG3atLGMyNENMd6qVAHSPa92Zh7UZA@mail.gmail.com>
 <871rh2i9xg.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
 <CAKwvOdkm3u83TQDBB-fC0TwKZCFXGh5sAfahKXxA+mnzgDid_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdkm3u83TQDBB-fC0TwKZCFXGh5sAfahKXxA+mnzgDid_w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 01:41:17PM -0800, Nick Desaulniers wrote:
> On Mon, Nov 9, 2020 at 11:51 AM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> >
> > On Fri, 06 Nov 2020, Nick Desaulniers <ndesaulniers@google.com>
> > wrote:
> > > +#pragma clang loop vectorize(enable)
> > >         do {
> > >                 p1[0] ^= p2[0] ^ p3[0] ^ p4[0] ^ p5[0]; p1[1] ^=
> > >                 p2[1] ^ p3[1] ^ p4[1] ^ p5[1];
> > > ``` seems to generate the vectorized code.
> > >
> > > Why don't we find a way to make those pragma's more toolchain
> > > portable, rather than open coding them like I have above rather
> > > than this series?
> >
> > Hi again Nick,
> >
> > How did you verify the above pragmas generate correct vectorized
> > code?  Have you tested this specific use case?
> 
> I read the disassembly before and after my suggested use of pragmas;
> look for vld/vstr.  You can also add -Rpass-missed=loop-vectorize to
> CFLAGS_xor-neon.o in arch/arm/lib/Makefile and rebuild
> arch/arm/lib/xor-neon.o with CONFIG_BTRFS enabled.
> 

https://godbolt.org/z/1oo9M6

With the __restrict__ keywords added, clang seems to vectorize the loop,
but still reports that vectorization wasn't beneficial -- any idea
what's going on?
