Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010172770A9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgIXMLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbgIXMLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:11:16 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D95C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:11:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v12so3345614wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TiwIu7mMni6DjsCfBHchRdA5CVaKLnFCdFVAp2ZYt6o=;
        b=amEBg3SanzowDpC8L92uFg1ii7jV8LSSaNhWsKDtzwGtMovPxnbrJScIct8Zbyhr2j
         kVBzfZ1zinNcK2dFmMHRf/ZxGy8tk+l35+9s3Uee/2IBwq4maZ23K/xb0ucg2z+iF60D
         VghPJMbTFUiJD+BIm7Nv3yVp2i7LNIpCLXwubebZovuHDOf2Acf+yDInfa4mWBU33TE5
         7fC3orT+PJq01qgwR5RkcyWUqfyOYcRFBM/qaGrU+CbDHlXhbBPIRFnaT/k5g/pkYtxF
         eXrzgC4Id9nqF9Ru+y4M0nZkR/y2/OVG2b0BDLmj6kIxX1AUlejcBHQ2SQjR0CT1z60c
         KInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TiwIu7mMni6DjsCfBHchRdA5CVaKLnFCdFVAp2ZYt6o=;
        b=bknOFuI/RBq0shcmhS2dyWXkR6wr2ChwWBS2CHdaoSH0BvA1FPz0YKlK9+9Q88xYKU
         Rz2jzURiVPyOhoOd5D4YWjiY0SNW24dz0ElBggc01hrbz3uN1O5cEoS/NTJCgz1AXLtu
         hdC6hiwVNLrWqMqXElYpor8ehFYiqIvQ314Haqa3JkNse8KS8xCeW7M8cqgThQR5viBh
         IAGaBABCR2DKqnL9gkzRpStVMthwpiGX2zUuBYjImbSfysfCfLncn4WqdS5QsNXGFppo
         z+a1JVr4e5Zus4q1AYeWS2dQl/WirLokRRmPPqDIILpCnX8ojM2K9OZn+fUIaexNqEeS
         Cl/g==
X-Gm-Message-State: AOAM533slLGdM8suC8D+7D4/VLczOWr6tgn1KZxckOKRGcARbl/ZH22C
        sjL85vRBsqRvBw2Dtngb6LoNJIHEgiecxoylJE+32A==
X-Google-Smtp-Source: ABdhPJzqXJqvh9i9Yw6uLQNsbhwEBrflRLruFC3gZHk6n9wh9Uk8sJJvov5IlWMP+9EB36a75P1Ve+qHwO/igHHpvVw=
X-Received: by 2002:a7b:c182:: with SMTP id y2mr4671696wmi.21.1600949474250;
 Thu, 24 Sep 2020 05:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200924040513.31051-1-walter-zh.wu@mediatek.com>
 <CAG_fn=W2dcGKFKHpDXzNvbPUp3USYyWi2DEpEewboqYBodnSsQ@mail.gmail.com> <CANpmjNNmeqfMLZ0aFC49fHTYS5k7BqTZHP4FmDc=sfZe+j6bOg@mail.gmail.com>
In-Reply-To: <CANpmjNNmeqfMLZ0aFC49fHTYS5k7BqTZHP4FmDc=sfZe+j6bOg@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 24 Sep 2020 14:11:03 +0200
Message-ID: <CAG_fn=UFnju7qBw2FC8nGxTKQ5VB2QeG-DKik_t=eWzu6p+H6A@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] kasan: print timer and workqueue stack
To:     Marco Elver <elver@google.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 1:55 PM Marco Elver <elver@google.com> wrote:
>
> On Thu, 24 Sep 2020 at 13:47, Alexander Potapenko <glider@google.com> wro=
te:
> >
> > On Thu, Sep 24, 2020 at 6:05 AM Walter Wu <walter-zh.wu@mediatek.com> w=
rote:
> > >
> > > The aux_stack[2] is reused to record the call_rcu() call stack,
> > > timer init call stack, and enqueuing work call stacks. So that
> > > we need to change the auxiliary stack title for common title,
> > > print them in KASAN report.
> > >
> > > Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > > Suggested-by: Marco Elver <elver@google.com>
> > > Acked-by: Marco Elver <elver@google.com>
> > > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > > Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
> > > Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > > Cc: Alexander Potapenko <glider@google.com>
> > > ---
> > >
> > > v2:
> > > - Thanks for Marco suggestion.
> > > - We modify aux stack title name in KASAN report
> > >   in order to print call_rcu()/timer/workqueue stack.
> > >
> > > ---
> > >  mm/kasan/report.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > > index 4f49fa6cd1aa..886809d0a8dd 100644
> > > --- a/mm/kasan/report.c
> > > +++ b/mm/kasan/report.c
> > > @@ -183,12 +183,12 @@ static void describe_object(struct kmem_cache *=
cache, void *object,
> > >
> > >  #ifdef CONFIG_KASAN_GENERIC
> > >                 if (alloc_info->aux_stack[0]) {
> > > -                       pr_err("Last call_rcu():\n");
> > > +                       pr_err("Last potentially related work creatio=
n:\n");
> >
> > This doesn't have to be a work creation (expect more callers of
> > kasan_record_aux_stack() in the future), so maybe change the wording
> > here to "Last potentially related auxiliary stack"?
>
> I suggested "work creation" as it's the most precise for what it is
> used for now.

I see, then maybe my suggestion is premature.

> What other users do you have in mind in future that are not work creation=
?

I think saving stacks may help in any case where an object is reused
for a different purpose without reallocation.
SKBs, maybe?


--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
