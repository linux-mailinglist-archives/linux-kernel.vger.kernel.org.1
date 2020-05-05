Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D72C1C6102
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 21:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgEET1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 15:27:12 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:56385
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726350AbgEET1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:27:11 -0400
X-IronPort-AV: E=Sophos;i="5.73,356,1583190000"; 
   d="scan'208";a="347819655"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 05 May 2020 21:27:09 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     kernel-janitors@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        eugene.volanschi@inria.fr
Subject: [PATCH] iommu/virtio: reverse arguments to list_add
Date:   Tue,  5 May 2020 20:47:47 +0200
Message-Id: <1588704467-13431-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Elsewhere in the file, there is a list_for_each_entry with
&vdev->resv_regions as the second argument, suggesting that
&vdev->resv_regions is the list head.  So exchange the
arguments on the list_add call to put the list head in the
second argument.

Fixes: 2a5a31487445 ("iommu/virtio: Add probe request")
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/iommu/virtio-iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index d5cac4f46ca5..4e1d11af23c8 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -453,7 +453,7 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 	if (!region)
 		return -ENOMEM;
 
-	list_add(&vdev->resv_regions, &region->list);
+	list_add(&region->list, &vdev->resv_regions);
 	return 0;
 }
 

