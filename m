Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35942A6B82
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 18:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbgKDRTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 12:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgKDRTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 12:19:16 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E25C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 09:19:15 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 133so17821118pfx.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 09:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BRsEpVNsm2U1NymzNtz6XZIq+7ItUy82ketxZkuXZwY=;
        b=BhZZuTp0/QIvexEoXZPbTPRf2cfsueCch8zI5Zhxb093KLRTJY+fHugH/r73VuI4tY
         d+fAtoxngBM4Y4qohXDGNuFslGE+MA5QEl/0zG1zj0vOPeNg5fjPTuPcnt5m4lFT2GJp
         eIVKqUekMURLiVGf3EIijSXX6Nwx7o68GlLqKwX/Gw/78P5XTN3+EHf/qba4DZoNxlfL
         CL8xgWFwYTKrW3CELCkgOVkj4qcAZUNNnMUrGGA7YYGm5tfMXWge9CiI0NRlji7KxYVC
         Zv08LDLZSGWX/xbR80kTdHf+38p3uADSk+hg9j2jwdX40VCU6Ap+XJJHwnvwoXh5/395
         5xuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BRsEpVNsm2U1NymzNtz6XZIq+7ItUy82ketxZkuXZwY=;
        b=T/Gk8J4VF+GD2ZC/EU8CUXtizUdYTefI6PYTb7/l1eBdm4ACx4L1np9vzG6jGIR4KW
         yh7g4BjS/VMSL8CLCbrNRpyjZrs7Bx1giAFLIndZcooWfXL1Uht1hoiehHcji3ZNU6te
         Vm+5HGSKH0YSv/27U9/Ce71FuhNfQXZ2VsCHCgJvy35RjL0O+7Eyufp3vsUEqRwS0Nxo
         MDeqC4n/vYayVk/NA/DzPnpwdrIIirTuNisyniHHtwnKOcdzAWZ14Qp3ny3LIQwy8Wbz
         oNJKWr4Hhijlo//58PrCFtyUrTkH2r2k3i8HzSWmowZ+gObYmoJZWpF+05wBnzlt/UV+
         kTwg==
X-Gm-Message-State: AOAM532BgHlxn3puBNsg1fOlRR3m6XZBEsOWiGFZ9Sci8gzENrzEF4HF
        Mn0SNy4dNCBVJJf7MWIvsE9/rYC2LSTmG5fBQvPiuA==
X-Google-Smtp-Source: ABdhPJzFbayKhmMuEehGo3Dh12S4PFAtpzryjtVLlw6bITSaSTyvm1L55WRBMK6jGSWjJFts+7eidQU4VP2TGxn0zqY=
X-Received: by 2002:a17:90a:eb02:: with SMTP id j2mr5124452pjz.136.1604510354459;
 Wed, 04 Nov 2020 09:19:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com> <5e7c366e68844a0fe8e18371c5a76aef53905fae.1604333009.git.andreyknvl@google.com>
In-Reply-To: <5e7c366e68844a0fe8e18371c5a76aef53905fae.1604333009.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 4 Nov 2020 18:19:03 +0100
Message-ID: <CAAeHK+z3WWTcvpaokXwnAML8hYpP==Ghw-QTNVgHUMytK=kmVw@mail.gmail.com>
Subject: Re: [PATCH v7 13/41] s390/kasan: include asm/page.h from asm/kasan.h
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 5:04 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> asm/kasan.h relies on pgd_t type that is defined in asm/page.h. Include
> asm/page.h from asm/kasan.h.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
> Change-Id: I369a8f9beb442b9d05733892232345c3f4120e0a
> ---
>  arch/s390/include/asm/kasan.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/s390/include/asm/kasan.h b/arch/s390/include/asm/kasan.h
> index e9bf486de136..a0ea4158858b 100644
> --- a/arch/s390/include/asm/kasan.h
> +++ b/arch/s390/include/asm/kasan.h
> @@ -2,6 +2,8 @@
>  #ifndef __ASM_KASAN_H
>  #define __ASM_KASAN_H
>
> +#include <asm/page.h>
> +
>  #ifdef CONFIG_KASAN
>
>  #define KASAN_SHADOW_SCALE_SHIFT 3
> --
> 2.29.1.341.ge80a0c044ae-goog
>

Hi Vasily,

Could you give your ack on this patch?

The full series is here:

https://lore.kernel.org/linux-arm-kernel/cover.1604333009.git.andreyknvl@google.com/

Thanks!
