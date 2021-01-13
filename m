Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523482F4B25
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbhAMMRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbhAMMRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:17:06 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BBCC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:16:26 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b8so984545plx.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a5W2wNZZKJZwsE86ZoW5+zbor2DhuPLMBAueklRl0b0=;
        b=xbXwyAIjyM97eOkk4+dSEuUvNacL2rj0frgu2asCQhXxQNJqcedtkO+BBrDSIHZ59y
         izm1yVtNpVKPHSqWrjyy8K96X6JUVIAfefzf2FAuS/kZP+N2p1HfkPLJTKmnNL8LbgId
         kw69KIIfA/7nq0l0BCyBJUzkAWiJI0Wm0kzAIU6vsH8YfxoJ1uN6jPpqFO2gqeQNeykP
         TPJ2aVKjPU87k0F1oqKt/Xy3CeewvJk6jYxA4Z8iNAsLr0rnkGaK8gBXnwwus2wPWciN
         x4FkLLrJjKH1v8/dmVwi+IEgijUe9AzND3OmIZX8v2DJKs4FtK7UiM3X3slDlQKetV11
         EQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5W2wNZZKJZwsE86ZoW5+zbor2DhuPLMBAueklRl0b0=;
        b=thODfxCQWn8YNBdiENUoJMTmL/4z46XSl9OMm1yE5zpkx+e8k97nczYbSi1UAvU9xt
         Ig5j5Gq37uajEbweqa27lm7EF2jvqk5cRw9KGJYHiOt3QFXzhk/cuctoCbPHt+L/5v9E
         DtKtO6PFNrhEywukLUc4//F2vNs+B70o4k9+qmZXylEE6UY0bMHb1aJrGYZi1oPeG91s
         /ZV8lbRwt2XjgX3MffJ5hHQC2KXFM//WWrG8eWGyuHbvh6YtdLUSnuAxFcXUdQFqiGtu
         +9yW6eokLGWh6EIeCU+5KMvd5TNYOfv6UjPFQaeTFgmMhMWe0JefO+nohMtY6eVfJTMA
         FmCg==
X-Gm-Message-State: AOAM530yzSt0pq0RH4Nsrs1OREuxQuAi/OZjx778TJneeWtPrkCMSjhl
        /hrDZYy8rdFwRw3SfXtlCdTrKjZG0mE3QM9DFDBEiR5vBhQWSwgM
X-Google-Smtp-Source: ABdhPJwTuXkFaHwl2vuqjUg1+rrxzQx2CdmGrJx2w61EvPyVJ/1vLbSBQPHNfyA/AjTnlOkByDvWRfVp9nHhTd90Rn0=
X-Received: by 2002:a17:90a:5405:: with SMTP id z5mr2154213pjh.13.1610540186159;
 Wed, 13 Jan 2021 04:16:26 -0800 (PST)
MIME-Version: 1.0
References: <20210113052209.75531-1-songmuchun@bytedance.com>
 <20210113052209.75531-5-songmuchun@bytedance.com> <20210113093331.GV22493@dhcp22.suse.cz>
 <CAMZfGtUObSSyRZfv8CHucp6WmUZZBupKD9hbNHVpAv_PuWtMhw@mail.gmail.com>
 <20210113103836.GW22493@dhcp22.suse.cz> <CAMZfGtUTZZyL6Pdop-SHt2vs2hLuYfB9dumhRHBm7QLzyRNzZA@mail.gmail.com>
 <20210113112201.GX22493@dhcp22.suse.cz>
In-Reply-To: <20210113112201.GX22493@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 13 Jan 2021 20:15:47 +0800
Message-ID: <CAMZfGtXAsAz4E+D+kSq7tFVD76huVY2CYjcv06Axc6iGzvSpoQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 4/6] mm: hugetlb: retry dissolve page
 when hitting race
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 7:22 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 13-01-21 19:11:06, Muchun Song wrote:
> > On Wed, Jan 13, 2021 at 6:38 PM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > > I just want the fix patch to be small enough.
> > > > So I do the retry in this patch. If you do not agree with this. I
> > > > will fold this into the previous patch.
> > > >
> > > > Do you mean this?
> > > >
> > > > cpu_relax();
> > > > cond_resched();
> > > > cpu_relax();
> > >
> > > No, I am questiong the use of cpu_relax. What is the point?
> >
> > If there is no task to be scheduled. Here is just a while loop.
> > The cpu_relax is a good thing to insert into busy-wait loops,
> > right?
>
> Well in an ideal world we would simply have a way to block and wait for
> the particular page. This is probably an overkill for a rare event like
> this. And while you are right that theoretically there might be nobody
> else to run but I find it rather unlikely considering that this path is
> racing with somebody. Sure there is even less likely possibility that
> the race is actually waiting for worker context but really I would just
> make it simple retry loop. If we ever hit a real busy loop then this
> would be pretty straightforward to spot and fix up.
>
> It's not like I am against the patch with cpu_relax but I find it
> excessive for this purpose. If you feel strongly then just keep it.
>
> Once the two patches are squashed I will ack it.

OK. I will do this. Thanks.

> --
> Michal Hocko
> SUSE Labs
