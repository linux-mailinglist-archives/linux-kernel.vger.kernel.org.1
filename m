Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C899E2A1CB3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 09:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgKAIpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 03:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgKAIpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 03:45:10 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFE6C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 01:45:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 13so8526161pfy.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 01:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nirr4mh91h/amV4LlL0NvUiEvNY3mHAiZkJd/cuRecI=;
        b=niplKfx2p3AHqN6uKVlxYHN5BKLN1GvMW+gFWWuN4/s9Viy13B8N3IjivHbWZW2ge5
         5TswGpu7Iv0b2MHdOLuZzhPeFsAFEdYaJ4p/3St2f4zfdJg4Za73ja7eypke2IjAFKBX
         M6xDbJ1K7T4KoZ5BEl3T1E8HoyiuI76+5P/PnHdVZj8zxsKiyRk1aUqRoE46UQXwFGRU
         QDdkzIo3W9lKSMIQvRwfgC/hPtK4gN6R4rNUhLmnC1j26Ss30zR1i0PSDaahfaDSAqz4
         ikmhtCsAAOxrtcbPUG3Y+m5yKOExuJ78COagY1kZEJgZ6ZK7ZAcTKa/8VqC3jL+plauz
         lwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nirr4mh91h/amV4LlL0NvUiEvNY3mHAiZkJd/cuRecI=;
        b=anq2mcNW5KA7xvuHDXJtUCj6KYJHT2MuEOMyocSxf5OBDco+MI2XiaY4rUE0Er8Wku
         CnQ7bTAWpRlPcsyiKl9uEIj1RBdl/+y81vuXnjwsvyJT3jVy6hlCN1p8aiXtl2zrtCHb
         IuOKrRU7fDi2zPsNFnMCZSJTUQP4/9Lha0bnfZVZgBmmOtP888B8prKPd3Hdj5Vi8/2V
         M06Z1gRJ18JbeIAAxryfgwqqXlhutwvp5eyYnGR98LUjtfrWYiJWCqYDaBXV/3Iu43iS
         MQQam0BhNGJhEcitb/qrEq/CX3UWc0OuLcn9FKVrq1KIJTcD6k/e5uxJMP0e+gFkweie
         9W4w==
X-Gm-Message-State: AOAM53164k2CRT5+Qi8GiaEONSao5yVRN2lz4KWfjRQzZkLhbuvsy4+D
        uQycpV2xH3p/XDAwE5agBmjA7GgNsqB8/gVq
X-Google-Smtp-Source: ABdhPJw12ZQr6o8Ld5zEDPVhwCdDTNJEqxkMGI1xzYGJMF9112uG297lUt2OoDdCo+R72Yq3xbPPbQ==
X-Received: by 2002:a62:6507:0:b029:155:3b11:b458 with SMTP id z7-20020a6265070000b02901553b11b458mr17224070pfb.45.1604220308964;
        Sun, 01 Nov 2020 01:45:08 -0700 (PDT)
Received: from localhost.localdomain (1-171-249-170.dynamic-ip.hinet.net. [1.171.249.170])
        by smtp.gmail.com with ESMTPSA id v196sm3276765pfc.34.2020.11.01.01.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 01:45:08 -0700 (PDT)
From:   Yun Hsiang <hsiang023167@gmail.com>
To:     dietmar.eggemann@arm.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, qais.yousef@arm.com,
        patrick.bellasi@matbug.net, Yun Hsiang <hsiang023167@gmail.com>
Subject: [PATCH v4 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET flag to reset uclamp
Date:   Sun,  1 Nov 2020 16:44:50 +0800
Message-Id: <20201101084450.985937-1-hsiang023167@gmail.com>
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

The policy is
_CLAMP_RESET                           => reset both min and max
_CLAMP_RESET | _CLAMP_MIN              => reset min value
_CLAMP_RESET | _CLAMP_MAX              => reset max value
_CLAMP_RESET | _CLAMP_MIN | _CLAMP_MAX => reset both min and max

Signed-off-by: Yun Hsiang <hsiang023167@gmail.com>
---
 include/uapi/linux/sched.h |  7 +++--
 kernel/sched/core.c        | 59 ++++++++++++++++++++++++++++----------
 2 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8ceab2..6c823ddb1a1e 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -132,17 +132,20 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_UTIL_CLAMP_RESET	0x80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
 
 #define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
-				 SCHED_FLAG_UTIL_CLAMP_MAX)
+				 SCHED_FLAG_UTIL_CLAMP_MAX | \
+				 SCHED_FLAG_UTIL_CLAMP_RESET)
 
 #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
 			 SCHED_FLAG_RECLAIM		| \
 			 SCHED_FLAG_DL_OVERRUN		| \
 			 SCHED_FLAG_KEEP_ALL		| \
