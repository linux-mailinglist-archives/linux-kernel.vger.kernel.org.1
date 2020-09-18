Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42FE26F8D8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgIRJCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:02:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13297 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbgIRJCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:02:43 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3D334F8BEB1345A7A03A;
        Fri, 18 Sep 2020 17:02:41 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 17:02:25 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <linuxppc-dev@lists.ozlabs.org>
CC:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <aneesh.kumar@linux.ibm.com>,
        <dan.j.williams@intel.com>, <vaibhav@linux.ibm.com>,
        <ira.weiny@intel.com>, <santosh@fossix.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] powerpc/papr_scm: Fix warnings about undeclared variable
Date:   Fri, 18 Sep 2020 08:59:51 +0000
Message-ID: <20200918085951.44983-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build the kernel with 'make C=2':
arch/powerpc/platforms/pseries/papr_scm.c:825:1: warning: symbol
'dev_attr_perf_stats' was not declared. Should it be static?

Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 5493bc847bd0..a95aa425e7d4 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -823,7 +823,7 @@ static ssize_t perf_stats_show(struct device *dev,
 	kfree(stats);
 	return rc ? rc : (ssize_t)seq_buf_used(&s);
 }
-DEVICE_ATTR_ADMIN_RO(perf_stats);
+static DEVICE_ATTR_ADMIN_RO(perf_stats);
 
 static ssize_t flags_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
-- 
2.25.0

