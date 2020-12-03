Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAE12CDBCA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbgLCRGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:06:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38055 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726744AbgLCRGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607015121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=v1KF529Mba23/W7kJBq6xiW7t1MnwSejIHh9OVbZeTI=;
        b=Y9Ke9pE93efyo38WW2Ki78fnb4L2qjbexplqM4nvOqSZ56we6fEsLyURF9/o3FDqg9iqSi
        V6LcqwZp6ABtkCxpjOv17c1Ewsv0+Q6/sglzPq5zvBjlBD78tYrmkuWAPFlbq0lI7HTlQg
        cGKbyPnHJiZB90U3FHhQgutYpUwgaSo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-g15nm-3fP5uf8RSQQoMMbQ-1; Thu, 03 Dec 2020 12:05:17 -0500
X-MC-Unique: g15nm-3fP5uf8RSQQoMMbQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0224210054FF;
        Thu,  3 Dec 2020 17:05:15 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8269C5D6AC;
        Thu,  3 Dec 2020 17:05:12 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH v3 00/19] vdpa: generalize vdpa simulator
Date:   Thu,  3 Dec 2020 18:04:52 +0100
Message-Id: <20201203170511.216407-1-sgarzare@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series moves the network device simulator in a new module
(vdpa_sim_net) and leaves the generic functions in the vdpa_sim core
module, allowing the possibility to add new vDPA device simulators.

For now I removed the vdpa-blk simulator patches, since I'm still working
on them and debugging the iotlb issues.

Thanks to Max that started this work! I took his patches and extended a bit.

v1: https://lists.linuxfoundation.org/pipermail/virtualization/2020-November/050677.html
v2: https://lists.linuxfoundation.org/pipermail/virtualization/2020-November/051036.html

v3:
 - avoided to remove some headers with structures and functions directly
   used [Jason]
 - defined VHOST_IOTLB_UNLIMITED macro in vhost_iotlb.h [Jason]
 - added set_config callback in vdpasim_dev_attr [Jason]
 - cleared notify during reset [Jason]

Max Gurtovoy (2):
  vdpa_sim: remove hard-coded virtq count
  vdpa: split vdpasim to core and net modules

Stefano Garzarella (17):
  vdpa: remove unnecessary 'default n' in Kconfig entries
  vdpa_sim: remove unnecessary headers inclusion
  vhost/iotlb: add VHOST_IOTLB_UNLIMITED macro
  vdpa_sim: remove the limit of IOTLB entries
  vdpa_sim: rename vdpasim_config_ops variables
  vdpa_sim: add struct vdpasim_dev_attr for device attributes
  vdpa_sim: add device id field in vdpasim_dev_attr
  vdpa_sim: add supported_features field in vdpasim_dev_attr
  vdpa_sim: add work_fn in vdpasim_dev_attr
  vdpa_sim: store parsed MAC address in a buffer
  vdpa_sim: make 'config' generic and usable for any device type
  vdpa_sim: add get_config callback in vdpasim_dev_attr
  vdpa_sim: add set_config callback in vdpasim_dev_attr
  vdpa_sim: set vringh notify callback
  vdpa_sim: use kvmalloc to allocate vdpasim->buffer
  vdpa_sim: make vdpasim->buffer size configurable
  vdpa_sim: split vdpasim_virtqueue's iov field in out_iov and in_iov

 drivers/vdpa/vdpa_sim/vdpa_sim.h     | 105 ++++++++++
 include/linux/vhost_iotlb.h          |   2 +
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 301 +++++++--------------------
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 171 +++++++++++++++
 drivers/vhost/iotlb.c                |   3 +-
 drivers/vdpa/Kconfig                 |  16 +-
 drivers/vdpa/vdpa_sim/Makefile       |   1 +
 7 files changed, 368 insertions(+), 231 deletions(-)
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim.h
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_net.c

-- 
2.26.2

