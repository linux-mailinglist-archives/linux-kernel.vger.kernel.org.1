Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B3F1EC30C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 21:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgFBTuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 15:50:17 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:26900 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBTuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:50:17 -0400
Received: from localhost.localdomain ([93.22.133.243])
        by mwinf5d52 with ME
        id mKq6220065FEkrh03Kq6L0; Tue, 02 Jun 2020 21:50:13 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 02 Jun 2020 21:50:13 +0200
X-ME-IP: 93.22.133.243
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] sched/deadline: Fix a typo in a comment
Date:   Tue,  2 Jun 2020 21:50:02 +0200
Message-Id: <20200602195002.677448-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/deadine/deadline/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 504d2f51b0d6..cc2066e25dcf 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1098,7 +1098,7 @@ void init_dl_task_timer(struct sched_dl_entity *dl_se)
  * cannot use the runtime, and so it replenishes the task. This rule
  * works fine for implicit deadline tasks (deadline == period), and the
  * CBS was designed for implicit deadline tasks. However, a task with
- * constrained deadline (deadine < period) might be awakened after the
+ * constrained deadline (deadline < period) might be awakened after the
  * deadline, but before the next period. In this case, replenishing the
  * task would allow it to run for runtime / deadline. As in this case
  * deadline < period, CBS enables a task to run for more than the
-- 
2.25.1

