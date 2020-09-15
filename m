Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C16269C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgIODD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:03:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40018 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbgIODDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:03:55 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 029D0528DAA3FAEC8488;
        Tue, 15 Sep 2020 11:03:54 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Tue, 15 Sep 2020
 11:03:48 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     James Morse <james.morse@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] firmware: arm_sdei: simplify the return expression of sdei_device_freeze()
Date:   Tue, 15 Sep 2020 11:26:25 +0800
Message-ID: <20200915032625.1772413-1-liushixin2@huawei.com>
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

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/firmware/arm_sdei.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index b4b9ce97f415..5b4c8c51cb20 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -798,16 +798,10 @@ static int sdei_device_resume(struct device *dev)
  */
 static int sdei_device_freeze(struct device *dev)
 {
-	int err;
-
 	/* unregister private events */
 	cpuhp_remove_state(CPUHP_AP_ARM_SDEI_STARTING);
 
-	err = sdei_unregister_shared();
-	if (err)
-		return err;
-
-	return 0;
+	return sdei_unregister_shared();
 }
 
 static int sdei_device_thaw(struct device *dev)
-- 
2.25.1

