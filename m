Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48F823BE00
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 18:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgHDQVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 12:21:19 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:43838 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726011AbgHDQUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:20:55 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from eli@mellanox.com)
        with SMTP; 4 Aug 2020 19:20:51 +0300
Received: from nps-server-21.mtl.labs.mlnx (nps-server-21.mtl.labs.mlnx [10.237.240.120])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 074GKpau023986;
        Tue, 4 Aug 2020 19:20:51 +0300
Received: from nps-server-21.mtl.labs.mlnx (localhost [127.0.0.1])
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id 074GKpCL022632;
        Tue, 4 Aug 2020 19:20:51 +0300
Received: (from eli@localhost)
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id 074GKpkj022631;
        Tue, 4 Aug 2020 19:20:51 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com,
        Eli Cohen <eli@mellanox.com>
Subject: [PATCH V4 linux-next 00/12] VDPA support for Mellanox ConnectX devices
Date:   Tue,  4 Aug 2020 19:20:36 +0300
Message-Id: <20200804162048.22587-1-eli@mellanox.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,
please note that this series depends on mlx5 core device driver patches
in mlx5-next branch in
git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git.

git pull git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next 

They also depend Jason Wang's patches: https://lkml.org/lkml/2020/7/1/301

Jason, I had to resolve some conflicts so I would appreciate of you can verify
that it is ok.

The following series of patches provide VDPA support for Mellanox
devices. The supported devices are ConnectX6 DX and newer.

Currently, only a network driver is implemented; future patches will
introduce a block device driver. iperf performance on a single queue is
around 12 Gbps.  Future patches will introduce multi queue support.

The files are organized in such a way that code that can be used by
different VDPA implementations will be placed in a common are resides in
drivers/vdpa/mlx5/core.

Only virtual functions are currently supported. Also, certain firmware
capabilities must be set to enable the driver. Physical functions (PFs)
are skipped by the driver.

To make use of the VDPA net driver, one must load mlx5_vdpa. In such
case, VFs will be operated by the VDPA driver. Although one can see a
regular instance of a network driver on the VF, the VDPA driver takes
precedence over the NIC driver, steering-wize.

Currently, the device/interface infrastructure in mlx5_core is used to
probe drivers. Future patches will introduce virtbus as a means to
register devices and drivers and VDPA will be adapted to it.

The mlx5 mode of operation required to support VDPA is switchdev mode.
Once can use Linux or OVS bridge to take care of layer 2 switching.

In order to provide virtio networking to a guest, an updated version of
qemu is required. This version has been tested by the following quemu
version:

url: https://github.com/jasowang/qemu.git
branch: vdpa
Commit ID: 6f4e59b807db


V2->V3
Fix makefile to use include path relative to the root of the kernel

V3-V4
Rebase Jason's patches on linux-next branch
Fix krobot error on mips arch
Make use of the free callback to destroy resoruces on unload
Use VIRTIO_F_ACCESS_PLATFORM instead of legacy VIRTIO_F_IOMMU_PLATFORM
Add empty implementations for get_vq_notification() and get_vq_irq()


Eli Cohen (6):
  net/vdpa: Use struct for set/get vq state
  vdpa: Modify get_vq_state() to return error code
  vdpa/mlx5: Add hardware descriptive header file
  vdpa/mlx5: Add support library for mlx5 VDPA implementation
  vdpa/mlx5: Add shared memory registration code
  vdpa/mlx5: Add VDPA driver for supported mlx5 devices

Jason Wang (5):
  vhost-vdpa: refine ioctl pre-processing
  vhost: generialize backend features setting/getting
  vhost-vdpa: support get/set backend features
  vhost-vdpa: support IOTLB batching hints
  vdpasim: support batch updating

Max Gurtovoy (1):
  vdpa: remove hard coded virtq num

 drivers/vdpa/Kconfig                   |   19 +
 drivers/vdpa/Makefile                  |    1 +
 drivers/vdpa/ifcvf/ifcvf_base.c        |    4 +-
 drivers/vdpa/ifcvf/ifcvf_base.h        |    4 +-
 drivers/vdpa/ifcvf/ifcvf_main.c        |   13 +-
 drivers/vdpa/mlx5/Makefile             |    4 +
 drivers/vdpa/mlx5/core/mlx5_vdpa.h     |   91 ++
 drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h |  168 ++
 drivers/vdpa/mlx5/core/mr.c            |  484 ++++++
 drivers/vdpa/mlx5/core/resources.c     |  284 ++++
 drivers/vdpa/mlx5/net/main.c           |   76 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c      | 1965 ++++++++++++++++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.h      |   24 +
 drivers/vdpa/vdpa.c                    |    3 +
 drivers/vdpa/vdpa_sim/vdpa_sim.c       |   53 +-
 drivers/vhost/net.c                    |   18 +-
 drivers/vhost/vdpa.c                   |   76 +-
 drivers/vhost/vhost.c                  |   15 +
 drivers/vhost/vhost.h                  |    2 +
 include/linux/vdpa.h                   |   24 +-
 include/uapi/linux/vhost.h             |    2 +
 include/uapi/linux/vhost_types.h       |   11 +
 22 files changed, 3284 insertions(+), 57 deletions(-)
 create mode 100644 drivers/vdpa/mlx5/Makefile
 create mode 100644 drivers/vdpa/mlx5/core/mlx5_vdpa.h
 create mode 100644 drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h
 create mode 100644 drivers/vdpa/mlx5/core/mr.c
 create mode 100644 drivers/vdpa/mlx5/core/resources.c
 create mode 100644 drivers/vdpa/mlx5/net/main.c
 create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.c
 create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h

-- 
2.26.0

