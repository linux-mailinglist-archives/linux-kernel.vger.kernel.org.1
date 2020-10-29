Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A4F29EA77
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgJ2L14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:27:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6667 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgJ2L1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:27:55 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CMNTk4LMRz15NVr;
        Thu, 29 Oct 2020 19:27:54 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 29 Oct 2020 19:27:41 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <hdegoede@redhat.com>, <mgross@linux.intel.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Zou Wei" <zou_wei@huawei.com>
Subject: [PATCH -next] platform/x86/dell-wmi-sysman: Make wmi_sysman_kobj_sysfs_ops static
Date:   Thu, 29 Oct 2020 19:39:41 +0800
Message-ID: <1603971581-64135-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

drivers/platform/x86/dell-wmi-sysman/sysman.c:258:24: warning:
symbol 'wmi_sysman_kobj_sysfs_ops' was not declared.
Should it be static?

wmi_sysman_kobj_sysfs_ops has only call within sysman.c
It should be static

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/platform/x86/dell-wmi-sysman/sysman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell-wmi-sysman/sysman.c
index 3842575..c6862c3 100644
--- a/drivers/platform/x86/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell-wmi-sysman/sysman.c
@@ -255,7 +255,7 @@ static ssize_t wmi_sysman_attr_store(struct kobject *kobj, struct attribute *att
 	return ret;
 }
 
-const struct sysfs_ops wmi_sysman_kobj_sysfs_ops = {
+static const struct sysfs_ops wmi_sysman_kobj_sysfs_ops = {
 	.show	= wmi_sysman_attr_show,
 	.store	= wmi_sysman_attr_store,
 };
-- 
2.6.2

