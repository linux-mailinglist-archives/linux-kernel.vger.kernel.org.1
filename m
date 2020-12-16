Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3622DBCAE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 09:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgLPI1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 03:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgLPI1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 03:27:04 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D78C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 00:26:23 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id et9so4666246qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 00:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r6hEt315SbG/e/8Vl1feLlxOu8fWYFzE3xspskEPV0M=;
        b=PAemIqM91cN4sEqCaeiWNNUyh1N1ovjV599H+sWNHJa1c8NAk2V+QiNPvcBzIFR3qb
         O+HDCfDZm7ee0RRjppMh2qU7nwAyUgKY2oUATo4Qjhc6Eg2B4NW7tKJESBievwdgPiJN
         DgEsk9vucLGI6cJ7z5NhTD77BO4ECnEVlu/0jA5F7nys22QzVODCGz8XAogwVCaYA+eW
         NaX3ZdaGAE9oAqPpFATpTr9Rb6oL1KvukplRNMXbJrfSNltM9rPPOElb3JTiUuhqzxPa
         nhttJ44JsCyHL4gbUqx2Dl1cSRUkgYK34iA2OFbVGDjy5T7p5cofddEr3SurK5Ui7nob
         dbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r6hEt315SbG/e/8Vl1feLlxOu8fWYFzE3xspskEPV0M=;
        b=S3p56Yr09PwwwBWUBWDvxV3mSt7d8evl/tBvojz6LWzOVlbelwmMcVKeylc2JwgCox
         8CKMytW1dS/eI/1BBBsjzVOHpWFnG/5sVlK67UlKIofOMESYYx3Q/RhNQXzndQlPpE7A
         pLUYYAdt/dDl3D9VhJkxQr79JG+RaHnv2Mrc44/F3B5w/25uy26XJYHHwBJhOeuCdwsQ
         e879WlKm/LL6izcUakn/166enz4antrifvgA4aT8GyUPaAgN4wWPCBpiWJ5JvYN5PVmq
         q8xDE2Qtn96BVRD0Nn7f9Q1QD1+Ln2sd743yIxtl5LRGLuejlYbva6Usva3SLE8GELHz
         ZDig==
X-Gm-Message-State: AOAM533OvD5oxAPIuKykH9m1gGj+WT6H6i5kUOF/RvB4+4uDcfkpGDS1
        fxZEm7RdpZ5+8ELSkw/mTMeTyA4xPoh4QyzaBzKytA==
X-Google-Smtp-Source: ABdhPJyjxOxCdcR9YGZm5e8bCkOXaeazbRnJ4UrgFVb79qCVta3O7de+0oprK1imOqRrqYEwFxqpY/n7xshsNAzSaBg=
X-Received: by 2002:a05:6214:1511:: with SMTP id e17mr12597116qvy.4.1608107181953;
 Wed, 16 Dec 2020 00:26:21 -0800 (PST)
MIME-Version: 1.0
References: <1607576401-25609-1-git-send-email-vjitta@codeaurora.org>
 <CAG_fn=VKsrYx+YOGPnZw_Q5t6Fx7B59FSUuphj7Ou+DDFKQ+8Q@mail.gmail.com>
 <77e98f0b-c9c3-9380-9a57-ff1cd4022502@codeaurora.org> <CAG_fn=WbN6unD3ASkLUcEmZvALOj=dvC0yp6CcJFkV+3mmhwxw@mail.gmail.com>
 <6cc89f7b-bf40-2fd3-96ce-2a02d7535c91@codeaurora.org> <CAG_fn=VOHag5AUwFbOj_cV+7RDAk8UnjjqEtv2xmkSDb_iTYcQ@mail.gmail.com>
 <255400db-67d5-7f42-8dcb-9a440e006b9d@codeaurora.org> <f901afa5-7c46-ceba-2ae9-6186afdd99c0@codeaurora.org>
In-Reply-To: <f901afa5-7c46-ceba-2ae9-6186afdd99c0@codeaurora.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 16 Dec 2020 09:26:10 +0100
Message-ID: <CAG_fn=UjJQP_gfDm3eJTPY371QTwyDJKXBCN2gs4DvnLP2pbyQ@mail.gmail.com>
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

On Wed, Dec 16, 2020 at 4:43 AM Vijayanand Jitta <vjitta@codeaurora.org> wr=
ote:
>
>
>
> On 12/14/2020 4:02 PM, Vijayanand Jitta wrote:
> >
> >
> > On 12/14/2020 3:04 PM, Alexander Potapenko wrote:
> >> On Mon, Dec 14, 2020 at 5:02 AM Vijayanand Jitta <vjitta@codeaurora.or=
g> wrote:
> >>>
> >>>
> >>>
> >>> On 12/11/2020 6:55 PM, Alexander Potapenko wrote:
> >>>> On Fri, Dec 11, 2020 at 1:45 PM Vijayanand Jitta <vjitta@codeaurora.=
org> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 12/11/2020 2:06 PM, Alexander Potapenko wrote:
> >>>>>> On Thu, Dec 10, 2020 at 6:01 AM <vjitta@codeaurora.org> wrote:
> >>>>>>>
> >>>>>>> From: Yogesh Lal <ylal@codeaurora.org>
> >>>>>>>
> >>>>>>> Add a kernel parameter stack_hash_order to configure STACK_HASH_S=
IZE.
> >>>>>>>
> >>>>>>> Aim is to have configurable value for STACK_HASH_SIZE, so that on=
e
> >>>>>>> can configure it depending on usecase there by reducing the stati=
c
> >>>>>>> memory overhead.
> >>>>>>>
> >>>>>>> One example is of Page Owner, default value of STACK_HASH_SIZE le=
ad
> >>>>>>> stack depot to consume 8MB of static memory. Making it configurab=
le
> >>>>>>> and use lower value helps to enable features like CONFIG_PAGE_OWN=
ER
> >>>>>>> without any significant overhead.
> >>>>>>
> >>>>>> Can we go with a static CONFIG_ parameter instead?
> >>>>>> Guess most users won't bother changing the default anyway, and for
> >>>>>> CONFIG_PAGE_OWNER users changing the size at boot time is not stri=
ctly
> >>>>>> needed.
> >>>>>>
> >>>>> Thanks for review.
> >>>>>
> >>>>> One advantage of having run time parameter is we can simply set it =
to a
> >>>>> lower value at runtime if page_owner=3Doff thereby reducing the mem=
ory
> >>>>> usage or use default value if we want to use page owner so, we have=
 some
