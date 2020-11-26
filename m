Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36A82C511D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 10:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389294AbgKZJ0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 04:26:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727697AbgKZJ0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 04:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606382777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ajh+x3DZkFmZhugWamZSP0S5ccCCc1J42IKCKoIb76E=;
        b=ixDOBSmdwJatxZ8bSIShI4tMm2cMITangWTAwoqagk8+RRaCxdLBLgKSbYKRUSd1PUV0ip
        +l17wFUdzb0GNGJu1RtWQhFfJn7QA8/oQ1AY2uB6Itc09SaVRHiVwPnZcx8JPpsD/vWsIW
        PuAYXdQCDpuK7nb6i+Q13gNMTKjBC7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-JpnmtnoZPXC_uwgqXzjNhQ-1; Thu, 26 Nov 2020 04:26:13 -0500
X-MC-Unique: JpnmtnoZPXC_uwgqXzjNhQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3084F185E495;
        Thu, 26 Nov 2020 09:26:12 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-213.pek2.redhat.com [10.72.13.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45C5F19C78;
        Thu, 26 Nov 2020 09:26:06 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com
Subject: [PATCH V2 00/14] vDPA driver for virtio-pci device
Date:   Thu, 26 Nov 2020 17:25:50 +0800
Message-Id: <20201126092604.208033-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

This series tries to implement a vDPA driver for virtio-pci device
which will bridge between vDPA bus and virtio-pci device.

This could be used for future feature prototyping and testing.

Please review

Changes from V1:

- Split common codes from virito-pci and share it with vDPA driver
- Use dynamic id in order to be less confusing with virtio-pci driver
- No feature whitelist, supporting any features (mq, config etc)

Thanks

Jason Wang (14):
  virtio-pci: do not access iomem via virtio_pci_device directly
  virtio-pci: switch to use devres for modern devices
  virtio-pci: split out modern device
  virtio-pci: move the notification sanity check to vp_modern_probe()
  virtio-pci-modern: introduce vp_modern_set_queue_vector()
  virtio-pci-modern: introduce vp_modern_queue_address()
  virtio-pci-modern: introduce helper to set/get queue_enable
  virtio-pci-modern: introduce helper for setting/geting queue size
  virtio-pci-modern: introduce helper for getting queue nums
  virtio-pci-modern: introduce helper to get notification offset
  virtio-pci: introduce modern device module
  vdpa: set the virtqueue num during register
  virtio_vdpa: don't warn when fail to disable vq
  vdpa: introduce virtio pci driver

 drivers/vdpa/Kconfig                   |   6 +
 drivers/vdpa/Makefile                  |   1 +
 drivers/vdpa/ifcvf/ifcvf_main.c        |   5 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c      |   5 +-
 drivers/vdpa/vdpa.c                    |   8 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c       |   4 +-
 drivers/vdpa/virtio_pci/Makefile       |   2 +
 drivers/vdpa/virtio_pci/vp_vdpa.c      | 450 ++++++++++++++++++++++++
 drivers/virtio/Kconfig                 |  10 +-
 drivers/virtio/Makefile                |   1 +
 drivers/virtio/virtio_pci_common.c     |  10 -
 drivers/virtio/virtio_pci_common.h     |  23 +-
 drivers/virtio/virtio_pci_legacy.c     |  13 +-
 drivers/virtio/virtio_pci_modern.c     | 442 +++--------------------
 drivers/virtio/virtio_pci_modern_dev.c | 462 +++++++++++++++++++++++++
 drivers/virtio/virtio_vdpa.c           |   3 +-
 include/linux/vdpa.h                   |   7 +-
 include/linux/virtio_pci_modern.h      | 107 ++++++
 18 files changed, 1121 insertions(+), 438 deletions(-)
 create mode 100644 drivers/vdpa/virtio_pci/Makefile
 create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa.c
 create mode 100644 drivers/virtio/virtio_pci_modern_dev.c
 create mode 100644 include/linux/virtio_pci_modern.h

-- 
2.25.1

