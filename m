Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E852C2A1E36
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 14:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgKANLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 08:11:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgKANLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 08:11:12 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DF6B2223F;
        Sun,  1 Nov 2020 13:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604236270;
        bh=FREsYtUy2vZibm7LZOzOV4Q3JWNgx9oDWfTbFS0qFVg=;
        h=Date:From:To:Cc:Subject:From;
        b=CGQtz7MoQauJ6Z/4uTJF/i0sLMNF3xqQSDAAaxpDw5r6QQMU2ysQFJN3Ub5Q2izv/
         FgAitm26YZ8b0TCpryx67iFfkpui75FvPVN56OwfYfasBHs4Gao97TARwDoinF7Udb
         cWiQb27GDRj9JdtrDcE03YZhooX9h6sJNBzhKSow=
Date:   Sun, 1 Nov 2020 14:11:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes/removals for 5.10-rc2
Message-ID: <20201101131153.GA31235@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.10-rc2

for you to fetch changes up to d1b35d66f48f926062dc81134ebd8ab93d71e61d:

  Merge tag 'icc-5.10-rc2' of https://git.linaro.org/people/georgi.djakov/linux into char-misc-linus (2020-10-30 13:25:58 +0100)

----------------------------------------------------------------
Char/Misc fixes/removals for 5.10-rc2

Here's some small fixes for 5.10-rc2 and a big driver removal.

The fixes are for some reported issues in the interconnect and coresight
drivers, nothing major.

The "big" driver removal is the MIC drivers have been asked to be
removed as the hardware never shipped and Intel no longer wants to
maintain something that no one can use.  This is welcomed by many as the
DMA usage of these drivers was "interesting" and the security people
were starting to question some issues that were starting to be found in
the codebase.

Note, one of the subsystems for this driver, the "VOP" code, will
probably come back in future kernel versions as it was looking to
potentially solve some PCIe virtualization issues that a number of other
vendors were wanting to solve.  But as-is, this codebase didn't work for
anyone else so no actual functionality is being removed.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      coresight: add module license

Dmitry Baryshkov (1):
      interconnect: qcom: use icc_sync state for sm8[12]50

Georgi Djakov (5):
      interconnect: qcom: sdm845: Enable keepalive for the MM1 BCM
      interconnect: Aggregate before setting initial bandwidth
      interconnect: qcom: sdm845: Init BCMs before creating the nodes
      interconnect: qcom: sc7180: Init BCMs before creating the nodes
      interconnect: qcom: Ensure that the floor bandwidth value is enforced

Greg Kroah-Hartman (1):
      Merge tag 'icc-5.10-rc2' of https://git.linaro.org/people/georgi.djakov/linux into char-misc-linus

Mike Leach (1):
      coresight: Fix uninitialised pointer bug in etm_setup_aux()

Sudeep Dutt (1):
      misc: mic: remove the MIC drivers

