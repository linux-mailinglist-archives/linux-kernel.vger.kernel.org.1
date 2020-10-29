Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6E629EABB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgJ2Lfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:35:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7099 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgJ2Lfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:35:41 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CMNfh24BfzLr7F;
        Thu, 29 Oct 2020 19:35:40 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 29 Oct 2020 19:35:29 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <hdegoede@redhat.com>, <mgross@linux.intel.com>,
        <luzmaximilian@gmail.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Zou Wei" <zou_wei@huawei.com>
Subject: [PATCH -next] platform/surface: remove status assignment without reading
Date:   Thu, 29 Oct 2020 19:47:28 +0800
Message-ID: <1603972048-64271-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The status local variable is assigned but never read:

drivers/platform/surface/surface3-wmi.c:60:14: warning:
variable ‘status’ set but not used [-Wunused-but-set-variable]
  acpi_status status;
              ^~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/platform/surface/surface3-wmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/platform/surface/surface3-wmi.c b/drivers/platform/surface/surface3-wmi.c
index 130b6f5..ae1416c 100644
--- a/drivers/platform/surface/surface3-wmi.c
+++ b/drivers/platform/surface/surface3-wmi.c
@@ -57,12 +57,10 @@ static DEFINE_MUTEX(s3_wmi_lock);
 static int s3_wmi_query_block(const char *guid, int instance, int *ret)
 {
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
-	acpi_status status;
 	union acpi_object *obj;
 	int error = 0;
 
 	mutex_lock(&s3_wmi_lock);
-	status = wmi_query_block(guid, instance, &output);
 
 	obj = output.pointer;
 
-- 
2.6.2

