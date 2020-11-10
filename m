Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D50F2ACB60
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 03:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbgKJC5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 21:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJC5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 21:57:54 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C78EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 18:57:53 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i7so8887509pgh.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 18:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I5rP8g6hbwpalFY9R3djgaCnvHELnDvXyVufjhRMTp4=;
        b=SajSFgVHD3t008BCAfms7vYRMyHVUNzVRoA9PWFZhXui2O65vHkM6DHm76/JFdYwd0
         Ao1jHwv2xVK7DR+x9csXBc4CgxDrYzZa3pmQThaX6k5GCMWtjXcEfOclD/YCPx+bD/V/
         8GoKyIpwouyJ9qZhDEjPxCEFAdDiQ2Vi/wZJD0Y3y5sOG0ILsxFZo2b90YigtXRCw514
         3UxAGOMfv4mUYklolS4667iUrk8HLWMrCIwuv091M1pJA+PeL/L9qb+WVvEsF//ZW1DK
         86t/cwgS059JrMj9k5kPJaS7bn/qeTnp9LTbRi+rZ7LvPPy/tw1ShgVSm5jsl49b0DvM
         1dqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I5rP8g6hbwpalFY9R3djgaCnvHELnDvXyVufjhRMTp4=;
        b=KF2YIT51rInsnr+swHqreN5ePXsMHck3H6azL0130MGI1pEgd1HEB6YLemaFefQsGq
         vLV5IyTWWx3/N7lweRJC1lIIZsm7psXmCbDyQHlJKiqwWDDpgwce79Ge/eKhkpaD2J6S
         eyDxSiPCJ+anAXoA/N5P9yMMMA/UjM++PbGQQEPEzpcLWTPvKiSpdKaB/E0xrNKOhUsl
         qt1WqPFwMmhSkoe+2cqUbN2evdldEr4bofW6lH5rPRGxlrcb5/veI/rtyrSBRs8JSgBm
         fLbaQ4Za1aabn1xsS/njEl9txOeyGKNhXBu5/Hc7hYAes0u27cnmiFsNH4074o+PSvE2
         Sd6w==
X-Gm-Message-State: AOAM530Qnvbz6Xmq6MIH8d0Q/CynZJmYdydHy0OmqCgbasACWrIZZ+Dv
        ATu/a1wM9ywlunsvyY20+Yz/mCumdD8kBqJ0IshK7A==
X-Google-Smtp-Source: ABdhPJxdBbEXq4Wwv7KcDH91L5LSKHsQCubNvPyNBN2i9pd3XRGWN3xcgrQbQ3hk95uYjRIE42rpxP0qtBtjfj6pixo=
X-Received: by 2002:a17:90a:8086:: with SMTP id c6mr2517944pjn.147.1604977072730;
 Mon, 09 Nov 2020 18:57:52 -0800 (PST)
MIME-Version: 1.0
References: <20201027080256.76497-1-songmuchun@bytedance.com>
 <20201027080256.76497-5-songmuchun@bytedance.com> <20201027184835.GB827280@carbon.dhcp.thefacebook.com>
 <CAMZfGtU1aViokYk1hkHbYEiqW5QNi49UTd-QTrkycLqj6Q+-8g@mail.gmail.com>
 <20201029001408.GF827280@carbon.dhcp.thefacebook.com> <CAMZfGtW9wa=S7+OQw_R+4LU5VzcN0H0OUPw-2XfTAJFniQN3TA@mail.gmail.com>
 <20201110013236.GB2612097@carbon.dhcp.thefacebook.com>
In-Reply-To: <20201110013236.GB2612097@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 10 Nov 2020 10:57:16 +0800
Message-ID: <CAMZfGtUC63W3PYE8QwoNgxCvuyHBnvuzL3i8--873AYKmncAfg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 4/5] mm: memcg/slab: Fix root memcg vmstats
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>, areber@redhat.com,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 9:33 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, Oct 29, 2020 at 02:15:43PM +0800, Muchun Song wrote:
> > On Thu, Oct 29, 2020 at 8:14 AM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Wed, Oct 28, 2020 at 10:56:20AM +0800, Muchun Song wrote:
> > > > On Wed, Oct 28, 2020 at 2:48 AM Roman Gushchin <guro@fb.com> wrote:
> > > > >
> > > > > On Tue, Oct 27, 2020 at 04:02:55PM +0800, Muchun Song wrote:
> > > > > > If we reparent the slab objects to the root memcg, when we free
> > > > > > the slab object, we need to update the per-memcg vmstats to keep
> > > > > > it correct for the root memcg. Now this at least affects the vmstat
> > > > > > of NR_KERNEL_STACK_KB for !CONFIG_VMAP_STACK when the thread stack
> > > > > > size is smaller than the PAGE_SIZE.
> > > > > >
> > > > > > Fixes: ec9f02384f60 ("mm: workingset: fix vmstat counters for shadow nodes")
> > > > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > >
> > > > > Can you, please, drop this patch for now?
> > > > >
> > > > > I'm working on a bigger cleanup related to the handling of the root memory
> > > > > cgroup (I sent a link earlier in this thread), which already does a similar change.
> > > > > There are several issues like this one, so it will be nice to fix them all at once.
> > > >
> > > > I have read the patch of https://lkml.org/lkml/2020/10/14/869. You
> > > > mean this patch
> > > > fixes this issue? It chooses to uncharge the root memcg. But here we may need to
> > > > uncharge the root memcg to keep root vmstats correct. If we do not do
> > > > this, we can
> > > > see the wrong vmstats via root memory.stat(e.g. NR_KERNEL_STACK_KB).
> > >
> > > I pointed at a different patch in the same thread (it looks like you read the first one):
> > > https://lkml.org/lkml/2020/10/21/612
>
> Hi Muchun!
>
> Can you please, resend your patch? The planned cleanup of the root memory cgroup
> is more complex than expected, so I think it makes sense to merge your patch without
> waiting for it. I'm sorry for delaying it initially.

OK, I will do that. Thanks.

>
> Please, feel free to add
> Acked-by: Roman Gushchin <guro@fb.com>
>
> Thank you!
>
> Roman



-- 
Yours,
Muchun
