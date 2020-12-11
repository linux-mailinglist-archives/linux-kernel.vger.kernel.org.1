Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56102D767E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 14:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436754AbgLKN0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 08:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406149AbgLKNZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:25:59 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D0AC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 05:25:19 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id 7so6366560qtp.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 05:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ryeytS68C+5ik8zmhDl+p3qAmL793iAIoW0r71FZKTQ=;
        b=rWgwgSy9J0qpTRa9893I/pi3DImcYFi36DbvZ2I9pa50TPNVHr3TPXSiPN00Io5Ma5
         dsh9znKm2jKLjKwJ85Dw5P78FzX6lA/mReX9cEn4r/e6rGBDBNUh/zNgF+b8ugAYeMUb
         UAhjI+C0ed0ZkbehFjZq/raGkEgAOzsrtDWs0hSEy3QFRIgY0mjHY9dSgsiRk0m1a1fe
         iKv9/Ac0raxrm5OA1DhvfgnPMK/eUNVnoVPotPOI/4q/xdQzwFyot+CibqLTB2JC5xBs
         eQLU2dJMrQXhApRSMvCW2GR80V+8lMAyTuGu65FhmcKAXqLSPZjVToAKs8W7JXW87kF1
         kzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ryeytS68C+5ik8zmhDl+p3qAmL793iAIoW0r71FZKTQ=;
        b=stuAOPO1d7Z8Jcg3VBNCqlqibpAAZztuLDyZhQXR6h13qxLnyNpFBkNlmB/9b7TM7H
         n2IiK8KkmImPpjxnOi51gJIpf2FICShn31AmUtMkjNgridbi7k5ps926vSJ9oPhNrfI1
         PWZ5CzawgQrzouMUDnS9TNdfYk5kfdbhkj7ysRn6bVv3tc70SxvOQj0GiLZz713/N+yd
         ATyUjAn2VBXUY+rAlQDgLYczM/8mCGaSuy5O1PWqAmnbW3RebjuzpTNsbYR3tn5+y1Sf
         qAFpXmjxeanbGUFJ1pybkO60XdB2rAu9SUJ+OCApeJXok2NLlly8Zm97k5cVUTI9b63k
         Ixcw==
X-Gm-Message-State: AOAM530PXXpTk1Wo18+hQIcjCpcsVSmq354u9AuHBUkPjOgW2r/y8JUp
        B/4LChNUo4JdB71fTqZZfpTY7QrOjIAuRmDTS2E4+w==
X-Google-Smtp-Source: ABdhPJy4dLajQH+Hcp+UsY0nstqtu4WZ2F5H+1vVGW+afiVko3Wtt8LHBBRiZqRm1w3Fd3F7FBlUAKwH5Hlw02ORxB0=
X-Received: by 2002:ac8:7512:: with SMTP id u18mr15399306qtq.300.1607693118360;
 Fri, 11 Dec 2020 05:25:18 -0800 (PST)
MIME-Version: 1.0
References: <1607576401-25609-1-git-send-email-vjitta@codeaurora.org>
 <CAG_fn=VKsrYx+YOGPnZw_Q5t6Fx7B59FSUuphj7Ou+DDFKQ+8Q@mail.gmail.com> <77e98f0b-c9c3-9380-9a57-ff1cd4022502@codeaurora.org>
In-Reply-To: <77e98f0b-c9c3-9380-9a57-ff1cd4022502@codeaurora.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 11 Dec 2020 14:25:06 +0100
Message-ID: <CAG_fn=WbN6unD3ASkLUcEmZvALOj=dvC0yp6CcJFkV+3mmhwxw@mail.gmail.com>
Subject: Re: [PATCH v3] lib: stackdepot: Add support to configure STACK_HASH_SIZE
To:     Vijayanand Jitta <vjitta@codeaurora.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        dan.j.williams@intel.com, broonie@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>, qcai@redhat.com,
        ylal@codeaurora.org, vinmenon@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 1:45 PM Vijayanand Jitta <vjitta@codeaurora.org> wr=
ote:
>
>
>
> On 12/11/2020 2:06 PM, Alexander Potapenko wrote:
> > On Thu, Dec 10, 2020 at 6:01 AM <vjitta@codeaurora.org> wrote:
> >>
> >> From: Yogesh Lal <ylal@codeaurora.org>
> >>
> >> Add a kernel parameter stack_hash_order to configure STACK_HASH_SIZE.
> >>
> >> Aim is to have configurable value for STACK_HASH_SIZE, so that one
> >> can configure it depending on usecase there by reducing the static
> >> memory overhead.
> >>
> >> One example is of Page Owner, default value of STACK_HASH_SIZE lead
> >> stack depot to consume 8MB of static memory. Making it configurable
> >> and use lower value helps to enable features like CONFIG_PAGE_OWNER
> >> without any significant overhead.
> >
> > Can we go with a static CONFIG_ parameter instead?
> > Guess most users won't bother changing the default anyway, and for
> > CONFIG_PAGE_OWNER users changing the size at boot time is not strictly
> > needed.
> >
> Thanks for review.
>
> One advantage of having run time parameter is we can simply set it to a
> lower value at runtime if page_owner=3Doff thereby reducing the memory
> usage or use default value if we want to use page owner so, we have some
> some flexibility here. This is not possible with static parameter as we
> have to have some predefined value.

If we are talking about a configuration in which page_owner is the
only stackdepot user in the system, then for page_owner=3Doff it
probably makes more sense to disable stackdepot completely instead of
setting it to a lower value. This is a lot easier to do in terms of
correctness.
But if there are other users (e.g. KASAN), their stackdepot usage may
actually dominate that of page_owner.

> >> -static struct stack_record *stack_table[STACK_HASH_SIZE] =3D {
> >> -       [0 ...  STACK_HASH_SIZE - 1] =3D NULL
> >> +static unsigned int stack_hash_order =3D 20;
> >
> > Please initialize with MAX_STACK_HASH_ORDER instead.
> >
>
> Sure, will update this.
>


> >> +
> >> +static int __init init_stackdepot(void)
> >> +{
> >> +       size_t size =3D (STACK_HASH_SIZE * sizeof(struct stack_record =
*));
> >> +
> >> +       stack_table =3D vmalloc(size);
> >> +       memcpy(stack_table, stack_table_def, size);
> >
> > Looks like you are assuming stack_table_def already contains some data
> > by this point.
> > But if STACK_HASH_SIZE shrinks this memcpy() above will just copy some
> > part of the table, whereas the rest will be lost.
> > We'll need to:
> > - either explicitly decide we can afford losing this data (no idea how
> > bad this can potentially be),
> > - or disallow storing anything prior to full stackdepot initialization
> > (then we don't need stack_table_def),
> > - or carefully move all entries to the first part of the table.
> >
> > Alex
> >
>
> The hash for stack_table_def is computed using the run time parameter
> stack_hash_order, though stack_table_def is a bigger array it will only
> use the entries that are with in the run time configured STACK_HASH_SIZE
> range. so, there will be no data loss during copy.

Do we expect any data to be stored into stack_table_def before
setup_stack_hash_order() is called?
If the answer is no, then we could probably drop stack_table_def and
allocate the table right in setup_stack_hash_order()?

> Thanks,
> Vijay
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member of Code Aurora Forum, hosted by The Linux Foundation



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
