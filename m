Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF38D1EC99E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 08:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgFCGhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 02:37:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58916 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbgFCGhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 02:37:00 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 423E1ED8987522C55550;
        Wed,  3 Jun 2020 14:36:58 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 3 Jun 2020
 14:36:49 +0800
From:   Chen Tao <chentao107@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <chentao107@huawei.com>
Subject: [PATCH -next] mm/page_alloc.c: Add missing line breaks
Date:   Wed, 3 Jun 2020 14:35:46 +0800
Message-ID: <20200603063547.235825-1-chentao107@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing line breaks on pr_warn().

Signed-off-by: Chen Tao <chentao107@huawei.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cef05d3a23f5..0b0f05e1e49e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7123,7 +7123,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 		}
 
 		if (mem_below_4gb_not_mirrored)
-			pr_warn("This configuration results in unmirrored kernel memory.");
+			pr_warn("This configuration results in unmirrored kernel memory.\n");
 
 		goto out2;
 	}
-- 
2.22.0