-			 SCHED_FLAG_UTIL_CLAMP)
+			 SCHED_FLAG_UTIL_CLAMP		| \
+			 SCHED_FLAG_UTIL_CLAMP_RESET)
 
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8160ab5263f8..2b644f4bf2eb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1004,7 +1004,7 @@ unsigned int uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
 	return uclamp_idle_value(rq, clamp_id, clamp_value);
 }
 
-static void __uclamp_update_util_min_rt_default(struct task_struct *p)
+static inline void __uclamp_update_util_min_rt_default(struct task_struct *p)
 {
 	unsigned int default_util_min;
 	struct uclamp_se *uc_se;
@@ -1413,8 +1413,14 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 static int uclamp_validate(struct task_struct *p,
 			   const struct sched_attr *attr)
 {
-	unsigned int lower_bound = p->uclamp_req[UCLAMP_MIN].value;
-	unsigned int upper_bound = p->uclamp_req[UCLAMP_MAX].value;
+	unsigned int lower_bound, upper_bound;
+
+	/* Do not check uclamp attributes values in reset case. */
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_RESET)
+		return 0;
+
+	lower_bound = p->uclamp_req[UCLAMP_MIN].value;
+	upper_bound = p->uclamp_req[UCLAMP_MAX].value;
 
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
 		lower_bound = attr->sched_util_min;
@@ -1438,20 +1444,43 @@ static int uclamp_validate(struct task_struct *p,
 	return 0;
 }
 
+static int uclamp_reset(enum uclamp_id clamp_id, unsigned long flags)
+{
+	/* No _UCLAMP_RESET flag set: do not reset */
+	if (!(flags & SCHED_FLAG_UTIL_CLAMP_RESET))
+		return false;
+
+	/* Only _UCLAMP_RESET flag set: reset both clamps */
+	if (!(flags & (SCHED_FLAG_UTIL_CLAMP_MIN | SCHED_FLAG_UTIL_CLAMP_MAX)))
+		return true;
+
+	/* Both _UCLAMP_RESET and _UCLAMP_MIN flags are set: reset only min */
+	if ((flags & SCHED_FLAG_UTIL_CLAMP_MIN) && clamp_id == UCLAMP_MIN)
+		return true;
+
+	/* Both _UCLAMP_RESET and _UCLAMP_MAX flags are set: reset only max */
+	if ((flags & SCHED_FLAG_UTIL_CLAMP_MAX) && clamp_id == UCLAMP_MAX)
+		return true;
+
+	return false;
+}
+
 static void __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr)
 {
+	unsigned int clamp_value;
 	enum uclamp_id clamp_id;
 
 	/*
-	 * On scheduling class change, reset to default clamps for tasks
-	 * without a task-specific value.
+	 * Reset to default clamps on forced _UCLAMP_RESET (always) and
+	 * for tasks without a task-specific value (on scheduling class change).
 	 */
 	for_each_clamp_id(clamp_id) {
 		struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
 
 		/* Keep using defined clamps across class changes */
-		if (uc_se->user_defined)
+		if (!uclamp_reset(clamp_id, attr->sched_flags) &&
+				uc_se->user_defined)
 			continue;
 
 		/*
@@ -1459,24 +1488,24 @@ static void __setscheduler_uclamp(struct task_struct *p,
 		 * at runtime.
 		 */
 		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
-			__uclamp_update_util_min_rt_default(p);
+			clamp_value = sysctl_sched_uclamp_util_min_rt_default;
 		else
-			uclamp_se_set(uc_se, uclamp_none(clamp_id), false);
+			clamp_value = uclamp_none(clamp_id);
 
+		uclamp_se_set(uc_se, uclamp_none(clamp_id), false);
 	}
 
-	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
+	if (likely(!(attr->sched_flags && SCHED_FLAG_UTIL_CLAMP)) ||
+		attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_RESET)
 		return;
 
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
-			      attr->sched_util_min, true);
-	}
+				attr->sched_util_min, true);
 
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
-			      attr->sched_util_max, true);
-	}
+				attr->sched_util_max, true);
 }
 
 static void uclamp_fork(struct task_struct *p)
-- 
2.25.1

