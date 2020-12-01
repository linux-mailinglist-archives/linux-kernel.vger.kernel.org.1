Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0CD2CB031
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 23:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgLAWg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 17:36:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:7589 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgLAWgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 17:36:55 -0500
IronPort-SDR: 7hI9ZnJ1rsPWHjld8QgRtjJMpMfy77ZZlMXncBAXT6HSWTgZgJEjEMnDQHrvC5HD/s96LowsYB
 nhpmb/WtIX0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="234524372"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="234524372"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 14:35:14 -0800
IronPort-SDR: gqM72U/P+ChdzAuFnAWxtzURl1j2mwLhcaubquZNoxq7tzQ9iaiFQhpNs1A49Hmhan85TfMzUw
 RgrQEN1NovxA==
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="330196242"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 14:35:14 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id 263C76363;
        Tue,  1 Dec 2020 14:35:14 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kkEEr-000H4E-Q8; Tue, 01 Dec 2020 14:35:14 -0800
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 00/22] Intel Vision Processing Unit base enabling part 1
Date:   Tue,  1 Dec 2020 14:34:49 -0800
Message-Id: <20201201223511.65542-1-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: mark gross <mgross@linux.intel.com>

The Intel Vision Processing Unit (VPU) is an IP block that is showing up for
the first time as part of the Keem Bay SOC.  Keem Bay is a quad core A53 Arm
SOC.  It is designed to be used as a stand alone SOC as well as in an PCIe
Vision Processing accelerator add in card.

This part 1 of the patches make up the base or core of the stack needed to
enable both use cases for the VPU.

Part 2 includes 11 more patches that depend on part 1.  Those should be ready
in a couple of weeks or less.

I am trying something a bit new with this sequence where I've been working with
the driver developers as a "pre-maintainer" reviewing and enforcing the kernel
expectations as I understand them.  Its taken a couple of months to get this
code to the point I feel its ready for public posting.  My goal is to make sure
it meets expectations for quality and compliance with kernel expectations and
there will be mostly technical / design issues to talk about.

Thanks for looking at these and providing feedback.

--mark
p.s. I have had a problem my MTA configuration between mutt and git send-email
where I was using msmpt to send from mutt (because 15+ years ago its the first
way I got to work and never changed) while my worstation MTA that git
send-email uses was un-configured resulting in my return-path naming my
workstion withing the firewall.  I suck at email administration.

I appologies for the multiple copies.

P.p.s.  corrected cc listings.

Daniele Alessandrelli (2):
  dt-bindings: Add bindings for Keem Bay IPC driver
  keembay-ipc: Add Keem Bay IPC module

Paul Murphy (2):
  dt-bindings: Add bindings for Keem Bay VPU IPC driver
  keembay-vpu-ipc: Add Keem Bay VPU IPC module

Seamus Kelly (8):
  xlink-ipc: Add xlink ipc device tree bindings
  xlink-ipc: Add xlink ipc driver
  xlink-core: Add xlink core device tree bindings
  xlink-core: Add xlink core driver xLink
  xlink-core: Enable xlink protocol over pcie
  xlink-core: Enable VPU IP management and runtime control
  xlink-core: add async channel and events
  xlink-core: factorize xlink_ioctl function by creating sub-functions
    for each ioctl command

Srikanth Thokala (9):
  misc: xlink-pcie: Add documentation for XLink PCIe driver
  misc: xlink-pcie: lh: Add PCIe EPF driver for Local Host
  misc: xlink-pcie: lh: Add PCIe EP DMA functionality
  misc: xlink-pcie: lh: Add core communication logic
  misc: xlink-pcie: lh: Prepare changes for adding remote host driver
  misc: xlink-pcie: rh: Add PCIe EP driver for Remote Host
  misc: xlink-pcie: rh: Add core communication logic
  misc: xlink-pcie: Add XLink API interface
  misc: xlink-pcie: Add asynchronous event notification support for
    XLink

