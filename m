Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826A8264880
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 16:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgIJOzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 10:55:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38644 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730261AbgIJOyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:54:14 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CFA006BE360D71439816;
        Thu, 10 Sep 2020 22:05:06 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 22:04:56 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <Roy.Pledge@nxp.com>, <leoyang.li@nxp.com>,
        <youri.querry_1@nxp.com>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] soc: fsl: dpio: remove set but not used 'addr_cena'
Date:   Thu, 10 Sep 2020 22:04:15 +0800
Message-ID: <20200910140415.1132266-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This addresses the following gcc warning with "make W=1":

drivers/soc/fsl/dpio/qbman-portal.c: In function
‘qbman_swp_enqueue_multiple_direct’:
drivers/soc/fsl/dpio/qbman-portal.c:650:11: warning: variable
‘addr_cena’ set but not used [-Wunused-but-set-variable]
  650 |  uint64_t addr_cena;
      |           ^~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/soc/fsl/dpio/qbman-portal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
index 0ab85bfb116f..659b4a570d5b 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -647,7 +647,6 @@ int qbman_swp_enqueue_multiple_direct(struct qbman_swp *s,
 	const uint32_t *cl = (uint32_t *)d;
 	uint32_t eqcr_ci, eqcr_pi, half_mask, full_mask;
 	int i, num_enqueued = 0;
-	uint64_t addr_cena;
 
 	spin_lock(&s->access_spinlock);
 	half_mask = (s->eqcr.pi_ci_mask>>1);
@@ -701,7 +700,6 @@ int qbman_swp_enqueue_multiple_direct(struct qbman_swp *s,
 
 	/* Flush all the cacheline without load/store in between */
 	eqcr_pi = s->eqcr.pi;
-	addr_cena = (size_t)s->addr_cena;
 	for (i = 0; i < num_enqueued; i++)
 		eqcr_pi++;
 	s->eqcr.pi = eqcr_pi & full_mask;
-- 
2.25.4