Suzuki K Poulose (1):
      coresight: cti: Initialize dynamic sysfs attributes

 Documentation/misc-devices/mic/index.rst          |   16 -
 Documentation/misc-devices/mic/mic_overview.rst   |   85 -
 Documentation/misc-devices/mic/scif_overview.rst  |  108 --
 MAINTAINERS                                       |   16 -
 drivers/dma/Kconfig                               |   18 -
 drivers/dma/Makefile                              |    1 -
 drivers/dma/mic_x100_dma.c                        |  770 --------
 drivers/dma/mic_x100_dma.h                        |  275 ---
 drivers/hwtracing/coresight/coresight-core.c      |    1 +
 drivers/hwtracing/coresight/coresight-cti-sysfs.c |    7 +
 drivers/hwtracing/coresight/coresight-etm-perf.c  |    2 +-
 drivers/interconnect/core.c                       |    3 +
 drivers/interconnect/qcom/icc-rpmh.c              |    7 +
 drivers/interconnect/qcom/sc7180.c                |    6 +-
 drivers/interconnect/qcom/sdm845.c                |    8 +-
 drivers/interconnect/qcom/sm8150.c                |    7 +-
 drivers/interconnect/qcom/sm8250.c                |    7 +-
 drivers/misc/Kconfig                              |    1 -
 drivers/misc/Makefile                             |    1 -
 drivers/misc/mic/Kconfig                          |  141 --
 drivers/misc/mic/Makefile                         |   12 -
 drivers/misc/mic/bus/Makefile                     |    9 -
 drivers/misc/mic/bus/cosm_bus.c                   |  130 --
 drivers/misc/mic/bus/cosm_bus.h                   |  125 --
 drivers/misc/mic/bus/mic_bus.c                    |  194 ---
 drivers/misc/mic/bus/scif_bus.c                   |  201 ---
 drivers/misc/mic/bus/scif_bus.h                   |  125 --
 drivers/misc/mic/bus/vop_bus.c                    |  194 ---
 drivers/misc/mic/bus/vop_bus.h                    |  129 --
 drivers/misc/mic/card/Makefile                    |   11 -
 drivers/misc/mic/card/mic_debugfs.c               |   85 -
 drivers/misc/mic/card/mic_device.c                |  417 -----
 drivers/misc/mic/card/mic_device.h                |  137 --
 drivers/misc/mic/card/mic_x100.c                  |  347 ----
 drivers/misc/mic/card/mic_x100.h                  |   37 -
 drivers/misc/mic/common/mic_dev.h                 |   55 -
 drivers/misc/mic/cosm/Makefile                    |   11 -
 drivers/misc/mic/cosm/cosm_debugfs.c              |  116 --
 drivers/misc/mic/cosm/cosm_main.c                 |  382 ----
 drivers/misc/mic/cosm/cosm_main.h                 |   61 -
 drivers/misc/mic/cosm/cosm_scif_server.c          |  399 -----
 drivers/misc/mic/cosm/cosm_sysfs.c                |  449 -----
 drivers/misc/mic/cosm_client/Makefile             |    8 -
 drivers/misc/mic/cosm_client/cosm_scif_client.c   |  269 ---
 drivers/misc/mic/host/Makefile                    |   12 -
 drivers/misc/mic/host/mic_boot.c                  |  588 -------
 drivers/misc/mic/host/mic_debugfs.c               |  149 --
 drivers/misc/mic/host/mic_device.h                |  157 --
 drivers/misc/mic/host/mic_intr.c                  |  635 -------
 drivers/misc/mic/host/mic_intr.h                  |  137 --
 drivers/misc/mic/host/mic_main.c                  |  335 ----
 drivers/misc/mic/host/mic_smpt.c                  |  427 -----
 drivers/misc/mic/host/mic_smpt.h                  |   87 -
 drivers/misc/mic/host/mic_x100.c                  |  585 -------
 drivers/misc/mic/host/mic_x100.h                  |   77 -
 drivers/misc/mic/scif/Makefile                    |   21 -
 drivers/misc/mic/scif/scif_api.c                  | 1485 ----------------
 drivers/misc/mic/scif/scif_debugfs.c              |  116 --
 drivers/misc/mic/scif/scif_dma.c                  | 1940 ---------------------
 drivers/misc/mic/scif/scif_epd.c                  |  357 ----
 drivers/misc/mic/scif/scif_epd.h                  |  200 ---
 drivers/misc/mic/scif/scif_fd.c                   |  462 -----
 drivers/misc/mic/scif/scif_fence.c                |  783 ---------
 drivers/misc/mic/scif/scif_main.c                 |  351 ----
 drivers/misc/mic/scif/scif_main.h                 |  274 ---
 drivers/misc/mic/scif/scif_map.h                  |  127 --
 drivers/misc/mic/scif/scif_mmap.c                 |  690 --------
 drivers/misc/mic/scif/scif_nm.c                   |  229 ---
 drivers/misc/mic/scif/scif_nodeqp.c               | 1349 --------------
 drivers/misc/mic/scif/scif_nodeqp.h               |  221 ---
 drivers/misc/mic/scif/scif_peer_bus.c             |  175 --
 drivers/misc/mic/scif/scif_peer_bus.h             |   23 -
 drivers/misc/mic/scif/scif_ports.c                |  116 --
 drivers/misc/mic/scif/scif_rb.c                   |  240 ---
 drivers/misc/mic/scif/scif_rb.h                   |  100 --
 drivers/misc/mic/scif/scif_rma.c                  | 1760 -------------------
 drivers/misc/mic/scif/scif_rma.h                  |  477 -----
 drivers/misc/mic/scif/scif_rma_list.c             |  282 ---
 drivers/misc/mic/scif/scif_rma_list.h             |   48 -
 drivers/misc/mic/vop/Makefile                     |   10 -
 drivers/misc/mic/vop/vop_debugfs.c                |  184 --
 drivers/misc/mic/vop/vop_main.c                   |  784 ---------
 drivers/misc/mic/vop/vop_main.h                   |  158 --
 drivers/misc/mic/vop/vop_vringh.c                 | 1166 -------------
 include/linux/mic_bus.h                           |  100 --
 include/linux/scif.h                              | 1339 --------------
 include/uapi/linux/mic_common.h                   |  235 ---
 include/uapi/linux/mic_ioctl.h                    |   77 -
 samples/mic/mpssd/.gitignore                      |    2 -
 samples/mic/mpssd/Makefile                        |   28 -
 samples/mic/mpssd/micctrl                         |  162 --
 samples/mic/mpssd/mpss                            |  189 --
 samples/mic/mpssd/mpssd.c                         | 1815 -------------------
 samples/mic/mpssd/mpssd.h                         |   89 -
 samples/mic/mpssd/sysfs.c                         |   91 -
 95 files changed, 34 insertions(+), 26793 deletions(-)
 delete mode 100644 Documentation/misc-devices/mic/index.rst
 delete mode 100644 Documentation/misc-devices/mic/mic_overview.rst
 delete mode 100644 Documentation/misc-devices/mic/scif_overview.rst
 delete mode 100644 drivers/dma/mic_x100_dma.c
 delete mode 100644 drivers/dma/mic_x100_dma.h
 delete mode 100644 drivers/misc/mic/Kconfig
 delete mode 100644 drivers/misc/mic/Makefile
 delete mode 100644 drivers/misc/mic/bus/Makefile
 delete mode 100644 drivers/misc/mic/bus/cosm_bus.c
 delete mode 100644 drivers/misc/mic/bus/cosm_bus.h
 delete mode 100644 drivers/misc/mic/bus/mic_bus.c
 delete mode 100644 drivers/misc/mic/bus/scif_bus.c
 delete mode 100644 drivers/misc/mic/bus/scif_bus.h
 delete mode 100644 drivers/misc/mic/bus/vop_bus.c
 delete mode 100644 drivers/misc/mic/bus/vop_bus.h
 delete mode 100644 drivers/misc/mic/card/Makefile
 delete mode 100644 drivers/misc/mic/card/mic_debugfs.c
 delete mode 100644 drivers/misc/mic/card/mic_device.c
 delete mode 100644 drivers/misc/mic/card/mic_device.h
 delete mode 100644 drivers/misc/mic/card/mic_x100.c
 delete mode 100644 drivers/misc/mic/card/mic_x100.h
 delete mode 100644 drivers/misc/mic/common/mic_dev.h
 delete mode 100644 drivers/misc/mic/cosm/Makefile
 delete mode 100644 drivers/misc/mic/cosm/cosm_debugfs.c
 delete mode 100644 drivers/misc/mic/cosm/cosm_main.c
 delete mode 100644 drivers/misc/mic/cosm/cosm_main.h
 delete mode 100644 drivers/misc/mic/cosm/cosm_scif_server.c
 delete mode 100644 drivers/misc/mic/cosm/cosm_sysfs.c
 delete mode 100644 drivers/misc/mic/cosm_client/Makefile
 delete mode 100644 drivers/misc/mic/cosm_client/cosm_scif_client.c
 delete mode 100644 drivers/misc/mic/host/Makefile
 delete mode 100644 drivers/misc/mic/host/mic_boot.c
 delete mode 100644 drivers/misc/mic/host/mic_debugfs.c
 delete mode 100644 drivers/misc/mic/host/mic_device.h
 delete mode 100644 drivers/misc/mic/host/mic_intr.c
 delete mode 100644 drivers/misc/mic/host/mic_intr.h
 delete mode 100644 drivers/misc/mic/host/mic_main.c
 delete mode 100644 drivers/misc/mic/host/mic_smpt.c
 delete mode 100644 drivers/misc/mic/host/mic_smpt.h
 delete mode 100644 drivers/misc/mic/host/mic_x100.c
 delete mode 100644 drivers/misc/mic/host/mic_x100.h
 delete mode 100644 drivers/misc/mic/scif/Makefile
 delete mode 100644 drivers/misc/mic/scif/scif_api.c
 delete mode 100644 drivers/misc/mic/scif/scif_debugfs.c
 delete mode 100644 drivers/misc/mic/scif/scif_dma.c
 delete mode 100644 drivers/misc/mic/scif/scif_epd.c
 delete mode 100644 drivers/misc/mic/scif/scif_epd.h
 delete mode 100644 drivers/misc/mic/scif/scif_fd.c
 delete mode 100644 drivers/misc/mic/scif/scif_fence.c
 delete mode 100644 drivers/misc/mic/scif/scif_main.c
 delete mode 100644 drivers/misc/mic/scif/scif_main.h
 delete mode 100644 drivers/misc/mic/scif/scif_map.h
 delete mode 100644 drivers/misc/mic/scif/scif_mmap.c
 delete mode 100644 drivers/misc/mic/scif/scif_nm.c
 delete mode 100644 drivers/misc/mic/scif/scif_nodeqp.c
 delete mode 100644 drivers/misc/mic/scif/scif_nodeqp.h
 delete mode 100644 drivers/misc/mic/scif/scif_peer_bus.c
 delete mode 100644 drivers/misc/mic/scif/scif_peer_bus.h
 delete mode 100644 drivers/misc/mic/scif/scif_ports.c
 delete mode 100644 drivers/misc/mic/scif/scif_rb.c
 delete mode 100644 drivers/misc/mic/scif/scif_rb.h
 delete mode 100644 drivers/misc/mic/scif/scif_rma.c
 delete mode 100644 drivers/misc/mic/scif/scif_rma.h
 delete mode 100644 drivers/misc/mic/scif/scif_rma_list.c
 delete mode 100644 drivers/misc/mic/scif/scif_rma_list.h
 delete mode 100644 drivers/misc/mic/vop/Makefile
 delete mode 100644 drivers/misc/mic/vop/vop_debugfs.c
 delete mode 100644 drivers/misc/mic/vop/vop_main.c
 delete mode 100644 drivers/misc/mic/vop/vop_main.h
 delete mode 100644 drivers/misc/mic/vop/vop_vringh.c
 delete mode 100644 include/linux/mic_bus.h
 delete mode 100644 include/linux/scif.h
 delete mode 100644 include/uapi/linux/mic_common.h
 delete mode 100644 include/uapi/linux/mic_ioctl.h
 delete mode 100644 samples/mic/mpssd/.gitignore
 delete mode 100644 samples/mic/mpssd/Makefile
 delete mode 100755 samples/mic/mpssd/micctrl
 delete mode 100755 samples/mic/mpssd/mpss
 delete mode 100644 samples/mic/mpssd/mpssd.c
 delete mode 100644 samples/mic/mpssd/mpssd.h
 delete mode 100644 samples/mic/mpssd/sysfs.c
