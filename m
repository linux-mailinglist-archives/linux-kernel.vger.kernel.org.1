Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A152B28E5BD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgJNRvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:51:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgJNRvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:51:43 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CBCD21D7F;
        Wed, 14 Oct 2020 17:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602697902;
        bh=UgjPcgSwO2CMV8epFPjr2u2qsJklKn6QeLFhLfwCVbA=;
        h=Date:From:To:Cc:Subject:From;
        b=RcVxu6Sida3yO9vy1vtWSmeZsg8Xqgbm8YSADvE3shv3Nxe4Fz2fNCC1hX9eS7zWg
         mOUyGRF3mXJaiZxkpSUlVNwLqQO9eM0kkEdfQUKq6npkPfjmLVgn7VEBK1LOHB6OOX
         FMV4o9v/4wy2FSYcW5CDIzKjjazf/K9mbruU/qIA=
Date:   Wed, 14 Oct 2020 19:52:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org
Subject: [GIT PULL] SPDX patches for 5.10-rc1
Message-ID: <20201014175216.GA3787023@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-5.10-rc1

for you to fetch changes up to c5c553850899e2662ecf749ac21fff95d17f59a4:

  scripts/spdxcheck.py: handle license identifiers in XML comments (2020-10-02 11:31:26 +0200)

----------------------------------------------------------------
SPDX patches for 5.10-rc1

Here are some SPDX-specific changes for 5.10-rc1.

They include:
	- driver fixes to make spdxcheck.pl work properly
	- add GFDL licenses as "deprecated" but required due to some of
	  our documentation using them
	- add Zlib license as "deprecated" but required because we have
	  code with this license in the tree.
	- convert some drivers to have SPDX identifiers that previously
	  didn't have them.

All have been in linux-next for a very long time with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Lukas Bulwahn (2):
      net/mlx5: IPsec: make spdxcheck.py happy
      scripts/spdxcheck.py: handle license identifiers in XML comments

Mauro Carvalho Chehab (1):
      LICENSE: add GFDL deprecated licenses

Mikhail Zaslonko (1):
      LICENSES/deprecated: add Zlib license text

