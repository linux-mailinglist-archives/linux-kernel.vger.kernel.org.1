Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABCC2F8355
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbhAOSJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbhAOSJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:09:50 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8956BC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:09:10 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id b8so5116638plx.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GeuXFTMHH/dqlLS30TqVtIZ+iZRqb8fjBFP+mG2mN+E=;
        b=Xpx51qo9Kemp9C08NnM+/vvKtmkeN700Xd2RXiEx9imbbsKJrIovSuD9Eq+cLLBRSG
         1myDAIHn1uYpi5wMOauhn1wJxnNKW88XyT4P3oeRvlHrKKAO6WX/DdOWCy9nxbzUEpNK
         VR9FIK54FhxjPif+hcQY5QqwWE1FuJCf1EujuCzF0VTmu1Muyf8aEdMya+psKYcEP2FC
         bSBoMaZoyHxMWhdIs1mQ4NUFMYXG3alZvxPtMkXayqpan5YI7VZPLrVsZCuYpn+ZXvOm
         776ncNs78b2pCIQnWyyj6XGlnZk9LOHuWXxqr02wc06nGO6A7Xo3QX8O9ShXN4PIhTlf
         LBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GeuXFTMHH/dqlLS30TqVtIZ+iZRqb8fjBFP+mG2mN+E=;
        b=a6f/6+Tja9XEnZfyHhvxPxIHKQBcP80MlmMxUuSVTaMU7emgTYwLCwXeyTyGgNDi7h
         5u4YgBhhiHgUuZ1UwYQWsdg+97t+lwybke2nMBwMxYJwjtZ0cHO9ShQzkCqkyv+xUWq2
         AajAFsc2Zjl19N0ul+78KUZVIfTL/oFzlbmZxpWT7+7wUUz7xQlQBfqxD1/pG1Lcg32f
         jCKXSf60Fzp6/tlphw/bnl24eTCmLUXxvS9e/CkCnbjFvl+z8O7FSUcODPFKz98ETfRC
         IPc7+njJ3JEXOBid/MHIGCXzql66jSavGUUiL8IJuk/XC38Gnvq3EVG2KtmLb2oaFnFr
         UjTg==
X-Gm-Message-State: AOAM531TjgzIIW9pWeWKPqH3QPFmEjonjJ/WVjit3Cq44GhD3cpRInoX
        0E4vz9DItH8G95Rlg8ygT3ScTI/e/MsULwij3Ajo5A==
X-Google-Smtp-Source: ABdhPJzNbllQto9hwL/hLOtREAy9hdEgCBOaHkZMrbkIngkRxP3KA/e7z9cQRQcPdWhR3yD4nVi9m8qtj4aod37PQo8=
X-Received: by 2002:a17:902:ff06:b029:de:362c:bd0b with SMTP id
 f6-20020a170902ff06b02900de362cbd0bmr13048327plj.13.1610734149962; Fri, 15
 Jan 2021 10:09:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610731872.git.andreyknvl@google.com> <ff30b0afe6005fd046f9ac72bfb71822aedccd89.1610731872.git.andreyknvl@google.com>
 <20210115175922.GI16707@gaia>
In-Reply-To: <20210115175922.GI16707@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 15 Jan 2021 19:08:59 +0100
Message-ID: <CAAeHK+xGDcd1DQVGU-WX+5aM6+0dO08xp20YBLPUJj0i3RWGKQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kasan, arm64: fix pointer tags in KASAN reports
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 6:59 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Jan 15, 2021 at 06:41:53PM +0100, Andrey Konovalov wrote:
> > As of the "arm64: expose FAR_EL1 tag bits in siginfo" patch, the address
> > that is passed to report_tag_fault has pointer tags in the format of 0x0X,
> > while KASAN uses 0xFX format (note the difference in the top 4 bits).
> >
> > Fix up the pointer tag for kernel pointers in do_tag_check_fault by
> > setting them to the same value as bit 55. Explicitly use __untagged_addr()
> > instead of untagged_addr(), as the latter doesn't affect TTBR1 addresses.
> >
> > Link: https://linux-review.googlesource.com/id/I9ced973866036d8679e8f4ae325de547eb969649
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>
> Unless there are other comments, I'll queue this for -rc5 through the
> arm64 tree (I already finalised the arm64 for-next/fixes branch for this
> week).

Sounds good, thank you!
