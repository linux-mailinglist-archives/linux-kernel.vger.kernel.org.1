Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215FB28503A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 18:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgJFQz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 12:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgJFQz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 12:55:56 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E53C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 09:55:56 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a5so6110056ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 09:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6FMgIEmm68X+8barBvlty/GsDrmbyTvteiUC/zViSzM=;
        b=E+fs5Kb6ZtKcDpUZvLnSB08EOAVj2XhAZad69x+W3WhY0TvKQs7HLnWuX1DalOm5k3
         75g0XMp7neiJ0e9OM6kSd7eBrufBh65ij0geSUYX+V5pNfDC72uq3vfmfDr0gtlZMpbJ
         DcQ0L1pYWRcCDJNfvgKMXtdc4EmejdC6A7ZExgxw+UxR0Ojc0g9NL1qIJs/8vB0fMhdJ
         x1JgRTLTqvDnnjFkkyrjySeMyl+r5ulpW2pQVTHhS4Ehu9+aX8n2CePeR3tUCCaBQ07T
         OQZfOuGO2gJWiGAternLPjoBUgE1ZZbuHrHcPcpP/ZzCWyLa8C6aBNI8lPQeSibLV3XP
         Y+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6FMgIEmm68X+8barBvlty/GsDrmbyTvteiUC/zViSzM=;
        b=l2U4BIhDViIuE2ffcVoI98bqKkwL45Wwhlu4FOAWGQHhiCMVHWvMiMkFa7HrZCOuNk
         WBwa9LX5La/UULMhmhIO4XXtp58r5WpFQdNrMtYZy6xb7oAgF76wHPV1/BJJHdcT6B4w
         jd2f4j+XW2S2AHWiU7KEUOarE2xMhNuKKxZZw0qF8TiJPSiJC9Y7yVZ4VrlzRP6I0wT1
         6V4pEqN7+35aNURiFjMhiF4MDX/kRsCu5fXTyy4nyFTBIFkOJmClEkNc8IrYLpvCVGr0
         wi/T3rxA73aYV5zllTtbsEAAy2i3+p093g/fgUFHxX4VMhdCa4hy5q/V7ZW8lCxx1kAC
         SwWg==
X-Gm-Message-State: AOAM5307LPdpIXXQ0xbHZuktcj+RjRzcQPjKx7n2PXXWGhmxCZ+NmhXg
        lZTxZzhb+XSuRrnxbPNWHUWZEsYMMlFbFwM4nNFmDg==
X-Google-Smtp-Source: ABdhPJxwPjYlCjbDVgEIVph5gkze3H34vaF29xYPgo2Wf3p+vlcIihMw4jCo164Pl8sUFSMayqXA9/r5NmYncb6z2LE=
X-Received: by 2002:a2e:3c0e:: with SMTP id j14mr1670185lja.332.1602003354535;
 Tue, 06 Oct 2020 09:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200909215752.1725525-1-shakeelb@google.com> <20200928210216.GA378894@cmpxchg.org>
 <20200929150444.GG2277@dhcp22.suse.cz> <20200929215341.GA408059@cmpxchg.org>
 <CALvZod5eN0PDtKo8SEp1n-xGvgCX9k6-OBGYLT3RmzhA+Q-2hw@mail.gmail.com> <20201001143149.GA493631@cmpxchg.org>
In-Reply-To: <20201001143149.GA493631@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 6 Oct 2020 09:55:43 -0700
Message-ID: <CALvZod59cU40A3nbQtkP50Ae3g6T2MQSt+q1=O2=Gy9QUzNkbg@mail.gmail.com>
Subject: Re: [PATCH] memcg: introduce per-memcg reclaim interface
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Righi <andrea.righi@canonical.com>,
        SeongJae Park <sjpark@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 7:33 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
[snip]
> > >    So instead of asking users for a target size whose suitability
> > >    heavily depends on the kernel's LRU implementation, the readahead
> > >    code, the IO device's capability and general load, why not directly
> > >    ask the user for a pressure level that the workload is comfortable
> > >    with and which captures all of the above factors implicitly? Then
> > >    let the kernel do this feedback loop from a per-cgroup worker.
> >
> > I am assuming here by pressure level you are referring to the PSI like
> > interface e.g. allowing the users to tell about their jobs that X
> > amount of stalls in a fixed time window is tolerable.
>
> Right, essentially the same parameters that psi poll() would take.

I thought a bit more on the semantics of the psi usage for the
proactive reclaim.

Suppose I have a top level cgroup A on which I want to enable
proactive reclaim. Which memory psi events should the proactive
reclaim should consider?

The simplest would be the memory.psi at 'A'. However memory.psi is
hierarchical and I would not really want the pressure due limits in
children of 'A' to impact the proactive reclaim. PSI due to refaults
and slow IO should be included or maybe only those which are caused by
the proactive reclaim itself. I am undecided on the PSI due to
compaction. PSI due to global reclaim for 'A' is even more
complicated. This is a stall due to reclaiming from the system
including self. It might not really cause more refaults and IOs for
'A'. Should proactive reclaim ignore the pressure due to global
pressure when tuning its aggressiveness.

Am I overthinking here?
