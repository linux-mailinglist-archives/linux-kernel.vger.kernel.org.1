Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914982B06B5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgKLNjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:39:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25618 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728462AbgKLNjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605188356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hRQQtuUNtiXbOmb75O03ZlIOWd8phER1A5atuq2TrM=;
        b=NOjjj5cmn+bMu+OHPgow3JE7cw9oIWAW34T3sdQwWWYwjqQxoMOnh4rDjb+/oYXKWvucU5
        cAOPitzTjcgnQk9BBRcb8e1pwovxm7S7yqxk8UYPCd7W3ZU2HGQIRn0Mtek18uceTAQSGz
        lp6tnneXQI4hOfRYY4sC3hge1vkBwOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-_Sch3msLPgeBZRjbKyCiyQ-1; Thu, 12 Nov 2020 08:39:14 -0500
X-MC-Unique: _Sch3msLPgeBZRjbKyCiyQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E607108E1A9;
        Thu, 12 Nov 2020 13:39:13 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A436255766;
        Thu, 12 Nov 2020 13:39:11 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 17/29] virito-mem: document Sub Block Mode (SBM)
Date:   Thu, 12 Nov 2020 14:38:03 +0100
Message-Id: <20201112133815.13332-18-david@redhat.com>
In-Reply-To: <20201112133815.13332-1-david@redhat.com>
References: <20201112133815.13332-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add some documentation for the current mode - Sub Block Mode (SBM) -
to prepare for a new mode - Big Block Mode (BBM).

Follow-up patches will properly factor out the existing Sub Block Mode
(SBM) and implement Big Block Mode (BBM).

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index cbd0aa5eb95c..4234bfc0cf52 100644
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

