Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5057E2F1E7F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390630AbhAKTEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbhAKTEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:04:21 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA4BC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:03:41 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id c79so514161pfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0M90n7WjWo+X1yIVKHdOTyfvfwcWqL9tkBr22HLMVsY=;
        b=mQxWWfxrpoJqQpQ0teH0JWLWjRlCD6LzwnF9DaADN1VituMO7/JZhJSc19maKjmKa0
         XAhLsG6GziZLcTS2nrs4aZgJyR1MwzUKmkGihnYT4kRyKGczg0UL7kcyLDEfJM67gV4o
         C6Qe1DfX/qHHCoZSiQr1IC3yt5haB46iMoLbiVigq5Z4Wk9LZWV1EsqDj7jVKI0Idjm+
         9FgiQytvEQ6ZkCGZeiYITKvdh+L8AFRXr2eHwaMMEDY3+zyb7fJvMawbCCycvQOicRPY
         459LZinhBEH0OuPe0NVfJ99MWMN4iZoQOUkf3GKueztCB5U3p47j+G6zeNylLPU3TE3A
         l7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0M90n7WjWo+X1yIVKHdOTyfvfwcWqL9tkBr22HLMVsY=;
        b=LBWiw5IwvNmdP7ReSwDZ6ztjbN+BxHFS+s5jCvhmw5dyysL0yi3MLuEgIJbpSfcBmn
         IRbw2e7uQP7P2GowoMcn5hpuNMhMdzsS6EGO8SQ5KQxYWwnSrn0XkqVXXMngywKagTaw
         Is/7YPWSuBto+E/xfJEjk4ZktsNMlTJrXyNKIb7AUSP9N60ANjLoEHFasZMUfs9Hv1zL
         /LDOLHTMS1Pnq0EoUQAexLWlTlAPhomfZ936WoHoRTO94zlRN0xstij3NnDH1CrCvBPK
         zNKUAIhujgmfg6N98nYhGejue442cGQDeR46q470118AJ9XvABz+5EXJ3mGfa90c5u/M
         Agog==
X-Gm-Message-State: AOAM530webm4DNYy42MlHXnWGQKj5QSCCVMGYIpPaQUlDgCng7aytv51
        mvXQtjZPODQcZPdXjAxz260J9sFXedMMWjpGVjgLIA==
X-Google-Smtp-Source: ABdhPJwE4imAaZmMhSvygLJ7bWjPPKzRbOvPeN2tNIIdl6OeQBhwMi9C6hF05YOIW4ESl/Tn4KeOeJ11tsXFRkISwUg=
X-Received: by 2002:a62:14c4:0:b029:19d:d3f5:c304 with SMTP id
 187-20020a6214c40000b029019dd3f5c304mr991822pfu.55.1610391820883; Mon, 11 Jan
 2021 11:03:40 -0800 (PST)
MIME-Version: 1.0
References: <20210108040940.1138-1-walter-zh.wu@mediatek.com>
 <CAAeHK+weY_DMNbYGz0ZEWXp7yho3_L3qfzY94QbH9pxPgqczoQ@mail.gmail.com> <20210111185902.GA2112090@ubuntu-m3-large-x86>
In-Reply-To: <20210111185902.GA2112090@ubuntu-m3-large-x86>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 11 Jan 2021 20:03:29 +0100
Message-ID: <CAAeHK+y8B9x2av0C3kj_nFEjgHmkxu1Y=5Y3U4-HzxWgTMh1uQ@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: remove redundant config option
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 7:59 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> > > -config KASAN_STACK_ENABLE
> > > +config KASAN_STACK
> > >         bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
> >
> > Does this syntax mean that KASAN_STACK is only present for
> > CC_IS_CLANG? Or that it can only be disabled for CC_IS_CLANG?
>
> It means that the option can only be disabled for clang.

OK, got it.

> > Anyway, I think it's better to 1. allow to control KASAN_STACK
> > regardless of the compiler (as it was possible before), and 2. avoid
>
> It has never been possible to control KASAN_STACK for GCC because of the
> bool ... if ... syntax. This patch does not change that logic. Making it
> possible to control KASAN_STACK with GCC seems fine but that is going to
> be a new change that would probably be suited for a new patch on top of
> this one.

The if syntax was never applied to KASAN_STACK, only to
KASAN_STACK_ENABLE, so it should have been possible (although I've
never specifically tried it).
