Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCBA2DAF3B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgLOOpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:45:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45367 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729389AbgLOOoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:44:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608043392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NjtP5kq/MzDamVzvIR793DL1opN4RaPFR8Dwu/WLx1o=;
        b=UuTXGA8opIW68kKfYz1TQuljvf9K75Pm22iaQyzKhva8SwgHW5Z9pd1qQZ89eT3O5Zjz0Y
        sKaWGXzRA84KEZCzUoBXVi9uOCWhICaNd7h7FrqTwQY23iT2jU/oulQvBk1HPuo0zvejLc
        7mGAwRmjZ5z1BYrKOal8aT4VVp8LLzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-xnbRHywLMUiWh9jD8vIZ4g-1; Tue, 15 Dec 2020 09:43:08 -0500
X-MC-Unique: xnbRHywLMUiWh9jD8vIZ4g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C156F184214C;
        Tue, 15 Dec 2020 14:43:06 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-115-49.ams2.redhat.com [10.36.115.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D13D100164C;
        Tue, 15 Dec 2020 14:42:56 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Oren Duer <oren@nvidia.com>, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shahaf Shuler <shahafs@nvidia.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 00/18] vdpa: generalize vdpa simulator
Date:   Tue, 15 Dec 2020 15:42:38 +0100
Message-Id: <20201215144256.155342-1-sgarzare@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
v3: https://lists.linuxfoundation.org/pipermail/virtualization/2020-December/051195.html

v4:
 - rebased on Linux v5.10
 - checked better which headers are not directly used [Randy]
 - removed patches that set unlimited iotlb and added a module
   parameter [Jason]
 - explained in the commit message that .get_config stuff moving
   is safe [Jason]
 - fixed typo in Kconfig (s/loop/loops) [Randy]

Max Gurtovoy (2):
  vdpa_sim: remove hard-coded virtq count
  vdpa: split vdpasim to core and net modules

Stefano Garzarella (16):
  vdpa: remove unnecessary 'default n' in Kconfig entries
  vdpa_sim: remove unnecessary headers inclusion
  vdpa_sim: make IOTLB entries limit configurable
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
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 298 ++++++++-------------------
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 177 ++++++++++++++++
 drivers/vdpa/Kconfig                 |  16 +-
 drivers/vdpa/vdpa_sim/Makefile       |   1 +
 5 files changed, 374 insertions(+), 223 deletions(-)
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim.h
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_net.c

-- 
2.26.2

