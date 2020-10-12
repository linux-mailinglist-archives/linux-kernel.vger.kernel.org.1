Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D6D28B510
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbgJLMyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729953AbgJLMyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602507249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GQSN1K5g95DC9GPkuy2aYWb/TZKagXTQDHHDwbyQIac=;
        b=VUWUB8HLRJ5HdweMbsDNKkdg6B++/UKqI52IO/jBR7WxxBqKa0UejfyxWKOqYWmRDLbE99
        gsjYLobXO6KEOi3yspLOSflb259sxCQ9Cjsnd/0lUO3C4DuuqUIwi2GB3xcP3Rxwqky0gJ
        Kpwg0iM5BJrVusVd1YdOe9Vi1xScHcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-XCpsU2AHO8uyoDpfRyDN_g-1; Mon, 12 Oct 2020 08:54:07 -0400
X-MC-Unique: XCpsU2AHO8uyoDpfRyDN_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6EB81018F7F;
        Mon, 12 Oct 2020 12:54:05 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 040AF672C0;
        Mon, 12 Oct 2020 12:53:53 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v1 02/29] virtio-mem: simplify calculation in virtio_mem_mb_state_prepare_next_mb()
Date:   Mon, 12 Oct 2020 14:52:56 +0200
Message-Id: <20201012125323.17509-3-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We actually need one byte less (next_mb_id is exclusive, first_mb_id is
inclusive). Simplify.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index a1f5bf7a571a..670b3faf412d 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -257,8 +257,8 @@ static enum virtio_mem_mb_state virtio_mem_mb_get_state(struct virtio_mem *vm,
  */
 static int virtio_mem_mb_state_prepare_next_mb(struct virtio_mem *vm)
 {
-	unsigned long old_bytes = vm->next_mb_id - vm->first_mb_id + 1;
-	unsigned long new_bytes = vm->next_mb_id - vm->first_mb_id + 2;
+	unsigned long old_bytes = vm->next_mb_id - vm->first_mb_id;
+	unsigned long new_bytes = old_bytes + 1;
 	int old_pages = PFN_UP(old_bytes);
 	int new_pages = PFN_UP(new_bytes);
 	uint8_t *new_mb_state;
-- 
2.26.2

