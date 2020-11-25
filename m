Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF9E2C462B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbgKYQ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:59:17 -0500
Received: from inva021.nxp.com ([92.121.34.21]:40464 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731062AbgKYQ7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:59:16 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EC05A200A53;
        Wed, 25 Nov 2020 17:59:14 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B461D2009E6;
        Wed, 25 Nov 2020 17:59:14 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id EA5BC40011;
        Wed, 25 Nov 2020 09:59:13 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] soc/fsl driver changes for next (v5.11)
Date:   Wed, 25 Nov 2020 10:59:13 -0600
Message-Id: <20201125165913.15441-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi arm-soc maintainers,

Please find the pull request for NXP/FSL SoC drivers.

Regards,
Leo

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.11

for you to fetch changes up to e95f287deed2454b8cad5b27859271db30130b2b:

  soc: fsl: handle RCPM errata A-008646 on SoC LS1021A (2020-11-23 19:16:02 -0600)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v5.11

- Add RCPM errata workaround for A-008646 on LS1021A
- Various W=1 warning fixes for fsl/soc drivers

----------------------------------------------------------------
Biwen Li (1):
      soc: fsl: handle RCPM errata A-008646 on SoC LS1021A

Lee Jones (3):
      soc: fsl: dpio: qbman-portal: Fix a bunch of kernel-doc misdemeanours
      soc: fsl: qe: qe_common: Fix misnamed function attribute 'addr'
      soc: fsl: qbman: qman: Remove unused variable 'dequeue_wq'

 drivers/soc/fsl/dpio/qbman-portal.c | 18 +++++++++++++-----
 drivers/soc/fsl/qbman/qman.c        |  8 ++------
 drivers/soc/fsl/qe/qe_common.c      |  2 +-
 drivers/soc/fsl/rcpm.c              | 35 ++++++++++++++++++++++++++++++++++-
 4 files changed, 50 insertions(+), 13 deletions(-)
