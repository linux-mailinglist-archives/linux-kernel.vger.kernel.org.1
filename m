Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F352021CAF7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jul 2020 20:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgGLSeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 14:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729136AbgGLSeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 14:34:24 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D96C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 11:34:23 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y13so6432846lfe.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 11:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IO9uKm8bvdgEjXJqj5Rrs1xcnUatMvk40LVf7RvbX1E=;
        b=j9AjgHBDK8GhxGwrcFrgpH75XSyVbuNfHykEx4D4mLydcgD/rn7GbBfs1u5ekG2XOP
         rBa7qpU1iHuVcWsWMIRn7fxyBREUsOaBW/HBn0hRaqYEmT1Lp+z0JecsqXPvA+hKXKVl
         v2yBsHzTJgFCEACderYqPlp4GsvJHID7YtykwUWRvBI+w9q2TiHt63YIoEmwOaRd5+09
         T5sBBkxwaK4lXsk6SYK81iiVCS6QO7NZqHKUm5PMG9Kvtqd7AFw3ENSx8k/PrJgPH7+H
         ibHqQj2ZOIIUdUhcijI56PQmDDiRoA46ppkUqgEu9YbLVxe/fLhErxtqw5u40U1KDBPC
         YGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IO9uKm8bvdgEjXJqj5Rrs1xcnUatMvk40LVf7RvbX1E=;
        b=ekCSwJSrXyzv0lxqScZ8iUOWqAEfs6HbRGlnEz7h4kMEQkHVe5L2a61a5pvgcWN1oZ
         6aqD0Kn6EZtg0IwCZvOSWeubZATpgu++orqPC+eeLiZcwaDhL75pElYxIseE+eUtqDnH
         KgY/cO4woQa9v3wSSnLkMZWxzAxsSMw+5DGaqtrOFZq1Dc/D1kF4oBcq5vYZhjI8V30o
         IA4a6qAdveLoAx0OGcUJ5gOC2aBEuOE4abgHCtr82+26UkblLz1zdtBOrMB4uGi2Ie0B
         PVvnrXxP/g7Hb/ogttAQHebCNYKtNwvRQdL1JEqFFPED4gBIiS+JFPahWI7yv5Wup9wT
         WXEA==
X-Gm-Message-State: AOAM533EeH/JGKTxhkuRDJOLn5hSdbTlam7ZVPZqE+seas8aODHjXMHu
        KzgmGjlxBpE+9ElEQov6tojmtP2aoTeWXRdiaNcVKg==
X-Google-Smtp-Source: ABdhPJyD3BLm7rKT28e/lXdMw50zAGeCsTW4qgPGdvr71CB1pTn9a1l/8uedaLfOGd2pmua+XpcP+k3dqyADBddg7Zk=
X-Received: by 2002:a05:6512:74f:: with SMTP id c15mr40253704lfs.26.1594578861881;
 Sun, 12 Jul 2020 11:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <1594396651-9931-1-git-send-email-laoar.shao@gmail.com>
In-Reply-To: <1594396651-9931-1-git-send-email-laoar.shao@gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 13 Jul 2020 00:04:10 +0530
Message-ID: <CA+G9fYuYwef7HcKbiDk_DQkKzdKf87yCnc7nHXeCmbQmFWHEUA@mail.gmail.com>
Subject: Re: [PATCH v3] mm, oom: make the calculation of oom badness more accurate
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>,
        rientjes@google.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 at 21:28, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> Recently we found an issue on our production environment that when memcg
> oom is triggered the oom killer doesn't chose the process with largest
> resident memory but chose the first scanned process. Note that all
> processes in this memcg have the same oom_score_adj, so the oom killer
> should chose the process with largest resident memory.
>
> Bellow is part of the oom info, which is enough to analyze this issue.
> [7516987.983223] memory: usage 16777216kB, limit 16777216kB, failcnt 5284=
3037
> [7516987.983224] memory+swap: usage 16777216kB, limit 9007199254740988kB,=
 failcnt 0
