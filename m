Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5BD28FCFC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 05:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394277AbgJPDuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 23:50:06 -0400
Received: from smtp.h3c.com ([60.191.123.56]:34848 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394270AbgJPDuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 23:50:05 -0400
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam01-ex.h3c.com with ESMTPS id 09G3nW3G052206
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Oct 2020 11:49:32 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 16 Oct 2020 11:49:34 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] mm: vmscan: avoid a unnecessary reschedule in shrink_slab()
Date:   Fri, 16 Oct 2020 11:39:52 +0800
Message-ID: <20201016033952.1924-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 09G3nW3G052206
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In shrink_slab(), it directly goes to 'out' label only when it
can't get the lock of shrinker_rwsew. In this case, it doesn't
do the real work of shrinking slab, so we don't need trigger a
reschedule by cond_resched().

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 mm/vmscan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 466fc3144..676e97b28 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -687,8 +687,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	}
 
 	up_read(&shrinker_rwsem);
-out:
+
 	cond_resched();
+out:
 	return freed;
 }
 
-- 
2.17.1

