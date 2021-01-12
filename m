Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B5E2F2AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389496AbhALJGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:06:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:60516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730261AbhALJGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:06:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7155D22DFA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610442340;
        bh=bjd/707GK1bm6/mi1xk8Lwzjj+wCIAT2bS3UP0CKR1U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VRoncQMtHuBhXZQmQkZ+e6Oh9YdJgT+ZHakVYDJn2v8DVJJg+6t9G2exQbtIqOXgB
         vK9ix/R4FGCA0FfT4Dk1WPCfMJ7kxQWjjLh37YGwX0CB/7vGYMTLI031/U7TjG0fzL
         P37YEOs6g0OevoPFqOL+cqjeJ7UAwib50mSvez8Qh/DODpaSpJH0VfCdI/xJJ3LGrw
         A+dGN/RdcGeKhgyl1psoDYKOJOsGESrfbIL3z15GBVunUMYNeq7CuOdA36tpTaFDwT
         Dx1TorGnmXqStxms9cSGu41pCyvphMenw+zlrIBC4K2hzvYnRLFTgUVRu7tJ9DDi9B
         4xUEsgYUXYIBg==
Received: by mail-ot1-f45.google.com with SMTP id x5so1262857otp.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 01:05:40 -0800 (PST)
X-Gm-Message-State: AOAM530Do5JeE0U8kDm6EpZz+ZBx0KXLm0ky9iUnBbXYaX3XeMZnCh4q
        YqPDwrzvZjwaWi+LL4t8ra6v3xvpRsZpqstjTfg=
X-Google-Smtp-Source: ABdhPJwj3mPMmgYQ0X+AvLaM4xW5bzXHpHoZO7TjUBvmuZFCzbVPq210vv6JqOcL4kamNliDzBUPfHVmeWuiGwbdPio=
X-Received: by 2002:a05:6830:1c24:: with SMTP id f4mr2131209ote.108.1610442339716;
 Tue, 12 Jan 2021 01:05:39 -0800 (PST)
MIME-Version: 1.0
References: <20210109044622.8312-1-hailongliiu@yeah.net> <CACRpkdb73diprma9Z1-4nm5A9OTQMeGVK=Hcqiwny9VOVdA=QQ@mail.gmail.com>
 <4c009d78.4e1.176ebcf8bc9.Coremail.hailongliiu@yeah.net> <CACRpkdY7eYyVNvqMRYvTQsLNrXa+fzPsWA5JHDuS4nqry+CHcw@mail.gmail.com>
 <20210111221820.b252f44de1e0bf4add506776@linux-foundation.org>
In-Reply-To: <20210111221820.b252f44de1e0bf4add506776@linux-foundation.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 12 Jan 2021 10:05:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHengoRaQFVPmbH2hNdLK_-pLuiL6Aqcg8a=1CDvU+HpQ@mail.gmail.com>
Message-ID: <CAMj1kXHengoRaQFVPmbH2hNdLK_-pLuiL6Aqcg8a=1CDvU+HpQ@mail.gmail.com>
Subject: Re: [PATCH] arm/kasan:fix the arry size of kasan_early_shadow_pte
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ziliang Guo <guo.ziliang@zte.com.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hailong Liu <liu.hailong6@zte.com.cn>,
        Russell King <linux@armlinux.org.uk>,
        kasan-dev <kasan-dev@googlegroups.com>,
        hailong <hailongliiu@yeah.net>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Potapenko <glider@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jan 2021 at 07:19, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sun, 10 Jan 2021 13:03:49 +0100 Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > On Sun, Jan 10, 2021 at 11:21 AM hailong <hailongliiu@yeah.net> wrote:
> >
> > > >> +#ifndef PTE_HWTABLE_PTRS
> > > >> +#define PTE_HWTABLE_PTRS 0
> > > >> +#endif
> > > >
> > > >Can this even happen? We have either pgtable-2level.h or
> > > >pgtable-3level.h, both of which define PTE_HWTABLE_PTRS.
> > > >
> > >
> > > I guess not for arm. But I'm not sure for other ARCHs.
> >
> > Oh it's a generic include. Sorry for the confusion.
> >
> > All good then!
> >
>
> This code is 2+ years old.  Do we think it warrants a cc:stable?
>

Not needed - ARM only gained Kasan support this cycle, and this patch
does not affect any other architectures
