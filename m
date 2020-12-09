Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530F32D4392
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732545AbgLINwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 08:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgLINwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:52:34 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA128C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 05:51:54 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id bj5so965584plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 05:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w4MkXK3tdvL2KD1xeLvIGtLJ1l3YTvntIB2NHLxLGEE=;
        b=odoVmjOP5a21hkZKPqPD/kvmnmP82iAFi1Q+sOKq2H0z9qS/cCOEvhgqlRHaQ67AFM
         DG2vpSkIpTZGwYASYEyDcVchdt1haJQxT9dxOP14VMEREenxN1KP1Gk3mGy6k72rtzVc
         9B4bb+pXD2vNGb/62RHKL5cSHH+1ps9YN3T+vPc/fWvg+Uh8kkuFxMdouOMpAVgB9J+g
         96HhPYEGFo/bz3ikWU/5wZbXvwGJoF88/joRN2tqIWzghtffM+W86TrX3Lq9jgbyihXV
         /uPbATPaMFQAD2ASY4crtD+Lp7aX0lFTPi48BE2YM2VGagaKPSiRGEiGMBjFRZOaxcx2
         kOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4MkXK3tdvL2KD1xeLvIGtLJ1l3YTvntIB2NHLxLGEE=;
        b=CehtnN2o1npEn/hhL2idKqLvbHbmer9Q8V2Tq3BK1gMQMIxj8c+HnYJodXwAuzyNmn
         oevLJuAFhz8I5rGoYqbe4MqZmP5BbOm8m3LvwKYWTZPcSQ/xDTpiiIFmEUUIdFiEigKU
         kMVPKTBavTagqANwVRWx2GfNWHbwiPjYwPt6mM2FgD+QPpHGIEFlrS3ctLxUwZHHtWbs
         ChBq6I4gAonbvoqcnMCfiQrOexA1Bk6DuUL/2yopFSX8xjNcokJKRvfYgrTsxHmuIday
         A3exS982/UOyvUX3xXyDNfWsRtafGsZ1ZZhm0FPXClVkuhNjVFeekQg7i50Z7fC4DKCr
         vfOQ==
X-Gm-Message-State: AOAM5323IFUjP4B+LkS0hNyz1LoLiwtCduSHfasX1zZ5O/khT0h4CDxN
        hB6EKXaKJ4pniemPL4l2otq8E518bLwUYof9kZoQWuyMTwk=
X-Google-Smtp-Source: ABdhPJxBsezEc8STQRX9tDLqC2eWAW+AY62pnK3hgFS5UbphzvcBPKkjl1yxpmR7/r0a7FlrApk+uK6ScI0166W5tFg=
X-Received: by 2002:a17:902:900c:b029:da:b7a3:d83a with SMTP id
 a12-20020a170902900cb02900dab7a3d83amr2010763plp.57.1607521913989; Wed, 09
 Dec 2020 05:51:53 -0800 (PST)
MIME-Version: 1.0
References: <20201209100152.2492072-1-dvyukov@google.com>
In-Reply-To: <20201209100152.2492072-1-dvyukov@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 9 Dec 2020 14:51:43 +0100
Message-ID: <CAAeHK+z-cWhLGv4qV20_4Ddacw9wSJTsAWoodEJ_L0rohR5p9g@mail.gmail.com>
Subject: Re: [PATCH] kcov: don't instrument with UBSAN
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 11:01 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Both KCOV and UBSAN use compiler instrumentation. If UBSAN detects a bug
> in KCOV, it may cause infinite recursion via printk and other common
> functions. We already don't instrument KCOV with KASAN/KCSAN for this
> reason, don't instrument it with UBSAN as well.
>
> As a side effect this also resolves the following gcc warning:
>
> conflicting types for built-in function '__sanitizer_cov_trace_switch';
> expected 'void(long unsigned int,  void *)' [-Wbuiltin-declaration-mismatch]
>
> It's only reported when kcov.c is compiled with any of the sanitizers
> enabled. Size of the arguments is correct, it's just that gcc uses 'long'
> on 64-bit arches and 'long long' on 32-bit arches, while kernel type is
> always 'long long'.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> ---
>  kernel/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/Makefile b/kernel/Makefile
> index aac15aeb9d69..efa42857532b 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -34,8 +34,11 @@ KCOV_INSTRUMENT_extable.o := n
>  KCOV_INSTRUMENT_stacktrace.o := n
>  # Don't self-instrument.
>  KCOV_INSTRUMENT_kcov.o := n
> +# If sanitizers detect any issues in kcov, it may lead to recursion
> +# via printk, etc.
>  KASAN_SANITIZE_kcov.o := n
>  KCSAN_SANITIZE_kcov.o := n
> +UBSAN_SANITIZE_kcov.o := n
>  CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack) -fno-stack-protector
>
>  obj-y += sched/
> --
> 2.29.2.576.ga3fc446d84-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
