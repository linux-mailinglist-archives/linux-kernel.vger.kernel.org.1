Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B032CC090
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbgLBPRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 10:17:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46271 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727611AbgLBPRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606922173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zqfbDEdmB+K+wrCtKWPCvHaKiRXjTInLALFT1GWF9Wg=;
        b=OE1sMp29kutrm+ldkQZ7g7ZAdRatlwxIxGW5UjLX4JzFTmX20omPoaxtlASQyioeE+2krP
        KTLg3oTfzIzHjd1DckR1VfUQkbKsqFvih9K+nnaFxi9zAZFuoCaG/r9VzA4PtMYW4SBGAs
        Zud/uSWvdDU8shM7slNSf8A0AjxQstU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-MmbhUDL8NkyixFkKyy_BOg-1; Wed, 02 Dec 2020 10:16:11 -0500
X-MC-Unique: MmbhUDL8NkyixFkKyy_BOg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6383B190A7B4;
        Wed,  2 Dec 2020 15:16:10 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.10.67.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8DC95C1BD;
        Wed,  2 Dec 2020 15:16:09 +0000 (UTC)
From:   Qian Cai <qcai@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <qcai@redhat.com>
Subject: [PATCH] mm/swapfile: Do not sleep with a spin lock held
Date:   Wed,  2 Dec 2020 10:15:49 -0500
Message-Id: <20201202151549.10350-1-qcai@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't call kvfree() with a spin lock held, so defer it.

Signed-off-by: Qian Cai <qcai@redhat.com>
---
 mm/swapfile.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index c4a613688a17..d58361109066 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2867,6 +2867,7 @@ late_initcall(max_swapfiles_check);
 static struct swap_info_struct *alloc_swap_info(void)
 {
 	struct swap_info_struct *p;
+	struct swap_info_struct *defer = NULL;
 	unsigned int type;
 	int i;
 
@@ -2895,7 +2896,7 @@ static struct swap_info_struct *alloc_swap_info(void)
 		smp_wmb();
 		WRITE_ONCE(nr_swapfiles, nr_swapfiles + 1);
 	} else {
-		kvfree(p);
+		defer = p;
 		p = swap_info[type];
 		/*
 		 * Do not memset this entry: a racing procfs swap_next()
@@ -2908,6 +2909,7 @@ static struct swap_info_struct *alloc_swap_info(void)
 		plist_node_init(&p->avail_lists[i], 0);
 	p->flags = SWP_USED;
 	spin_unlock(&swap_lock);
+	kvfree(defer);
 	spin_lock_init(&p->lock);
 	spin_lock_init(&p->cont_lock);
 
-- 
2.28.0

