Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30945268344
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 05:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgINDzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 23:55:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35254 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbgINDzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 23:55:18 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 42BE948726F22B358724;
        Mon, 14 Sep 2020 11:55:16 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 14 Sep 2020
 11:55:09 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, <dm-devel@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] dm integrity: convert to use le64_add_cpu()
Date:   Mon, 14 Sep 2020 12:17:49 +0800
Message-ID: <20200914041749.3702000-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert cpu_to_le64(le64_to_cpu(E1) + E2) to use le64_add_cpu().

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/md/dm-integrity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 3fc3757def55..cf9dadd55625 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3696,7 +3696,7 @@ static int create_journal(struct dm_integrity_c *ic, char **error)
 retest_commit_id:
 		for (j = 0; j < i; j++) {
 			if (ic->commit_ids[j] == ic->commit_ids[i]) {
-				ic->commit_ids[i] = cpu_to_le64(le64_to_cpu(ic->commit_ids[i]) + 1);
+				le64_add_cpu(&ic->commit_ids[i], 1);
 				goto retest_commit_id;
 			}
 		}
-- 
2.25.1

