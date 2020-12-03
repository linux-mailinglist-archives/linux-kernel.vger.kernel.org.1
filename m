Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AB62CDBCB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbgLCRGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:06:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32177 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727470AbgLCRGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607015121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k4tojkWY82l70KdB/Lsr4k2Y/bngWEncji8Wtqxzzm8=;
        b=DYakvfupKAWHuOvkjOnbIgDwdaGtBhPMoQEcg0qG+KVGxdzgrjQ1MhJ0o6pPE4QNJH58bS
        3+tWB96VRU/Lii5EW3jLLbE+urrUuKND7bvnWcgRhadr4gm+8zYU9XqJCZXknFArpwLdkx
        pRzqQzRg/X48zg6x8q1yCSK0rgsOtNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-vnPpnPElOZ6CgcK2JNhcWw-1; Thu, 03 Dec 2020 12:05:20 -0500
X-MC-Unique: vnPpnPElOZ6CgcK2JNhcWw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFFD4800D53;
        Thu,  3 Dec 2020 17:05:17 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 638625D6AC;
        Thu,  3 Dec 2020 17:05:15 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH v3 01/19] vdpa: remove unnecessary 'default n' in Kconfig entries
Date:   Thu,  3 Dec 2020 18:04:53 +0100
Message-Id: <20201203170511.216407-2-sgarzare@redhat.com>
In-Reply-To: <20201203170511.216407-1-sgarzare@redhat.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'default n' is not necessary since it is already the default when
nothing is specified.

Suggested-by: Jason Wang <jasowang@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 6caf539091e5..2c892e890b9e 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -14,7 +14,6 @@ config VDPA_SIM
 	select DMA_OPS
 	select VHOST_RING
 	select GENERIC_NET_UTILS
-	default n
 	help
 	  vDPA networking device simulator which loop TX traffic back
 	  to RX. This device is used for testing, prototyping and
@@ -23,7 +22,6 @@ config VDPA_SIM
 config IFCVF
 	tristate "Intel IFC VF vDPA driver"
 	depends on PCI_MSI
-	default n
 	help
 	  This kernel module can drive Intel IFC VF NIC to offload
 	  virtio dataplane traffic to hardware.
@@ -42,7 +40,6 @@ config MLX5_VDPA_NET
 	tristate "vDPA driver for ConnectX devices"
 	select MLX5_VDPA
 	depends on MLX5_CORE
-	default n
 	help
 	  VDPA network driver for ConnectX6 and newer. Provides offloading
 	  of virtio net datapath such that descriptors put on the ring will
-- 
2.26.2

