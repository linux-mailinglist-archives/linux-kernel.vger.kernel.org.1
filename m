Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450D7221278
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 18:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgGOQg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 12:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgGOQgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:36:54 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A39C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 09:36:54 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h22so3281319lji.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 09:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eCQSS5Z/XAuJJ0ObjR5nRfl8x7vpuq0gBBiMlc5n388=;
        b=izvgTdokwsQbPkEHKbGYg+vgL3PLbT710ndTtF+lw0QVNhZPDQQjkr8aN4juyq1ITY
         yQaBTbw4G262maEKv7mI6zKBmKapyRz7IN5soCyNo1VZQX2zOEPVC7DSLWN/JmKEwdA5
         lI8Oeb9+QNbM582nfIuOILLRmXR0wXZ8dtVMWeD5p77C+CgAO3F/4N3Oz+huCpu3K9Vc
         OTktHziUeHCrwlIub3z5XnFu/xigyh3HdjfxCrAXVzW9vuSRzKqfZ0DvNEKYGC28/++q
         gYM+2CZgooNe3NtWog1NoDMOmCYr8FS9mjj8RmfHzJ1TEOktmvCLP6r3NgZXZhU/gB35
         sxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCQSS5Z/XAuJJ0ObjR5nRfl8x7vpuq0gBBiMlc5n388=;
        b=CGMkqam7IlSaaTPsyYRlQuX6Nu1h6RFdMzkINVsc/KHvU7KNSM7LUl3r0SnZwjrzrZ
         rTfR4h3+Nxa4l8s6w1X894QQZfK2Ja0mo5wOdQcw/0bCFZh5VZ+ivCMIlaIjQCByUcNX
         5FVC4arojQCPTnlPW7YOUi3LbTkeAvI1BLmyEr3zjlWAiUYc9Y8DHlRAUa9HqTr5cayg
         6RWjoZuq5dESMhKTCYwyl+D4J+NkkOzvvXIGPXBQNRUeE+MUkJj7pmVN+b8LSBp7Uyf5
         vx/qlywy7mmvTHkq5F8yP7hczSPEcAi80BP000zwlh2obj61YiIchS2enxbmmKECbj/Z
         KAMw==
X-Gm-Message-State: AOAM533zeiwN0sc/MD32k1ZK36ymG+rjWberxbxVrFHtqMebH6Pfjxeg
        /Bzz8EQaPRtWvwouLmEAziZlACZ9Vw9uAZgVjDehtQ==
X-Google-Smtp-Source: ABdhPJxkvCC8/QXGjTsKModznq9Sitpzv8TpZrU2xepInx6yXDiYQJ55n1/Rgdh/Jkbnh3Eg86yNuwgRgkS6wU5FZEc=
X-Received: by 2002:a2e:9585:: with SMTP id w5mr24703ljh.58.1594831012200;
 Wed, 15 Jul 2020 09:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <1585649077-10896-1-git-send-email-laoar.shao@gmail.com>
In-Reply-To: <1585649077-10896-1-git-send-email-laoar.shao@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 15 Jul 2020 09:36:41 -0700
Message-ID: <CALvZod6Yn=_fYEM+xN3a+4W2e5CCLkvMXZg_txD3j+dZieX-CQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] psi: enhance psi with the help of ebpf
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yafang,

On Tue, Mar 31, 2020 at 3:05 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> PSI gives us a powerful way to anaylze memory pressure issue, but we can
> make it more powerful with the help of tracepoint, kprobe, ebpf and etc.
> Especially with ebpf we can flexiblely get more details of the memory
> pressure.
>
> In orderc to achieve this goal, a new parameter is added into
> psi_memstall_{enter, leave}, which indicates the specific type of a
> memstall. There're totally ten memstalls by now,
>         MEMSTALL_KSWAPD
>         MEMSTALL_RECLAIM_DIRECT
>         MEMSTALL_RECLAIM_MEMCG
>         MEMSTALL_RECLAIM_HIGH
>         MEMSTALL_KCOMPACTD
>         MEMSTALL_COMPACT
>         MEMSTALL_WORKINGSET_REFAULT
>         MEMSTALL_WORKINGSET_THRASH
>         MEMSTALL_MEMDELAY
>         MEMSTALL_SWAPIO
> With the help of kprobe or tracepoint to trace this newly added agument we
> can know which type of memstall it is and then do corresponding
> improvement. I can also help us to analyze the latency spike caused by
> memory pressure.
>
> But note that we can't use it to build memory pressure for a specific type
> of memstall, e.g. memcg pressure, compaction pressure and etc, because it
> doesn't implement various types of task->in_memstall, e.g.
> task->in_memcgstall, task->in_compactionstall and etc.
>
> Although there're already some tracepoints can help us to achieve this
> goal, e.g.
>         vmscan:mm_vmscan_kswapd_{wake, sleep}
>         vmscan:mm_vmscan_direct_reclaim_{begin, end}
>         vmscan:mm_vmscan_memcg_reclaim_{begin, end}
>         /* no tracepoint for memcg high reclaim*/
>         compcation:mm_compaction_kcompactd_{wake, sleep}
>         compcation:mm_compaction_begin_{begin, end}
>         /* no tracepoint for workingset refault */
>         /* no tracepoint for workingset thrashing */
>         /* no tracepoint for use memdelay */
>         /* no tracepoint for swapio */
> but psi_memstall_{enter, leave} gives us a unified entrance for all
> types of memstall and we don't need to add many begin and end tracepoints
> that hasn't been implemented yet.
>
> Patch #2 gives us an example of how to use it with ebpf. With the help of
> ebpf we can trace a specific task, application, container and etc. It also
> can help us to analyze the spread of latencies and whether they were
> clustered at a point of time or spread out over long periods of time.
>
> To summarize, with the pressure data in /proc/pressure/memroy we know that
> the system is under memory pressure, and then with the newly added tracing
> facility in this patchset we can get the reason of this memory pressure,
> and then thinks about how to make the change.
> The workflow can be illustrated as bellow.
>
>                    REASON         ACTION
>                  | compcation   | improve compcation    |
>                  | vmscan       | improve vmscan        |
> Memory pressure -| workingset   | improve workingset    |
>                  | etc          | ...                   |
>

I have not looked at the patch series in detail but I wanted to get
your thoughts if it is possible to achieve what I am trying to do with
this patch series.

At the moment I am only interested in global reclaim and I wanted to
enable alerts like "alert if there is process stuck in global reclaim
for x seconds in last y seconds window" or "alert if all the processes
are stuck in global reclaim for some z seconds".

I see that using this series I can identify global reclaim but I am
wondering if alert or notifications are possible. Android is using psi
monitors for such alerts but it does not use cgroups, so, most of the
memstalls are related to global reclaim stall. For cgroup environment,
do we need for add support to psi monitor similar to this patch
series?

thanks,
Shakeel
