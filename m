Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E3C2CE6E5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgLDEF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:05:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26702 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727589AbgLDEF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607054672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jWQOtPyifN/PjEn3xTBf4iGLE1QrxjMiv/aT+1c7dfI=;
        b=P3Rhwm2OhgUKDoic5hDq4mCSLIcdfw2cLR1IcB2vJLnbDMNATMyjRuoeylubZG8xDkIPXE
        NeqTwjGRHrLhOAfVCLqf/QpcIhMy8YbcG9xc4y8ZcxgTGEiOVIl10hcOB//TAYYbNBdcgA
        m3qoF/oPqyDNnbrVFXtr/OVX0PMZL1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-NWFx0MyyP_eTAe03uZfnxQ-1; Thu, 03 Dec 2020 23:04:30 -0500
X-MC-Unique: NWFx0MyyP_eTAe03uZfnxQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA271802B47;
        Fri,  4 Dec 2020 04:04:29 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-12-116.pek2.redhat.com [10.72.12.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9901A1A838;
        Fri,  4 Dec 2020 04:04:27 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com
Subject: [PATCH V2 08/19] virtio-pci-modern: introduce vp_modern_generation()
Date:   Fri,  4 Dec 2020 12:03:42 +0800
Message-Id: <20201204040353.21679-9-jasowang@redhat.com>
In-Reply-To: <20201204040353.21679-1-jasowang@redhat.com>
References: <20201204040353.21679-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces vp_modern_generation() to get device generation.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index cb14fc334a9c..a128e5814045 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -289,15 +289,26 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 	}
 }
 
-static u32 vp_generation(struct virtio_device *vdev)
+/*
+ * vp_modern_generation - get the device genreation
+ * @mdev: the modern virtio-pci device
+ *
+ * Returns the genreation read from device
+ */
+static u32 vp_modern_generation(struct virtio_pci_modern_device *mdev)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 
 	return vp_ioread8(&cfg->config_generation);
 }
 
+static u32 vp_generation(struct virtio_device *vdev)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+
+	return vp_modern_generation(&vp_dev->mdev);
+}
+
 /*
  * vp_modern_get_status - get the device status
  * @mdev: the modern virtio-pci device
-- 
2.25.1

