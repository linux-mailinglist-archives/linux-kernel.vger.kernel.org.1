Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3EB300071
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbhAVKdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbhAVJbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 04:31:46 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1160C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 01:31:04 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id j3so5746853ljb.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 01:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MH09kRgJ3c/VLXxR/STT+yQAdeF/xaJCGc1HwjRJZkE=;
        b=fTNefO3CE/8eT/BhlNZ/09hynki/eX2wQrVm/MfFHE1bga140ti86/ipN8YcUQw9YM
         B9IpLSBri0jWukR3BldrbG3XAFv33mgC9QOUbRNM5fXfAzg5TvIKSznftQrZxkY06pOE
         yYge6nxWVahSyHHyDrswV+g6c6RQo+p1G7AtujWjXiK3TkoNqMuDumACREroxnUcxCss
         dR0h2Kh+4RqLjGHs/q+V3BM/YNN0H4T3is16fLAJzLpvuu4g+QevunmCQ/bufxlLBMmF
         1P7RLxD6mCNlkyJCWsKQynPTozih8GeYexPdcHI0l9CqZtp+bkbX9NSdMQ8ercJ0hJ2z
         6hkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MH09kRgJ3c/VLXxR/STT+yQAdeF/xaJCGc1HwjRJZkE=;
        b=Yr47tw4UXZfFn1lKHhchQBIMC3U2tuJfhTw5n+04C8P9E6b2LGesYDv0xNMpd+18tI
         A2BNTJokvLqSHpirsgQBNtam1ZKH8B7iQBOsy4/P8bU3sVApagm3BXJvssGA4w2yPm2S
         +QOZivAw/tlNqnfx6eDvS5jCJqB7KQiU8ls9atrjl/DWvxWGSihCRqC3nnl8XnAzXTAL
         yI59VFVqaeyEDVaRpO+tM2eLbPXQMxhk67yvINLNMSUFcIGcCvJJ88k0FflCxivUkwpd
         vaDAG1+lBO2MuAcVMufuRvpiicO6P0P7k79+t5WRP0gEwftQNyqVRuS68guYwmSb+ai9
         EHJQ==
X-Gm-Message-State: AOAM531+j/RX0Ncycrzi0kRS/9r8hzltZvEpTTzJEXawSdB45Fubkmgg
        G7ZKF4Ho4ebvAssZ5dhq57E4HRsXLaXcMlWSVlZabg==
X-Google-Smtp-Source: ABdhPJwuoAdyNU35yxqzV+uohI/w2WqZwDX+hzgCxIwuBYuRu1hFfCLvJdYA3PkCm7AHOrv4KRb6WH2qjJLqDfBzAlE=
X-Received: by 2002:a2e:b4d4:: with SMTP id r20mr788113ljm.445.1611307863312;
 Fri, 22 Jan 2021 01:31:03 -0800 (PST)
MIME-Version: 1.0
References: <20210119112211.3196-1-mgorman@techsingularity.net>
 <CAKfTPtAsuY4aN6J2C+KCOpyJDULd6yEBZ_8zTLWRXwhakCq8oQ@mail.gmail.com> <20210119120220.GS3592@techsingularity.net>
In-Reply-To: <20210119120220.GS3592@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 22 Jan 2021 10:30:52 +0100
Message-ID: <CAKfTPtAWcVu5y_L93h47WHS1wkUZh=EPxyMDi5vSeNvx14Y_kQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Scan for an idle sibling in a single pass
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

On Tue, 19 Jan 2021 at 13:02, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Jan 19, 2021 at 12:33:04PM +0100, Vincent Guittot wrote:
> > On Tue, 19 Jan 2021 at 12:22, Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > Changelog since v2
> > > o Remove unnecessary parameters
> > > o Update nr during scan only when scanning for cpus
> >
> > Hi Mel,
> >
> > I haven't looked at your previous version mainly because I'm chasing a
> > performance regression on v5.11-rcx which prevents me from testing the
> > impact of your patchset on my !SMT2 system.
> > Will do this as soon as this problem is fixed
> >
>
> Thanks, that would be appreciated as I do not have access to a !SMT2
> system to do my own evaluation.

I have been able to run tests with your patchset on both large arm64
SMT4 system and small arm64 !SMT system and patch 3 is still a source
of regression on both. Decreasing min number of loops to 2 instead of
4 and scaling it with smt weight doesn't seem to be a good option as
regressions disappear when I remove them as I tested with the patch
below

hackbench -l 2560 -g 1 on 8 cores arm64
v5.11-rc4 : 1.355 (+/- 7.96)
+ sis improvement : 1.923 (+/- 25%)
+ the patch below : 1.332 (+/- 4.95)

hackbench -l 2560 -g 256 on 8 cores arm64
v5.11-rc4 : 2.116 (+/- 4.62%)
+ sis improvement : 2.216 (+/- 3.84%)
+ the patch below : 2.113 (+/- 3.01%)

So starting with a min of 2 loops instead of 4 currently and scaling
nr loop with smt weight doesn't seem to be a good option and we should
remove it for now

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 808e40d0439d..c4de33574e6e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6138,7 +6138,7 @@ static inline int select_idle_core(struct
task_struct *p, int core, struct cpuma

 #endif /* CONFIG_SCHED_SMT */

-#define sis_min_cores          2
+#define sis_min_cores          4

 /*
  * Scan the LLC domain for idle CPUs; this is dynamically regulated by
@@ -6176,8 +6176,6 @@ static int select_idle_cpu(struct task_struct
*p, struct sched_domain *sd, int t
                else
                        nr = sis_min_cores;

-               nr *= sched_smt_weight;
-
                time = cpu_clock(this);
        }



>
> --
> Mel Gorman
> SUSE Labs
