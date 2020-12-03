Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32EC2CDBDB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501898AbgLCRHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:07:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725918AbgLCRHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607015159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FwRJrUBTPsHO6CS9p2N6npskY2prbgJKju6rYBszPUY=;
        b=HD8SMLaWEyq4VIJtdx6/d2ytaAL++Mi3W3LVLwXAKt8IElch7Rl6n4UWwnTDIyBM67spT9
        dRZoP3wel+jUcFHJ8h+fJ0bo56ksopZlWVXGL/Obehna+atzDw/o0wfZnQGbtt09QJz9JL
        WYBAZe+vtJ7Zi6VqVu2og8gdJQxZ8l4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-AenLv00DOHOZc5Kke33WtA-1; Thu, 03 Dec 2020 12:05:55 -0500
X-MC-Unique: AenLv00DOHOZc5Kke33WtA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 137711922043;
        Thu,  3 Dec 2020 17:05:54 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5ED8160C15;
        Thu,  3 Dec 2020 17:05:44 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH v3 04/19] vhost/iotlb: add VHOST_IOTLB_UNLIMITED macro
Date:   Thu,  3 Dec 2020 18:04:56 +0100
Message-Id: <20201203170511.216407-5-sgarzare@redhat.com>
In-Reply-To: <20201203170511.216407-1-sgarzare@redhat.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible to allocate an unlimited IOTLB calling
vhost_iotlb_alloc() with 'limit' = 0.

Add a new macro (VHOST_IOTLB_UNLIMITED) for this case and document
it in the vhost_iotlb_alloc() documentation block.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/vhost_iotlb.h | 2 ++
 drivers/vhost/iotlb.c       | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/vhost_iotlb.h b/include/linux/vhost_iotlb.h
index 6b09b786a762..47019f97f795 100644
--- a/include/linux/vhost_iotlb.h
+++ b/include/linux/vhost_iotlb.h
@@ -4,6 +4,8 @@
 
 #include <linux/interval_tree_generic.h>
 
+#define VHOST_IOTLB_UNLIMITED 0
+
 struct vhost_iotlb_map {
 	struct rb_node rb;
 	struct list_head link;
diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
index 0fd3f87e913c..80fdde78ee5a 100644
--- a/drivers/vhost/iotlb.c
+++ b/drivers/vhost/iotlb.c
@@ -100,7 +100,8 @@ EXPORT_SYMBOL_GPL(vhost_iotlb_del_range);
 
 /**
  * vhost_iotlb_alloc - add a new vhost IOTLB
- * @limit: maximum number of IOTLB entries
+ * @limit: maximum number of IOTLB entries (use VHOST_IOTLB_UNLIMITED for an
+ *         unlimited IOTLB)
  * @flags: VHOST_IOTLB_FLAG_XXX
  *
  * Returns an error is memory allocation fails
-- 
2.26.2

