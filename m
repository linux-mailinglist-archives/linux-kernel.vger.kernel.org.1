Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A70A2656CC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 04:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgIKCCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 22:02:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11808 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725300AbgIKCCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 22:02:13 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5651284925446A64A6DB;
        Fri, 11 Sep 2020 10:02:08 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Fri, 11 Sep 2020
 10:02:00 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <geoff@infradead.org>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] powerpc/ps3: make two symbols static
Date:   Fri, 11 Sep 2020 10:01:21 +0800
Message-ID: <20200911020121.1464585-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This addresses the following sparse warning:

arch/powerpc/platforms/ps3/spu.c:451:33: warning: symbol
'spu_management_ps3_ops' was not declared. Should it be static?
arch/powerpc/platforms/ps3/spu.c:592:28: warning: symbol
'spu_priv1_ps3_ops' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 arch/powerpc/platforms/ps3/spu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/spu.c b/arch/powerpc/platforms/ps3/spu.c
index 1193c294b8d0..0c252478e556 100644
--- a/arch/powerpc/platforms/ps3/spu.c
+++ b/arch/powerpc/platforms/ps3/spu.c
@@ -448,7 +448,7 @@ static void ps3_disable_spu(struct spu_context *ctx)
 	ctx->ops->runcntl_stop(ctx);
 }
 
-const struct spu_management_ops spu_management_ps3_ops = {
+static const struct spu_management_ops spu_management_ps3_ops = {
 	.enumerate_spus = ps3_enumerate_spus,
 	.create_spu = ps3_create_spu,
 	.destroy_spu = ps3_destroy_spu,
@@ -589,7 +589,7 @@ static u64 resource_allocation_enable_get(struct spu *spu)
 	return 0; /* No support. */
 }
 
-const struct spu_priv1_ops spu_priv1_ps3_ops = {
+static const struct spu_priv1_ops spu_priv1_ps3_ops = {
 	.int_mask_and = int_mask_and,
 	.int_mask_or = int_mask_or,
 	.int_mask_set = int_mask_set,
-- 
2.25.4

