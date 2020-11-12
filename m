Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184B92B0699
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgKLNig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:38:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54328 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728062AbgKLNie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605188313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vWj2ryGZracq7Jb4f+d4SllYNO6XdToGqxK6IXTvhW8=;
        b=QJjo0fAk1/ENTNK8xDaHMbywO1FtKJuZcejP7XjqMQ8VYS9uTuMo9Uf+4gW+BLoRFJbBd7
        uEkvPtwZgP2fxQcmqx9DpuxgcgeI+ydeQJ3lynm5TwZ67eh+BEgJb9Y24525ihaA33MJJP
        OOmipClcRiq2zzzg4IVfrwizVFqsItU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-biAF8QpOP6aQ2x_ScKgn_g-1; Thu, 12 Nov 2020 08:38:31 -0500
X-MC-Unique: biAF8QpOP6aQ2x_ScKgn_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 627D5809DEE;
        Thu, 12 Nov 2020 13:38:30 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C80AE55765;
        Thu, 12 Nov 2020 13:38:28 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v2 02/29] virtio-mem: more precise calculation in virtio_mem_mb_state_prepare_next_mb()
Date:   Thu, 12 Nov 2020 14:37:48 +0100
Message-Id: <20201112133815.13332-3-david@redhat.com>
In-Reply-To: <20201112133815.13332-1-david@redhat.com>
References: <20201112133815.13332-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We actually need one byte less (next_mb_id is exclusive, first_mb_id is
inclusive). While at it, compact the code.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index a37fd73588da..dee46865bae2 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -257,10 +257,8 @@ static enum virtio_mem_mb_state virtio_mem_mb_get_state(struct virtio_mem *vm,
  */
 static int virtio_mem_mb_state_prepare_next_mb(struct virtio_mem *vm)
 {
-	unsigned long old_bytes = vm->next_mb_id - vm->first_mb_id + 1;
-	unsigned long new_bytes = vm->next_mb_id - vm->first_mb_id + 2;
-	int old_pages = PFN_UP(old_bytes);
-	int new_pages = PFN_UP(new_bytes);
+	int old_pages = PFN_UP(vm->next_mb_id - vm->first_mb_id);
+	int new_pages = PFN_UP(vm->next_mb_id - vm->first_mb_id + 1);
 	uint8_t *new_mb_state;
 
 	if (vm->mb_state && old_pages == new_pages)
-- 
2.26.2

