Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FF02F518D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbhAMR6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:58:52 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:28808 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbhAMR6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:58:51 -0500
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 10DHvsCO008110
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:57:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 10DHvsCO008110
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1610560675;
        bh=5QLVKZuMn5+SASfPyUyRYZJzylR2IbKY13Wi4rwHquM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P5ZlsuTITcTtH4fgdsfnIRQA/RNX/XwYw6hh3aXjz8I5GBF0JhiJ0OZtOiv2XE9lw
         IyjCEjvPIOggSlld3JN8PjBDTBFtFT4Gx3ZU5V+2LDN87FkLl8dcGM37oDF7051xXF
         rVoX6bNtkUEhfe/1YDj1FrN73PpW6iSXXSlTKzepLaYmcxPJiQP9Mjf+gQjlOnDIzl
         3rtesFZvnvxYANp1TIDBaYnwDtKiQSYpMYakEv+Y74mJ/Iv5iaHo4e0PRndqjygORf
         ybUEV3l7S3ylfL1u4w8WXp/kbPvvEoRh2yvzkLLZCDMF2qwdc7FNEYjF3hs2LJDrqN
         TfDmVg07oTQhw==
X-Nifty-SrcIP: [209.85.210.176]
Received: by mail-pf1-f176.google.com with SMTP id h186so1711599pfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 09:57:55 -0800 (PST)
X-Gm-Message-State: AOAM532QCENqHoNk4MDciRUXZSPdW2Ui2/Ca3SBhJ6zTjD8CU0Z/hNuz
        tTTZRYPhH3zvXfef9kx5ZjHLheACJYEI7V96amY=
X-Google-Smtp-Source: ABdhPJwe0YwDDNuydX2BebdE5MltJXjy4MJNoOanXcv5kpNBbU3IkW5nMY5kgtTSjSp+VhWkx7IipknxRKQB2gK7of8=
X-Received: by 2002:aa7:9501:0:b029:155:3b11:d5c4 with SMTP id
 b1-20020aa795010000b02901553b11d5c4mr3156162pfp.76.1610560674180; Wed, 13 Jan
 2021 09:57:54 -0800 (PST)
MIME-Version: 1.0
References: <20210112224832.10980-1-will@kernel.org> <161055398865.21762.12236232732054213928.b4-ty@arm.com>
In-Reply-To: <161055398865.21762.12236232732054213928.b4-ty@arm.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 14 Jan 2021 02:57:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNASs6dvU6D3jL2GG3jW58fXfaj6VNOe55NJnTB8UPuk2pA@mail.gmail.com>
Message-ID: <CAK7LNASs6dvU6D3jL2GG3jW58fXfaj6VNOe55NJnTB8UPuk2pA@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: Raise minimum version of GCC to 5.1 for arm64
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 1:08 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, 12 Jan 2021 22:48:32 +0000, Will Deacon wrote:
> > GCC versions >= 4.9 and < 5.1 have been shown to emit memory references
> > beyond the stack pointer, resulting in memory corruption if an interrupt
> > is taken after the stack pointer has been adjusted but before the
> > reference has been executed. This leads to subtle, infrequent data
> > corruption such as the EXT4 problems reported by Russell King at the
> > link below.
> >
> > [...]
>
> Applied to arm64 (for-next/fixes), thanks!
>
> [1/1] compiler.h: Raise minimum version of GCC to 5.1 for arm64
>       https://git.kernel.org/arm64/c/1f1244a5ddb7
>
> --
> Catalin
>


Maybe, we can raise the minimal version to gcc 5.1
for all architectures.


-- 
Best Regards
Masahiro Yamada