Thomas Gleixner (5):
      scsi/qla4xxx: Convert to SPDX license identifiers
      scsi/qla2xxx: Convert to SPDX license identifiers
      net/qlcnic: Convert to SPDX license identifiers
      net/qlge: Convert to SPDX license identifiers
      net/qla3xxx: Convert to SPDX license identifiers

 .../device_drivers/qlogic/LICENSE.qla3xxx          |  46 ---
 .../device_drivers/qlogic/LICENSE.qlcnic           | 288 --------------
 .../networking/device_drivers/qlogic/LICENSE.qlge  | 288 --------------
 Documentation/scsi/LICENSE.qla2xxx                 | 290 --------------
 Documentation/scsi/LICENSE.qla4xxx                 | 289 --------------
 LICENSES/deprecated/GFDL-1.1                       | 377 +++++++++++++++++++
 LICENSES/deprecated/GFDL-1.2                       | 417 +++++++++++++++++++++
 LICENSES/deprecated/Zlib                           |  27 ++
 MAINTAINERS                                        |   3 -
 .../mellanox/mlx5/core/accel/ipsec_offload.c       |   2 +-
 drivers/net/ethernet/qlogic/qla3xxx.c              |   3 +-
 drivers/net/ethernet/qlogic/qla3xxx.h              |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h        |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h    |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c  |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_vnic.c  |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_ctx.c    |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_dcb.c    |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_dcb.h    |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c    |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hdr.h    |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c     |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h     |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_init.c   |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c     |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c   |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_minidump.c   |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov.h  |   3 +-
 .../ethernet/qlogic/qlcnic/qlcnic_sriov_common.c   |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c   |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c  |   3 +-
 drivers/scsi/qla2xxx/qla_attr.c                    |   3 +-
 drivers/scsi/qla2xxx/qla_bsg.c                     |   3 +-
 drivers/scsi/qla2xxx/qla_bsg.h                     |   3 +-
 drivers/scsi/qla2xxx/qla_dbg.c                     |   3 +-
 drivers/scsi/qla2xxx/qla_dbg.h                     |   3 +-
 drivers/scsi/qla2xxx/qla_def.h                     |   3 +-
 drivers/scsi/qla2xxx/qla_dfs.c                     |   3 +-
 drivers/scsi/qla2xxx/qla_fw.h                      |   3 +-
 drivers/scsi/qla2xxx/qla_gbl.h                     |   3 +-
 drivers/scsi/qla2xxx/qla_gs.c                      |   3 +-
 drivers/scsi/qla2xxx/qla_init.c                    |   3 +-
 drivers/scsi/qla2xxx/qla_inline.h                  |   3 +-
 drivers/scsi/qla2xxx/qla_iocb.c                    |   3 +-
 drivers/scsi/qla2xxx/qla_isr.c                     |   3 +-
 drivers/scsi/qla2xxx/qla_mbx.c                     |   3 +-
 drivers/scsi/qla2xxx/qla_mid.c                     |   3 +-
 drivers/scsi/qla2xxx/qla_mr.c                      |   3 +-
 drivers/scsi/qla2xxx/qla_mr.h                      |   3 +-
 drivers/scsi/qla2xxx/qla_nvme.c                    |   3 +-
 drivers/scsi/qla2xxx/qla_nvme.h                    |   3 +-
 drivers/scsi/qla2xxx/qla_nx.c                      |   3 +-
 drivers/scsi/qla2xxx/qla_nx.h                      |   3 +-
 drivers/scsi/qla2xxx/qla_nx2.c                     |   3 +-
 drivers/scsi/qla2xxx/qla_nx2.h                     |   3 +-
 drivers/scsi/qla2xxx/qla_os.c                      |   3 +-
 drivers/scsi/qla2xxx/qla_settings.h                |   3 +-
 drivers/scsi/qla2xxx/qla_sup.c                     |   3 +-
 drivers/scsi/qla2xxx/qla_tmpl.c                    |   3 +-
 drivers/scsi/qla2xxx/qla_tmpl.h                    |   3 +-
 drivers/scsi/qla2xxx/qla_version.h                 |   3 +-
 drivers/scsi/qla4xxx/ql4_83xx.c                    |   3 +-
 drivers/scsi/qla4xxx/ql4_83xx.h                    |   3 +-
 drivers/scsi/qla4xxx/ql4_attr.c                    |   3 +-
 drivers/scsi/qla4xxx/ql4_bsg.c                     |   3 +-
 drivers/scsi/qla4xxx/ql4_bsg.h                     |   3 +-
 drivers/scsi/qla4xxx/ql4_dbg.c                     |   3 +-
 drivers/scsi/qla4xxx/ql4_dbg.h                     |   3 +-
 drivers/scsi/qla4xxx/ql4_def.h                     |   3 +-
 drivers/scsi/qla4xxx/ql4_fw.h                      |   3 +-
 drivers/scsi/qla4xxx/ql4_glbl.h                    |   3 +-
 drivers/scsi/qla4xxx/ql4_init.c                    |   3 +-
 drivers/scsi/qla4xxx/ql4_inline.h                  |   3 +-
 drivers/scsi/qla4xxx/ql4_iocb.c                    |   3 +-
 drivers/scsi/qla4xxx/ql4_isr.c                     |   3 +-
 drivers/scsi/qla4xxx/ql4_mbx.c                     |   3 +-
 drivers/scsi/qla4xxx/ql4_nvram.c                   |   3 +-
 drivers/scsi/qla4xxx/ql4_nvram.h                   |   3 +-
 drivers/scsi/qla4xxx/ql4_nx.c                      |   3 +-
 drivers/scsi/qla4xxx/ql4_nx.h                      |   3 +-
 drivers/scsi/qla4xxx/ql4_os.c                      |   3 +-
 drivers/scsi/qla4xxx/ql4_version.h                 |   3 +-
 drivers/staging/qlge/qlge.h                        |   3 +-
 drivers/staging/qlge/qlge_main.c                   |   2 +-
 scripts/spdxcheck.py                               |   3 +
 86 files changed, 900 insertions(+), 1354 deletions(-)
 delete mode 100644 Documentation/networking/device_drivers/qlogic/LICENSE.qla3xxx
 delete mode 100644 Documentation/networking/device_drivers/qlogic/LICENSE.qlcnic
 delete mode 100644 Documentation/networking/device_drivers/qlogic/LICENSE.qlge
 delete mode 100644 Documentation/scsi/LICENSE.qla2xxx
 delete mode 100644 Documentation/scsi/LICENSE.qla4xxx
 create mode 100644 LICENSES/deprecated/GFDL-1.1
 create mode 100644 LICENSES/deprecated/GFDL-1.2
 create mode 100644 LICENSES/deprecated/Zlib
