Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E46272273
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgIUL2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 07:28:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13747 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726648AbgIUL2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:28:49 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 61D5732AC86CC64EB1AB;
        Mon, 21 Sep 2020 19:28:47 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 19:28:40 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <sourabhjain@linux.ibm.com>,
        <wangwensheng4@huawei.com>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] powerpc/opalcore: Fix symbol undeclared warning
Date:   Mon, 21 Sep 2020 11:26:01 +0000
Message-ID: <20200921112601.85543-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build kernel with `C=2`:
arch/powerpc/platforms/powernv/opal-core.c:74:16: warning: symbol
'mpipl_kobj' was not declared. Should it be static?

Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 arch/powerpc/platforms/powernv/opal-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
index 6dba3b62269f..c25f9f254f05 100644
--- a/arch/powerpc/platforms/powernv/opal-core.c
+++ b/arch/powerpc/platforms/powernv/opal-core.c
@@ -71,7 +71,7 @@ static LIST_HEAD(opalcore_list);
 static struct opalcore_config *oc_conf;
 static const struct opal_mpipl_fadump *opalc_metadata;
 static const struct opal_mpipl_fadump *opalc_cpu_metadata;
-struct kobject *mpipl_kobj;
+static struct kobject *mpipl_kobj;
 
 /*
  * Set crashing CPU's signal to SIGUSR1. if the kernel is triggered
-- 
2.25.0