> [7516987.983225] kmem: usage 301464kB, limit 9007199254740988kB, failcnt =
0
[...]
> [7516987.984221] oom-kill:constraint=3DCONSTRAINT_MEMCG,nodemask=3D(null)=
,cpuset=3D3aa16c9482ae3a6f6b78bda68a55d32c87c99b985e0f11331cddf05af6c4d753,=
mems_allowed=3D0-1,oom_memcg=3D/kubepods/podf1c273d3-9b36-11ea-b3df-246e969=
3c184,task_memcg=3D/kubepods/podf1c273d3-9b36-11ea-b3df-246e9693c184/1f246a=
3eeea8f70bf91141eeaf1805346a666e225f823906485ea0b6c37dfc3d,task=3Dpause,pid=
=3D5740,uid=3D0
> [7516987.984254] Memory cgroup out of memory: Killed process 5740 (pause)=
 total-vm:1028kB, anon-rss:4kB, file-rss:0kB, shmem-rss:0kB
> [7516988.092344] oom_reaper: reaped process 5740 (pause), now anon-rss:0k=
B, file-rss:0kB, shmem-rss:0kB
>
> We can find that the first scanned process 5740 (pause) was killed, but i=
ts
> rss is only one page. That is because, when we calculate the oom badness =
in
> oom_badness(), we always ignore the negtive point and convert all of thes=
e
> negtive points to 1. Now as oom_score_adj of all the processes in this
> targeted memcg have the same value -998, the points of these processes ar=
e
> all negtive value. As a result, the first scanned process will be killed.
>
> The oom_socre_adj (-998) in this memcg is set by kubelet, because it is a
> a Guaranteed pod, which has higher priority to prevent from being killed =
by
> system oom.
>
> To fix this issue, we should make the calculation of oom point more
> accurate. We can achieve it by convert the chosen_point from 'unsigned
> long' to 'long'.
>
> [cai@lca.pw: reported a issue in the previous version]
> [mhocko@suse.com: fixed the issue reported by Cai]
> [mhocko@suse.com: add the comment in proc_oom_score()]
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Qian Cai <cai@lca.pw>
>
> ---
> v2 -> v3:
> - fix the type of variable 'point' in oom_evaluate_task()
> - initialize oom_control->chosen_points in select_bad_process() per Micha=
l
> - update the comment in proc_oom_score() per Michal
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

I have noticed kernel panic with v2 patch while running LTP mm test suite.

[ 63.451494] Out of memory and no killable processes...
[ 63.456633] Kernel panic - not syncing: System is deadlocked on memory

Then I have removed the v2 patch and applied this below v3 patch and re-tes=
ted.
No regression noticed with v3 patch while running LTP mm on x86_64 and arm.

OTOH,
oom01 test case started with 100 iterations but runltp got killed after the
6th iteration [3]. I think this is expected.

test steps:
          - cd /opt/ltp
          - ./runltp -s oom01 -I 100 || true

[  209.052842] Out of memory: Killed process 519 (runltp)
total-vm:10244kB, anon-rss:904kB, file-rss:4kB, shmem-rss:0kB, UID:0
pgtables:60kB oom_score_adj:0
[  209.066782] oom_reaper: reaped process 519 (runltp), now
anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
/lava-1558245/0/tests/0_prep-tmp-disk/run.sh: line 21:   519 Killed
              ./runltp -s oom01 -I 100

> ---
>  fs/proc/base.c      | 11 ++++++++++-
>  include/linux/oom.h |  4 ++--
>  mm/oom_kill.c       | 22 ++++++++++------------
>  3 files changed, 22 insertions(+), 15 deletions(-)


Reference test jobs,
[1] https://lkft.validation.linaro.org/scheduler/job/1558246#L9189
[2] https://lkft.validation.linaro.org/scheduler/job/1558247#L17213
[3] https://lkft.validation.linaro.org/scheduler/job/1558245#L1407
