Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4982E00DB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 20:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgLUTTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 14:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgLUTTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 14:19:46 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB0AC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 11:19:06 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id 7so7402405qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 11:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9Gs1qnHni/7JgGg8DxLHzFHnG72behPmmY3QIu4VsAE=;
        b=WNR++gqSQrNz6A7WPNnOKG7h1Qj1gcBqIX6VZY4PQd0m2xSHw0pX8M4JZfiYb31Gjp
         5K/b9uoDDSovzgpJFu+gj+bp4B3C8R+TaRuNL2/FIU03XPaKVLUeytzS7/cYIYDuGwRT
         pyO9r1XUpMe/6CakMEY0Fxw7Q+aA4Njv4UKuYIErE7FdqmH/goyOgB53A0289hJAs6ux
         i7BTuk/klqLoKU5gO9Ih+wC1cIAz0aTuFHliLooQB/U53Bv6cEpWAAsAE08wfb5uwQAU
         JwFUrNyH8JliYwtXxaL9xt3v7Opm4mOdYl/fxhO/oJhitGj5GdXkdpbSR8pBS2LPtVPM
         wH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9Gs1qnHni/7JgGg8DxLHzFHnG72behPmmY3QIu4VsAE=;
        b=oURu7yPmpRyN+yJ5huoPGduHhwhVszRVhWNVk0bbZNyZ3gwJqMJEvvlJD3ZicNn7S9
         bMS0778HISLoauqmZmycgF01SY+7pFUSeWBvpIfahYcnEQbw0Bxz+z24B9y7mj5a8qdG
         yXz4oOj7Y6Aq9idt9qcrKnks8VO7nn5RUVMo2xuNc+3EFl6gEaNlKQEt0OvV45mIyli7
         SIhsXVJUaKnjaVBSInTiSj9J+EoI7UAWSF4gtmhphw9LssLnpBjVJeepZKI3qO2npUSf
         ibBv9VByFzBRM9tafWiMm+VPgwU5edNN0SC15Bic77+yvX78j+/aFMa+ko+JvaIqh5Wz
         UUzQ==
X-Gm-Message-State: AOAM530LCclDZEiHsZ1St7CBQEWSOACnzgD+xWaL9PXig3hEBZJKMEkS
        E71StOHN1QTCTPLIVUaqaEACT3xcRVCgrq6mRQ8OFINTIZEA4Q==
X-Google-Smtp-Source: ABdhPJx5V8NquHLQWEMeiUtPd5mg4cOtP6/e3s6RCMT9P7xFT5CCUX7cK7LGVWDjcUD++tUTAAQ+RSEDf7LSEqHPo0g=
X-Received: by 2002:ac8:7512:: with SMTP id u18mr16624678qtq.300.1608563061279;
 Mon, 21 Dec 2020 07:04:21 -0800 (PST)
MIME-Version: 1.0
References: <1607576401-25609-1-git-send-email-vjitta@codeaurora.org>
 <CAG_fn=VKsrYx+YOGPnZw_Q5t6Fx7B59FSUuphj7Ou+DDFKQ+8Q@mail.gmail.com>
 <77e98f0b-c9c3-9380-9a57-ff1cd4022502@codeaurora.org> <CAG_fn=WbN6unD3ASkLUcEmZvALOj=dvC0yp6CcJFkV+3mmhwxw@mail.gmail.com>
 <6cc89f7b-bf40-2fd3-96ce-2a02d7535c91@codeaurora.org> <CAG_fn=VOHag5AUwFbOj_cV+7RDAk8UnjjqEtv2xmkSDb_iTYcQ@mail.gmail.com>
 <255400db-67d5-7f42-8dcb-9a440e006b9d@codeaurora.org> <f901afa5-7c46-ceba-2ae9-6186afdd99c0@codeaurora.org>
 <CAG_fn=UjJQP_gfDm3eJTPY371QTwyDJKXBCN2gs4DvnLP2pbyQ@mail.gmail.com>
 <7f2e171f-fa44-ef96-6cc6-14e615e3e457@codeaurora.org> <CAG_fn=VihkHLx7nHRrzQRuHeL-UYRezcyGLDQMJY+d1O5AkJfA@mail.gmail.com>
 <601d4b1a-8526-f7ad-d0f3-305894682109@codeaurora.org> <CAG_fn=V8e8y1fbOaYUD5SfDSQ9+Tc3r7w6ZSoJ-ZNFJvvq-Aeg@mail.gmail.com>
 <9e0d2c07-af1f-a1d3-fb0d-dbf2ae669f96@codeaurora.org> <CAG_fn=UXQUGiDqmChqD-xX-yF5Jp+7K+oHwKPrO9DZL-zW_4KQ@mail.gmail.com>
 <48df48fe-dc36-83a4-1c11-e9d0cf230372@codeaurora.org> <6110a26b-dc87-b6f9-e679-aa60917403de@codeaurora.org>
