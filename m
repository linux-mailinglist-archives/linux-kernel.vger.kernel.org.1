Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E601CB16D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 16:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgEHOJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 10:09:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43014 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726817AbgEHOJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:09:26 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5CB18DFBFAE8AAA0CC89;
        Fri,  8 May 2020 22:09:24 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 8 May 2020
 22:09:15 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <leoyang.li@nxp.com>, <roy.pledge@nxp.com>
CC:     <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] soc: fsl: qbman: Remove unused inline function qm_eqcr_get_ci_stashing
Date:   Fri, 8 May 2020 22:08:46 +0800
Message-ID: <20200508140846.47608-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no callers in-tree anymore.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/soc/fsl/qbman/qman.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 1e164e03410a..9888a7061873 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -449,11 +449,6 @@ static inline int qm_eqcr_init(struct qm_portal *portal,
 	return 0;
 }
 
-static inline unsigned int qm_eqcr_get_ci_stashing(struct qm_portal *portal)
-{
-	return (qm_in(portal, QM_REG_CFG) >> 28) & 0x7;
-}
-
 static inline void qm_eqcr_finish(struct qm_portal *portal)
 {
 	struct qm_eqcr *eqcr = &portal->eqcr;
-- 
2.17.1


