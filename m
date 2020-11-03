Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641482A3A80
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 03:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgKCCiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 21:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgKCCiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 21:38:10 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFFAC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 18:38:10 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id w11so7840521pll.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 18:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cvjs71nFKGG3Tj091a5dvvD/TsUYO+RFhbzZ+1ksR4o=;
        b=AA807p2OrwyeFYr8prWFFrEChaTuKu/J0geg/tl5T+9y7H1LmT8z0LCLPQXx5FagY/
         eVJSalQ+yglVrpQOHrZXrrFhLt1U58EjIRfPv/R0Bxd2R4/zyiaRM5negikCxfRR4aTh
         h3JiPYavpXLabqNFelrJPtHGCcsfe3OgtoB+7MoL7BI58C/WAYZ6Kf82hxlKGOu0h46y
         nB5cvBnXSTrQ8MotEAZDstKmzeTZX3n6WN0aU7sHYXIvotW+/+gqv6lR9yQz/Ldff9yz
         XHBB2rvsBvFHEJ6+56VHREMNMDFc4SnGiLuatwEeiUl6xZYYRmY3sAg3z4nw5oc4JSOp
         zrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cvjs71nFKGG3Tj091a5dvvD/TsUYO+RFhbzZ+1ksR4o=;
        b=Ff7wu7BrRZrHzYV52TwGJL9yHc1Fe/cZu29bXfytZCLp8MlGF2UKTE9SSVdD1lh/qn
         ZKLkPpSWf8E2V7ke90k7cAqo2fRkES8czlsjWLn71cdvz9olyHNb+SZ9IArk4PPkIgTS
         o0TvG0jSMIiz6kAqMYplwAIgNKtkZXKNHmi6J9PGOkNYF4tdIcY3vbpzkUbhtqllxsfT
         WZUsJdq4DkCScfNwb6V2dAUgO9OWoAHPT3D63f67IkA/wI2IGNGBR1DAvoMp4Pa60kPv
         hYBrOkKTzf+CdIMgkDXHty9cAOs3ljX/oVY+v2Whtyhz4bZkM8R/Bv6YU9ZLdhTRYm8Y
         MK1A==
X-Gm-Message-State: AOAM531haGNh4gsCdxq7iiZpNAIoyyTkVyEvnlQCeew0jQTSJgk/x5iK
        LNJeI/3WsNOB4MvUy3S4tZ8=
X-Google-Smtp-Source: ABdhPJy6c3iE9Ftx5JGuJlpwVTZOhVq7RJK7bg6YicCvUYYpn/56+5DU+kRORDNwfDxwBJ39EJkO+Q==
X-Received: by 2002:a17:902:a584:b029:d6:4a70:3241 with SMTP id az4-20020a170902a584b02900d64a703241mr24335735plb.81.1604371089016;
        Mon, 02 Nov 2020 18:38:09 -0800 (PST)
Received: from localhost.localdomain (42-73-194-116.emome-ip.hinet.net. [42.73.194.116])
        by smtp.gmail.com with ESMTPSA id x22sm15476769pfp.181.2020.11.02.18.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 18:38:07 -0800 (PST)
From:   Yun Hsiang <hsiang023167@gmail.com>
To:     dietmar.eggemann@arm.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, qais.yousef@arm.com,
        patrick.bellasi@matbug.net, Yun Hsiang <hsiang023167@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v5 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET flag to reset uclamp
Date:   Tue,  3 Nov 2020 10:37:56 +0800
Message-Id: <20201103023756.1012088-1-hsiang023167@gmail.com>
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
Reported-by: kernel test robot <lkp@intel.com>
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
index 8160ab5263f8..6ae463b64834 100644
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
 	enum uclamp_id clamp_id;
 
 	/*
-	 * On scheduling class change, reset to default clamps for tasks
-	 * without a task-specific value.
+	 * Reset to default clamps on forced _UCLAMP_RESET (always) and
+	 * for tasks without a task-specific value (on scheduling class change).
 	 */
 	for_each_clamp_id(clamp_id) {
+		unsigned int clamp_value;
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
 
+		uclamp_se_set(uc_se, clamp_value, false);
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

