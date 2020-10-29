Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE62529F0B4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgJ2QCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgJ2QCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:02:36 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90896C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:01:50 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 126so3964882lfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p81Xb4QB6WZnyTYb/aPQJGGs3MtSmkCjVSQFBTfTe00=;
        b=eeVMWmyLkGAhC1rQFKkLvBOCkWQ6Smot20Si3H+Lg87YKkUxflwYxLcfGFqVLc5KLf
         SwfZDbAGSj4utMXHZmxzJ7TGpzf/Jd7X5Inmxc4MCtwfLFLZytqccPGQm1mHvSm7j5Lp
         dMfYdPJhpw9CWTTVqZsaV7ks5rzt5ea8aULFpgqf8ikV/61BMq3p8Szx3rYFDUXOUAnZ
         mAnrQOY1y6sAb0KwsoD3XeL7AmBHXhk4w543PNyD0NFf6HqcD0asVoBZ1/Q11E6qJedJ
         7abxq5IUrm3H3tQgcVV7hVxwNp+ND66/eKEZkhmXVM7KiHEur3c3SDi/bzfspTKvt+9q
         iOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p81Xb4QB6WZnyTYb/aPQJGGs3MtSmkCjVSQFBTfTe00=;
        b=Mmwb6RO5ZFZQOX6rryx4vwB4W/63dywF+xN6pdqPpAWcOTc2QUjd7FGg8NItz5eN7I
         nU8JzUbrh9BnIbfuUkqF+S/+nG4gf1o4AyjoUNNIxssbvMSZIHZ/XmpVPl2Vjw39Qzwp
         EmbTdvmP1PGLipWP5yoKLS5t7YIb81GcMsTtsd/d5GkY8hC4Z64yl98YwCUhbhpjoKKM
         akqhe8FqVuGzgpoOdHUl1E3mHzsuhNnixzxnSoUbzSkeW7XtanzfQNBixtXlZKv8fBFL
         8bs7lZ2u7i1ceBHlEL40RZKwiLZdKbPR0eE/DvtxPOOA1qXUnOQGdcJRiCgx5n7a5KEY
         Pggg==
X-Gm-Message-State: AOAM5313HJaPAXZmu6rxJ3cw/5Qt9paBrF96m4iNvYFJKM9WgI0EBIB2
        Q9uflvWAI9mhF8oraMVtxpN1Xmt9+vS8NRxPx0KIkA==
X-Google-Smtp-Source: ABdhPJx+zC1arRhZCm7aznCIifmlA/6cXtGd3vyaxduqhW4AIttT0kz+HB9ULUcSqFW5zic1sM3xgNSvr5x8UXg3rjA=
X-Received: by 2002:a19:7ed8:: with SMTP id z207mr1786143lfc.54.1603987308798;
 Thu, 29 Oct 2020 09:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201028035013.99711-1-songmuchun@bytedance.com>
 <20201028035013.99711-4-songmuchun@bytedance.com> <20201029090806.GD17500@dhcp22.suse.cz>
In-Reply-To: <20201029090806.GD17500@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 29 Oct 2020 09:01:37 -0700
Message-ID: <CALvZod68-f-_1pevYbegzXk_b0L=XbCJkM5KqcRF9TuLiz3_ww@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcontrol: Simplify the mem_cgroup_page_lruvec
To:     Michal Hocko <mhocko@suse.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>, areber@redhat.com,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 2:08 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 28-10-20 11:50:13, Muchun Song wrote:
> [...]
> > -struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgdat)
> > +static struct lruvec *
> > +__mem_cgroup_node_lruvec(struct mem_cgroup *memcg, struct pglist_data *pgdat,
> > +                      int nid)
>
> I thought I have made it clear that this is not a good approach. Please
> do not repost new version without that being addressed. If there are any
> questions then feel free to ask for details.

You can get nid from pgdat (pgdat->node_id) and also pgdat from nid
(NODE_DATA(nid)), so, __mem_cgroup_node_lruvec() only need one of them
as parameter.
