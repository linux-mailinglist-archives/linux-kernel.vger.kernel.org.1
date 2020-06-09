Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444901F408D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 18:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgFIQVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 12:21:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgFIQVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:21:45 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0678F206A4;
        Tue,  9 Jun 2020 16:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591719705;
        bh=6qYCXRp4rlIwJzKIwSBl5gMRaYjfFI7zDht+KWOIiAc=;
        h=Subject:From:To:Cc:Date:From;
        b=qxaX8StGubWZDvNJ9q0Ys2YqmducF4o8eudlPfJJHUknZwMmLND5YSLkqi98b69EO
         Vwm+NEOjSL7bgAr8m/xPdMxb5hBc402ygV+Sm+sw/rvIb/JodeUnF5zQEx8LkXoIM7
         eWf6Ev8T8RwfLJtuxUm39hA4Ng7SGgjY4Tc2a/Lo=
Message-ID: <7642da1ef2578601d8c2b7bb739b0f8451e69bed.camel@kernel.org>
Subject: [4.19 stable-rt PATCH] tasklet: Fix UP case for tasklet CHAINED
 state
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 09 Jun 2020 11:21:44 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19 stable-rt commit 62d0a2a30cd0 (tasklet: Address a race resulting in
double-enqueue) addresses a problem that can result in a tasklet being
enqueued on two cpus at the same time by combining the RUN flag with a
new CHAINED flag, and relies on the combination to be present in order
to zero it out, which can never happen on !SMP because the RUN flag
is SMP-only.

So make sure the above commit is only applied for the SMP case.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/softirq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 73dae64bfc9c..4f37a6173ab9 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -947,10 +947,12 @@ static void __tasklet_schedule_common(struct tasklet_struct *t,
 	 * is locked before adding it to the list.
 	 */
 	if (test_bit(TASKLET_STATE_SCHED, &t->state)) {
+#if defined(CONFIG_SMP)
 		if (test_and_set_bit(TASKLET_STATE_CHAINED, &t->state)) {
 			tasklet_unlock(t);
 			return;
 		}
+#endif
 		t->next = NULL;
 		*head->tail = t;
 		head->tail = &(t->next);
@@ -1044,7 +1046,11 @@ static void tasklet_action_common(struct softirq_action *a,
 again:
 		t->func(t->data);
 
+#if !defined(CONFIG_SMP)
+		while (!tasklet_tryunlock(t)) {
+#else
 		while (cmpxchg(&t->state, TASKLET_STATEF_RC, 0) != TASKLET_STATEF_RC) {
+#endif
 			/*
 			 * If it got disabled meanwhile, bail out:
 			 */
-- 
2.17.1


