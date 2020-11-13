Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3372B1654
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 08:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgKMHYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 02:24:42 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:34285 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726133AbgKMHYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 02:24:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UFAebxt_1605252278;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFAebxt_1605252278)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Nov 2020 15:24:39 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     john.stultz@linaro.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] timekeeping: add missed kernel-doc marks for 'tkf'
Date:   Fri, 13 Nov 2020 15:24:31 +0800
Message-Id: <1605252275-63652-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605252275-63652-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1605252275-63652-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the kernel-doc markup and remove the following warning:
kernel/time/timekeeping.c:415: warning: Function parameter or member
'tkf' not described in 'update_fast_timekeeper'
kernel/time/timekeeping.c:464: warning: Function parameter or member
'tkf' not described in '__ktime_get_fast_ns'

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/time/timekeeping.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index daa0ff017819..d0f7cd1b8823 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -399,6 +399,7 @@ static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 c
 /**
  * update_fast_timekeeper - Update the fast and NMI safe monotonic timekeeper.
  * @tkr: Timekeeping readout base from which we take the update
+ * @tkf: NMI safe timekeeper
  *
  * We want to use this from any context including NMI and tracing /
  * instrumenting the timekeeping code itself.
@@ -430,6 +431,7 @@ static void update_fast_timekeeper(const struct tk_read_base *tkr,
 
 /**
  * ktime_get_mono_fast_ns - Fast NMI safe access to clock monotonic
+ * @tkf: NMI safe timekeeper
  *
  * This timestamp is not guaranteed to be monotonic across an update.
  * The timestamp is calculated by:
-- 
2.29.GIT

