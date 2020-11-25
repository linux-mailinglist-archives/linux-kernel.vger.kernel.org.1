Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998262C393E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 07:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgKYGqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 01:46:18 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8032 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgKYGqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 01:46:17 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cgrxt41PHzhcQl;
        Wed, 25 Nov 2020 14:45:54 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 25 Nov 2020 14:46:08 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH] platform/x86: dell-smbios-base: Fix error return code in dell_smbios_init
Date:   Wed, 25 Nov 2020 14:50:32 +0800
Message-ID: <20201125065032.154125-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return the error code -ENODEV when fails to init wmi and
smm.

Fixes: 41e36f2f85af ("platform/x86: dell-smbios: Link all dell-smbios-* modules together")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/platform/x86/dell-smbios-base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/dell-smbios-base.c b/drivers/platform/x86/dell-smbios-base.c
index 2e2cd5659..3a1dbf199 100644
--- a/drivers/platform/x86/dell-smbios-base.c
+++ b/drivers/platform/x86/dell-smbios-base.c
@@ -594,6 +594,7 @@ static int __init dell_smbios_init(void)
 	if (wmi && smm) {
 		pr_err("No SMBIOS backends available (wmi: %d, smm: %d)\n",
 			wmi, smm);
+		ret = -ENODEV;
 		goto fail_create_group;
 	}
 
-- 
2.23.0

