Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DAB292BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 18:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbgJSQnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 12:43:23 -0400
Received: from m12-11.163.com ([220.181.12.11]:34633 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729879AbgJSQnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 12:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=YC7Ho
        mMsF1MVd69eG5Tkh0OhJDK52Iatm/gNKnLN6Hw=; b=ZgCHt8Oth4PwwxBrN3a6W
        93pEO49qRBuDZr5JsEBMJhwcxV86eRPOm7Xsy12j4cD5yPblTAIG4Zr+E3xS7I85
        e0FgxWw/G5v5K27H/lah7nK0uhGk+JyFe+VqHJmsC2K3uBVQPr74iH7ecXVvSe6F
        OOSYrzO4ijI4PRpvDHnOzA=
Received: from localhost (unknown [101.86.214.18])
        by smtp7 (Coremail) with SMTP id C8CowAAX_dkGwo1fOyrtDw--.24180S2;
        Tue, 20 Oct 2020 00:42:46 +0800 (CST)
Date:   Tue, 20 Oct 2020 00:42:46 +0800
From:   Hui Su <sh_def@163.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block/elevator: reduce the critical section
Message-ID: <20201019164246.GA79115@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: C8CowAAX_dkGwo1fOyrtDw--.24180S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw4rJFWfJrWfWF1xWry3Jwb_yoW8Wr4kpr
        sIg3sxKr1kXryxZwsrAa429w1Iq34j9r4jqryrCw10kFnrXw43W3W7Ca17XF4YyayxXFs8
        WF1ktFWDAFWUZr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYksDUUUUU=
X-Originating-IP: [101.86.214.18]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiIAbCX10TB0yC3wAAsj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.reduce the critical section in elevator_get().
2.reduce the critical section in elevator_get_by_features().
3.remove the found variable.

the elv_list_lock is used to protect the elv_list,
and the operations of elevator_type does not need
to be protected.

Signed-off-by: Hui Su <sh_def@163.com>
---
 block/elevator.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 293c5c81397a..727902b31954 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -151,11 +151,11 @@ static struct elevator_type *elevator_get(struct request_queue *q,
 		spin_lock(&elv_list_lock);
 		e = elevator_find(name, q->required_elevator_features);
 	}
+	spin_unlock(&elv_list_lock);
 
 	if (e && !try_module_get(e->elevator_owner))
 		e = NULL;
 
-	spin_unlock(&elv_list_lock);
 	return e;
 }
 
@@ -633,23 +633,21 @@ static struct elevator_type *elevator_get_default(struct request_queue *q)
  */
 static struct elevator_type *elevator_get_by_features(struct request_queue *q)
 {
-	struct elevator_type *e, *found = NULL;
+	struct elevator_type *e = NULL;
 
 	spin_lock(&elv_list_lock);
-
 	list_for_each_entry(e, &elv_list, list) {
 		if (elv_support_features(e->elevator_features,
 					 q->required_elevator_features)) {
-			found = e;
 			break;
 		}
 	}
+	spin_unlock(&elv_list_lock);
 
-	if (found && !try_module_get(found->elevator_owner))
-		found = NULL;
+	if (e && !try_module_get(e->elevator_owner))
+		e = NULL;
 
-	spin_unlock(&elv_list_lock);
-	return found;
+	return e;
 }
 
 /*
-- 
2.25.1


