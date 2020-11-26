Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F792C576C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 15:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391163AbgKZOuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 09:50:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35103 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391084AbgKZOuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 09:50:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606402207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=znG6gNvcMrh6gLEREmJ7/Dx2cqBpHJvtQC5F0euUQxU=;
        b=RAmCPXivsfKYRoXBRNcrnCvsM4lmeMWvQeV0IJ3xBLPfxaLSnCqF0ruZRS8r2syzaqj7jH
        AZcrvenAq0AhwyYpuhuFvY6qZOgFchKhPktPTOVXG343tcDg9wvsq7QGsVnKey+W/Omiw8
        w4DH/ic9VDHheLIzlZJ/23DQ96dZ+eA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-VbdWBMQAP6yRWdRc7U_7_g-1; Thu, 26 Nov 2020 09:50:05 -0500
X-MC-Unique: VbdWBMQAP6yRWdRc7U_7_g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A24A8049C0;
        Thu, 26 Nov 2020 14:50:04 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-252.ams2.redhat.com [10.36.113.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FC2019C71;
        Thu, 26 Nov 2020 14:50:02 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 02/17] vdpa_sim: remove unnecessary headers inclusion
Date:   Thu, 26 Nov 2020 15:49:35 +0100
Message-Id: <20201126144950.92850-3-sgarzare@redhat.com>
In-Reply-To: <20201126144950.92850-1-sgarzare@redhat.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some headers are not necessary, so let's remove them to do
some cleaning.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 6a90fdb9cbfc..c6eaf62df8ec 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -7,24 +7,11 @@
  *
  */
 
-#include <linux/init.h>
 #include <linux/module.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/fs.h>
-#include <linux/poll.h>
-#include <linux/slab.h>
-#include <linux/sched.h>
-#include <linux/wait.h>
-#include <linux/uuid.h>
-#include <linux/iommu.h>
 #include <linux/dma-map-ops.h>
-#include <linux/sysfs.h>
-#include <linux/file.h>
 #include <linux/etherdevice.h>
 #include <linux/vringh.h>
 #include <linux/vdpa.h>
-#include <linux/virtio_byteorder.h>
 #include <linux/vhost_iotlb.h>
 #include <uapi/linux/virtio_config.h>
 #include <uapi/linux/virtio_net.h>
-- 
2.26.2

