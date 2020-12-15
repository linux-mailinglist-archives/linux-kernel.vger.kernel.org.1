Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6522DAF45
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgLOOpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:45:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729546AbgLOOom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608043396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+d7eBVQhRYSOsoXaRlz2/mPK7jIgJDoZ0zgKA5DbJ7Y=;
        b=UfwE1iEwMgUJQ7H/orTg9c0IslbJquEvO83q+5lrKhGq5NtO45t9EgoMfF/ID5pvjZSoGX
        tQOigw7oTy4PfTqEsFw1CNHJ8crw1NlnFNMrpcgNF74Qp4gwqUpzfc0bR97ifLqfyRcWN1
        EhuUCupzQCwd4KQWamv23hj1csuPAhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-pJNVcBw5PZWJQvzCNfw_vQ-1; Tue, 15 Dec 2020 09:43:14 -0500
X-MC-Unique: pJNVcBw5PZWJQvzCNfw_vQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3101107ACE3;
        Tue, 15 Dec 2020 14:43:12 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-115-49.ams2.redhat.com [10.36.115.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 117E910013C1;
        Tue, 15 Dec 2020 14:43:09 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Oren Duer <oren@nvidia.com>, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shahaf Shuler <shahafs@nvidia.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 02/18] vdpa_sim: remove unnecessary headers inclusion
Date:   Tue, 15 Dec 2020 15:42:40 +0100
Message-Id: <20201215144256.155342-3-sgarzare@redhat.com>
In-Reply-To: <20201215144256.155342-1-sgarzare@redhat.com>
References: <20201215144256.155342-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some headers are not necessary, so let's remove them to do
some cleaning.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v4:
- checked better which headers are not directly used [Randy]

v3:
- avoided to remove some headers with structures and functions directly
  used (device.h, slab.h, virtio_byteorder.h)[Jason]
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 6a90fdb9cbfc..63b85541fb5e 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -11,16 +11,9 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/fs.h>
-#include <linux/poll.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
-#include <linux/wait.h>
-#include <linux/uuid.h>
-#include <linux/iommu.h>
 #include <linux/dma-map-ops.h>
-#include <linux/sysfs.h>
-#include <linux/file.h>
 #include <linux/etherdevice.h>
 #include <linux/vringh.h>
 #include <linux/vdpa.h>
-- 
2.26.2

