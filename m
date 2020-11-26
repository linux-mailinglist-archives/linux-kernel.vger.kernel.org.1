Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18B82C576A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 15:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391068AbgKZOuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 09:50:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39143 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728017AbgKZOuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 09:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606402204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SVVxBNARCD8CQXWqDsuH/lbOEODOsgmpqioxX0mWgfM=;
        b=VM+EhKs8lnazn+xMSFcm1A+T/3qI/TM/8c6ZnXeNVmdrcsGkfOUjDrr6XT/EevpHHWNczc
        j1/8V2FFzKelYODnoWud6L2kjSBqC+/TyJ1uDTk8Pj/PfoIs8KvngNcn+Xgj4KzvFQ/PlZ
        lkwHL/9fAsJo3tiQpH5Shp5cjaIe/lw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-awRmv38SP1ms0WxvC9UiGg-1; Thu, 26 Nov 2020 09:50:01 -0500
X-MC-Unique: awRmv38SP1ms0WxvC9UiGg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 788759A229;
        Thu, 26 Nov 2020 14:49:59 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-252.ams2.redhat.com [10.36.113.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FB2B19C66;
        Thu, 26 Nov 2020 14:49:51 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 00/17] vdpa: generalize vdpa simulator
Date:   Thu, 26 Nov 2020 15:49:33 +0100
Message-Id: <20201126144950.92850-1-sgarzare@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series moves the network device simulator in a new module
(vdpa_sim_net) and leaves the generic functions in the vdpa_sim core
module, allowing the possibility to add new vDPA device simulators.

For now I removed the vdpa-blk simulator patches, since I'm still working
on them and debugging the iotlb issues.

Thanks to Max that started this work! I took his patches and extended a bit.

As Jason suggested, I simplified the "vdpa: split vdpasim to core and
net modules" patch, moving some changes out in small patches.
@Max: I put your Co-developed-by and Signed-off-by tags on these patches,
let me know if it is okay for you, or if there is a better way to give
credit to your work!

v1: https://lists.linuxfoundation.org/pipermail/virtualization/2020-November/050677.html

v2:
  - moved most of the patches before the vdpa-core/net split [Jason]
  - removed unnecessary headers
  - removed 'default n' in Kconfig entries [Jason]
  - added VDPASIM_IOTLB_LIMIT macro [Jason]
  - set vringh notify callback [Jason]
  - used VIRTIO terminology for in_iov/out_iov [Stefan]
  - simplified "vdpa: split vdpasim to core and net modules" patch,
    moving some changes out in small patches
  - left batch_mapping module parameter in the core [Jason]

Max Gurtovoy (2):
  vdpa_sim: remove hard-coded virtq count
  vdpa: split vdpasim to core and net modules

Stefano Garzarella (15):
  vdpa: remove unnecessary 'default n' in Kconfig entries
  vdpa_sim: remove unnecessary headers inclusion
  vdpa_sim: remove the limit of IOTLB entries
  vdpa_sim: rename vdpasim_config_ops variables
  vdpa_sim: add struct vdpasim_dev_attr for device attributes
  vdpa_sim: add device id field in vdpasim_dev_attr
  vdpa_sim: add supported_features field in vdpasim_dev_attr
  vdpa_sim: add work_fn in vdpasim_dev_attr
  vdpa_sim: store parsed MAC address in a buffer
  vdpa_sim: make 'config' generic and usable for any device type
  vdpa_sim: add get_config callback in vdpasim_dev_attr
  vdpa_sim: set vringh notify callback
  vdpa_sim: use kvmalloc to allocate vdpasim->buffer
  vdpa_sim: make vdpasim->buffer size configurable
  vdpa_sim: split vdpasim_virtqueue's iov field in out_iov and in_iov

 drivers/vdpa/vdpa_sim/vdpa_sim.h     | 103 ++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 290 +++++++--------------------
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 171 ++++++++++++++++
 drivers/vdpa/Kconfig                 |  16 +-
 drivers/vdpa/vdpa_sim/Makefile       |   1 +
 5 files changed, 351 insertions(+), 230 deletions(-)
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim.h
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_net.c

-- 
2.26.2

