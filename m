Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB7F2A251D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgKBHVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:21:25 -0500
Received: from zerg.cs.ucr.edu ([169.235.26.103]:53406 "EHLO zerg.cs.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727848AbgKBHVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:21:25 -0500
X-Greylist: delayed 567 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Nov 2020 02:21:25 EST
Received: by zerg.cs.ucr.edu (Postfix, from userid 69049)
        id 9ADE41C20851; Sun,  1 Nov 2020 23:11:57 -0800 (PST)
From:   Yu Hao <yuhaobehappy@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     yuhaobehappy@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sound/core/seq: remove dead code
Date:   Sun,  1 Nov 2020 23:11:54 -0800
Message-Id: <20201102071154.23563-1-yuhaobehappy@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function snd_seq_queue_client_termination() is only called from
function seq_free_client1(). The seq_free_client1() calls function
snd_seq_queue_client_leave(), which deletes all objects whose owner
equals to client->number in global array queue_list, before the function
snd_seq_queue_client_termination(), which checks whether there are
any objects in global array queue_list whose owner equals to
client->number, with the same argument client->number. So
the checking code in function snd_seq_queue_client_termination() is
dead code. Remove those dead code.

Signed-off-by: Yu Hao <yuhaobehappy@gmail.com>
---
 sound/core/seq/seq_queue.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/sound/core/seq/seq_queue.c b/sound/core/seq/seq_queue.c
index 71a6ea62c3be..91b3f3295d0b 100644
--- a/sound/core/seq/seq_queue.c
+++ b/sound/core/seq/seq_queue.c
@@ -545,21 +545,10 @@ void snd_seq_queue_client_termination(int client)
 	unsigned long flags;
 	int i;
 	struct snd_seq_queue *q;
-	bool matched;
 
 	for (i = 0; i < SNDRV_SEQ_MAX_QUEUES; i++) {
 		if ((q = queueptr(i)) == NULL)
 			continue;
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
 		queuefree(q);
 	}
 }
-- 
2.17.1

