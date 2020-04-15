Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4088D1A8FD4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 02:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634630AbgDOAo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 20:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634576AbgDOAoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:44:04 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D51C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:44:03 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id i128so1429826pfc.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PFykNGvDt3Bxt0QgQrjfg5BlhCJRU6MbqMOEnjuLcXU=;
        b=h6MEDxzulGPn8cUv0luU8RVJe/qfhKlzGqRAQXJbs0Af3EIO+a8KI9Z0bZUIBiyoWC
         T1/f4ACXdlJ49iQHdhLlGbErN/dif21WNj2Azxnd2qdIjbAo/BFdIc8Su7g50sEjWn8e
         tli6Zqof+vrBGHCO+l2gLzPrZhPOHOuYBWTrYEdSVcQC+Utd0xoupvOQaQ1Dwk85/buS
         aol7oU58RmTZy+Nqktgd2WZuGy42av2XvOqGGPgKYDoTnzF4VxxU8ake9J/tbjefur9I
         SMGuflZz+iB5zk5uZgdDrgOgyC9cvRqCW9E597ljNQgoKQ9ndAJ+YP5y9xqJ/sYFFe+l
         L6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PFykNGvDt3Bxt0QgQrjfg5BlhCJRU6MbqMOEnjuLcXU=;
        b=AUBkPK5IEWEaCitJ9lE3d+VX19Mqb5UDbwWPdbvBSG08qeGB6Ft6njYnkZSoeonBWP
         qx3OvNgrETOa4jo2PxwWcHU9h9bs8qyiEuuqKBhtgY73ZOOsP/IvqOZ/Dy+YJpPaXQZC
         4e54kHAeq/VtAqpDPt0BtBBgr5uIF6i3X4Np4jqCSLwviB2MPmSu0EcOMNPT8LwZb3MC
         /wo0zjYJXt/p5AlJdk+eal1M8uwSEuUAyUFGj6OShiO1HjgmWxsG+m2V5qFKHKWZUdgE
         QqDht8VMCOrSTlL2VKe5el+pkBl13X99+B0A87kBFJ2ExjGMaILoExHwJutmdthR1BeW
         /H+w==
X-Gm-Message-State: AGi0PubVsTkTrv8m1HAOUbJtL4fDySzBFBrbjehdcqhS/KNO2qEMgqKk
        0N7Mdp28hPe/91I7bQvfKobVO5o2lHw=
X-Google-Smtp-Source: APiQypJUPOjXj47njM/tZMnKODRO80SSygsOwTD52IPYAElI2mroURYKiHWeE4U+jjih6llcE6QYZ2x7niU=
X-Received: by 2002:a63:40f:: with SMTP id 15mr16254934pge.57.1586911443279;
 Tue, 14 Apr 2020 17:44:03 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:43:46 -0700
In-Reply-To: <20200415004353.130248-1-walken@google.com>
Message-Id: <20200415004353.130248-4-walken@google.com>
Mime-Version: 1.0
References: <20200415004353.130248-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v4 03/10] DMA  reservations: use the new mmap locking API
From:   Michel Lespinasse <walken@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This use is converted manually ahead of the next patch in the series,
as it requires including a new header which the automated conversion
would miss.

Signed-off-by: Michel Lespinasse <walken@google.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 drivers/dma-buf/dma-resv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 4264e64788c4..b45f8514dc82 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -34,6 +34,7 @@
 
 #include <linux/dma-resv.h>
 #include <linux/export.h>
+#include <linux/mm.h>
 #include <linux/sched/mm.h>
 
 /**
@@ -109,7 +110,7 @@ static int __init dma_resv_lockdep(void)
 
 	dma_resv_init(&obj);
 
-	down_read(&mm->mmap_sem);
+	mmap_read_lock(mm);
 	ww_acquire_init(&ctx, &reservation_ww_class);
 	ret = dma_resv_lock(&obj, &ctx);
 	if (ret == -EDEADLK)
@@ -118,7 +119,7 @@ static int __init dma_resv_lockdep(void)
 	fs_reclaim_release(GFP_KERNEL);
 	ww_mutex_unlock(&obj.lock);
 	ww_acquire_fini(&ctx);
-	up_read(&mm->mmap_sem);
+	mmap_read_unlock(mm);
 	
 	mmput(mm);
 
-- 
2.26.0.110.g2183baf09c-goog

