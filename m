Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B521A268AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 14:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgINMZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 08:25:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgINMX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:23:28 -0400
Received: from hump.ibmuc.com (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2EDE22260;
        Mon, 14 Sep 2020 11:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600084718;
        bh=oOyNP2I010h7mQ9PCaWanD45FCq7uN4hF6n+5gLqcIo=;
        h=From:To:Cc:Subject:Date:From;
        b=Sd+pe5mRtsBatYE2niIjbfyUPuBRoTcB0UBmAa+foHkFn0p7/EG+8CgjgNHQ0wmGy
         VcHb5gujwEq7CNjwssxHQjIIeotusSJawkzIicDQDVgncrh9Tl7UuISAkoCYnAGm2j
         4Vbl3HcS0pLcwKz1LTGGtpQPsmdQXRV9atCikA2A=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] mm: __do_fault: fix pte_alloc_one spelling
Date:   Mon, 14 Sep 2020 14:58:33 +0300
Message-Id: <20200914115833.2571188-1-rppt@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Fix spelling of pte_alloc_one() in a comment in __do_fault().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 469af373ae76..d582ac79cb7d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3433,7 +3433,7 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 	 *				unlock_page(A)
 	 * lock_page(B)
 	 *				lock_page(B)
-	 * pte_alloc_pne
+	 * pte_alloc_one
 	 *   shrink_page_list
 	 *     wait_on_page_writeback(A)
 	 *				SetPageWriteback(B)
-- 
2.25.4

