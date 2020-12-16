Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A62D2DC0D5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgLPNLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgLPNLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:11:54 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C21C061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 05:11:14 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id a6so17091156qtw.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 05:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FmMCS8Pj2VzZHf2AA4LBMOp5nKjiJ+3rmUKltHSCM6Y=;
        b=GxllYEWHBI9xfXmLwD9Qb2+EjsoWos0P2ae1bZejW8SGUXE5YxTnI1OEF0NGalhDYT
         uz1t0MPjVd0635lvI8smWgKNIWxagjr/lRNPLKxUzzWZc8Gr4v815ZjmxoHNot2Aayz4
         XejSIvFm+JfrNgHihdgv9acgyxEOio1i0QWSdoifGGrmrhOFyxJVvjQoj6scTt1/1oNK
         hl+PJ6PaJWkBi+2z7qI2POG0u0nIiTdcP4H0rhZuQcgR9GjmV+EVvnU8E6ZKD35Tcg4w
         /eRzn5+OFAJt30THv9d+Xlm4rKm4nG+KtXj66K4G/Dn/ctoufvhDzdHPpkp3mFSVWk6l
         oBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FmMCS8Pj2VzZHf2AA4LBMOp5nKjiJ+3rmUKltHSCM6Y=;
        b=RJqS5ZLCGa0BYEQd/CHW2eDZL0lVjbvvvQO8pPGBf64bnkA85U+C0GTdCgbjBvopwH
         K8z2Fu9wsaskW/fbSXmc+nuN/8BUBQkfi2f6BqTkJIyz8ex4D9P2+xAqcFuDfIKyE+MP
         GX3y3/R5k4qS7KGfWbpa5uTLWENA9YnN/OlP4iWRZNV0lVqFIATG6WlNexDNp6I3n82s
         iMIHP0CyQNfZGjgHEypQA45nIA/Wzk3oPSyWKtU7f1HT7JCov9Oistk7E9JUc4+LFNB+
         jznyjLePWL1zZ5xTB0vLVXeSjSsEc4EQMlV7vdsejdjzL/z7lTc/ckMYnPRz7JWV0d2R
         zASQ==
X-Gm-Message-State: AOAM531PyNNYp2bLBYxra6v9+qrSGS5psUHYjf2YkKrkNYqWHxfWLoyd
        BWIp24DEDNBGPfrkdjUDk3OVvRh2jOW+H/mgI4pS6w==
X-Google-Smtp-Source: ABdhPJygFzYYm5dZ6In0I1Va/ChkcoVBLX1pkJzlzIwBu9ThmUh/mwjmazKPXbxGiojMaAcTLFNoPVzg/YyvUaS4iG4=
X-Received: by 2002:ac8:7111:: with SMTP id z17mr42824565qto.369.1608124273468;
 Wed, 16 Dec 2020 05:11:13 -0800 (PST)
MIME-Version: 1.0
References: <1607576401-25609-1-git-send-email-vjitta@codeaurora.org>
 <CAG_fn=VKsrYx+YOGPnZw_Q5t6Fx7B59FSUuphj7Ou+DDFKQ+8Q@mail.gmail.com>
 <77e98f0b-c9c3-9380-9a57-ff1cd4022502@codeaurora.org> <CAG_fn=WbN6unD3ASkLUcEmZvALOj=dvC0yp6CcJFkV+3mmhwxw@mail.gmail.com>
 <6cc89f7b-bf40-2fd3-96ce-2a02d7535c91@codeaurora.org> <CAG_fn=VOHag5AUwFbOj_cV+7RDAk8UnjjqEtv2xmkSDb_iTYcQ@mail.gmail.com>
 <255400db-67d5-7f42-8dcb-9a440e006b9d@codeaurora.org> <f901afa5-7c46-ceba-2ae9-6186afdd99c0@codeaurora.org>
 <CAG_fn=UjJQP_gfDm3eJTPY371QTwyDJKXBCN2gs4DvnLP2pbyQ@mail.gmail.com> <7f2e171f-fa44-ef96-6cc6-14e615e3e457@codeaurora.org>
In-Reply-To: <7f2e171f-fa44-ef96-6cc6-14e615e3e457@codeaurora.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 16 Dec 2020 14:11:01 +0100
Message-ID: <CAG_fn=VihkHLx7nHRrzQRuHeL-UYRezcyGLDQMJY+d1O5AkJfA@mail.gmail.com>
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

