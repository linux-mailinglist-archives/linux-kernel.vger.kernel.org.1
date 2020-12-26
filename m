Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EA32E2D5B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 07:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgLZFli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 00:41:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46245 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725801AbgLZFli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 00:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608961211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=RciS3qF6mXrSlTKUjAjECWK+kmGx/IgeCIP1cax7Fik=;
        b=VMnE70DlQBqJP46kMFbyElZNNh4janogbqGCC+Qg1X8oY1KYr0XBAJaG3xxuCyUTrlwmp9
        uB/DaBpz78IvEXjiPO26yrLyjHjgMhwS2Wpl2XI4/DJoN5659+7UaQqyB7i0yJKXJwWWt8
        XXCSbnjRcEuLWZfcP/IjGZqnu0H7W4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-7ReRvWHMN2CMLSVQJMO8xA-1; Sat, 26 Dec 2020 00:40:07 -0500
X-MC-Unique: 7ReRvWHMN2CMLSVQJMO8xA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 015001800D42;
        Sat, 26 Dec 2020 05:40:06 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-181.pek2.redhat.com [10.72.12.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 016E25D9D3;
        Sat, 26 Dec 2020 05:40:02 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH] iommu: check for the deferred attach when attaching a device
Date:   Sat, 26 Dec 2020 13:39:59 +0800
Message-Id: <20201226053959.4222-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, because domain attach allows to be deferred from iommu
driver to device driver, and when iommu initializes, the devices
on the bus will be scanned and the default groups will be allocated.

Due to the above changes, some devices could be added to the same
group as below:

[    3.859417] pci 0000:01:00.0: Adding to iommu group 16
[    3.864572] pci 0000:01:00.1: Adding to iommu group 16
[    3.869738] pci 0000:02:00.0: Adding to iommu group 17
[    3.874892] pci 0000:02:00.1: Adding to iommu group 17

But when attaching these devices, it doesn't allow that a group has
more than one device, otherwise it will return an error. This conflicts
with the deferred attaching. Unfortunately, it has two devices in the
same group for my side, for example:

[    9.627014] iommu_group_device_count(): device name[0]:0000:01:00.0
[    9.633545] iommu_group_device_count(): device name[1]:0000:01:00.1
...
[   10.255609] iommu_group_device_count(): device name[0]:0000:02:00.0
[   10.262144] iommu_group_device_count(): device name[1]:0000:02:00.1

Finally, which caused the failure of tg3 driver when tg3 driver calls
the dma_alloc_coherent() to allocate coherent memory in the tg3_test_dma().

[    9.660310] tg3 0000:01:00.0: DMA engine test failed, aborting
[    9.754085] tg3: probe of 0000:01:00.0 failed with error -12
[    9.997512] tg3 0000:01:00.1: DMA engine test failed, aborting
[   10.043053] tg3: probe of 0000:01:00.1 failed with error -12
[   10.288905] tg3 0000:02:00.0: DMA engine test failed, aborting
[   10.334070] tg3: probe of 0000:02:00.0 failed with error -12
[   10.578303] tg3 0000:02:00.1: DMA engine test failed, aborting
[   10.622629] tg3: probe of 0000:02:00.1 failed with error -12

In addition, the similar situations also occur in other drivers such
as the bnxt_en driver. That can be reproduced easily in kdump kernel
when SME is active.

Add a check for the deferred attach in the iommu_attach_device() and
allow to attach the deferred device regardless of how many devices
are in a group.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 drivers/iommu/iommu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ffeebda8d6de..dccab7b133fb 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1967,8 +1967,11 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 	 */
 	mutex_lock(&group->mutex);
 	ret = -EINVAL;
-	if (iommu_group_device_count(group) != 1)
+	if (!iommu_is_attach_deferred(domain, dev) &&
+	    iommu_group_device_count(group) != 1) {
+		dev_err_ratelimited(dev, "Group has more than one device\n");
 		goto out_unlock;
+	}
 
 	ret = __iommu_attach_group(domain, group);
 
-- 
2.17.1

