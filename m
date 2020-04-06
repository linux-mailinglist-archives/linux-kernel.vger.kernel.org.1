Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D872419FFE1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 23:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgDFVCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 17:02:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56410 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726380AbgDFVCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586206931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b+P99eoGOE59dzJri6nDdYTRF/iHp1rUM821OiEBSWI=;
        b=XmIRmsiUZ3I7KTvTmU6YIlZygfvw1JUzx7vTeNey3LWmMGJuK063rnD2YNpb8nG2LgfW1E
        MX2g9E0xGPawA0p1g7z1IhsmxUHWYxiXNh9eS9MkH7aMbm5O4FuvRysOEwS0K2N7ncr/hb
        +Z4CFQ6T/Njq1WxLIlMrqH7qgbFTNJc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-HbXOWrP4Oy-Eitklo9Znsw-1; Mon, 06 Apr 2020 17:02:07 -0400
X-MC-Unique: HbXOWrP4Oy-Eitklo9Znsw-1
Received: by mail-wr1-f70.google.com with SMTP id g6so528555wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b+P99eoGOE59dzJri6nDdYTRF/iHp1rUM821OiEBSWI=;
        b=qmubGMn2EAOJ3aZEc0F/qhNxr+3l1FMHpviR4aVgViafYxLrmvu3IO2CbiOuAUx7aO
         DnLoUXl7yJGHmg25H+5ItJaAw253VqRKfEsPjHQoT3zIiAk0BIcCgeuOMMzv1XJYcPtf
         K8uq8Egowa6a2Sb8KZSlO3OYWkLvPkdGOs/PxO6UBVDNNhmk9j6A37fra1E3qPuMmEsB
         urqm7f+oczrTXQ2PYZ/KDR4BCs/5tRqJl3gw5YO0fzufEmR0+prQgpJnXpWXX7CzqEM2
         vSLtyjsyOifiURbHWJ3A2QH/h2IQaOfVcGJttrPJoVyM3PRGCBrWDbvSBLyE+TjAkLXu
         KOww==
X-Gm-Message-State: AGi0PuaOEhbwiPdl9Ezv+mX6LbJtpixfNGIv6wfwV/EQm9dhwblJQmP+
        UjziD6Je1u3EnIpXxD0F3/h7dMrqNXQmtz0QoxY6T8wx59KJ0eZPzoOVlX8+6D9hZS6QI3B/HuL
        7aD4iAFCgIIS1yScA44WU96qQ
X-Received: by 2002:a1c:3589:: with SMTP id c131mr1302286wma.116.1586206926217;
        Mon, 06 Apr 2020 14:02:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypLupa6V8Ag++nWn1lmvVOFBGbVp+NnLiKBe5TZlJuWBjL147oyGdoSjF8DsSNg7neOpqnwMaw==
X-Received: by 2002:a1c:3589:: with SMTP id c131mr1302258wma.116.1586206925856;
        Mon, 06 Apr 2020 14:02:05 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id v9sm17395464wrv.18.2020.04.06.14.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:02:05 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:02:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH v4 06/12] vhost: force spec specified alignment on types
Message-ID: <20200406210108.148131-7-mst@redhat.com>
References: <20200406210108.148131-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406210108.148131-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ring element addresses are passed between components with different
alignments assumptions. Thus, if guest/userspace selects a pointer and
host then gets and dereferences it, we might need to decrease the
compiler-selected alignment to prevent compiler on the host from
assuming pointer is aligned.

This actually triggers on ARM with -mabi=apcs-gnu - which is a
deprecated configuration, but it seems safer to handle this
generally.

I verified that the produced binary is exactly identical on x86.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vhost.h       |  6 +++---
 include/linux/virtio_ring.h | 24 +++++++++++++++++++++---
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index f8403bd46b85..60cab4c78229 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -67,9 +67,9 @@ struct vhost_virtqueue {
 	/* The actual ring of buffers. */
 	struct mutex mutex;
 	unsigned int num;
-	struct vring_desc __user *desc;
-	struct vring_avail __user *avail;
-	struct vring_used __user *used;
+	vring_desc_t __user *desc;
+	vring_avail_t __user *avail;
+	vring_used_t __user *used;
 	const struct vhost_iotlb_map *meta_iotlb[VHOST_NUM_ADDRS];
 	struct file *kick;
 	struct eventfd_ctx *call_ctx;
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 11680e74761a..c3f9ca054250 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -60,14 +60,32 @@ static inline void virtio_store_mb(bool weak_barriers,
 struct virtio_device;
 struct virtqueue;
 
+/*
+ * The ring element addresses are passed between components with different
+ * alignments assumptions. Thus, we might need to decrease the compiler-selected
+ * alignment, and so must use a typedef to make sure the __aligned attribute
+ * actually takes hold:
+ *
+ * https://gcc.gnu.org/onlinedocs//gcc/Common-Type-Attributes.html#Common-Type-Attributes
+ *
+ * When used on a struct, or struct member, the aligned attribute can only
+ * increase the alignment; in order to decrease it, the packed attribute must
+ * be specified as well. When used as part of a typedef, the aligned attribute
+ * can both increase and decrease alignment, and specifying the packed
+ * attribute generates a warning.
+ */
+typedef struct vring_desc __aligned(VRING_DESC_ALIGN_SIZE) vring_desc_t;
+typedef struct vring_avail __aligned(VRING_AVAIL_ALIGN_SIZE) vring_avail_t;
+typedef struct vring_used __aligned(VRING_USED_ALIGN_SIZE) vring_used_t;
+
 struct vring {
 	unsigned int num;
 
-	struct vring_desc *desc;
+	vring_desc_t *desc;
 
-	struct vring_avail *avail;
+	vring_avail_t *avail;
 
-	struct vring_used *used;
+	vring_used_t *used;
 };
 
 /*
-- 
MST

