Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25792CDBCC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbgLCRGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:06:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20933 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731399AbgLCRGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607015125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aE3CJWv12p3c45pgVJgnnZEAR7LVIJzz6cumFBh2UmM=;
        b=hkAEI1AeMKNPnsNOgxYB64mx7BLLlp6524Ptue2N7A9YYTJ3IRY8DcWzQZ/SZB0ZJU/NqR
        4ZrtVcyr9WLkDDAhYBos63+rDf5AtYGUZXnk2qsj0jQSkWvMUv7uJhNApMNY7as757FhFc
        /i2FafPt19zN1hOXzxKCIxng4BGQ760=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-swkHTwh4PRqmK73FoUgZwA-1; Thu, 03 Dec 2020 12:05:21 -0500
X-MC-Unique: swkHTwh4PRqmK73FoUgZwA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5ED9F800D55;
        Thu,  3 Dec 2020 17:05:20 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 144555D6AC;
        Thu,  3 Dec 2020 17:05:17 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH v3 02/19] vdpa_sim: remove unnecessary headers inclusion
Date:   Thu,  3 Dec 2020 18:04:54 +0100
Message-Id: <20201203170511.216407-3-sgarzare@redhat.com>
In-Reply-To: <20201203170511.216407-1-sgarzare@redhat.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some headers are not necessary, so let's remove them to do
some cleaning.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v3:
- avoided to remove some headers with structures and functions directly
  used (device.h, slab.h, virtio_byteorder.h)[Jason]
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 6a90fdb9cbfc..b08f28d20d8d 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -7,20 +7,10 @@
  *
  */
 
-#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/fs.h>
-#include <linux/poll.h>
 #include <linux/slab.h>
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
-- 
2.26.2

