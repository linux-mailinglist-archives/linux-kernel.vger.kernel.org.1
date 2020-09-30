Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6923827F09D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 19:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731418AbgI3Rfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 13:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgI3Rfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 13:35:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA33C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:35:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e2so2428389ybc.17
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=wshcNGdTha70JwxbPwuqLCOHL5oIDzKhLikbvh+J0yU=;
        b=ceNwvdw1B4sjq2Xcoix1tSEApjHzQoAmd/bFG8/8tEpssPEJxYiO6khx1iUpAgqSiF
         1InWHY7z74mxFjKPdgyyxVta95BLNjovsD5ccTtDFW/iq2s1XLPXh/MM6N9bXvgkiIh3
         Zx0HV8zC+odKlLHRXwPKU2FbDwCcFOSn9OWnhqDaUidTxnrmNBFQyir1ne6862EcOtgk
         UPMEu+ClJw3/ijN5o3ZqkM/p0d/WxKlfi+5C5Jn6qo1MFN7qov0II2e9Xl/TXQXNy2iV
         LYa8zpxCLbJE8BoYyOb76qbrqQvaAzm9rMcmQGDkmVaD7bputDhX78DjXnyR5KG8+zdo
         E5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=wshcNGdTha70JwxbPwuqLCOHL5oIDzKhLikbvh+J0yU=;
        b=fzqoebv+cMZrxcW+mYLslu7FKHTjv4d/lwVIcwtlJsB7gdl/2j8dyAT964gXUcQKNv
         JMIea+Xn9B1JPHoV6NPMVARbcXVmPn3O67jiJgYEyetDng3GWZnXtpO0heH/gt7daVL1
         UldAUattcTBscQcT23VNwqRz02zjzXk5vpq8NwS07cAo/b5FsJucBoP6WsaGrq+Ds3vf
         kiKnrdrruPueeoN8fxnWp8LlVdvMZVJOIob++e4+SZJbWeD8gjYmrnrryaLfub698Qb7
         0Uoi1+Px0R482cg54ImEe/DBdfdcFaHBJJrpWUjTYXFsKjpkPU8xse7STMBd3qE3a/aS
         PBgA==
X-Gm-Message-State: AOAM533ariHOJOkb7Zw/PVB41xpNRSDjZWTPIFUCEREeJtCpLJRbX2xM
        ZvPs3UvtrR6Us9TXg//syj5/Q0B4
X-Google-Smtp-Source: ABdhPJyIJD22w8mY1UwbuU/9ZlK4M0UZNuijd9wi/dhXRJr2VgJee2imBH32Cs3S3q+voSfR7f6Y1YcE
Sender: "posk via sendgmr" <posk@posk.svl.corp.google.com>
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:7220:84ff:fe09:7598])
 (user=posk job=sendgmr) by 2002:a25:abea:: with SMTP id v97mr4724341ybi.158.1601487336991;
 Wed, 30 Sep 2020 10:35:36 -0700 (PDT)
Date:   Wed, 30 Sep 2020 10:35:32 -0700
Message-Id: <20200930173532.1069092-1-posk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH] sched/fair: tweak pick_next_entity
From:   Peter Oskolkov <posk@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Oskolkov <posk@posk.io>, Peter Oskolkov <posk@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, pick_next_entity(...) has the following structure
(simplified):

[...]
if (last_buddy_ok())
  result = last_buddy;
if (next_buddy_ok())
  result = next_buddy;
[...]

The intended behavior is to prefer next buddy over last buddy;
the current code somewhat obfuscates this, and also wastes
cycles checking the last buddy when eventually the next buddy is
picked up.

So this patch refactors two 'ifs' above into

[...]
if (next_buddy_ok())
    result = next_buddy;
else if (last_buddy_ok())
    result = last_buddy;
[...]

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 kernel/sched/fair.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fc3410b8b990..cec6cf9b2bb3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4465,17 +4465,17 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 			se = second;
 	}
 
-	/*
-	 * Prefer last buddy, try to return the CPU to a preempted task.
-	 */
-	if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1)
-		se = cfs_rq->last;
-
-	/*
-	 * Someone really wants this to run. If it's not unfair, run it.
-	 */
-	if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1)
+	if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1) {
+		/*
+		 * Someone really wants this to run. If it's not unfair, run it.
+		 */
 		se = cfs_rq->next;
+	} else if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1) {
+		/*
+		 * Prefer last buddy, try to return the CPU to a preempted task.
+		 */
+		se = cfs_rq->last;
+	}
 
 	clear_buddies(cfs_rq, se);
 
-- 
2.28.0.709.gb0816b6eb0-goog

