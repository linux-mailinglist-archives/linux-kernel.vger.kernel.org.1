Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E361E296CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462106AbgJWKUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462098AbgJWKU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:20:29 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2C3C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 03:20:29 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j5so599866plk.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 03:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=57hzLQaJMNAPBdPxw7/Mh7ohBPiIWIlEXegmuy2e8tQ=;
        b=ACFm6fNwdWbaykKnnsPWj9zBMxJwpz73jrCjLgAomymbDgslm3zxaXPbqzcb71RaHM
         kwuqXrB3gabm92H3vWWYVAW5M1A5Zphih6/uG+hTIiSPtPOnAoff8PIRVsTBKEeLYA3o
         +jcWayTNCzYFgYM8U7Pd64NyOish0Iv59WaarZfsvssYDjnMKunNebmgCUX9Zs3hKDWp
         efHM6iqiV+eV1BNbGx3NWKyUcPSoGSAxFYwSeaqdz7tF1RskfaFOk2mTvFjArlV8FoGk
         7/2S3Nmc6OGl3bm2asof4rTT8KwvfPlcZrbtuyNfeHFoPOwMvhldn7UN8QJBJ38zjLQP
         2QjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=57hzLQaJMNAPBdPxw7/Mh7ohBPiIWIlEXegmuy2e8tQ=;
        b=a/XMRuatlKJ3dO+qiInVFjKSizwEusZ0SKte7xLZkFCWUt84Mb0O9S63V4qwmbnKc2
         nPOVh4FQbePuwI6R+N+y61pSanp5Yd2Lc4co64IyemJgqC//F4Y2G9+AipKOGKN3h9G0
         2PBmxbZTaU6wpV6oU7Wns57MV6MGHAyRg7qEmO2dpgLP7spSCLLtjlDXbDJcHHtoPlTt
         MA5NctA/bxRmZOwoh99eY+jVBqNrCW0TQ92Rc6hM/IPc2hYjduCUP3K6DZcUKM1yC3Wq
         G6PSzeI+P7wYB73YDGbKYs/Mlau7FIxk8OVJylghl0+E5u/jPcGiGw7vKvoDnYWmHUqB
         V8oQ==
X-Gm-Message-State: AOAM532SggY3mC3p7eFep/4L/Vd1gK2V0HWHzenc/cuP6HGESIXJC2Io
        Iazseyb+lLH4Ub2iYULj4yiCUg==
X-Google-Smtp-Source: ABdhPJz3hhe1HtBQtKMbcAD/xcUY7YzF7JhVwG8E7RIFh9XNFgbAk+A7U6IH3tjuxLu2kVMa1dbNpw==
X-Received: by 2002:a17:902:9006:b029:d6:799:5df4 with SMTP id a6-20020a1709029006b02900d607995df4mr1842897plp.12.1603448429123;
        Fri, 23 Oct 2020 03:20:29 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id 197sm1630711pfa.170.2020.10.23.03.20.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 03:20:28 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Javi Merino <javi.merino@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Subject: [PATCH V2 0/2] cpufreq_cooling: Get effective CPU utilization from scheduler
Date:   Fri, 23 Oct 2020 15:50:19 +0530
Message-Id: <cover.1603448113.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter/Rafael,

I thought about the fallback thing getting registered by scheduler with
cpufreq core, and after Peter's comment about two interactions with
cpufreq I didn't like it much. Either way we are exposing the cpu
utilization finding algorithm to rest of the kernel, through cpufreq or
otherwise.

And so kept it simple for now. Scheduler exposes a single routine,
sched_cpu_util(), along with the related enum and that's all schedutil
and cpufreq_cooling stuff want.

V1->V2:
- Name the routine as sched_cpu_util().
- Make it more self sufficient and remove few parameters that aren't
  required to be exposed anymore to rest of the kernel.
- Better cleanups in schedutil and cpufreq_cooling.

---

Schedutil and fair.c use schedutil_cpu_util() to get an idea of how busy
a CPU is. Do the same for cpufreq_cooling which uses CPU's idle time
currently to get load, which is used to calculate the current power
consumption of the CPUs, which isn't that accurate.

Tested with hackbench and sysbench on Hikey (octa-core SMP) and no
regression was observed.

--
Viresh

Viresh Kumar (2):
  sched/core: Rename and move schedutil_cpu_util() to core.c
  thermal: cpufreq_cooling: Reuse sched_cpu_util()

 drivers/thermal/cpufreq_cooling.c |  70 +++++-------------
 include/linux/sched.h             |  19 +++++
 kernel/sched/core.c               | 113 +++++++++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c  | 116 +-----------------------------
 kernel/sched/fair.c               |   6 +-
 kernel/sched/sched.h              |  29 +-------
 6 files changed, 156 insertions(+), 197 deletions(-)

-- 
2.25.0.rc1.19.g042ed3e048af

