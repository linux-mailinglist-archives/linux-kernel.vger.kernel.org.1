Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673E8296B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460911AbgJWJBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42367 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S460858AbgJWJBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603443660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dkRMpWaUloTYnrKHXbZYIz2Z4yObRhEiBSWPNEaSME8=;
        b=b7MWXaQI0I7nPAvOnlgx+GYLhCa0AjaE5JACNh+lceOE9zgyuZd4OwUWdztUrhoe79Orla
        /DcEqLO/wO5LUNCqdz8bizOM346UwPxQJxXy/G50eKqfJX+mXQDTuJfyP9wL4up8jZSch2
        I+Jhu+Kl1stQUTLDE4s/Q/hx1Lsx/RY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-iRbf0L6kO-yDAxYr_W32GA-1; Fri, 23 Oct 2020 05:00:56 -0400
X-MC-Unique: iRbf0L6kO-yDAxYr_W32GA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48E64804B72;
        Fri, 23 Oct 2020 09:00:54 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-85.pek2.redhat.com [10.72.13.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2362D5B4C3;
        Fri, 23 Oct 2020 09:00:45 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH V4 0/3] vDPA: API for reporting IOVA range
Date:   Fri, 23 Oct 2020 17:00:40 +0800
Message-Id: <20201023090043.14430-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

This series introduces API for reporing IOVA range. This is a must for
userspace to work correclty:

- for the process that uses vhost-vDPA directly, the IOVA must be
  allocated from this range.
- for VM(qemu), when vIOMMU is not enabled, fail early if GPA is out
  of range
- for VM(qemu), when vIOMMU is enabled, determine a valid guest
  address width and then guest IOVA allocator can behave correctly.

Please review.

Changes from V3:

- really silent build warnings

Changes from V2:

- silent build warnings

Changes from V1:

- do not mandate get_iova_range() for device with its own DMA
  translation logic and assume a [0, ULLONG_MAX] range
- mandate IOVA range only for IOMMU that forcing aperture
- forbid the map which is out of the IOVA range in vhost-vDPA

Jason Wang (3):
  vdpa: introduce config op to get valid iova range
  vhost: vdpa: report iova range
  vdpa_sim: implement get_iova_range()

 drivers/vdpa/vdpa_sim/vdpa_sim.c | 12 ++++++++++
 drivers/vhost/vdpa.c             | 41 ++++++++++++++++++++++++++++++++
 include/linux/vdpa.h             | 15 ++++++++++++
 include/uapi/linux/vhost.h       |  4 ++++
 include/uapi/linux/vhost_types.h |  9 +++++++
 5 files changed, 81 insertions(+)

-- 
2.20.1

