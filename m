Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06B62AF3B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgKKOf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKKOfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:35:45 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E52FC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:35:45 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id d3so1062499plo.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1v3v46143qlbHKcKxAQHZCqAVPerk8jpepPtoNSlpl8=;
        b=kzsM7g5mjVJkuEB5HiVqkPejTRZ3uX+t5KkQdWxvdxmacK3WhVDtGaMLDvMTlbG0bg
         dP+tseO47eGYmYBEMMqHc8E8hmfta057cqSqNuabuVadwUvnr4UEtPhNKg5tcFOr3cag
         kjYMloQKzLw7IjGGQ5X6DP2P9DUp2bnjhvw143M3A220p5/ucAFipxM8J5SG+whatJ+y
         q5omH0pUDlSN7AOHwwHzkDoIFMQzs2X4DA5pQBXLy2Tv09fZ3GmBbGCudPcJhk/k25hT
         PQwXqSO4WdwRpfN+mw8+LwdZQlorrGYoTP6coIzBObTazsNgi0nZJr7XO4US6zj9Old2
         J3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1v3v46143qlbHKcKxAQHZCqAVPerk8jpepPtoNSlpl8=;
        b=n2LgiQiG7sYQymdJrt858J5LHDxYUcnR+MDDrhQjQHRD03vWZlFCYYlPSrzW5Tc56T
         Mj/dfGuXIYN/i4E+d8gacmA36UATwbIy5zn+gMXwqarUChwQMc4jtV6BYluINmTr1Mm6
         Gus9JOWZZjzCiHAh8kGH4XwASD8wRp5rp9yKNjCnigP/jnS5m27O8fLHW9evKRAaRLnH
         VF2u0Twp93IzHZG1TDft8Z8OxBtQtwH3ILbO7SCBcLahm/c+m1zXJwxbfQrnNPNsf8GE
         vxiwx4xTqfEnLzr02v+RP8yo/L9TCVfiux87tDRips8+PusLo+tRPHsTmnu+caat6oSZ
         AAIw==
X-Gm-Message-State: AOAM531zPPnIDlRtGDYIsPK4OLGJGHwNLZS+YOp6se5/Kfsr/6Q6qfD9
        NLdsMsHJbo2XrDp/0+K0WH40nvvyl8oBM0s1Iayb7g==
X-Google-Smtp-Source: ABdhPJxAAWhC6+QGm0h6WS7E1fx4N1/2ckmZqbqjSV1d3ARyuRGwrICUCYRPa0FITKeqIDcZ2M96ASDx4ho2MtBCuK8=
X-Received: by 2002:a17:902:d90d:b029:d6:ecf9:c1dd with SMTP id
 c13-20020a170902d90db02900d6ecf9c1ddmr21191991plz.13.1605105344448; Wed, 11
 Nov 2020 06:35:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <20201110145430.e15cb0e0d51498d961206be9@linux-foundation.org>
In-Reply-To: <20201110145430.e15cb0e0d51498d961206be9@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 11 Nov 2020 15:35:33 +0100
Message-ID: <CAAeHK+yx1dAnR9n7c5iWjXEQSab8V5xEW6hLwVba0cbc6rxvcA@mail.gmail.com>
Subject: Re: [PATCH v9 00/44] kasan: add hardware tag-based mode for arm64
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
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

On Tue, Nov 10, 2020 at 11:54 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 10 Nov 2020 23:09:57 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:
>
> > This patchset adds a new hardware tag-based mode to KASAN [1]. The new mode
> > is similar to the existing software tag-based KASAN, but relies on arm64
> > Memory Tagging Extension (MTE) [2] to perform memory and pointer tagging
> > (instead of shadow memory and compiler instrumentation).
>
> I have that all merged up on top of linux-next.  Numerous minor
> conflicts, mainly in arch/arm/Kconfig.  Also the changes in
> https://lkml.kernel.org/r/20201103175841.3495947-7-elver@google.com had
> to be fed into "kasan: split out shadow.c from common.c".
>
> I staged it after linux-next to provide visibility into potentially
> conflicting changes in the arm tree as things move forward.

Thank you very much, Andrew!

In case we need a v10, I'll do the rebase on top of mm and include the
kasan_enabled declaration fix as well.