On Wed, Dec 16, 2020 at 2:06 PM Vijayanand Jitta <vjitta@codeaurora.org> wr=
ote:
>
>
>
> On 12/16/2020 1:56 PM, Alexander Potapenko wrote:
> > On Wed, Dec 16, 2020 at 4:43 AM Vijayanand Jitta <vjitta@codeaurora.org=
> wrote:
> >>
> >>
> >>
> >> On 12/14/2020 4:02 PM, Vijayanand Jitta wrote:
> >>>
> >>>
> >>> On 12/14/2020 3:04 PM, Alexander Potapenko wrote:
> >>>> On Mon, Dec 14, 2020 at 5:02 AM Vijayanand Jitta <vjitta@codeaurora.=
org> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 12/11/2020 6:55 PM, Alexander Potapenko wrote:
> >>>>>> On Fri, Dec 11, 2020 at 1:45 PM Vijayanand Jitta <vjitta@codeauror=
a.org> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 12/11/2020 2:06 PM, Alexander Potapenko wrote:
> >>>>>>>> On Thu, Dec 10, 2020 at 6:01 AM <vjitta@codeaurora.org> wrote:
> >>>>>>>>>
> >>>>>>>>> From: Yogesh Lal <ylal@codeaurora.org>
> >>>>>>>>>
> >>>>>>>>> Add a kernel parameter stack_hash_order to configure STACK_HASH=
_SIZE.
> >>>>>>>>>
> >>>>>>>>> Aim is to have configurable value for STACK_HASH_SIZE, so that =
one
> >>>>>>>>> can configure it depending on usecase there by reducing the sta=
tic
> >>>>>>>>> memory overhead.
> >>>>>>>>>
> >>>>>>>>> One example is of Page Owner, default value of STACK_HASH_SIZE =
lead
> >>>>>>>>> stack depot to consume 8MB of static memory. Making it configur=
able
> >>>>>>>>> and use lower value helps to enable features like CONFIG_PAGE_O=
WNER
> >>>>>>>>> without any significant overhead.
> >>>>>>>>
> >>>>>>>> Can we go with a static CONFIG_ parameter instead?
> >>>>>>>> Guess most users won't bother changing the default anyway, and f=
or
> >>>>>>>> CONFIG_PAGE_OWNER users changing the size at boot time is not st=
rictly
> >>>>>>>> needed.
> >>>>>>>>
> >>>>>>> Thanks for review.
> >>>>>>>
> >>>>>>> One advantage of having run time parameter is we can simply set i=
t to a
> >>>>>>> lower value at runtime if page_owner=3Doff thereby reducing the m=
emory
> >>>>>>> usage or use default value if we want to use page owner so, we ha=
ve some
> >>>>>>> some flexibility here. This is not possible with static parameter=
 as we
> >>>>>>> have to have some predefined value.
> >>>>>>
> >>>>>> If we are talking about a configuration in which page_owner is the
> >>>>>> only stackdepot user in the system, then for page_owner=3Doff it
> >>>>>> probably makes more sense to disable stackdepot completely instead=
 of
