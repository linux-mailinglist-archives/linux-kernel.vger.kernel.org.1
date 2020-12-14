Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1932D9559
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 10:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbgLNJff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 04:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbgLNJff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 04:35:35 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE706C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 01:34:54 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id b64so10984963qkc.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 01:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s7I3IQjihF/l5M5NpOWkbtUsOkBOq12IgPccKBHENpw=;
        b=BIrnpDzIJn2tUouG/zISgnUOGrf0H1CeZ/wdEpCMwQ58cOI2WM95R8ZsVMpE9k/pru
         jmue/53TKzTspNneGvzJUtlGjso85frjksU6nR1WnE/rSMknPy3ElCMZq7nZrcBs0nez
         UKiTy+2R7fJFZnfU7EfsQSU2DUh34AOUp8hk1W686ZMamB95i6JNCDHlYVGfJjaAEUp5
         yPCgeWiCqOzc3SuMQ/MUcD01+kW3uwXKP2j7zlmPkcVYqRdfAOINmOp8kxGHFkqeAfPG
         yhxgD/ZXAsXGc7K37nTC/C91LF5euEaGlzirdV4T4Jp78L7mLFANbcmjmemR0Pun8mZH
         DX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s7I3IQjihF/l5M5NpOWkbtUsOkBOq12IgPccKBHENpw=;
        b=F4eZwI8eEsPul7ZA1Jg2hyZb1jijxGL+epwUe06ijrKHZZwb5DCBXiMLzcHoZbiU+F
         +4a2zgNgE3zsgaZaKtidKobH8AeuMardM/wxxSjjzQAjr/3ljA8LtYLNl33UwUgDr71R
         tYNxK2k7rkYnJbiwJLXAsx6lo8ixUQ/+Z5s+MRR2pwxEt+ioVIYnup8Vw5amixM5dSRz
         nBDQG4Q5FLupwls9LY+Rqks50Ehl4lHpXApXEWwJ77VAv3R4N/90TDGvqYVBfIpacZ9G
         Jz68e8gknEdc35De7KMCIWXPMmw2dh30XzimpBk6DifuvVXMzSLkfmnD2hjywmiy7o+x
         Uaqg==
X-Gm-Message-State: AOAM531z50MThxBzvmVyUa4n6Evw64sLzivmnFcJc3inWRs8hu5ZzQJ8
        FMxVpr5TX3+Nb9C7XltCN8FiIM8tZceJF2lCNdeZ8g==
X-Google-Smtp-Source: ABdhPJwO+hFDyg6ok0gHTpSFFEj1saBmMnoBTxK8Jvtqn99wxzgHCCtHjMCZ7r0Cx4ykxWflBaBXMwoYL2/rtggH6IE=
X-Received: by 2002:a05:620a:2051:: with SMTP id d17mr27195814qka.403.1607938493788;
 Mon, 14 Dec 2020 01:34:53 -0800 (PST)
MIME-Version: 1.0
References: <1607576401-25609-1-git-send-email-vjitta@codeaurora.org>
 <CAG_fn=VKsrYx+YOGPnZw_Q5t6Fx7B59FSUuphj7Ou+DDFKQ+8Q@mail.gmail.com>
 <77e98f0b-c9c3-9380-9a57-ff1cd4022502@codeaurora.org> <CAG_fn=WbN6unD3ASkLUcEmZvALOj=dvC0yp6CcJFkV+3mmhwxw@mail.gmail.com>
 <6cc89f7b-bf40-2fd3-96ce-2a02d7535c91@codeaurora.org>
In-Reply-To: <6cc89f7b-bf40-2fd3-96ce-2a02d7535c91@codeaurora.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 14 Dec 2020 10:34:41 +0100
Message-ID: <CAG_fn=VOHag5AUwFbOj_cV+7RDAk8UnjjqEtv2xmkSDb_iTYcQ@mail.gmail.com>
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

