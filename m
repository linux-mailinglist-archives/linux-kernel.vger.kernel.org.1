Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF252D38DA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 03:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgLICdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 21:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLICdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 21:33:18 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD1CC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 18:32:33 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id h7so39179pjk.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 18:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lpLy5o85Uv8KFkEXX1qh8QHfnClzTv7IW4GkyuNRa/I=;
        b=iol7HVumr2vVfjJpGSYJsjp2//+4swLMulHc2gpp0zagvSLlssLPP9K3PRtq2X6zMy
         Po5hMnqSAA28ZIbmek9aOm0SSGmzdrpc5dZLVJ4bMUVEj0uC3X3jZ9G6A+z8LrQIi033
         +PK6fgSurp1M2od/4Td4FLHZZo1TXLt3GWL1FhWnJIJNmZWuAwNC/TPlLHYR96nthc9V
         Qj4+z5EjXrBaKWai2A4XYuBgu0phbWuur699cOnNUw7tYen7UJX3dm0rXvKlgUGn6asC
         wN0X9e+wv9i6vOlueoBI/4+SXBLMYWtrQrWQMYleF0cx+FYfqbfCsfmdDd4SkWvNPLIN
         I3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpLy5o85Uv8KFkEXX1qh8QHfnClzTv7IW4GkyuNRa/I=;
        b=SxlOK57O465K64RgkwnNwINMA78Y8iyoVgwLGOlLB+u29uBWQycfSRJAvK6btNFzKS
         XO1bfr/Tf+w8x4VuCnXtInD2wbqoKRzjlqM16lBqlIwH/XEY0orgFKqkf/KUG366H/s9
         B4h0xj3l16lHp39M8kONWDCjDzIMxhu4GQirQ8xw5D51Sb7nWWoasBkNszifWzNEckge
         2msxCCmLfvn+LY5rCPa0EzBO2+P07q7AqXMNB7j2066GK1rqo4vhLojd/Jcm/IJcaT99
         N/uLcj1gjM1POAcvs4BeJa5UUAYE2px5Dah0xaXMzh731LMeomdVqcecwfuljV8RszDq
         DTgw==
X-Gm-Message-State: AOAM533JFzxBRCbh6lCDorGzGcIh2E17EE71HSYqgUbkwBJ759ET81Cm
        BZndaNZIPu25dY1ldf//DFzP3olkwzSoKY4SA+EKMg==
X-Google-Smtp-Source: ABdhPJzX8i+5maIC4Xaggk0vVkqmpTP5yL9kQGX5Q+FNbLpvsQ7j83OXxXaeEUvRkV17+sEibPsplk/bfiju4XZ2T30=
X-Received: by 2002:a17:90a:ae14:: with SMTP id t20mr184105pjq.13.1607481152196;
 Tue, 08 Dec 2020 18:32:32 -0800 (PST)
MIME-Version: 1.0
References: <20201208095132.79383-1-songmuchun@bytedance.com> <20201209022118.GB2385286@carbon.DHCP.thefacebook.com>
In-Reply-To: <20201209022118.GB2385286@carbon.DHCP.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 9 Dec 2020 10:31:55 +0800
Message-ID: <CAMZfGtUMP6mz3DE7DHS55fyto=LZuQpcitt59WuwhZw8m2LqBg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] mm: memcontrol: optimize per-lruvec
 stats counter memory usage
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>, richard.weiyang@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 10:21 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Dec 08, 2020 at 05:51:32PM +0800, Muchun Song wrote:
> > The vmstat threshold is 32 (MEMCG_CHARGE_BATCH), so the type of s32
> > of lruvec_stat_cpu is enough. And introduce struct per_cpu_lruvec_stat
> > to optimize memory usage.
> >
> > The size of struct lruvec_stat is 304 bytes on 64 bits system. As it
> > is a per-cpu structure. So with this patch, we can save 304 / 2 * ncpu
> > bytes per-memcg per-node where ncpu is the number of the possible CPU.
> > If there are c memory cgroup (include dying cgroup) and n NUMA node in
> > the system. Finally, we can save (152 * ncpu * c * n) bytes.
>
> Honestly, I'm not convinced.
> Say, ncpu = 32, n = 2, c = 500. We're saving <5Mb of memory.
> If the machine has 128Gb of RAM, it's .000000003%.

Hi Roman,

When the cpu hotplug is enabled, the ncpu can be 256 on
some configurations. Also, the c can be more large when
there are many dying cgroup in the system.

So the savings depends on the environment and
configurations. Right?


>
> Using longs (s64) allows not to think too much about overflows
> and can also be slightly faster on 64-bit machines.
>
> Thanks!



--
Yours,
Muchun
