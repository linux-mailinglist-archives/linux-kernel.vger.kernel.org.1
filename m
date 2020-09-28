Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB98627ACF2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 13:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgI1LgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 07:36:15 -0400
Received: from mail.windriver.com ([147.11.1.11]:50591 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgI1LgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 07:36:15 -0400
X-Greylist: delayed 2734 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Sep 2020 07:36:10 EDT
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 08SAnu8U012139
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 28 Sep 2020 03:49:56 -0700 (PDT)
Received: from pek-qwang2-d1.wrs.com (128.224.162.199) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Mon, 28 Sep 2020 03:49:55 -0700
From:   <quanyang.wang@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Leo Yan <leo.yan@linaro.org>, Will Deacon <will@kernel.org>,
        <a.darwish@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        <ben.dooks@codethink.co.uk>
Subject: [PATCH] time/sched_clock: mark sched_clock_read_begin as notrace
Date:   Mon, 28 Sep 2020 18:49:52 +0800
Message-ID: <20200928104952.26892-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

Since sched_clock_read_begin is called by notrace function sched_clock,
it shouldn't be traceable either, or else __ftrace_graph_caller will
run into a dead loop on the path (arm for instance):

  ftrace_graph_caller
    prepare_ftrace_return
      function_graph_enter
        ftrace_push_return_trace
          trace_clock_local
            sched_clock
              sched_clock_read_begin

Fixes: 1b86abc1c645 ("sched_clock: Expose struct clock_read_data")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 kernel/time/sched_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 1c03eec6ca9b..58459e1359d7 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -68,7 +68,7 @@ static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
 	return (cyc * mult) >> shift;
 }
 
-struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
+notrace struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
 {
 	*seq = raw_read_seqcount_latch(&cd.seq);
 	return cd.read_data + (*seq & 1);
-- 
2.17.1