On Mon, Dec 14, 2020 at 5:02 AM Vijayanand Jitta <vjitta@codeaurora.org> wr=
ote:
>
>
>
> On 12/11/2020 6:55 PM, Alexander Potapenko wrote:
> > On Fri, Dec 11, 2020 at 1:45 PM Vijayanand Jitta <vjitta@codeaurora.org=
> wrote:
> >>
> >>
> >>
> >> On 12/11/2020 2:06 PM, Alexander Potapenko wrote:
> >>> On Thu, Dec 10, 2020 at 6:01 AM <vjitta@codeaurora.org> wrote:
> >>>>
> >>>> From: Yogesh Lal <ylal@codeaurora.org>
> >>>>
> >>>> Add a kernel parameter stack_hash_order to configure STACK_HASH_SIZE=
.
> >>>>
> >>>> Aim is to have configurable value for STACK_HASH_SIZE, so that one
> >>>> can configure it depending on usecase there by reducing the static
> >>>> memory overhead.
> >>>>
> >>>> One example is of Page Owner, default value of STACK_HASH_SIZE lead
> >>>> stack depot to consume 8MB of static memory. Making it configurable
> >>>> and use lower value helps to enable features like CONFIG_PAGE_OWNER
> >>>> without any significant overhead.
> >>>
> >>> Can we go with a static CONFIG_ parameter instead?
> >>> Guess most users won't bother changing the default anyway, and for
> >>> CONFIG_PAGE_OWNER users changing the size at boot time is not strictl=
y
> >>> needed.
> >>>
> >> Thanks for review.
> >>
> >> One advantage of having run time parameter is we can simply set it to =
a
> >> lower value at runtime if page_owner=3Doff thereby reducing the memory
> >> usage or use default value if we want to use page owner so, we have so=
me
> >> some flexibility here. This is not possible with static parameter as w=
e
> >> have to have some predefined value.
> >
> > If we are talking about a configuration in which page_owner is the
> > only stackdepot user in the system, then for page_owner=3Doff it
> > probably makes more sense to disable stackdepot completely instead of
> > setting it to a lower value. This is a lot easier to do in terms of
> > correctness.
> > But if there are other users (e.g. KASAN), their stackdepot usage may
> > actually dominate that of page_owner.
> >
> >>>> -static struct stack_record *stack_table[STACK_HASH_SIZE] =3D {
> >>>> -       [0 ...  STACK_HASH_SIZE - 1] =3D NULL
> >>>> +static unsigned int stack_hash_order =3D 20;
> >>>
> >>> Please initialize with MAX_STACK_HASH_ORDER instead.
> >>>
> >>
> >> Sure, will update this.
> >>
> >
> >
> >>>> +
> >>>> +static int __init init_stackdepot(void)
> >>>> +{
> >>>> +       size_t size =3D (STACK_HASH_SIZE * sizeof(struct stack_recor=
d *));
> >>>> +
> >>>> +       stack_table =3D vmalloc(size);
> >>>> +       memcpy(stack_table, stack_table_def, size);
> >>>
> >>> Looks like you are assuming stack_table_def already contains some dat=
a
> >>> by this point.
> >>> But if STACK_HASH_SIZE shrinks this memcpy() above will just copy som=
e
> >>> part of the table, whereas the rest will be lost.
> >>> We'll need to:
> >>> - either explicitly decide we can afford losing this data (no idea ho=
w
> >>> bad this can potentially be),
> >>> - or disallow storing anything prior to full stackdepot initializatio=
n
> >>> (then we don't need stack_table_def),
> >>> - or carefully move all entries to the first part of the table.
> >>>
> >>> Alex
> >>>
> >>
> >> The hash for stack_table_def is computed using the run time parameter
> >> stack_hash_order, though stack_table_def is a bigger array it will onl=
y
> >> use the entries that are with in the run time configured STACK_HASH_SI=
ZE
> >> range. so, there will be no data loss during copy.
> >
> > Do we expect any data to be stored into stack_table_def before
> > setup_stack_hash_order() is called?
> > If the answer is no, then we could probably drop stack_table_def and
> > allocate the table right in setup_stack_hash_order()?
> >
>
> Yes, we do see an allocation from stack depot even before init is called
> from kasan, thats the reason for having stack_table_def.
> This is the issue reported due to that on v2, so i added stack_table_def.
> https://lkml.org/lkml/2020/12/3/839

But at that point STACK_HASH_SIZE is still equal to 1L <<
MAX_STACK_HASH_ORDER, isn't it?
Then we still need to take care of the records that fit into the
bigger array, but not the smaller one.

> Thanks,
> Vijay
>
> >> Thanks,
> >> Vijay
> >>
> >> --
> >> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> >> member of Code Aurora Forum, hosted by The Linux Foundation
> >
> >
> >
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