> >>>>> some flexibility here. This is not possible with static parameter a=
s we
> >>>>> have to have some predefined value.
> >>>>
> >>>> If we are talking about a configuration in which page_owner is the
> >>>> only stackdepot user in the system, then for page_owner=3Doff it
> >>>> probably makes more sense to disable stackdepot completely instead o=
f
> >>>> setting it to a lower value. This is a lot easier to do in terms of
> >>>> correctness.
> >>>> But if there are other users (e.g. KASAN), their stackdepot usage ma=
y
> >>>> actually dominate that of page_owner.
> >>>>
> >>>>>>> -static struct stack_record *stack_table[STACK_HASH_SIZE] =3D {
> >>>>>>> -       [0 ...  STACK_HASH_SIZE - 1] =3D NULL
> >>>>>>> +static unsigned int stack_hash_order =3D 20;
> >>>>>>
> >>>>>> Please initialize with MAX_STACK_HASH_ORDER instead.
> >>>>>>
> >>>>>
> >>>>> Sure, will update this.
> >>>>>
> >>>>
> >>>>
> >>>>>>> +
> >>>>>>> +static int __init init_stackdepot(void)
> >>>>>>> +{
> >>>>>>> +       size_t size =3D (STACK_HASH_SIZE * sizeof(struct stack_re=
cord *));
> >>>>>>> +
> >>>>>>> +       stack_table =3D vmalloc(size);
> >>>>>>> +       memcpy(stack_table, stack_table_def, size);
> >>>>>>
> >>>>>> Looks like you are assuming stack_table_def already contains some =
data
> >>>>>> by this point.
> >>>>>> But if STACK_HASH_SIZE shrinks this memcpy() above will just copy =
some
> >>>>>> part of the table, whereas the rest will be lost.
> >>>>>> We'll need to:
> >>>>>> - either explicitly decide we can afford losing this data (no idea=
 how
> >>>>>> bad this can potentially be),
> >>>>>> - or disallow storing anything prior to full stackdepot initializa=
tion
> >>>>>> (then we don't need stack_table_def),
> >>>>>> - or carefully move all entries to the first part of the table.
> >>>>>>
> >>>>>> Alex
> >>>>>>
> >>>>>
> >>>>> The hash for stack_table_def is computed using the run time paramet=
er
> >>>>> stack_hash_order, though stack_table_def is a bigger array it will =
only
> >>>>> use the entries that are with in the run time configured STACK_HASH=
_SIZE
> >>>>> range. so, there will be no data loss during copy.
> >>>>
> >>>> Do we expect any data to be stored into stack_table_def before
> >>>> setup_stack_hash_order() is called?
> >>>> If the answer is no, then we could probably drop stack_table_def and
> >>>> allocate the table right in setup_stack_hash_order()?
> >>>>
> >>>
> >>> Yes, we do see an allocation from stack depot even before init is cal=
led
> >>> from kasan, thats the reason for having stack_table_def.
> >>> This is the issue reported due to that on v2, so i added stack_table_=
def.
> >>> https://lkml.org/lkml/2020/12/3/839
> >>
> >> But at that point STACK_HASH_SIZE is still equal to 1L <<
> >> MAX_STACK_HASH_ORDER, isn't it?
> >> Then we still need to take care of the records that fit into the
> >> bigger array, but not the smaller one.
> >>
> >
> > At this point early_param is already called which sets stack_hash_order=
.
> > So, STACK_HASH_SIZE will be set to this updated value and not
> > MAX_STACK_HASH_SIZE.So, no additional entires in the bigger array.
> >
> > Thanks,
> > Vijay
> >
>
> Let me know if there are any other concerns.

I still think there are implicit assumptions that should at least be
written down in the comments.
As far as I understand the code, here is what happens here:

0. No stacks are recorded.
1. early_param is called to set stack_hash_order to a value
potentially smaller than MAX_STACK_HASH_SIZE.
2. KASAN (or other users) records some stacks into stack_table_def
(capped at new STACK_HASH_SIZE)
3. init_stackdepot() allocates a new stack_table and copies the
contents of stack_table_def into it
4. Further stacks are recorded into the new stack_table

If this is how the things work, I agree we don't need to account for
the part of stack_table_def past STACK_HASH_SIZE.
Not allocating stack_table when setting stack_hash_order is probably
also justified, as we don't have SLAB or vmalloc at that point.

But I am still curious if a runtime parameter that disables the
stackdepot completely will solve your problem.
Allocating a small amount of memory when you actually don't want to
allocate any sounds suboptimal.

> Thanks,
> Vijay
>
> >>> Thanks,
> >>> Vijay
> >>>
> >>>>> Thanks,
> >>>>> Vijay
> >>>>>
> >>>>> --
> >>>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> >>>>> member of Code Aurora Forum, hosted by The Linux Foundation
> >>>>
> >>>>
> >>>>
> >>>
> >>> --
> >>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> >>> member of Code Aurora Forum, hosted by The Linux Foundation
> >>
> >>
> >>
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
