Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04A32A2D64
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgKBOwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgKBOwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:52:30 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D513C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:52:30 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id k9so9270355pgt.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 06:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aUzlgHjCNYZph1yS+8m6KnYKTiNBZbplUqx6FtBjVjU=;
        b=csJWRdD1sbeRdikJMiHryEWVPv6Whuanfrwn7ExUkEHpr0dCZi27D5+8t1PzBIU0MF
         8StlO2+KZkzv01moaLPdt5lH54JxQ681jE3ValKU4UwYFI0hnd/NBRVmLdYzRYTouce2
         /RQIRDTal4ad93/5LbSqG5dsgxg4ke3B71zcsJqxHso8QxZZb+xMjzGLjU3yNlbpQF2p
         l/gb4RHMhDr9gWYiadwmAEv543hcSaDoU1nm7BsMY5RuC09+Li8bGmWVPWEKMqmo4EuZ
         MimrM8dc+K6FPORO1OaebsVObfXWbw/tGB5YKFBi0tSqYMJ27rWKQB8dFgJISRJC11PI
         dMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=aUzlgHjCNYZph1yS+8m6KnYKTiNBZbplUqx6FtBjVjU=;
        b=E5oghObYiNrb21LCUqQibwkpmdqsStLGC2zSZmfguGXQUPM2k4frXxrfQmU9o15aRL
         N5YjCrDd1nOxbPOlW5RFjP4Q920DNrQoJDAH81HVoLdFh4nu9ibDsi9m+V+29lAYrpCn
         su7IvA+WhzhGXmMgV1UEhMu84LjsDedGO47GkIIYuTWVGQm+1z58qs2o+DS09KF8JGsq
         p/HkKLujfjBwYBrR3heOH8q9rsWkt693Mx2iM3Rw2EulCdZnfZ/didicaX9SbyYfvr0j
         jHoG6Tk+K3lmJDqftrTQ/NiDlYSbHQyp8WvsweY2N2rXsQQMQqKCC9iejfQ0lGljljlo
         Sm0g==
X-Gm-Message-State: AOAM531a2fcxvTiXXXxuQFHycRV7aeTnQ9lRbmGh5XRjaKQH/0EGS74A
        G0s2mV4rFl4RlZ0O4TOyyCU=
X-Google-Smtp-Source: ABdhPJzFKBCjNxVbUjl11JQtuJ2/5uZh4S+3X59wYEHFUWsNeJydEdwWPDv1KQYecQPezkNpwEiRdg==
X-Received: by 2002:a17:90a:1903:: with SMTP id 3mr18247773pjg.74.1604328749885;
        Mon, 02 Nov 2020 06:52:29 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id y4sm13513091pjc.53.2020.11.02.06.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:52:29 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Gabriel Marin <gmx@google.com>
Subject: [RFC 0/2] perf/core: Invoke pmu::sched_task callback for cpu events
Date:   Mon,  2 Nov 2020 23:52:19 +0900
Message-Id: <20201102145221.309001-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It was reported that system-wide events with precise_ip set have a lot
of unknown symbols on Intel machines.  Depending on the system load I
can see more than 30% of total symbols are not resolved (actually
don't have DSO mappings).

I found that it's only large PEBS is enabled - using call-graph or the
frequency mode will disable it and have valid results.  I've verified
it by checking intel_pmu_pebs_sched_task() is called like below:

  # perf probe -a intel_pmu_pebs_sched_task

  # perf stat -a -e probe:intel_pmu_pebs_sched_task \
  >   perf record -a -e cycles:ppp -c 100001 sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 2.625 MB perf.data (10345 samples) ]

   Performance counter stats for 'system wide':

                 0      probe:intel_pmu_pebs_sched_task                                   

       2.157533991 seconds time elapsed


Looking at the code, I found out that the pmu::sched_task callback was
changed recently that it's called only for task events.  So cpu events
with large PEBS didn't flush the buffer and they are attributed to
unrelated tasks later resulted in unresolved symbols.

This patch reverts it and keeps the optimization for task events.
While at it, I also found the context switch callback was not enabled
for cpu events from the beginning.  So I've added it too.  With this
applied, I can see the above callbacks are hit as expected and perf
report has valid symbols.

Thanks
Namhyung


Namhyung Kim (2):
  perf/core: Enable sched_task callbacks if PMU has it
  perf/core: Invoke pmu::sched_task callback for per-cpu events

 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 42 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 2 deletions(-)

-- 
2.29.1.341.ge80a0c044ae-goog

