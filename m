Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B619726D537
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgIQHwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:52:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12820 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726210AbgIQHv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:51:29 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9D5AE135A945D77FDA77;
        Thu, 17 Sep 2020 15:51:26 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 15:51:20 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] drivers/firmware/psci: fix type warning of sizeof in alloc_init_cpu_groups()
Date:   Thu, 17 Sep 2020 16:13:53 +0800
Message-ID: <20200917081353.2083241-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sizeof() when applied to a pointer typed expression should gives the
size of the pointed data, even if the data is a pointer.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/firmware/psci/psci_checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
index 9a369a2eda71..116eb465cdb4 100644
--- a/drivers/firmware/psci/psci_checker.c
+++ b/drivers/firmware/psci/psci_checker.c
@@ -155,7 +155,7 @@ static int alloc_init_cpu_groups(cpumask_var_t **pcpu_groups)
 	if (!alloc_cpumask_var(&tmp, GFP_KERNEL))
 		return -ENOMEM;
 
-	cpu_groups = kcalloc(nb_available_cpus, sizeof(cpu_groups),
+	cpu_groups = kcalloc(nb_available_cpus, sizeof(*cpu_groups),
 			     GFP_KERNEL);
 	if (!cpu_groups) {
 		free_cpumask_var(tmp);
-- 
2.25.1

