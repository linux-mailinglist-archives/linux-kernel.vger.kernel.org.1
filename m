Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACD128BE0C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 18:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403857AbgJLQcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 12:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390257AbgJLQcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:32:10 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C407C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 09:32:10 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o3so4800280pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WTP6OE2M7Lnv/C5viDMO4jefnI2cxFoZOeomv6BzexE=;
        b=P3Q0Bukj+XxHlkcSXZMj6DymOk8d1l+AefOqONG5KYKIDLeE5g749kcuRQiNXlsKfz
         d+SFaFvYwxFxRY3PC6C46lZGViW3Kwkkmifj5p3GO0ZqXcAn90dMLfpVL2DUmNC3NvDg
         LRfZUTozwqyG/8/nL6WiYCJ/QIrUvobYLWX+VlUqEuaWf6oP8Rcb7bcK3lYMu3/cDrIu
         s9n3aM9UlNmL0UKEKhMLBQmsS79Vth2ktyQvmDthiE2z3o892a+Qyya1S6SMh9Eozk3f
         L6tpnwdfyDYKArsq56MO3RpYwQLpHT1vzauS3CX0EMVUp9NfwcuDW7mFoVbdb64xzjyc
         euHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WTP6OE2M7Lnv/C5viDMO4jefnI2cxFoZOeomv6BzexE=;
        b=uaQq+R9oZ5e2//wfwJ2EW6sp5GU5vGkVF63zWJGwOoRRnRmmMtd3ofIXkfneE1OaHi
         z8xsSntdnMG3OV5o3rR1klGp7HyqEi+vtCS7j9HoLn3q6FjhFsPxPzSZX3HlIEmiQdA/
         U+NJXGzcZWtZ61cofFgB/y13MYKp8OzFY1ozyb7iolsntA8m4XBuhVQbQ6seIgxwluXv
         wxZze2NJxj7tk1aLWn/EnVOkN17DoVgUo5uRcFEN0xqksafMcxijOnhzpHen75pNz38Q
         2RMDUvotRoegY8JRhB0YEModnuzymSs3YZ3QoGfwCQHsCH6KNMrpDFPOTmas4T135FKT
         Jt1A==
X-Gm-Message-State: AOAM532f/jCTZfgo0d9U79Ziax2mtVqpFuw7+BOIP3G0qpDu6hxHu2Rc
        nfVdyt0obqH4549i/8HWuqdYFLa/cAuuAlHc
X-Google-Smtp-Source: ABdhPJzlrXQWzwsdEUm71Sgd2N52P6HjdfBAMRt3ReO5YlfHlLsPPgZPp2RJfGs/6xUNUXyqz6dEIw==
X-Received: by 2002:a17:90a:c403:: with SMTP id i3mr4507278pjt.47.1602520329717;
        Mon, 12 Oct 2020 09:32:09 -0700 (PDT)
Received: from localhost.localdomain (61-231-11-37.dynamic-ip.hinet.net. [61.231.11.37])
        by smtp.gmail.com with ESMTPSA id t6sm11509588pgn.26.2020.10.12.09.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 09:32:09 -0700 (PDT)
From:   Yun Hsiang <hsiang023167@gmail.com>
To:     dietmar.eggemann@arm.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, qais.yousef@arm.com,
        patrick.bellasi@matbug.net, Yun Hsiang <hsiang023167@gmail.com>
Subject: [PATCH v2 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET flag to reset uclamp
Date:   Tue, 13 Oct 2020 00:31:40 +0800
Message-Id: <20201012163140.371688-1-hsiang023167@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the user wants to stop controlling uclamp and let the task inherit
the value from the group, we need a method to reset.

Add SCHED_FLAG_UTIL_CLAMP_RESET flag to allow the user to reset uclamp via
sched_setattr syscall.

Signed-off-by: Yun Hsiang <hsiang023167@gmail.com>
---
 include/uapi/linux/sched.h |  9 ++++++++-
 kernel/sched/core.c        | 16 ++++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8ceab2..a12e88c362d8 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -132,6 +132,9 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_UTIL_CLAMP_RESET_MIN	0x80
+#define SCHED_FLAG_UTIL_CLAMP_RESET_MAX	0x100
+
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
@@ -139,10 +142,14 @@ struct clone_args {
 #define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
 				 SCHED_FLAG_UTIL_CLAMP_MAX)
 
+#define SCHED_FLAG_UTIL_CLAMP_RESET (SCHED_FLAG_UTIL_CLAMP_RESET_MIN | \
+					SCHED_FLAG_UTIL_CLAMP_RESET_MAX)
+
 #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
 			 SCHED_FLAG_RECLAIM		| \
 			 SCHED_FLAG_DL_OVERRUN		| \
 			 SCHED_FLAG_KEEP_ALL		| \
-			 SCHED_FLAG_UTIL_CLAMP)
+			 SCHED_FLAG_UTIL_CLAMP		| \
+			 SCHED_FLAG_UTIL_CLAMP_RESET)
 
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9a2fbf98fd6f..ed4cb412dde7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1207,15 +1207,22 @@ static void __setscheduler_uclamp(struct task_struct *p,
 		uclamp_se_set(uc_se, clamp_value, false);
 	}
 
-	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
+	if (likely(!(attr->sched_flags &
+			(SCHED_FLAG_UTIL_CLAMP | SCHED_FLAG_UTIL_CLAMP_RESET))))
 		return;
 
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_RESET_MIN) {
+		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
+			      0, false);
+	} else if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
 			      attr->sched_util_min, true);
 	}
 
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_RESET_MAX) {
+		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
+			      1024, false);
+	} else if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
 			      attr->sched_util_max, true);
 	}
@@ -4901,7 +4908,8 @@ static int __sched_setscheduler(struct task_struct *p,
 			goto change;
 		if (dl_policy(policy) && dl_param_changed(p, attr))
 			goto change;
-		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
+		if (attr->sched_flags &
+				(SCHED_FLAG_UTIL_CLAMP | SCHED_FLAG_UTIL_CLAMP_RESET))
 			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
-- 
2.25.1

