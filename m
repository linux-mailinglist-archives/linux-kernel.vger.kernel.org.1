Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5CA2980AE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 08:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1767835AbgJYHhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 03:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731291AbgJYHhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 03:37:04 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0960EC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 00:36:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id x10so910552plm.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 00:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KdOxf6IUNA4bUToxUWEE2HywHjkytKDn0mIX6eby5So=;
        b=tEGGlNOQBRfIQVacZtuULRiMnIy6rOOU6TLHbZ7T8Gf2n/NNZ7yR84PrdyaaXPrElg
         Qae715Wb/qKjkrR6y6b1+Le06Ee1DnFS3934t8fjgtpk6WDBCZ/Pc1XuGs3nr/8P6CiA
         nZEwAReOVUCcKlC2OMxhPMWmXHynYjdmU0vUGa6AbZ/bTAYuyvJDXLHTjDjWQEeEYzgY
         KlxYEMjp0Xg3wn561jubLO4XJ7yhV/Blz9IeQoJ8bjCUGNkROnsqwn0ehgK/7OtGo6a6
         PNcWiCs0qSfXBr3VgnsuOqB4FbOLKi75rN9vipJD1h5+9aY4o60/R63hcWFht96ya7lM
         Dy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KdOxf6IUNA4bUToxUWEE2HywHjkytKDn0mIX6eby5So=;
        b=YWF8g7GxD+qYtTeuajTr8qhSy7Uij60x/8eOShCxuU4d7nIpk6M58x3bEJRAg87JH7
         QLexG/iYCGrdKQcTQBTiHVgzfrkueFyNBDwiEO9sicUBMtTRFYMG5RXe0hwyI8F0+QmM
         AMllCydsc+Wo6kHoCtVxlz55e65LZ7xj6CRMVrNd1SqpbfNQUQfse0qi50g2kRi28KvC
         XpLGvEtO4SlevyKtfdMnMhAdJHcXikV5OMUtWdQ6ZlysQubtRQvWLo3YTQSFwZfeozPR
         9WKXUo4VVBslTvYNlVZGdxFeEkog6/OQjMWWHkUKDbICMVSRq7M7DIxbkf43jcqFzxh3
         2gag==
X-Gm-Message-State: AOAM530wwqstkbGNIMdphct/kT9eHh3LgrBcI2tTjeZnLacSScS42+GH
        vJYd8yuCZtfD3dTp2rT3SLw=
X-Google-Smtp-Source: ABdhPJxomnynhKDnXUjbXyzwbfEUSs6FTUqdyOw+SoDrgYxwgpGjLNibIifAAbUMpyC4WkS4NdT9VQ==
X-Received: by 2002:a17:90b:19c4:: with SMTP id nm4mr10391288pjb.133.1603611411392;
        Sun, 25 Oct 2020 00:36:51 -0700 (PDT)
Received: from localhost.localdomain (1-171-242-24.dynamic-ip.hinet.net. [1.171.242.24])
        by smtp.gmail.com with ESMTPSA id h5sm4489537pfn.12.2020.10.25.00.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 00:36:50 -0700 (PDT)
From:   Yun Hsiang <hsiang023167@gmail.com>
To:     dietmar.eggemann@arm.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, qais.yousef@arm.com,
        patrick.bellasi@matbug.net, Yun Hsiang <hsiang023167@gmail.com>
Subject: [PATCH v3 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET flag to reset uclamp
Date:   Sun, 25 Oct 2020 15:36:32 +0800
Message-Id: <20201025073632.720393-1-hsiang023167@gmail.com>
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
 include/uapi/linux/sched.h |  7 +++++--
 kernel/sched/core.c        | 41 +++++++++++++++++++++++++++++++-------
 2 files changed, 39 insertions(+), 9 deletions(-)

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
index 8160ab5263f8..b337f8d3b5ae 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1438,9 +1438,22 @@ static int uclamp_validate(struct task_struct *p,
 	return 0;
 }
 
+static unsigned int __default_uclamp_value(struct task_struct *p,
+					int clamp_id)
+{
+	if (rt_task(p) && clamp_id == UCLAMP_MIN)
+		return sysctl_sched_uclamp_util_min_rt_default;
+	else
+		return uclamp_none(clamp_id);
+}
+
 static void __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr)
 {
+	int reset = attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_RESET;
+	bool user_defined;
+	unsigned int clamp_value;
+	unsigned long flags = attr->sched_flags & SCHED_FLAG_UTIL_CLAMP;
 	enum uclamp_id clamp_id;
 
 	/*
@@ -1451,7 +1464,8 @@ static void __setscheduler_uclamp(struct task_struct *p,
 		struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
 
 		/* Keep using defined clamps across class changes */
-		if (uc_se->user_defined)
+		if (flags != SCHED_FLAG_UTIL_CLAMP_RESET &&
+				uc_se->user_defined)
 			continue;
 
 		/*
@@ -1462,20 +1476,33 @@ static void __setscheduler_uclamp(struct task_struct *p,
 			__uclamp_update_util_min_rt_default(p);
 		else
 			uclamp_se_set(uc_se, uclamp_none(clamp_id), false);
-
 	}
 
-	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
+	if (likely(!flags || flags == SCHED_FLAG_UTIL_CLAMP_RESET))
 		return;
 
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
+	if (flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
+		if (reset) {
+			clamp_value = __default_uclamp_value(p, UCLAMP_MIN);
+			user_defined = false;
+		} else {
+			clamp_value = attr->sched_util_min;
+			user_defined = true;
+		}
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
-			      attr->sched_util_min, true);
+				clamp_value, user_defined);
 	}
 
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
+	if (flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
+		if (reset) {
+			clamp_value = __default_uclamp_value(p, UCLAMP_MAX);
+			user_defined = false;
+		} else {
+			clamp_value = attr->sched_util_max;
+			user_defined = true;
+		}
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
-			      attr->sched_util_max, true);
+				clamp_value, user_defined);
 	}
 }
 
-- 
2.25.1

