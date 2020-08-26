Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD06252949
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 10:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHZIhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 04:37:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36550 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727045AbgHZIhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:37:16 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AFA9991A271F0DDD8FA3;
        Wed, 26 Aug 2020 16:37:10 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 26 Aug 2020 16:37:00 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v2 2/2] drm/amdkfd: Put ACPI table after using it
Date:   Wed, 26 Aug 2020 16:29:16 +0800
Message-ID: <1598430556-18788-2-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1598430556-18788-1-git-send-email-guohanjun@huawei.com>
References: <1598430556-18788-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The acpi_get_table() should be coupled with acpi_put_table() if
the mapped table is not used at runtime to release the table
mapping which can prevent the memory leak.

In kfd_create_crat_image_acpi(), crat_table is copied to pcrat_image,
and in kfd_create_vcrat_image_cpu(), the acpi_table is only used to
get the OEM information, so those two table mappings need to be released
after using it.

Fixes: 174de876d6d0 ("drm/amdkfd: Group up CRAT related functions")
Fixes: 520b8fb755cc ("drm/amdkfd: Add topology support for CPUs")
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index ed77b109..c3f3ffb6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -758,6 +758,7 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 	struct acpi_table_header *crat_table;
 	acpi_status status;
 	void *pcrat_image;
+	int rc = 0;
 
 	if (!crat_image)
 		return -EINVAL;
@@ -782,13 +783,16 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 	}
 
 	pcrat_image = kmemdup(crat_table, crat_table->length, GFP_KERNEL);
-	if (!pcrat_image)
-		return -ENOMEM;
+	if (!pcrat_image) {
+		rc = -ENOMEM;
+		goto out;
+	}
 
 	*crat_image = pcrat_image;
 	*size = crat_table->length;
-
-	return 0;
+out:
+	acpi_put_table(crat_table);
+	return rc;
 }
 
 /* Memory required to create Virtual CRAT.
@@ -972,6 +976,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 				CRAT_OEMID_LENGTH);
 		memcpy(crat_table->oem_table_id, acpi_table->oem_table_id,
 				CRAT_OEMTABLEID_LENGTH);
+		acpi_put_table(acpi_table);
 	}
 	crat_table->total_entries = 0;
 	crat_table->num_domains = 0;
-- 
1.7.12.4

