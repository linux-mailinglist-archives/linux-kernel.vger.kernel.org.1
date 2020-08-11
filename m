Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C3E241866
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 10:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgHKInh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 04:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbgHKIng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 04:43:36 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E9EC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 01:43:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d22so7237868pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 01:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VndS2BLOqf37XqayvnJH1gMMn9IVLACCwhIHVo8hz/k=;
        b=kJhdXgs2ahrPiT2GfDFNkSTVv9q/haH1vdQEmPSjvPlQwSldeaSMX5dVS90GyMQGEo
         0Xazqt/7Efs8ZAQoJW1wM+PGcYXdVThF+64+qVlinCwNx6dC3ubI9aRzcVQOGeX+EaaZ
         Jflc5NbAvLjAdFXZQ64XVCiKQQTgXtI2fVZT9oANVxTqV7hHQ2HWjrMfsmK86wKIYqxv
         Hd7/4J6rcAodvsqaRvrB3v/4l3CzMnL1L2qMfdlrtsXnrQidq0CkeVkDkv9AnZtffZDZ
         Y/v+yLLSSRUkF0GMX4Rd1OKm97SI/bkwX9i/n6MUD3QOXZc5q+BEjFm0N2XYBYedMPID
         oZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VndS2BLOqf37XqayvnJH1gMMn9IVLACCwhIHVo8hz/k=;
        b=LPK5eHbJJ6x5Ty7VsiMy8B6tUeS6MmOvwWfgz7kgBVJUCu79qGwH05ppo9kCGvsr+X
         l3obG53A2fBHmc9P4uw0tzOt3oVkOyJEbV+hxPpO1fW4sp5wuPut0yXKKNXOp4rS9T3f
         czCl/MuCggzeaHRno6vCh6wRUB9Piq9ufGYx5vVdtE9fIeyniQTkpSjd+oqnCcnU6Iiq
         ljcc52z7JIkb4ci9qWN/HUD5yw5eYFWO4+jOifLik/xpD2SKmpvPQ/HY8iPfFeAXEHOh
         9c5iOGsDAzhnn+V6JWq4Iah8xVDZxM60E4XBZvl4Sk47UE6aSBagHz0NBhngsE0ay3SI
         27UA==
X-Gm-Message-State: AOAM533q9yEgeYlgdfStVsQfky7xdvLtJx4LI0NDTDFCovGl4OkigHos
        I9ypqvlDINRdGvl6cb/UNsM=
X-Google-Smtp-Source: ABdhPJzoukbQeHJy5KJ6MWDtb+4kNliXlHe6ABkk913kyk9XzS7YQBn70RIT8qN2LaYzzfyA+TX9Ug==
X-Received: by 2002:aa7:8eca:: with SMTP id b10mr5063142pfr.50.1597135415907;
        Tue, 11 Aug 2020 01:43:35 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.7])
        by smtp.gmail.com with ESMTPSA id z25sm24742295pfn.159.2020.08.11.01.43.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2020 01:43:35 -0700 (PDT)
From:   Jiang Biao <benbjiang@gmail.com>
X-Google-Original-From: Jiang Biao <benbjiang@tencent.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        Jiang Biao <benbjiang@tencent.com>
Subject: [PATCH] sched/fair: Optimize dequeue_task_fair()
Date:   Tue, 11 Aug 2020 16:43:10 +0800
Message-Id: <20200811084310.27130-1-benbjiang@tencent.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar optimization as what has been done in commit,
7d148be69e3a(sched/fair: Optimize enqueue_task_fair())

dequeue_task_fair jumps to dequeue_throttle label when cfs_rq_of(se) is
throttled which means that se can't be NULL. We can move the label after
the if (!se) statement and remove the if(!se) statment as se is always
NULL when reaching this point.

Besides, trying to keep the same pattern with enqueue_task_fair can make
it more readable.

Signed-off-by: Jiang Biao <benbjiang@tencent.com>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04fa8dbcfa4d..cbbeafdfa8b7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5618,10 +5618,10 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	}
 
-dequeue_throttle:
-	if (!se)
-		sub_nr_running(rq, 1);
+	/* At this point se is NULL and we are at root level*/
+	sub_nr_running(rq, 1);
 
+dequeue_throttle:
 	/* balance early to pull high priority tasks */
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;
-- 
2.21.0

