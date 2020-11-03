Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538942A5A25
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 23:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbgKCWdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 17:33:39 -0500
Received: from zerg.cs.ucr.edu ([169.235.26.103]:34686 "EHLO zerg.cs.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729715AbgKCWdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 17:33:38 -0500
Received: by zerg.cs.ucr.edu (Postfix, from userid 69049)
        id A8C121C20852; Tue,  3 Nov 2020 14:33:37 -0800 (PST)
From:   Yu Hao <yuhaobehappy@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     yuhaobehappy@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sound/core/seq: remove useless function
Date:   Tue,  3 Nov 2020 14:33:35 -0800
Message-Id: <20201103223335.21831-1-yuhaobehappy@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function snd_seq_queue_client_termination() is only called from
the function seq_free_client1(). The function seq_free_client1() calls
the function snd_seq_queue_client_leave() and the function
snd_seq_queue_client_termination() together. Because the function
snd_seq_queue_client_leave() does all things, so the function
snd_seq_queue_client_termination() is a useless function.

Signed-off-by: Yu Hao <yuhaobehappy@gmail.com>
---
 sound/core/seq/seq_clientmgr.c |  1 -
 sound/core/seq/seq_queue.c     | 27 ---------------------------
 sound/core/seq/seq_queue.h     |  3 ---
 3 files changed, 31 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index cc93157fa950..f9f2fea58b32 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -279,7 +279,6 @@ static int seq_free_client1(struct snd_seq_client *client)
 	snd_seq_delete_all_ports(client);
 	snd_seq_queue_client_leave(client->number);
 	snd_use_lock_sync(&client->use_lock);
-	snd_seq_queue_client_termination(client->number);
 	if (client->pool)
 		snd_seq_pool_delete(&client->pool);
 	spin_lock_irq(&clients_lock);
diff --git a/sound/core/seq/seq_queue.c b/sound/core/seq/seq_queue.c
index 71a6ea62c3be..13cfc2d47fa7 100644
--- a/sound/core/seq/seq_queue.c
+++ b/sound/core/seq/seq_queue.c
@@ -537,33 +537,6 @@ int snd_seq_queue_is_used(int queueid, int client)
 
 /*----------------------------------------------------------------*/
 
-/* notification that client has left the system -
- * stop the timer on all queues owned by this client
- */
-void snd_seq_queue_client_termination(int client)
-{
-	unsigned long flags;
-	int i;
-	struct snd_seq_queue *q;
-	bool matched;
-
-	for (i = 0; i < SNDRV_SEQ_MAX_QUEUES; i++) {
-		if ((q = queueptr(i)) == NULL)
-			continue;
-		spin_lock_irqsave(&q->owner_lock, flags);
-		matched = (q->owner == client);
-		if (matched)
-			q->klocked = 1;
-		spin_unlock_irqrestore(&q->owner_lock, flags);
-		if (matched) {
-			if (q->timer->running)
-				snd_seq_timer_stop(q->timer);
-			snd_seq_timer_reset(q->timer);
-		}
-		queuefree(q);
-	}
-}
-
 /* final stage notification -
  * remove cells for no longer exist client (for non-owned queue)
  * or delete this queue (for owned queue)
diff --git a/sound/core/seq/seq_queue.h b/sound/core/seq/seq_queue.h
index 9254c8dbe5e3..1c3a8d3254d9 100644
--- a/sound/core/seq/seq_queue.h
+++ b/sound/core/seq/seq_queue.h
@@ -59,9 +59,6 @@ struct snd_seq_queue *snd_seq_queue_alloc(int client, int locked, unsigned int f
 /* delete queue (destructor) */
 int snd_seq_queue_delete(int client, int queueid);
 
-/* notification that client has left the system */
-void snd_seq_queue_client_termination(int client);
-
 /* final stage */
 void snd_seq_queue_client_leave(int client);
 
-- 
2.17.1

