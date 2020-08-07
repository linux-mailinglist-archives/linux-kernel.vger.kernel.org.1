Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BAA23E792
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 09:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgHGHJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 03:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgHGHJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:09:25 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB587C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 00:09:24 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id o21so1048171oie.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 00:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uLQHBFTmBmwUqDoaiiE130WzMyrApr6UvOSb4IUTTB8=;
        b=TmSBvJ3duCrYdmyJEMPijGgyzrsxf4Wsp0DSFhOtD6F+n69OQjKaYTBX+nmXYpsOhZ
         gsTTpuRxsgbNl9n81S8XZx8geuSicmXGyklUHmZ4oLofkRedfWazPB8v6w0yqdsmFAY8
         o8Pg10anUkIByOne6YFJJVmsG0ZX0pgGpdGn1O/H62wI335Bv/hVJvDsqqDGIzoXT17W
         iAJrDkyVjmqGVlvmcilO59TFZqXSxmd1rUz92L/+5tPfFC+uNpOk1XNHBNZ1w0K8+eQY
         Q3fObk3+JE8uisNWIkHu5OyZFLANXbjTOWjQDnn0r3L2+zBpKdjeEjgEE2hD+wpF/eJh
         m5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uLQHBFTmBmwUqDoaiiE130WzMyrApr6UvOSb4IUTTB8=;
        b=PH04p38B0rFTu3cWlwREOU95pttJnisCaMSOhYHq9n9vrdStOHy8tK2jEfdkH0ORde
         gQ2hVmc5omZTRlNmLQt2kidfiIveRUUdVEBSEUCKItnYFP+ZMRYmVNwY1HK0P/dlpi5E
         sVmJZp5Gedw5CvnY5CTND5OvNfKzyh+qn6FW3cI1k6BT0TUplL+ka4D+VS8dUMqvzevX
         9qQUTT1yF6oKd9HvJjmE0e/6rHaN+0heSKWzK+3HvHrCYzv3WpK50wh9lQ/mU+RWplty
         acNReNfUTmJolmh4SEyk3ig1TJW3gDczj26eqLjmzdIglstq+/0y8Wy991o2midb31Bk
         JKbQ==
X-Gm-Message-State: AOAM533s3Ik/NqOGfbnxjKQx/W8rQLjFKzSbE6YtpvVSjhPQTs7WZqSK
        CTofTWEey7+3/TIIob225lFn4QO6e9hC0GltDPE=
X-Google-Smtp-Source: ABdhPJxUoUC9D1qb/TSkAtYOZ8P2AojnvVZYFEvhk1z4B1ubehX59+bxtrZtMZqnwBJfHPii3A/W7qOJg1fB8ab3phE=
X-Received: by 2002:aca:f38b:: with SMTP id r133mr10348803oih.81.1596784163233;
 Fri, 07 Aug 2020 00:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200803061805epcas2p20faeeff0b31b23d1bc4464972285b561@epcas2p2.samsung.com>
 <1596435031-41837-1-git-send-email-pullip.cho@samsung.com> <5f41af0f-4593-3441-12f4-5b0f7e6999ac@redhat.com>
In-Reply-To: <5f41af0f-4593-3441-12f4-5b0f7e6999ac@redhat.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Fri, 7 Aug 2020 10:08:41 +0300
Message-ID: <CAOJsxLHTL__N3KE_HUhQrVR=rkri80=kU1e64-6nBgMKHZRi4g@mail.gmail.com>
Subject: Re: [PATCH] mm: sort freelist by rank number
To:     David Hildenbrand <david@redhat.com>
Cc:     pullip.cho@samsung.com, Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, hyesoo.yu@samsung.com,
        janghyuck.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cho and David,

On Mon, Aug 3, 2020 at 10:57 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 03.08.20 08:10, pullip.cho@samsung.com wrote:
> > From: Cho KyongHo <pullip.cho@samsung.com>
> >
> > LPDDR5 introduces rank switch delay. If three successive DRAM accesses
> > happens and the first and the second ones access one rank and the last
> > access happens on the other rank, the latency of the last access will
> > be longer than the second one.
> > To address this panelty, we can sort the freelist so that a specific
> > rank is allocated prior to another rank. We expect the page allocator
> > can allocate the pages from the same rank successively with this
> > change. It will hopefully improves the proportion of the consecutive
> > memory accesses to the same rank.
>
> This certainly needs performance numbers to justify ... and I am sorry,
> "hopefully improves" is not a valid justification :)
>
> I can imagine that this works well initially, when there hasn't been a
> lot of memory fragmentation going on. But quickly after your system is
> under stress, I doubt this will be very useful. Proof me wrong. ;)
>
> ... I dislike this manual setting of "dram_rank_granule". Yet another mm
> feature that can only be enabled by a magic command line parameter where
> users have to guess the right values.
>
> (side note, there have been similar research approaches to improve
> energy consumption by switching off ranks when not needed).

I was thinking of the exact same thing. PALLOC [1] comes to mind, but
perhaps there are more recent ones?

I also dislike the manual knob, but is there a way for the OS to
detect this by itself? My (perhaps outdated) understanding was that
the DRAM address mapping scheme, for example, is not exposed to the
OS.

I think having more knowledge of DRAM controller details in the OS
would be potentially beneficial for better page allocation policy, so
maybe try come up with something more generic, even if the fallback to
providing this information is a kernel command line option.

[1] http://cs-people.bu.edu/rmancuso/files/papers/palloc-rtas2014.pdf

- Pekka