> >>>>>> setting it to a lower value. This is a lot easier to do in terms o=
f
> >>>>>> correctness.
> >>>>>> But if there are other users (e.g. KASAN), their stackdepot usage =
may
> >>>>>> actually dominate that of page_owner.
> >>>>>>
> >>>>>>>>> -static struct stack_record *stack_table[STACK_HASH_SIZE] =3D {
> >>>>>>>>> -       [0 ...  STACK_HASH_SIZE - 1] =3D NULL
> >>>>>>>>> +static unsigned int stack_hash_order =3D 20;
> >>>>>>>>
> >>>>>>>> Please initialize with MAX_STACK_HASH_ORDER instead.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Sure, will update this.
> >>>>>>>
> >>>>>>
> >>>>>>
> >>>>>>>>> +
> >>>>>>>>> +static int __init init_stackdepot(void)
> >>>>>>>>> +{
> >>>>>>>>> +       size_t size =3D (STACK_HASH_SIZE * sizeof(struct stack_=
record *));
> >>>>>>>>> +
> >>>>>>>>> +       stack_table =3D vmalloc(size);
> >>>>>>>>> +       memcpy(stack_table, stack_table_def, size);
> >>>>>>>>
> >>>>>>>> Looks like you are assuming stack_table_def already contains som=
e data
> >>>>>>>> by this point.
> >>>>>>>> But if STACK_HASH_SIZE shrinks this memcpy() above will just cop=
y some
> >>>>>>>> part of the table, whereas the rest will be lost.
> >>>>>>>> We'll need to:
> >>>>>>>> - either explicitly decide we can afford losing this data (no id=
ea how
> >>>>>>>> bad this can potentially be),
> >>>>>>>> - or disallow storing anything prior to full stackdepot initiali=
zation
> >>>>>>>> (then we don't need stack_table_def),
> >>>>>>>> - or carefully move all entries to the first part of the table.
> >>>>>>>>
> >>>>>>>> Alex
> >>>>>>>>
> >>>>>>>
> >>>>>>> The hash for stack_table_def is computed using the run time param=
eter
> >>>>>>> stack_hash_order, though stack_table_def is a bigger array it wil=
l only
> >>>>>>> use the entries that are with in the run time configured STACK_HA=
SH_SIZE
> >>>>>>> range. so, there will be no data loss during copy.
> >>>>>>
> >>>>>> Do we expect any data to be stored into stack_table_def before
> >>>>>> setup_stack_hash_order() is called?
> >>>>>> If the answer is no, then we could probably drop stack_table_def a=
nd
> >>>>>> allocate the table right in setup_stack_hash_order()?
> >>>>>>
> >>>>>
> >>>>> Yes, we do see an allocation from stack depot even before init is c=
alled
> >>>>> from kasan, thats the reason for having stack_table_def.
> >>>>> This is the issue reported due to that on v2, so i added stack_tabl=
e_def.
> >>>>> https://lkml.org/lkml/2020/12/3/839
> >>>>
> >>>> But at that point STACK_HASH_SIZE is still equal to 1L <<
> >>>> MAX_STACK_HASH_ORDER, isn't it?
> >>>> Then we still need to take care of the records that fit into the
> >>>> bigger array, but not the smaller one.
> >>>>
> >>>
> >>> At this point early_param is already called which sets stack_hash_ord=
er.
> >>> So, STACK_HASH_SIZE will be set to this updated value and not
> >>> MAX_STACK_HASH_SIZE.So, no additional entires in the bigger array.
> >>>
> >>> Thanks,
> >>> Vijay
> >>>
> >>
> >> Let me know if there are any other concerns.
> >
> > I still think there are implicit assumptions that should at least be
> > written down in the comments.
>
> Sure, will add the comments.
>
> > As far as I understand the code, here is what happens here:
> >
> > 0. No stacks are recorded.
> > 1. early_param is called to set stack_hash_order to a value
> > potentially smaller than MAX_STACK_HASH_SIZE.
> > 2. KASAN (or other users) records some stacks into stack_table_def
> > (capped at new STACK_HASH_SIZE)
> > 3. init_stackdepot() allocates a new stack_table and copies the
> > contents of stack_table_def into it
> > 4. Further stacks are recorded into the new stack_table
> >
> > If this is how the things work, I agree we don't need to account for
> > the part of stack_table_def past STACK_HASH_SIZE.
> > Not allocating stack_table when setting stack_hash_order is probably
> > also justified, as we don't have SLAB or vmalloc at that point.
> >
>
> That's Right.
>
> > But I am still curious if a runtime parameter that disables the
> > stackdepot completely will solve your problem.
> > Allocating a small amount of memory when you actually don't want to
> > allocate any sounds suboptimal.
> >
>
> I think disabling stack depot completely should be fine, we can make
> STACK_HASH_SIZE as runtime parameter instead of stack_hash_order and set
> stack_hash_size to 0 to disable stack depot completely.

To reiterate, I think you don't need a tunable stack_hash_order
parameter if the only use case is to disable the stack depot.
Maybe it is enough to just add a boolean flag?
Or even go further and disable the stack depot in the same place that
disables page owner, as the user probably doesn't want to set two
flags instead of one?

> Minchan,
> This should be fine right ? Do you see any issue with disabling
> stack depot completely ?
>
> Thanks,
> Vijay
>
> >> Thanks,
> >> Vijay
> >>
> >>>>> Thanks,
> >>>>> Vijay
> >>>>>
> >>>>>>> Thanks,
> >>>>>>> Vijay
> >>>>>>>
> >>>>>>> --
> >>>>>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is =
a
> >>>>>>> member of Code Aurora Forum, hosted by The Linux Foundation
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>
> >>>>> --
> >>>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> >>>>> member of Code Aurora Forum, hosted by The Linux Foundation
> >>>>
> >>>>
> >>>>
> >>>
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
