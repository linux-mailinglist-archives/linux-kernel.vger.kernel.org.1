Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80562269311
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgINRYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:24:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11843 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbgINM2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:28:54 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C60E4F998CC4076F3916;
        Mon, 14 Sep 2020 20:28:46 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 14 Sep 2020
 20:28:44 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <benh@kernel.crashing.org>, <gustavoars@kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drivers/macintosh/smu.c: Fix undeclared symbol warning
Date:   Mon, 14 Sep 2020 12:26:15 +0000
Message-ID: <20200914122615.65669-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make kernel with `C=2`:
drivers/macintosh/smu.c:1018:30: warning: symbol
'__smu_get_sdb_partition' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 drivers/macintosh/smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index 96684581a25d..bae94caaad5c 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -1015,7 +1015,7 @@ static struct smu_sdbp_header *smu_create_sdb_partition(int id)
 /* Note: Only allowed to return error code in pointers (using ERR_PTR)
  * when interruptible is 1
  */
-const struct smu_sdbp_header *__smu_get_sdb_partition(int id,
+static const struct smu_sdbp_header *__smu_get_sdb_partition(int id,
 		unsigned int *size, int interruptible)
 {
 	char pname[32];
-- 
2.25.0

