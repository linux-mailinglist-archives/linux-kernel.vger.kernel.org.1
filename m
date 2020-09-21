Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CE72724A9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgIUNKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:10:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727113AbgIUNJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:09:56 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 395306C370E3AD7EAC4E;
        Mon, 21 Sep 2020 21:09:52 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:09:46 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, <dm-devel@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] dm bufio: simplify the return expression of skip_metadata()
Date:   Mon, 21 Sep 2020 21:10:10 +0800
Message-ID: <20200921131010.91236-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the return expression.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/md/dm-snap-persistent.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/md/dm-snap-persistent.c b/drivers/md/dm-snap-persistent.c
index 63fab7c76..74b483fed 100644
--- a/drivers/md/dm-snap-persistent.c
+++ b/drivers/md/dm-snap-persistent.c
@@ -284,16 +284,11 @@ static void skip_metadata(struct pstore *ps)
  */
 static int area_io(struct pstore *ps, int op, int op_flags)
 {
-	int r;
 	chunk_t chunk;
 
 	chunk = area_location(ps, ps->current_area);
 
-	r = chunk_io(ps, ps->area, chunk, op, op_flags, 0);
-	if (r)
-		return r;
-
-	return 0;
+	return chunk_io(ps, ps->area, chunk, op, op_flags, 0);
 }
 
 static void zero_memory_area(struct pstore *ps)
-- 
2.23.0

