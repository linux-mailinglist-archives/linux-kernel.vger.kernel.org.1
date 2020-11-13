Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0548F2B1F55
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgKMP5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:57:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37553 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726741AbgKMP5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605283037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=60wJj95OB0HMoxRPwUZqpPdQUOWeJPZmog9M4skpc20=;
        b=cmsxZnZvSI6I7bX5BjwduYPOy062CycFmIyLp5F8SQGh+XQcTGH/gqo4dZdiT3TVPiN0PG
        0lDMrKpWQyrRGMEx2Y/xnf+GXL/7e0t/2zcOU/KHI2dMsAHXrDl+e5D22f/wFMv7mwdqe2
        EJBQ9TMkDWSEMXks4fQRHVOGW+7oAl0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403--STiG3t2NrKA4VtThMO5tw-1; Fri, 13 Nov 2020 10:57:13 -0500
X-MC-Unique: -STiG3t2NrKA4VtThMO5tw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D357C1868401;
        Fri, 13 Nov 2020 15:57:12 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-113-83.ams2.redhat.com [10.36.113.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4364710013BD;
        Fri, 13 Nov 2020 15:57:08 +0000 (UTC)
From:   Laurent Vivier <lvivier@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] vdpasim: fix "mac_pton" undefined error
Date:   Fri, 13 Nov 2020 16:57:06 +0100
Message-Id: <20201113155706.599434-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

   ERROR: modpost: "mac_pton" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!

mac_pton() is defined in lib/net_utils.c and is not built if NET is not set.

Select GENERIC_NET_UTILS as vdpasim doesn't depend on NET.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/vdpa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index d7d32b656102..358f6048dd3c 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -13,6 +13,7 @@ config VDPA_SIM
 	depends on RUNTIME_TESTING_MENU && HAS_DMA
 	select DMA_OPS
 	select VHOST_RING
+	select GENERIC_NET_UTILS
 	default n
 	help
 	  vDPA networking device simulator which loop TX traffic back
-- 
2.28.0

