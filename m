Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEA226B83D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgIPAjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgIONFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:05:18 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33380C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:05:07 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x77so3051589lfa.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TiUoL320uq66SMKf2+Eny3vvR1gyG9qqLiwp56ys0NU=;
        b=BfMCx+Ej3KyEKGD3ojoodaFWgTnJqd+fl6X7wGGG1ipgUMBQdtefHHu4z8IFG2JtT7
         SYE7BxxULPYUlwUQTbNphvsc/813FLdU2Ej9widBXTVYLRUdk3y5d9cTX35hPbEpdlsA
         2D2DUOLEL23YbGsoZM/i5dvIUmJLmQxLlP11LEn8cbSt2kQfjFuj+zV9DljWqEzA5hHB
         5QW7h9pTwSqSkTdwGL6HXxuRLd5i8A9k6BcH5mNO142/vWY6kzZjkK4UvXHIKAkyKflY
         ALEX2aBT4X77NebQA5aVXn2gjwe/E4Os6YN7dqKHb93Zg+sON+EBqCXeRVClGGOVKSmW
         4fMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TiUoL320uq66SMKf2+Eny3vvR1gyG9qqLiwp56ys0NU=;
        b=q+DKF2Q2Mn/Wr47cArip2DdXsLVhf5vVPwfKWeSVyP0ZR4+MXCljWigD59wpBZVCyc
         73Io9nnVo/EIma+/tROc/I+zPMsmZ2CseM/+owBELBqfg5wja9zwzJwzqR+EsgBDm9nd
         7oWqAvcXWE2dWDzsuYOWy2fE/et12V+xZT5nm2e0XIO2qOYPh2EY/IjdMpu+NPnEgIIY
         5MpmYGW27T8pwwd13l1DWsPvvuuEshtb09V9m25gMsEIEjRHKnXjFvRGQSlHyAEOQU1A
         uto5HHDQJWKPUnX2EKAts7TWuDniczjFjm4GX8BHztk0/jrZsuEww1pYAg8Om8KoM1Xh
         o57Q==
X-Gm-Message-State: AOAM531ZqPNmWx/BTQyoF+V5wksKMYAa+4GWvSoM0QCdVjE4GQvL8CHf
        6m8ixj0np4mI6rkcZLPJsbS3xl63omSeG0wc9wXTpupcWQfzL8mG
X-Google-Smtp-Source: ABdhPJyz0ruofUHHJZRu8MQdcaZ/xZKmcDvdmchuYD6qE7HxRTTLpzkMTHxFOKItn4wnjVLzRA0j1bmourzkXtrWikI=
X-Received: by 2002:a19:ed13:: with SMTP id y19mr6704282lfy.187.1600175105497;
 Tue, 15 Sep 2020 06:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200915114001.79950-1-zangchunxin@bytedance.com> <20200915121329.GC4649@dhcp22.suse.cz>
In-Reply-To: <20200915121329.GC4649@dhcp22.suse.cz>
From:   Chunxin Zang <zangchunxin@bytedance.com>
Date:   Tue, 15 Sep 2020 21:04:54 +0800
Message-ID: <CAKRVAeOwV7EBupU9dRbGJvj_M=jS=8WF+B_fEb6B7M2oN1_8TA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3] mm/vmscan: add a fatal signals check in drop_slab_node
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 8:13 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 15-09-20 19:40:01, zangchunxin@bytedance.com wrote:
> > From: Chunxin Zang <zangchunxin@bytedance.com>
> >
> > On our server, there are about 10k memcg in one machine. They use memory
> > very frequently. We have observed that drop_caches can take a
> > considerable amount of time, and can't stop it.
> >
> > There are two reasons:
> > 1. There is somebody constantly generating more objects to reclaim
> >    on drop_caches, result the 'freed' always bigger than 10.
> > 2. The process has no chance to process signals.
> >
> > We can get the following info through 'ps':
> >
> >   root:~# ps -aux | grep drop
> >   root  357956 ... R    Aug25 21119854:55 echo 3 > /proc/sys/vm/drop_caches
> >   root 1771385 ... R    Aug16 21146421:17 echo 3 > /proc/sys/vm/drop_caches
> >   root 1986319 ... R    18:56 117:27 echo 3 > /proc/sys/vm/drop_caches
> >   root 2002148 ... R    Aug24 5720:39 echo 3 > /proc/sys/vm/drop_caches
> >   root 2564666 ... R    18:59 113:58 echo 3 > /proc/sys/vm/drop_caches
> >   root 2639347 ... R    Sep03 2383:39 echo 3 > /proc/sys/vm/drop_caches
> >   root 3904747 ... R    03:35 993:31 echo 3 > /proc/sys/vm/drop_caches
> >   root 4016780 ... R    Aug21 7882:18 echo 3 > /proc/sys/vm/drop_caches
> >
> > Use bpftrace follow 'freed' value in drop_slab_node:
> >
> >   root:~# bpftrace -e 'kprobe:drop_slab_node+70 {@ret=hist(reg("bp")); }'
> >   Attaching 1 probe...
> >   ^B^C
> >
> >   @ret:
> >   [64, 128)        1 |                                                    |
> >   [128, 256)      28 |                                                    |
> >   [256, 512)     107 |@                                                   |
> >   [512, 1K)      298 |@@@                                                 |
> >   [1K, 2K)       613 |@@@@@@@                                             |
> >   [2K, 4K)      4435 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> >   [4K, 8K)       442 |@@@@@                                               |
> >   [8K, 16K)      299 |@@@                                                 |
> >   [16K, 32K)     100 |@                                                   |
> >   [32K, 64K)     139 |@                                                   |
> >   [64K, 128K)     56 |                                                    |
> >   [128K, 256K)    26 |                                                    |
> >   [256K, 512K)     2 |                                                    |
>
> I am not sure this is very helpful for this patch but whatever.
>

Yes, it looks a bit messy, I will delete that.

> > We need one path to stop the process.
>
> I would use the following instead
> "
> Add a bail out on the fatal signals in the main loop so that the
> operation can be terminated by userspace.
> "
>

Thanks,  will do that :)

> >
> > Signed-off-by: Chunxin Zang <zangchunxin@bytedance.com>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> > ---
> >
> >       changelogs in v3:
> >       1) update the description of the patch.
> >               v2 named: mm/vmscan: fix infinite loop in drop_slab_node
> >
> >       changelogs in v2:
> >       1) via check fatal signal break loop.
> >
> >  mm/vmscan.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index b6d84326bdf2..6b2b5d420510 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -704,6 +704,9 @@ void drop_slab_node(int nid)
> >       do {
> >               struct mem_cgroup *memcg = NULL;
> >
> > +             if (signal_pending(current))
> > +                     return;
> > +
> >               freed = 0;
> >               memcg = mem_cgroup_iter(NULL, NULL, NULL);
> >               do {
> > --
> > 2.11.0
> >
>
> --
> Michal Hocko
> SUSE Labs

Best wishes
Chunxin
