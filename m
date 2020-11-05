Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0272A84DA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbgKER1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKER1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:27:43 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6171C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 09:27:43 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 10so1893483pfp.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 09:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuHzlMA7AoHCHwuNKz7UkjzBoF493bgOUUuEIK52/Ng=;
        b=jTkbl9gKmVYO+cklCUCK9GhPlwXZpP/eRPazY+vkRQOXb2zNd1Tae+l9SHSVBeDyta
         hoQxUZ12h+s+kk976C5uM/mgr6PRi1eY5qYbmdLZPmwg4U1AyurkhJ+/gR13Tzr59Gyt
         xYMMFMf4ZgnHj0/EHdA3fEQ8rP8KOpwFbP6l3HrFMknBh/HjK4Dn5njwqLxfMKYySuoC
         ftufPWBWeVCQDyWf6NIjADSczrqR1kySP8rtAgBxwZ7worfq1nISp/eMSqurFQ6K5+pT
         3Y/ReZjdEwpdqM8ywGfmRn4Ph5+AUh9e8Y/Rs/rFfX8AUbIIPuyRZfWhxxmsLb2rzWGd
         PMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuHzlMA7AoHCHwuNKz7UkjzBoF493bgOUUuEIK52/Ng=;
        b=Ea6X2k8Tz/kdbPFF1YCCwEPQFih2Zufd/bV6j1AxDzwhDvdcLwN8nxd1xZePKmg+yv
         0P7dOCyVo9dkUQiQB82MlzZGfn16IxOlfJ+gMsilHXu9c96Ctn9hfpFL7s7Ao8NePppg
         8KYgVGt9L8KLjuMzezZcmI5txR65vW0yMzyavKGmN8xFLjezBPw3HPeXhtaglFPFfZkt
         vNQOYtdIHF9IAohI3lV87gxe5EGZI5+Is4cJtVmem+Hcus5CISQWLzujxO17F3LyIBJB
         usThE5gRGdBy/++4X82QTNGZPqEnrvG0hGJurFmaKhP19NBBu7LJQ5+O3vCUhZlQ51U4
         /a2g==
X-Gm-Message-State: AOAM532+hrPDN/CQBkHjjos2RzdZ8fLfza4lF7ncFV4Bt06VGfUJrCot
        hHBr8e16VVFyJwf69QtjY3UBA3Ju5qDFoc+mEmYUbg==
X-Google-Smtp-Source: ABdhPJzm8rx2kfyU6P+3/OZ5yfCI1h38ArCi88KHBja812HJd/VliAbeXcpV/Z3RBiGsSE5gLPMUKkHrAFo656qk1Jk=
X-Received: by 2002:a62:cec6:0:b029:18a:d620:6b86 with SMTP id
 y189-20020a62cec60000b029018ad6206b86mr3384207pfg.2.1604597263116; Thu, 05
 Nov 2020 09:27:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com> <5e3c76cac4b161fe39e3fc8ace614400bc2fb5b1.1604531793.git.andreyknvl@google.com>
 <58aae616-f1be-d626-de16-af48cc2512b0@arm.com> <CAAeHK+yfQJbHLP0ja=_qnEugyrtQFMgRyw3Z1ZOeu=NVPNCFgg@mail.gmail.com>
 <1ef3f645-8b91-cfcf-811e-85123fea90fa@arm.com> <CAAeHK+zuJtMbUK75TEFSmLjpu8h-wTfkra1ZGV533shYKEYi6g@mail.gmail.com>
 <090ab218-8566-772b-648f-00001413fef2@arm.com>
In-Reply-To: <090ab218-8566-772b-648f-00001413fef2@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 5 Nov 2020 18:27:32 +0100
Message-ID: <CAAeHK+y+F+A8-5_ouc8E8UEPGf8L0fFUVXGo3jAiNFpx_GorrA@mail.gmail.com>
Subject: Re: [PATCH v8 30/43] arm64: kasan: Allow enabling in-kernel MTE
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 3:14 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
>
>
> On 11/5/20 12:14 PM, Andrey Konovalov wrote:
> > On Thu, Nov 5, 2020 at 12:39 PM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> >>
> >> On 11/5/20 11:35 AM, Andrey Konovalov wrote:
> >>> This will work. Any preference on the name of this function?
> >>>
> >>
> >> I called it in my current iteration mte_enable(), and calling it from
> >> cpu_enable_mte().
> >>
> >>> Alternatively we can rename mte_init_tags() to something else and let
> >>> it handle both RRND and sync/async.
> >>
> >> This is an option but then you need to change the name of kasan_init_tags and
> >> the init_tags indirection name as well. I would go for the simpler and just
> >> splitting the function as per above.
> >>
> >> What do you think?
> >
> > OK, let's split. mte_enable() as a name sounds good to me. Both
> > functions will still be called one right after another from
> > kasan_init_hw_tags (as it's now called) though. I think the name
> > works, as it means initializing the hw_tags mode, not just the tags.
> >
>
> I agree. When you finish with v9, could you please provide a tree with both the
> sets on top similar to [1]? I would like to repeat the tests (ltp + kselftests)
> and even to rebase my async code on top of it since we are aligning with the
> development.
>
> [1] https://github.com/xairy/linux/tree/up-boot-mte-v1

Sure, will share the trees, probably later today.
