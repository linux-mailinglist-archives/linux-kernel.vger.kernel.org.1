Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B780428B52E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbgJLMzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbgJLMzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602507338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6CxxBkFaIBujR5H4ePNpLjJNj4n9V2qfQRlFDh40t9U=;
        b=MiL6EpsXLcVJ20gYAtC0fGcKTOv2W/cwcE/lX8LEcoZys3G3TD34Hw7QRd5cFd3DXaQTZ4
        RqymOQfhao/C75ZFev9jw9e576VoHt9j6HwCHEfUgSxk41nSYF3XU9RMHU1TbdnuIOJDML
        qad+miiD/bGsjRvwKtJ1rB8eKXnP3fo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-GRLVSriTMdWbbPBGQs18-g-1; Mon, 12 Oct 2020 08:55:35 -0400
X-MC-Unique: GRLVSriTMdWbbPBGQs18-g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D85041084D63;
        Mon, 12 Oct 2020 12:55:33 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8580D60C07;
        Mon, 12 Oct 2020 12:55:20 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v1 15/29] virito-mem: document Sub Block Mode (SBM)
Date:   Mon, 12 Oct 2020 14:53:09 +0200
Message-Id: <20201012125323.17509-16-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add some documentation for the current mode - Sub Block Mode (SBM) -
to prepare for a new mode - Big Block Mode (BBM).

Follow-up patches will properly factor out the existing Sub Block Mode
(SBM) and implement Device Block Mode (DBM).

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index faeb759687fe..fd8685673fe4 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -27,6 +27,21 @@ static bool unplug_online = true;
 module_param(unplug_online, bool, 0644);
 MODULE_PARM_DESC(unplug_online, "Try to unplug online memory");
 
+/*
+ * virtio-mem currently supports the following modes of operation:
+ *
+ * * Sub Block Mode (SBM): A Linux memory block spans 1..X subblocks (SB). The
+ *   size of a Sub Block (SB) is determined based on the device block size, the
+ *   pageblock size, and the maximum allocation granularity of the buddy.
+ *   Subblocks within a Linux memory block might either be plugged or unplugged.
+ *   Memory is added/removed to Linux MM in Linux memory block granularity.
+ *
+ * User space / core MM (auto onlining) is responsible for onlining added
+ * Linux memory blocks - and for selecting a zone. Linux Memory Blocks are
+ * always onlined separately, and all memory within a Linux memory block is
+ * onlined to the same zone - virtio-mem relies on this behavior.
+ */
+
 enum virtio_mem_mb_state {
 	/* Unplugged, not added to Linux. Can be reused later. */
 	VIRTIO_MEM_MB_STATE_UNUSED = 0,
-- 
2.26.2