In-Reply-To: <6110a26b-dc87-b6f9-e679-aa60917403de@codeaurora.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 21 Dec 2020 16:04:09 +0100
Message-ID: <CAG_fn=VjejHtY8=cuuFkixpXd6A6q1C==6RAaUC3Vb5_4hZkcg@mail.gmail.com>
Subject: Re: [PATCH v3] lib: stackdepot: Add support to configure STACK_HASH_SIZE
To:     Vijayanand Jitta <vjitta@codeaurora.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        dan.j.williams@intel.com, broonie@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>, qcai@redhat.com,
        ylal@codeaurora.org, vinmenon@codeaurora.org,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 12:15 PM Vijayanand Jitta <vjitta@codeaurora.org> w=
rote:
>
>
>
> On 12/18/2020 2:10 PM, Vijayanand Jitta wrote:
> >
> >
> > On 12/17/2020 4:24 PM, Alexander Potapenko wrote:
> >>>> Can you provide an example of a use case in which the user wants to
> >>>> use the stack depot of a smaller size without disabling it completel=
y,
> >>>> and that size cannot be configured statically?
> >>>> As far as I understand, for the page owner example you gave it's
> >>>> sufficient to provide a switch that can disable the stack depot if
> >>>> page_owner=3Doff.
> >>>>
> >>> There are two use cases here,
> >>>
> >>> 1. We don't want to consume memory when page_owner=3Doff ,boolean fla=
g
> >>> would work here.
> >>>
> >>> 2. We would want to enable page_owner on low ram devices but we don't
> >>> want stack depot to consume 8 MB of memory, so for this case we would
> >>> need a configurable stack_hash_size so that we can still use page_own=
er
> >>> with lower memory consumption.
> >>>
> >>> So, a configurable stack_hash_size would work for both these use case=
s,
> >>> we can set it to '0' for first case and set the required size for the
> >>> second case.
> >>
> >> Will a combined solution with a boolean boot-time flag and a static
> >> CONFIG_STACKDEPOT_HASH_SIZE work for these cases?
> >> I suppose low-memory devices have a separate kernel config anyway?
> >>
> >
> > Yes, the combined solution will also work but i think having a single
> > run time config is simpler instead of having two things to configure.
> >
>
> To add to it we started of with a CONFIG first, after the comments from
> Minchan (https://lkml.org/lkml/2020/11/3/2121) we decided to switch to
> run time param.
>
> Quoting Minchan's comments below:
>
> "
> 1. When we don't use page_owner, we don't want to waste any memory for
> stackdepot hash array.
> 2. When we use page_owner, we want to have reasonable stackdeport hash ar=
ray
>
> With this configuration, it couldn't meet since we always need to
> reserve a reasonable size for the array.
> Can't we make the hash size as a kernel parameter?
> With it, we could use it like this.
>
> 1. page_owner=3Doff, stackdepot_stack_hash=3D0 -> no more wasted memory
> when we don't use page_owner
> 2. page_owner=3Don, stackdepot_stack_hash=3D8M -> reasonable hash size
> when we use page_owner.
> "

Minchan, what do you think about making the hash size itself a static
parameter, while letting the user disable stackdepot completely at
runtime?
As noted before, I am concerned that moving a low-level configuration
bit (which essentially means "save 8Mb - (1 << stackdepot_stack_hash)
of static memory") to the boot parameters will be unused by most
admins and may actually trick them into thinking they reduce the
overall stackdepot memory consumption noticeably.
I also suppose device vendors may prefer setting a fixed (maybe
non-default) hash size for low-memory devices rather than letting the
admins increase it.


Alex

PS. Sorry for being late to the party, I should have probably spoken
up in November, when you've been discussing the first version of this
patch.

> Thanks,
> Vijay
> >> My concern is that exposing yet another knob to users won't really
> >> solve their problems, because the hash size alone doesn't give enough
> >> control over stackdepot memory footprint (we also have stack_slabs,
> >> which may get way bigger than 8Mb).
> >>
> >
> > True, stack_slabs can consume more memory but they consume most only
> > when stack depot is used as they are allocated in stack_depot_save path=
.
> > when stack depot is not used they consume 8192 * sizeof(void) bytes at
> > max. So nothing much we can do here since static allocation is not much
> > and memory consumption depends up on stack depot usage, unlike
> > stack_hash_table where 8mb is preallocated.
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
