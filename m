Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F248723BB90
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 16:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgHDN7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 09:59:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8760 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728501AbgHDN7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:59:00 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8C271A78127EB8E234D3;
        Tue,  4 Aug 2020 21:58:36 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 4 Aug 2020
 21:58:31 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <qiang.zhao@nxp.com>, <leoyang.li@nxp.com>
CC:     <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] soc: fsl: qe: Remove unnessesary check in ucc_set_tdm_rxtx_clk
Date:   Tue, 4 Aug 2020 21:56:44 +0800
Message-ID: <20200804135644.58878-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix smatch warning:

drivers/soc/fsl/qe/ucc.c:526
 ucc_set_tdm_rxtx_clk() warn: unsigned 'tdm_num' is never less than zero.

'tdm_num' is u32 type, never less than zero.

Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/soc/fsl/qe/ucc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/ucc.c b/drivers/soc/fsl/qe/ucc.c
index cac0fb7693a0..21dbcd787cd5 100644
--- a/drivers/soc/fsl/qe/ucc.c
+++ b/drivers/soc/fsl/qe/ucc.c
@@ -523,7 +523,7 @@ int ucc_set_tdm_rxtx_clk(u32 tdm_num, enum qe_clock clock,
 
 	qe_mux_reg = &qe_immr->qmx;
 
-	if (tdm_num > 7 || tdm_num < 0)
+	if (tdm_num > 7)
 		return -EINVAL;
 
 	/* The communications direction must be RX or TX */
-- 
2.17.1

