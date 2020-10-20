Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287D82932D5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390346AbgJTBo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390238AbgJTBot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:44:49 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D922AC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:48 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id w17so298463ilg.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jEEPcR9HeiT8Ochzutp5X/YG2vopWuTHOXMJMMPo+eA=;
        b=dt0Gus6XYxsnpn8cVWyKMe21VbcQZFqnB/7qij4nWX3xRxzKDZR/QiZvgva/HViqGr
         pwmOu32QAYp/FVWQaYBse5x+GkBMRr4O/5W59W5HvwT5EfZS/Tye/qexOIA+3blfp5+2
         IBwTcOHN3w3WbhjFgW8DNvtvztuqFIXKRB554=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jEEPcR9HeiT8Ochzutp5X/YG2vopWuTHOXMJMMPo+eA=;
        b=l9v3lF1fsVQVXQmkRwgQuFFC8h7orZemurAvD5n7hm4Gtf7/5ligKupTq/52WLT//S
         tX32aCONnjC+9xhLZumATGl+qm1tBEX18VNtJYckturXysk09EzoKpqHv262jNzp0MNm
         b9SRoQac9WFREh/G4sRyYRrizSpZzPbaXCUaJlB93FZYNP/PgDk5OKSAPKnpO4zNE3+I
         F2YM3+QyYIv7MTzhV1VAFlx6h2wKCk5zMFS466XnN5EHqypnhWG+8bltbcHzBw4P6k5q
         BYg8d2FGVViDsvi+DPyjPpAUAvAlNl+Vd1CCvQBXA+bEBNtunnvCGko/Y2n5ciAxFqHb
         rpvA==
X-Gm-Message-State: AOAM530arFHY3VfFXFmRmujytqTGZvJ1LoNESXpe+wmv3+b+779HlgWM
        prW2Y3COoWytPO9AKn7c9HIxeg==
X-Google-Smtp-Source: ABdhPJznYp7dScRin2eLE67+qOgNmj//Sc9fHJYDfv8GLTeAVO/FkGagvbZxw3HHvdzlDzSXeaB/HA==
X-Received: by 2002:a92:3650:: with SMTP id d16mr240061ilf.29.1603158288281;
        Mon, 19 Oct 2020 18:44:48 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t22sm485306ili.9.2020.10.19.18.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 18:44:47 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH v8 -tip 21/26] sched: Handle task addition to CGroup
Date:   Mon, 19 Oct 2020 21:43:31 -0400
Message-Id: <20201020014336.2076526-22-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020014336.2076526-1-joel@joelfernandes.org>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to earlier patches, the old way of computing a task's cookie when it
is added to a CGroup,is outdated. Update it by fetching the group's
cookie using the new helpers.

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 61e1dcf11000..1321c26a8385 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8505,6 +8505,9 @@ void sched_offline_group(struct task_group *tg)
 	spin_unlock_irqrestore(&task_group_lock, flags);
 }
 
+#define SCHED_CORE_GROUP_COOKIE_MASK ((1UL << (sizeof(unsigned long) * 4)) - 1)
+static unsigned long cpu_core_get_group_cookie(struct task_group *tg);
+
 static void sched_change_group(struct task_struct *tsk, int type)
 {
 	struct task_group *tg;
@@ -8519,11 +8522,13 @@ static void sched_change_group(struct task_struct *tsk, int type)
 	tg = autogroup_task_group(tsk, tg);
 
 #ifdef CONFIG_SCHED_CORE
-	if ((unsigned long)tsk->sched_task_group == tsk->core_cookie)
-		tsk->core_cookie = 0UL;
+	if (tsk->core_group_cookie) {
+		tsk->core_group_cookie = 0UL;
+		tsk->core_cookie &= ~SCHED_CORE_GROUP_COOKIE_MASK;
+	}
 
-	if (tg->core_tagged /* && !tsk->core_cookie ? */)
-		tsk->core_cookie = (unsigned long)tg;
+	tsk->core_group_cookie = cpu_core_get_group_cookie(tg);
+	tsk->core_cookie |= tsk->core_group_cookie;
 #endif
 
 	tsk->sched_task_group = tg;
@@ -9471,7 +9476,7 @@ static unsigned long cpu_core_get_group_cookie(struct task_group *tg)
 
 		if (tg->core_tagged) {
 			unsigned long cookie = ((unsigned long)tg << 8) | color;
-			cookie &= (1UL << (sizeof(unsigned long) * 4)) - 1;
+			cookie &= SCHED_CORE_GROUP_COOKIE_MASK;
 			return cookie;
 		}
 	}
-- 
2.29.0.rc1.297.gfa9743e501-goog

