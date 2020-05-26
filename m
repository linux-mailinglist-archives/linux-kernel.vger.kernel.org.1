Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5D91C68DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 08:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgEFG0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 02:26:01 -0400
Received: from relay.sw.ru ([185.231.240.75]:41124 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgEFG0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:26:01 -0400
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1jWDVC-0007jF-Lw; Wed, 06 May 2020 09:25:54 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] ipc/util.c: sysvipc_find_ipc() incorrectly updates position
 index
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Andreas Schwab <schwab@suse.de>
References: <ad24ee52-21a8-3ff0-e968-63d315472b91@virtuozzo.com>
Message-ID: <4921fe9b-9385-a2b4-1dc4-1099be6d2e39@virtuozzo.com>
Date:   Wed, 6 May 2020 09:25:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ad24ee52-21a8-3ff0-e968-63d315472b91@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

new_pos should jump through hole of unused ids,
pos can be updated inside "for" cycle.

Cc: stable@vger.kernel.org
Fixes: 89163f93c6f9 ("ipc/util.c: sysvipc_find_ipc() should increase position index")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 ipc/util.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/ipc/util.c b/ipc/util.c
index 7acccfd..cfa0045 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -764,21 +764,21 @@ static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
 			total++;
 	}
 
-	*new_pos = pos + 1;
+	ipc = NULL;
 	if (total >= ids->in_use)
-		return NULL;
+		goto out;
 
 	for (; pos < ipc_mni; pos++) {
 		ipc = idr_find(&ids->ipcs_idr, pos);
 		if (ipc != NULL) {
 			rcu_read_lock();
 			ipc_lock_object(ipc);
-			return ipc;
+			break;
 		}
 	}
-
-	/* Out of range - return NULL to terminate iteration */
-	return NULL;
+out:
+	*new_pos = pos + 1;
+	return ipc;
 }
 
 static void *sysvipc_proc_next(struct seq_file *s, void *it, loff_t *pos)
-- 
1.8.3.1

