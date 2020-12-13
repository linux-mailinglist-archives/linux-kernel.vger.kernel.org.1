Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F15E2D8F3C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 19:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgLMSK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 13:10:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38896 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725777AbgLMSK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 13:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607882940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Jlz332zFWJReTYscol+oPYeopBaK9ZxEFQwZJbYpmjg=;
        b=XtD5LCnpIvJwbZl9DucuA2nfVR535INTeiqYjXIm9u1iy27OAoy2cb3AjoyUghYueesulR
        k9PxreQFwauchso5pe1xiwfC7ziGl3j/GYTHyZOKfZqtJncq+45olw81XnrNmd1rNP9ZL7
        wkrv5q84y0bauHJwb6CgmiivHuLTy0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-n7S7KqtrOWq5Tu-6s5UIPw-1; Sun, 13 Dec 2020 13:08:58 -0500
X-MC-Unique: n7S7KqtrOWq5Tu-6s5UIPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92D2559;
        Sun, 13 Dec 2020 18:08:57 +0000 (UTC)
Received: from llong.com (ovpn-112-248.rdu2.redhat.com [10.10.112.248])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D4FB62464;
        Sun, 13 Dec 2020 18:08:52 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] mm/vmalloc: Fix unlock order in s_stop()
Date:   Sun, 13 Dec 2020 13:08:43 -0500
Message-Id: <20201213180843.16938-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple locks are acquired, they should be released in reverse
order. For s_start() and s_stop() in mm/vmalloc.c, that is not the
case.

  s_start: mutex_lock(&vmap_purge_lock); spin_lock(&vmap_area_lock);
  s_stop : mutex_unlock(&vmap_purge_lock); spin_unlock(&vmap_area_lock);

This unlock sequence, though allowed, is not optimal. If a waiter is
present, mutex_unlock() will need to go through the slowpath of waking
up the waiter with preemption disabled. Fix that by releasing the
spinlock first before the mutex.

Fixes: e36176be1c39 ("mm/vmalloc: rework vmap_area_lock")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/vmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6ae491a8b210..75913f685c71 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3448,11 +3448,11 @@ static void *s_next(struct seq_file *m, void *p, loff_t *pos)
 }
 
 static void s_stop(struct seq_file *m, void *p)
-	__releases(&vmap_purge_lock)
 	__releases(&vmap_area_lock)
+	__releases(&vmap_purge_lock)
 {
-	mutex_unlock(&vmap_purge_lock);
 	spin_unlock(&vmap_area_lock);
+	mutex_unlock(&vmap_purge_lock);
 }
 
 static void show_numa_info(struct seq_file *m, struct vm_struct *v)
-- 
2.18.1

