Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD72227BAB3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 04:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgI2CKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 22:10:55 -0400
Received: from mail5.windriver.com ([192.103.53.11]:37566 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbgI2CKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 22:10:55 -0400
X-Greylist: delayed 1024 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Sep 2020 22:10:55 EDT
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 08T1p5Jm012535
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 28 Sep 2020 18:51:15 -0700
Received: from pek-qwang2-d1.wrs.com (128.224.162.199) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Mon, 28 Sep 2020 18:50:54 -0700
From:   <quanyang.wang@windriver.com>
To:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>, Leo Yan <leo.yan@linaro.org>,
        Will Deacon <will@kernel.org>, <a.darwish@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        <ben.dooks@codethink.co.uk>
Subject: [PATCH V2] time/sched_clock: mark sched_clock_read_begin/retry as notrace
Date:   Tue, 29 Sep 2020 09:50:51 +0800
Message-ID: <20200929015051.4097-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

Since sched_clock_read_begin and sched_clock_read_retry are called
by notrace function sched_clock, they shouldn't be traceable either,
or else ftrace_graph_caller will run into a dead loop on the path
as below (arm for instance):

  ftrace_graph_caller
    prepare_ftrace_return
      function_graph_enter
        ftrace_push_return_trace
          trace_clock_local
            sched_clock
              sched_clock_read_begin/retry

Fixes: 1b86abc1c645 ("sched_clock: Expose struct clock_read_data")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
Changes:
V2: Add notrace to sched_clock_read_retry according to Peter's suggestion.

 kernel/time/sched_clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 1c03eec6ca9b..f629e3f5afbe 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -68,13 +68,13 @@ static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
 	return (cyc * mult) >> shift;
 }
 
-struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
+notrace struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
 {
 	*seq = raw_read_seqcount_latch(&cd.seq);
 	return cd.read_data + (*seq & 1);
 }
 
-int sched_clock_read_retry(unsigned int seq)
+int notrace sched_clock_read_retry(unsigned int seq)
 {
 	return read_seqcount_retry(&cd.seq, seq);
 }
-- 
2.17.1

