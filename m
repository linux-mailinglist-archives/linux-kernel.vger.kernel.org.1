Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3169D2B1C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgKMNrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:47:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42048 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726160AbgKMNr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605275245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OfulPYTZhsoQhkiaVeD/pLg5PazzTZIGNLw9gLcaGuw=;
        b=fAJP26JWfpOdHMQJISDY6F14ZbbM1T8Xy1Ri015pn3GRvmZRYICTaSt3wGoBMVeUavZAYk
        8vEzFSRiJ5DpLOSELEjN2az5zQUMakFXwNtWGuzsBJH5WZ3lZj8PPs9P4LFgELZ6Ji+fzi
        YtHTnIw1YUUeLtxFp5EarAYVMk9/IJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-XlpqqaSlMveemIZAxuAuLA-1; Fri, 13 Nov 2020 08:47:23 -0500
X-MC-Unique: XlpqqaSlMveemIZAxuAuLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0B36809DC4;
        Fri, 13 Nov 2020 13:47:21 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-21.ams2.redhat.com [10.36.114.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEA8D60C84;
        Fri, 13 Nov 2020 13:47:13 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH RFC 00/12] vdpa: generalize vdpa simulator and add block device
Date:   Fri, 13 Nov 2020 14:47:00 +0100
Message-Id: <20201113134712.69744-1-sgarzare@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Max that started this work!
I took his patches, and extended the block simulator a bit.

This series moves the network device simulator in a new module
(vdpa_sim_net) and leaves the generic functions in the vdpa_sim core
module, allowing the possibility to add new vDPA device simulators.
Then we added a new vdpa_sim_blk module to simulate a block device.

I'm not sure about patch 11 ("vringh: allow vringh_iov_xfer() to skip
bytes when ptr is NULL"), maybe we can add a new functions instead of
modify vringh_iov_xfer().

As Max reported, I'm also seeing errors with vdpa_sim_blk related to
iotlb and vringh when there is high load, these are some of the error
messages I can see randomly:

  vringh: Failed to access avail idx at 00000000e8deb2cc
  vringh: Failed to read head: idx 6289 address 00000000e1ad1d50
  vringh: Failed to get flags at 000000006635d7a3

  virtio_vdpa vdpa0: vringh_iov_push_iotlb() error: -14 offset: 0x2840000 len: 0x20000
  virtio_vdpa vdpa0: vringh_iov_pull_iotlb() error: -14 offset: 0x58ee000 len: 0x3000

These errors should all be related to the fact that iotlb_translate()
fails with -EINVAL, so it seems that we miss some mapping.

I'll debug more carefully, in the meantime can you give a first review?

Thanks,
Stefano

Max Gurtovoy (4):
  vhost-vdpa: add support for vDPA blk devices
  vdpa: split vdpasim to core and net modules
  vdpa_sim: remove hard-coded virtq count
  vdpa: add vdpa simulator for block device

Stefano Garzarella (8):
  vdpa_sim: remove the limit of IOTLB entries
  vdpa_sim: add struct vdpasim_device to store device properties
  vdpa_sim: move config management outside of the core
  vdpa_sim: use kvmalloc to allocate vdpasim->buffer
  vdpa_sim: make vdpasim->buffer size configurable
  vdpa_sim: split vdpasim_virtqueue's iov field in riov and wiov
  vringh: allow vringh_iov_xfer() to skip bytes when ptr is NULL
  vdpa_sim_blk: implement ramdisk behaviour

 drivers/vdpa/vdpa_sim/vdpa_sim.h     | 117 +++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 283 +++++----------------------
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 251 ++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 172 ++++++++++++++++
 drivers/vhost/vdpa.c                 |  11 +-
 drivers/vhost/vringh.c               |  16 +-
 drivers/vdpa/Kconfig                 |  16 +-
 drivers/vdpa/vdpa_sim/Makefile       |   2 +
 8 files changed, 628 insertions(+), 240 deletions(-)
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim.h
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_net.c

-- 
2.26.2

