Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90892EC6B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 00:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbhAFXSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 18:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbhAFXSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 18:18:15 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E561C061757
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 15:17:35 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id p18so3280690pgm.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 15:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J3lGr4YZbk3BlMgDSCib4VSawc9GYX81ZHhsXt4/HtQ=;
        b=j8pUIx85KIAbfaHy6fVIzRrFBGjkdjEOxJ6mAw2oQ0m2/uctUcLz8Gdt29lkg5GGFy
         4/oje9/GSD2O4DfUWashHtBda9ZLPw4gNmNWEfz35qgoCi/o0KdH+dAwN53yW4zanT7Y
         Txnjp9QMp50MdqjHxb4CuupTx7tzAh6gLLMwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J3lGr4YZbk3BlMgDSCib4VSawc9GYX81ZHhsXt4/HtQ=;
        b=NGPnAaXYqqR6vQ/nmpVAp9X6HzZDjXBEIjZ9SUwYf1M91rA5wa9UIRZXbKiCRD1k5T
         zzwIKUjzEfaDROONKgNQjebDr1v5swuhiWleDzUt4fxPvc0AWIuk88nk+PDgUopei/+8
         xc1GFb91rPTfFDvP5qZKJLYscohRX1brenDbo6qtrPOEuY5WLG+oR4Yrzt19y7I0kJnP
         b07EhRkj+6/bGTCjxh0CZCBZYw8CUrBq7HZkDNY4MHHEAJte4bWSpfAl6c0IJ9ZNSaVX
         8V3nZo4QWWjs2OUSNOOjvChk/8qP4B2tyi6Kt9OZPooVaAomxtgXBOuW5XAxrTQ56mp5
         S2vg==
X-Gm-Message-State: AOAM530/uNeRMKBzBu3k2O3J9g3kmOjhe5ZsNcT3Gp+N3q5BYt5p2oZW
        qI8AGI79pjdMw3u3Pbw63CgGLA==
X-Google-Smtp-Source: ABdhPJxmHyj4wCz2q4/fqZGwaCa0vGEGxG9eL9BIb5S1ok1Y2m1BUkfqsgENyr4+wQQrRh6aOrXBfQ==
X-Received: by 2002:a05:6a00:a91:b029:19d:9421:847 with SMTP id b17-20020a056a000a91b029019d94210847mr6307899pfl.72.1609975054844;
        Wed, 06 Jan 2021 15:17:34 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q9sm3807528pgb.82.2021.01.06.15.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 15:17:34 -0800 (PST)
Date:   Wed, 6 Jan 2021 15:17:33 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        George Popescu <georgepope@android.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] ubsan: disable unsigned-integer-overflow sanitizer with
 clang
Message-ID: <202101061516.F0EA5F0@keescook>
References: <20201230154749.746641-1-arnd@kernel.org>
 <202101061350.913E1FDF6@keescook>
 <CAK8P3a1tSaUE2uzb2JbQ1f7LWmkiHQtSxzJHmfa=fqT3fNXOPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1tSaUE2uzb2JbQ1f7LWmkiHQtSxzJHmfa=fqT3fNXOPA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 11:12:18PM +0100, Arnd Bergmann wrote:
> On Wed, Jan 6, 2021 at 10:57 PM Kees Cook <keescook@chromium.org> wrote:
> > On Wed, Dec 30, 2020 at 04:47:35PM +0100, Arnd Bergmann wrote:
> > > diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> > > index 8b635fd75fe4..e23873282ba7 100644
> > > --- a/lib/Kconfig.ubsan
> > > +++ b/lib/Kconfig.ubsan
> > > @@ -122,6 +122,8 @@ config UBSAN_SIGNED_OVERFLOW
> > >
> > >  config UBSAN_UNSIGNED_OVERFLOW
> > >       bool "Perform checking for unsigned arithmetic overflow"
> > > +     # clang hugely expands stack usage with -fsanitize=object-size
> > > +     depends on !CC_IS_CLANG
> > >       depends on $(cc-option,-fsanitize=unsigned-integer-overflow)
> >
> > Because of Clang implementation issues (see commit c637693b20da), this is
> > already "default n" (and not supported under GCC at all). IIUC, setting
> > this to "depends on !COMPILE_TEST" won't work for randconfigs, yes?
> 
> Ah, I had not realized this is clang specific. Adding the !COMPILE_TEST
> dependency would hide it for me, which may be good enough for me.

I thought COMPILE_TEST does not get set for randconfig?

> > Is there some better way to mark this as "known to have issues, please
> > don't include in randconfig?"
> >
> > I'd like to keep it around so people can continue to work out the
> > problems with it, but not have unexpecting folks trip over it. ;)
> 
> I've reverted that patch locally now and default-enabled for randconfigs.
> Now that I have an otherwise clean build, this should provide me
> with a full set of files that produce the warning. If the number is
> small enough, I could try opening individual github issues.

Okay, let me know if something needs changing. :)

-- 
Kees Cook
