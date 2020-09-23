Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47798274EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 04:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgIWC1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 22:27:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49458 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726893AbgIWC1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 22:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600828023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=d1zwNE/FijiTofGwoi7ffclzRV65K5GjqX+0bKQ26Fw=;
        b=e+RQeWHE0Gf3iSgehb0xrsN+s7RrTAl9JWBqczmy2vuUo99sJKTX8FJqQZSn8RJM2nSOKt
        5dvDGXImS58KOid4A8VNAPwQIj1o44nXBLL3vwyKrEJ9zSrt8VwEkMaRvJxMItDCwgdK8J
        XHrxFwbXVCs3+2qhqJue6FdeDRH8svA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-L6uzC-czO9mRA6XpsP-sbw-1; Tue, 22 Sep 2020 22:27:00 -0400
X-MC-Unique: L6uzC-czO9mRA6XpsP-sbw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0A2C8027E1;
        Wed, 23 Sep 2020 02:26:58 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33E3A277B0;
        Wed, 23 Sep 2020 02:26:56 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     joro@8bytes.org, ahuang12@lenovo.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "iommu/amd: Treat per-device exclusion ranges as r/w unity-mapped regions"
Date:   Wed, 23 Sep 2020 10:26:55 +0800
Message-Id: <20200923022655.750-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A regression failure of kdump kernel boot was reported on a HPE system.
Bisect points at commit 387caf0b759ac43 ("iommu/amd: Treat per-device
exclusion ranges as r/w unity-mapped regions") as criminal. Reverting it
fix the failure.

With the commit, kdump kernel will always print below error message, then
naturally AMD iommu can't function normally during kdump kernel bootup.

  ~~~~~~~~~
  AMD-Vi: [Firmware Bug]: IVRS invalid checksum

Why commit 387caf0b759ac43 causing it haven't been made clear.

From the commit log, a discussion thread link is pasted. In that discussion
thread, Adrian told the fix is for a system with already broken BIOS, and
Joerg suggested two options. Finally option 2) is taken. Maybe option 1)
should be the right approach?

  1) Bail out and disable the IOMMU as the BIOS screwed up
  2) Treat per-device exclusion ranges just as r/w unity-mapped
     regions.

https://lists.linuxfoundation.org/pipermail/iommu/2019-November/040117.html
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd/init.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 9aa1eae26634..bbe7ceae5949 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1109,17 +1109,22 @@ static int __init add_early_maps(void)
  */
 static void __init set_device_exclusion_range(u16 devid, struct ivmd_header *m)
 {
+	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
+
 	if (!(m->flags & IVMD_FLAG_EXCL_RANGE))
 		return;
 
-	/*
-	 * Treat per-device exclusion ranges as r/w unity-mapped regions
-	 * since some buggy BIOSes might lead to the overwritten exclusion
-	 * range (exclusion_start and exclusion_length members). This
-	 * happens when there are multiple exclusion ranges (IVMD entries)
-	 * defined in ACPI table.
-	 */
-	m->flags = (IVMD_FLAG_IW | IVMD_FLAG_IR | IVMD_FLAG_UNITY_MAP);
+	if (iommu) {
+		/*
+		 * We only can configure exclusion ranges per IOMMU, not
+		 * per device. But we can enable the exclusion range per
+		 * device. This is done here
+		 */
+		set_dev_entry_bit(devid, DEV_ENTRY_EX);
+		iommu->exclusion_start = m->range_start;
+		iommu->exclusion_length = m->range_length;
+	}
+
 }
 
 /*
-- 
2.17.2