mark gross (1):
  Add Vision Processing Unit (VPU) documentation.

 .../misc/intel,keembay-xlink-ipc.yaml         |   49 +
 .../bindings/misc/intel,keembay-xlink.yaml    |   27 +
 .../bindings/soc/intel/intel,keembay-ipc.yaml |   63 +
 .../soc/intel/intel,keembay-vpu-ipc.yaml      |  151 ++
 Documentation/index.rst                       |    3 +-
 Documentation/vpu/index.rst                   |   19 +
 Documentation/vpu/vpu-stack-overview.rst      |  267 +++
 Documentation/vpu/xlink-core.rst              |   80 +
 Documentation/vpu/xlink-ipc.rst               |   50 +
 Documentation/vpu/xlink-pcie.rst              |   91 +
 MAINTAINERS                                   |   41 +
 drivers/misc/Kconfig                          |    3 +
 drivers/misc/Makefile                         |    3 +
 drivers/misc/xlink-core/Kconfig               |   33 +
 drivers/misc/xlink-core/Makefile              |    5 +
 drivers/misc/xlink-core/xlink-core.c          | 1335 +++++++++++
 drivers/misc/xlink-core/xlink-core.h          |   24 +
 drivers/misc/xlink-core/xlink-defs.h          |  181 ++
 drivers/misc/xlink-core/xlink-dispatcher.c    |  436 ++++
 drivers/misc/xlink-core/xlink-dispatcher.h    |   26 +
 drivers/misc/xlink-core/xlink-ioctl.c         |  584 +++++
 drivers/misc/xlink-core/xlink-ioctl.h         |   36 +
 drivers/misc/xlink-core/xlink-multiplexer.c   | 1164 ++++++++++
 drivers/misc/xlink-core/xlink-multiplexer.h   |   35 +
 drivers/misc/xlink-core/xlink-platform.c      |  273 +++
 drivers/misc/xlink-core/xlink-platform.h      |   65 +
 drivers/misc/xlink-ipc/Kconfig                |    7 +
 drivers/misc/xlink-ipc/Makefile               |    4 +
 drivers/misc/xlink-ipc/xlink-ipc.c            |  879 +++++++
 drivers/misc/xlink-pcie/Kconfig               |   20 +
 drivers/misc/xlink-pcie/Makefile              |    2 +
 drivers/misc/xlink-pcie/common/core.h         |  247 ++
 drivers/misc/xlink-pcie/common/interface.c    |  126 +
 drivers/misc/xlink-pcie/common/util.c         |  375 +++
 drivers/misc/xlink-pcie/common/util.h         |   70 +
 drivers/misc/xlink-pcie/common/xpcie.h        |  120 +
 drivers/misc/xlink-pcie/local_host/Makefile   |    6 +
 drivers/misc/xlink-pcie/local_host/core.c     |  905 ++++++++
 drivers/misc/xlink-pcie/local_host/dma.c      |  577 +++++
 drivers/misc/xlink-pcie/local_host/epf.c      |  523 +++++
 drivers/misc/xlink-pcie/local_host/epf.h      |  106 +
 drivers/misc/xlink-pcie/remote_host/Makefile  |    6 +
 drivers/misc/xlink-pcie/remote_host/core.c    |  647 ++++++
 drivers/misc/xlink-pcie/remote_host/main.c    |   96 +
 drivers/misc/xlink-pcie/remote_host/pci.c     |  525 +++++
 drivers/misc/xlink-pcie/remote_host/pci.h     |   67 +
 drivers/soc/Kconfig                           |    1 +
 drivers/soc/Makefile                          |    1 +
 drivers/soc/intel/Kconfig                     |   32 +
 drivers/soc/intel/Makefile                    |    5 +
 drivers/soc/intel/keembay-ipc.c               | 1669 ++++++++++++++
 drivers/soc/intel/keembay-vpu-ipc.c           | 2036 +++++++++++++++++
 include/linux/soc/intel/keembay-ipc.h         |   30 +
 include/linux/soc/intel/keembay-vpu-ipc.h     |   62 +
 include/linux/xlink-ipc.h                     |   48 +
 include/linux/xlink.h                         |  146 ++
 include/linux/xlink_drv_inf.h                 |   72 +
 include/uapi/misc/xlink_uapi.h                |  145 ++
 58 files changed, 14598 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml
 create mode 100644 Documentation/vpu/index.rst
 create mode 100644 Documentation/vpu/vpu-stack-overview.rst
 create mode 100644 Documentation/vpu/xlink-core.rst
 create mode 100644 Documentation/vpu/xlink-ipc.rst
 create mode 100644 Documentation/vpu/xlink-pcie.rst
 create mode 100644 drivers/misc/xlink-core/Kconfig
 create mode 100644 drivers/misc/xlink-core/Makefile
 create mode 100644 drivers/misc/xlink-core/xlink-core.c
 create mode 100644 drivers/misc/xlink-core/xlink-core.h
 create mode 100644 drivers/misc/xlink-core/xlink-defs.h
 create mode 100644 drivers/misc/xlink-core/xlink-dispatcher.c
 create mode 100644 drivers/misc/xlink-core/xlink-dispatcher.h
 create mode 100644 drivers/misc/xlink-core/xlink-ioctl.c
 create mode 100644 drivers/misc/xlink-core/xlink-ioctl.h
 create mode 100644 drivers/misc/xlink-core/xlink-multiplexer.c
 create mode 100644 drivers/misc/xlink-core/xlink-multiplexer.h
 create mode 100644 drivers/misc/xlink-core/xlink-platform.c
 create mode 100644 drivers/misc/xlink-core/xlink-platform.h
 create mode 100644 drivers/misc/xlink-ipc/Kconfig
 create mode 100644 drivers/misc/xlink-ipc/Makefile
 create mode 100644 drivers/misc/xlink-ipc/xlink-ipc.c
 create mode 100644 drivers/misc/xlink-pcie/Kconfig
 create mode 100644 drivers/misc/xlink-pcie/Makefile
 create mode 100644 drivers/misc/xlink-pcie/common/core.h
 create mode 100644 drivers/misc/xlink-pcie/common/interface.c
 create mode 100644 drivers/misc/xlink-pcie/common/util.c
 create mode 100644 drivers/misc/xlink-pcie/common/util.h
 create mode 100644 drivers/misc/xlink-pcie/common/xpcie.h
 create mode 100644 drivers/misc/xlink-pcie/local_host/Makefile
 create mode 100644 drivers/misc/xlink-pcie/local_host/core.c
 create mode 100644 drivers/misc/xlink-pcie/local_host/dma.c
 create mode 100644 drivers/misc/xlink-pcie/local_host/epf.c
 create mode 100644 drivers/misc/xlink-pcie/local_host/epf.h
 create mode 100644 drivers/misc/xlink-pcie/remote_host/Makefile
 create mode 100644 drivers/misc/xlink-pcie/remote_host/core.c
 create mode 100644 drivers/misc/xlink-pcie/remote_host/main.c
 create mode 100644 drivers/misc/xlink-pcie/remote_host/pci.c
 create mode 100644 drivers/misc/xlink-pcie/remote_host/pci.h
 create mode 100644 drivers/soc/intel/Kconfig
 create mode 100644 drivers/soc/intel/Makefile
 create mode 100644 drivers/soc/intel/keembay-ipc.c
 create mode 100644 drivers/soc/intel/keembay-vpu-ipc.c
 create mode 100644 include/linux/soc/intel/keembay-ipc.h
 create mode 100644 include/linux/soc/intel/keembay-vpu-ipc.h
 create mode 100644 include/linux/xlink-ipc.h
 create mode 100644 include/linux/xlink.h
 create mode 100644 include/linux/xlink_drv_inf.h
 create mode 100644 include/uapi/misc/xlink_uapi.h

-- 
2.17.1

