Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C0026BCC5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgIPGVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:21:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12300 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726390AbgIPGVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:21:00 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5B41814F3F1F731B005E;
        Wed, 16 Sep 2020 14:20:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 16 Sep 2020 14:20:48 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH -next] powerpc/powernv: fix wrong warning message in opalcore_config_init()
Date:   Wed, 16 Sep 2020 14:21:29 +0800
Message-ID: <20200916062129.190864-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic of the warn output is incorrect. The two args should be
exchanged.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 arch/powerpc/platforms/powernv/opal-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
index 6dba3b622..23571f0b5 100644
--- a/arch/powerpc/platforms/powernv/opal-core.c
+++ b/arch/powerpc/platforms/powernv/opal-core.c
@@ -510,7 +510,7 @@ static void __init opalcore_config_init(void)
 	idx = be32_to_cpu(opalc_metadata->region_cnt);
 	if (idx > MAX_PT_LOAD_CNT) {
 		pr_warn("WARNING: OPAL regions count (%d) adjusted to limit (%d)",
-			MAX_PT_LOAD_CNT, idx);
+			idx, MAX_PT_LOAD_CNT);
 		idx = MAX_PT_LOAD_CNT;
 	}
 	for (i = 0; i < idx; i++) {
-- 
2.23.0

