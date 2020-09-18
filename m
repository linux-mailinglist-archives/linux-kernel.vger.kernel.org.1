Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B585926FC7A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgIRM2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRM2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:28:23 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2000C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 05:28:23 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l191so3388097pgd.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 05:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P7ycjQB8Qf5Z6caxe0rnViEryCtRi9d3yDaiZcexIRY=;
        b=u/tah1KnDN7AwVodlKOD8a5jgACdXBLjP747bAXJdF4JUpQapXTX2BMOWMRsWgN3ED
         zLgHnmmXcPJh5i0LeM0jTmIh6wAWHs6iN7v84cbUCXblyIc+VDePlVCbdOKHp3hNkd9S
         OCL7aRuQO+0IEW7L8mxgJfP6B6F2TSAPZCg9ffhf/cH/8yNqeidBrGWUEIuWqc+kA4VM
         ec76S2zcbGev4oSQFOhZxwPkjVXYMXBTCw3hL1ExXrLXnj/TEp6F526lui6nVsNVrFAu
         ro91FuS7bETUiT8qKo7BxBCzUxOPqH3rWZCI0UgrSI+lbMbypKSrhn8SDq4RdPkZHJWp
         v37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P7ycjQB8Qf5Z6caxe0rnViEryCtRi9d3yDaiZcexIRY=;
        b=fpiO8K5Cdig2xGZLzLENj6YsyYbV9qVx6p4pBQVYOc0CYBI4705/LyVrpkMoJPyL7Q
         kbWWB/jhlYOxHuZYM1znnx3RudVeUWjPvoh0GXv+dDA9wnDWBCGUZATOUYdiqX1zjnxm
         LJEsNzSiDuZLudtJQs/CBDJcdVGrCGjF/pcbWq0Iq4QAP+YBQLwgwEoTzABRx/gPc28L
         WZJzf5Nbk4z/N2GnDVD5UF152MHd5XFEkZM2vSr6YoA2MvbWe4/2G4viXcbQ3eIBVSL1
         Q8og3aJFYkcag2n6ngqTF8Mk9lvIRby4GYCvGTWFVNzNtq4UclhN5VVGpXCt4E9Qd6gI
         fbLw==
X-Gm-Message-State: AOAM533ClM4RPmRG/4uKBPmt63o5cldTEmMJ5MdfZTVVg6jh3bJOk1EE
        w09WheV9g8XPskgAbjIqi3ytZdsCwfnvk1Tg8sEANw==
X-Google-Smtp-Source: ABdhPJzqgzII0KaPdRre+oDC1j0bJsqSfsNy17fKfcsSiid/f2qZ0J/MyTPJ9hBmQA5hX2keVUFvawszd+z5Uq9+aG8=
X-Received: by 2002:a63:2209:: with SMTP id i9mr21795613pgi.130.1600432101917;
 Fri, 18 Sep 2020 05:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com> <74133d1a57c47cb8fec791dd5d1e6417b0579fc3.1600204505.git.andreyknvl@google.com>
 <20200918104650.GA2384246@elver.google.com>
In-Reply-To: <20200918104650.GA2384246@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 18 Sep 2020 14:28:11 +0200
Message-ID: <CAAeHK+zxJqQ3v_K7UkMMMrz73+3LQwZctDGngrJabXtiXU5YvA@mail.gmail.com>
Subject: Re: [PATCH v2 33/37] kasan, arm64: implement HW_TAGS runtime
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 12:46 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Sep 15, 2020 at 11:16PM +0200, Andrey Konovalov wrote:
> [...]
> >  arch/arm64/include/asm/memory.h   |  4 +-
> >  arch/arm64/kernel/setup.c         |  1 -
> >  include/linux/kasan.h             |  6 +--
> >  include/linux/mm.h                |  2 +-
> >  include/linux/page-flags-layout.h |  2 +-
> >  mm/kasan/Makefile                 |  5 ++
> >  mm/kasan/common.c                 | 14 +++---
> >  mm/kasan/kasan.h                  | 17 +++++--
> >  mm/kasan/report_tags_hw.c         | 47 +++++++++++++++++++
> >  mm/kasan/report_tags_sw.c         |  2 +-
> >  mm/kasan/shadow.c                 |  2 +-
> >  mm/kasan/tags_hw.c                | 78 +++++++++++++++++++++++++++++++
> >  mm/kasan/tags_sw.c                |  2 +-
> >  13 files changed, 162 insertions(+), 20 deletions(-)
> >  create mode 100644 mm/kasan/report_tags_hw.c
> >  create mode 100644 mm/kasan/tags_hw.c
> [...]
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index 77c4c9bad1b8..5985be8af2c6 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -358,7 +358,6 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
> >       smp_init_cpus();
> >       smp_build_mpidr_hash();
> >
> > -     /* Init percpu seeds for random tags after cpus are set up. */
>
> Why was the comment removed and not updated?

Will fix in v3, thanks!
