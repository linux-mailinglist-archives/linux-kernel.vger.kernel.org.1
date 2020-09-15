Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF8526AED1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 22:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgIOUo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 16:44:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46171 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727931AbgIOUlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 16:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600202483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QfHY44HmAXILkzkS4zDWgoKUVOzk9yi/J9wMZg+3V00=;
        b=H6eowr3K+jkyfNkROJGAFafNSUyD6WAyehyaT7mwY5XoWVdPVY4nGRrZcbg0Q+JdYHYCJ3
        tqn5KVLY0HnWO2gAP+2/xoKrqn1psf/+b8VS8j8e0ahCeOAB7j7x57ZRo0YTYGOTLWagIa
        B/0jbbciUUDQB8bq86Z4rt7Wn/wthTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-JUEsAOeoMlKyj8_mXM_Pdg-1; Tue, 15 Sep 2020 16:41:19 -0400
X-MC-Unique: JUEsAOeoMlKyj8_mXM_Pdg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5163164089;
        Tue, 15 Sep 2020 20:41:18 +0000 (UTC)
Received: from trippy.localdomain (ovpn-113-154.rdu2.redhat.com [10.10.113.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3E6C10016DA;
        Tue, 15 Sep 2020 20:41:17 +0000 (UTC)
From:   Mark Salter <msalter@redhat.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     Khuong Dinh <khuong@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] drivers/perf: xgene_pmu: Fix uninitialized resource struct
Date:   Tue, 15 Sep 2020 16:41:09 -0400
Message-Id: <20200915204110.326138-1-msalter@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This splat was reported on newer Fedora kernels booting on certain
X-gene based machines:

 xgene-pmu APMC0D83:00: X-Gene PMU version 3
 Unable to handle kernel read from unreadable memory at virtual \
 address 0000000000004006
 ...
 Call trace:
  string+0x50/0x100
  vsnprintf+0x160/0x750
  devm_kvasprintf+0x5c/0xb4
  devm_kasprintf+0x54/0x60
  __devm_ioremap_resource+0xdc/0x1a0
  devm_ioremap_resource+0x14/0x20
  acpi_get_pmu_hw_inf.isra.0+0x84/0x15c
  acpi_pmu_dev_add+0xbc/0x21c
  acpi_ns_walk_namespace+0x16c/0x1e4
  acpi_walk_namespace+0xb4/0xfc
  xgene_pmu_probe_pmu_dev+0x7c/0xe0
  xgene_pmu_probe.part.0+0x2c0/0x310
  xgene_pmu_probe+0x54/0x64
  platform_drv_probe+0x60/0xb4
  really_probe+0xe8/0x4a0
  driver_probe_device+0xe4/0x100
  device_driver_attach+0xcc/0xd4
  __driver_attach+0xb0/0x17c
  bus_for_each_dev+0x6c/0xb0
  driver_attach+0x30/0x40
  bus_add_driver+0x154/0x250
  driver_register+0x84/0x140
  __platform_driver_register+0x54/0x60
  xgene_pmu_driver_init+0x28/0x34
  do_one_initcall+0x40/0x204
  do_initcalls+0x104/0x144
  kernel_init_freeable+0x198/0x210
  kernel_init+0x20/0x12c
  ret_from_fork+0x10/0x18
 Code: 91000400 110004e1 eb08009f 540000c0 (38646846)
 ---[ end trace f08c10566496a703 ]---

This is due to use of an uninitialized local resource struct in the xgene
pmu driver. The thunderx2_pmu driver avoids this by using the resource list
constructed by acpi_dev_get_resources() rather than using a callback from
that function. The callback in the xgene driver didn't fully initialize
the resource. So get rid of the callback and search the resource list as
done by thunderx2.

Fixes: 832c927d119b ("perf: xgene: Add APM X-Gene SoC Performance Monitoring Unit driver")
Signed-off-by: Mark Salter <msalter@redhat.com>
---
 drivers/perf/xgene_pmu.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index edac28cd25dd..633cf07ba672 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1453,17 +1453,6 @@ static char *xgene_pmu_dev_name(struct device *dev, u32 type, int id)
 }
 
 #if defined(CONFIG_ACPI)
-static int acpi_pmu_dev_add_resource(struct acpi_resource *ares, void *data)
-{
-	struct resource *res = data;
-
-	if (ares->type == ACPI_RESOURCE_TYPE_FIXED_MEMORY32)
-		acpi_dev_resource_memory(ares, res);
-
-	/* Always tell the ACPI core to skip this resource */
-	return 1;
-}
-
 static struct
 xgene_pmu_dev_ctx *acpi_get_pmu_hw_inf(struct xgene_pmu *xgene_pmu,
 				       struct acpi_device *adev, u32 type)
@@ -1475,6 +1464,7 @@ xgene_pmu_dev_ctx *acpi_get_pmu_hw_inf(struct xgene_pmu *xgene_pmu,
 	struct hw_pmu_info *inf;
 	void __iomem *dev_csr;
 	struct resource res;
+	struct resource_entry *rentry;
 	int enable_bit;
 	int rc;
 
@@ -1483,11 +1473,23 @@ xgene_pmu_dev_ctx *acpi_get_pmu_hw_inf(struct xgene_pmu *xgene_pmu,
 		return NULL;
 
 	INIT_LIST_HEAD(&resource_list);
-	rc = acpi_dev_get_resources(adev, &resource_list,
-				    acpi_pmu_dev_add_resource, &res);
+	rc = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
+	if (rc <= 0) {
+		dev_err(dev, "PMU type %d: No resources found\n", type);
+		return NULL;
+	}
+
+	list_for_each_entry(rentry, &resource_list, node) {
+		if (resource_type(rentry->res) == IORESOURCE_MEM) {
+			res = *rentry->res;
+			rentry = NULL;
+			break;
+		}
+	}
 	acpi_dev_free_resource_list(&resource_list);
-	if (rc < 0) {
-		dev_err(dev, "PMU type %d: No resource address found\n", type);
+
+	if (rentry) {
+		dev_err(dev, "PMU type %d: No memory resource found\n", type);
 		return NULL;
 	}
 
-- 
2.26.2

