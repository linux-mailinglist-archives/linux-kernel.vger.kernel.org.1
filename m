Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49059276404
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 00:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgIWWoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 18:44:19 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55462 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgIWWoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 18:44:19 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A5ECA1A03C6;
        Thu, 24 Sep 2020 00:44:17 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D0231A01F3;
        Thu, 24 Sep 2020 00:44:17 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id AF61440A63;
        Wed, 23 Sep 2020 15:44:16 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] soc/fsl drivers changes for next(v5.10)
Date:   Wed, 23 Sep 2020 17:44:16 -0500
Message-Id: <20200923224416.25788-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi soc maintainers,

Please merge the following new changes for soc/fsl drivers.

Regards,
Leo

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.10

for you to fetch changes up to d97b957e32b1e7527a9b6652fa6e795f2861df7d:

  soc: fsl: qe: Remove unnessesary check in ucc_set_tdm_rxtx_clk (2020-09-22 18:25:29 -0500)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v5.10

Fix various compile warnings and static analysis warnings for:
- QBMan driver
- DPIO driver
- QE driver

----------------------------------------------------------------
Jason Yan (1):
      soc: fsl: dpio: remove set but not used 'addr_cena'

Krzysztof Kozlowski (1):
      soc: fsl: qbman: Fix return value on success

Li Yang (1):
      soc: fsl: qman: fix -Wpacked-not-aligned warnings

Liu Shixin (1):
      soc: fsl: qman: convert to use be32_add_cpu()

Wang Hai (1):
      soc: fsl: qe: Remove unnessesary check in ucc_set_tdm_rxtx_clk

 drivers/soc/fsl/dpio/qbman-portal.c   | 2 --
 drivers/soc/fsl/qbman/bman.c          | 2 +-
 drivers/soc/fsl/qbman/qman_test_api.c | 2 +-
 drivers/soc/fsl/qe/ucc.c              | 2 +-
 include/soc/fsl/qman.h                | 4 ++--
 5 files changed, 5 insertions(+), 7 deletions(-)
