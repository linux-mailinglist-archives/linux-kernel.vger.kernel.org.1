Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C2A2B1658
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 08:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgKMHYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 02:24:53 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:29019 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726431AbgKMHYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 02:24:51 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UFAebxt_1605252278;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFAebxt_1605252278)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Nov 2020 15:24:39 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     john.stultz@linaro.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] timekeeping: remove static functions from kernel-doc markup
Date:   Fri, 13 Nov 2020 15:24:33 +0800
Message-Id: <1605252275-63652-4-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605252275-63652-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1605252275-63652-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are couple of functions are 'static' without correct kernel-doc
marks. Since they are not likely be used by others, moving them out of
kernel-doc is better.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/time/timekeeping.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 9db6aee48c52..9bee13d94d70 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1403,7 +1403,7 @@ void timekeeping_warp_clock(void)
 	}
 }
 
-/**
+/*
  * __timekeeping_set_tai_offset - Sets the TAI offset from UTC and monotonic
  *
  */
@@ -1413,7 +1413,7 @@ static void __timekeeping_set_tai_offset(struct timekeeper *tk, s32 tai_offset)
 	tk->offs_tai = ktime_add(tk->offs_real, ktime_set(tai_offset, 0));
 }
 
-/**
+/*
  * change_clocksource - Swaps clocksources if a new one is available
  *
  * Accumulates current time interval and initializes new clocksource
@@ -2011,7 +2011,7 @@ static void timekeeping_adjust(struct timekeeper *tk, s64 offset)
 	}
 }
 
-/**
+/*
  * accumulate_nsecs_to_secs - Accumulates nsecs into secs
  *
  * Helper function that accumulates the nsecs greater than a second
@@ -2059,7 +2059,7 @@ static inline unsigned int accumulate_nsecs_to_secs(struct timekeeper *tk)
 	return clock_set;
 }
 
-/**
+/*
  * logarithmic_accumulation - shifted accumulation of cycles
  *
  * This functions accumulates a shifted interval of cycles into
@@ -2295,7 +2295,7 @@ ktime_t ktime_get_update_offsets_now(unsigned int *cwsseq, ktime_t *offs_real,
 	return base;
 }
 
-/**
+/*
  * timekeeping_validate_timex - Ensures the timex is ok for use in do_adjtimex
  */
 static int timekeeping_validate_timex(const struct __kernel_timex *txc)
-- 
2.29.GIT

