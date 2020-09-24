Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E28277057
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgIXLzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbgIXLzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:55:10 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC55C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 04:55:10 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 95so2809745ota.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 04:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ztRBPPvDaKOY/eanG9V3sp2lDW4LO5Tox/N9KiU+s4o=;
        b=KC3r+MptjH/RTy/874CBDG3LrIXfP8feQfAP7+/hMMMj/ti8ELR6KiicqyT2j9kmNl
         c89a6PBl1YAx7bbrDpZyNXZyhdK5ikYEIaSwbEWQmmwElvCPxips6yC+c8Ay6AEsndDf
         iRbwt9rhwrrTNe1XfSbpjOYKZryKtm7Eneiq7JPsUbPsW5Ivjrik88zf2y+f3ExpS4yS
         wUqLwJBMbDHQ6TXzOVVHl+Mk7PeHPBIbOKJkI7jIvqmRtAMgVfFXBlc8VA3lPG2w7SQ4
         IGJpuwjS4zIt1ijLDM0JeJ26vpi18keWgLQdMOQjUzYH1SlD9SKzLWiUOtBadyDYiMhQ
         i95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ztRBPPvDaKOY/eanG9V3sp2lDW4LO5Tox/N9KiU+s4o=;
        b=Ku5zsGQrunRF3HGcKT/uXHyiK66K1OxcLot3dqQr9W6l2WsNwQY2Bv5XD5Yrdzmk6T
         EpD2iVNX0tA8S0pndpnDKoU2wh0Y4zsZ4+XejO5CX1REECsL66twHqa3T90qv+aC/2OY
         vYIeYpMeHEhV6iPhOkjnj8gFfK1UNfnqO6nkgfi9rQxIuPXvIRh2unvwiCb/XAIRcYBE
         Kkew/jUpjzYX99gD05Sznen4KSaSXP9PJenNta8TddyQh2cIsXfml5izUa+x+A3YKM+9
         pCFkXqS78rhp4UDYq7nqUdmPBCCZMBAPAV/NWls/N/yY2sDItE8lEMQEXpDdySCYuncP
         Civg==
X-Gm-Message-State: AOAM5311GLJHaDlIDYrGcFbXt6mOQny2KcIynv49Q9do2m6me2cTKSaA
        xLvMnrtPH5BGwFP/32ukD47ynaTEtDvUfpde3q1FZQ==
X-Google-Smtp-Source: ABdhPJzEBQ4Ct/h1arzvWDi0y14t62r2NGPwfHNLNhHfWH4WnG/J9sJadnKxxKmmnRROfMojYyJ8YHirAvneUEUwmno=
X-Received: by 2002:a9d:758b:: with SMTP id s11mr2619746otk.251.1600948508986;
 Thu, 24 Sep 2020 04:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200924040513.31051-1-walter-zh.wu@mediatek.com> <CAG_fn=W2dcGKFKHpDXzNvbPUp3USYyWi2DEpEewboqYBodnSsQ@mail.gmail.com>
In-Reply-To: <CAG_fn=W2dcGKFKHpDXzNvbPUp3USYyWi2DEpEewboqYBodnSsQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 24 Sep 2020 13:54:57 +0200
Message-ID: <CANpmjNNmeqfMLZ0aFC49fHTYS5k7BqTZHP4FmDc=sfZe+j6bOg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] kasan: print timer and workqueue stack
To:     Alexander Potapenko <glider@google.com>
Cc:     Walter Wu <walter-zh.wu@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 at 13:47, Alexander Potapenko <glider@google.com> wrote:
>
> On Thu, Sep 24, 2020 at 6:05 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> >
> > The aux_stack[2] is reused to record the call_rcu() call stack,
> > timer init call stack, and enqueuing work call stacks. So that
> > we need to change the auxiliary stack title for common title,
> > print them in KASAN report.
> >
> > Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > Suggested-by: Marco Elver <elver@google.com>
> > Acked-by: Marco Elver <elver@google.com>
> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
> > Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > Cc: Alexander Potapenko <glider@google.com>
> > ---
> >
> > v2:
> > - Thanks for Marco suggestion.
> > - We modify aux stack title name in KASAN report
> >   in order to print call_rcu()/timer/workqueue stack.
> >
> > ---
> >  mm/kasan/report.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > index 4f49fa6cd1aa..886809d0a8dd 100644
> > --- a/mm/kasan/report.c
> > +++ b/mm/kasan/report.c
> > @@ -183,12 +183,12 @@ static void describe_object(struct kmem_cache *cache, void *object,
> >
> >  #ifdef CONFIG_KASAN_GENERIC
> >                 if (alloc_info->aux_stack[0]) {
> > -                       pr_err("Last call_rcu():\n");
> > +                       pr_err("Last potentially related work creation:\n");
>
> This doesn't have to be a work creation (expect more callers of
> kasan_record_aux_stack() in the future), so maybe change the wording
> here to "Last potentially related auxiliary stack"?

I suggested "work creation" as it's the most precise for what it is
used for now.

What other users do you have in mind in future that are not work creation?
