Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E306929618B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901295AbgJVPQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509933AbgJVPQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:16:08 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01961C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 08:16:08 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e6so1268856qtw.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 08:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z3vmtV0NaowwAl/bkuJPmHs13M06Kmq+h1vxwA4hLas=;
        b=pu4/oIE96b9WepM1KyYgDHEbBJpHXDkiB0Rc3gA4iHoiWv7uqBRDM2rNU71uBrXzIK
         z/RSgcF+IqGFQwlvjRUdhEAi1RWf6YDVM2IS/E22uZQAnB4ixbJjgZMkedtOl9JV6QHM
         TbuewAXGqlRIvn12XGaxHRRYFBQNSPA9wEY+VGn83227qfjQQMX9uycQ5HrEHdHoddCu
         Pvfdyy11QRd6fWp8M5j38eFs7rcdyALz4fKr1GPWpePcfi0+LDOIbA3IGOuOF40dNCMo
         3T+HGTAiLSB8NNiB7TVtY9OrtlNyWvZGktJ2QlqtrNTMh1DxJjjyIRUSj7xlracCmUOo
         y40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z3vmtV0NaowwAl/bkuJPmHs13M06Kmq+h1vxwA4hLas=;
        b=s0N4VFA/A6RN8m1fG+ecBM5YPa/gquz4YShUH5rs37YTYoG41JXvqglaHoaotgabLb
         LEeVVvdLbOUGynp68+1KdQvq9BEQOGTRIZ3akf0uDplX+AjqG4hLl2/NMJntEbt+CNpz
         oM+7gd5AuAbh5AHyz81Y0pF2dy5QfUZ1T8mG6RI1u4opMSPB4pJ77yuZ6dcd2qbXO5Cf
         +V/sT7pN7B7fuwQJuu4bwEPe5x9TAG4Zay6etzRk7OYWX8tTNP2Vz8S7naCL6WCFee9w
         zalTuoUrjBvwWlNFNuQpAx+DmPzqQaPduOaseHHxJhNVy7AlzPXq+Yy6R/KnABZWa+Hd
         6cKg==
X-Gm-Message-State: AOAM531S2iBV4SCfxiA40IlgtVOI8h66aB9X5jkHH4uSjJQCXBR/c8Jy
        Q45CuqGa8TIJGgUpclhRkF62Lqo9yfnIlurkboZVNQ==
X-Google-Smtp-Source: ABdhPJxuQ/BA6vpJQzxhrqMGyXaPlsQefVCsoiVd55h1woFQfeiMP0sUtRl8Gzy2ahMruP98DbRdMsq8wSMVueYCGQ8=
X-Received: by 2002:ac8:928:: with SMTP id t37mr2588192qth.67.1603379766837;
 Thu, 22 Oct 2020 08:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com>
In-Reply-To: <cover.1603372719.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 22 Oct 2020 17:15:55 +0200
Message-ID: <CACT4Y+bVCADgzweb_gmC9f7m_uc5r73scLPy+D3=Tbf2DFqb6g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/21] kasan: hardware tag-based mode for
 production use on arm64
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 3:19 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> This patchset is not complete (hence sending as RFC), but I would like to
> start the discussion now and hear people's opinions regarding the
> questions mentioned below.
>
> === Overview
>
> This patchset adopts the existing hardware tag-based KASAN mode [1] for
> use in production as a memory corruption mitigation. Hardware tag-based
> KASAN relies on arm64 Memory Tagging Extension (MTE) [2] to perform memory
> and pointer tagging. Please see [3] and [4] for detailed analysis of how
> MTE helps to fight memory safety problems.
>
> The current plan is reuse CONFIG_KASAN_HW_TAGS for production, but add a
> boot time switch, that allows to choose between a debugging mode, that
> includes all KASAN features as they are, and a production mode, that only
> includes the essentials like tag checking.
>
> It is essential that switching between these modes doesn't require
> rebuilding the kernel with different configs, as this is required by the
> Android GKI initiative [5].
>
> The patch titled "kasan: add and integrate kasan boot parameters" of this
> series adds a few new boot parameters:
>
> kasan.mode allows choosing one of main three modes:
>
> - kasan.mode=off - no checks at all
> - kasan.mode=prod - only essential production features
> - kasan.mode=full - all features
>
> Those mode configs provide default values for three more internal configs
> listed below. However it's also possible to override the default values
> by providing:
>
> - kasan.stack=off/on - enable stacks collection
>                        (default: on for mode=full, otherwise off)
> - kasan.trap=async/sync - use async or sync MTE mode
>                           (default: sync for mode=full, otherwise async)
> - kasan.fault=report/panic - only report MTE fault or also panic
>                              (default: report)
>
> === Benchmarks
>
> For now I've only performed a few simple benchmarks such as measuring
> kernel boot time and slab memory usage after boot. The benchmarks were
> performed in QEMU and the results below exclude the slowdown caused by
> QEMU memory tagging emulation (as it's different from the slowdown that
> will be introduced by hardware and therefore irrelevant).
>
> KASAN_HW_TAGS=y + kasan.mode=off introduces no performance or memory
> impact compared to KASAN_HW_TAGS=n.
>
> kasan.mode=prod (without executing the tagging instructions) introduces
> 7% of both performace and memory impact compared to kasan.mode=off.
> Note, that 4% of performance and all 7% of memory impact are caused by the
> fact that enabling KASAN essentially results in CONFIG_SLAB_MERGE_DEFAULT
> being disabled.
>
> Recommended Android config has CONFIG_SLAB_MERGE_DEFAULT disabled (I assume
> for security reasons), but Pixel 4 has it enabled. It's arguable, whether
> "disabling" CONFIG_SLAB_MERGE_DEFAULT introduces any security benefit on
> top of MTE. Without MTE it makes exploiting some heap corruption harder.
> With MTE it will only make it harder provided that the attacker is able to
> predict allocation tags.
>
> kasan.mode=full has 40% performance and 30% memory impact over
> kasan.mode=prod. Both come from alloc/free stack collection.
>
> === Questions
>
> Any concerns about the boot parameters?

For boot parameters I think we are now "safe" in the sense that we
provide maximum possible flexibility and can defer any actual
decisions.

> Should we try to deal with CONFIG_SLAB_MERGE_DEFAULT-like behavor mentioned
> above?

How hard it is to allow KASAN with CONFIG_SLAB_MERGE_DEFAULT? Are
there any principal conflicts?
The numbers you provided look quite substantial (on a par of what MTE
itself may introduce). So I would assume if a vendor does not have
CONFIG_SLAB_MERGE_DEFAULT disabled, it may not want to disable it
because of MTE (effectively doubles overhead).
