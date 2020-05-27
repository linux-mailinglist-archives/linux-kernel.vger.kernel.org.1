Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B994F1E50C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 23:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgE0V5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 17:57:43 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49740 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbgE0V5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 17:57:43 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D81951A0989;
        Wed, 27 May 2020 23:57:41 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9F6DD1A0984;
        Wed, 27 May 2020 23:57:41 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id DE9AD40A5F;
        Wed, 27 May 2020 14:57:40 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] soc/fsl drivers changes for next(v5.8)
Date:   Wed, 27 May 2020 16:57:40 -0500
Message-Id: <20200527215740.9279-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi soc maintainers,

Please merge the following new changes for soc/fsl drivers.

Regards,
Leo

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.8

for you to fetch changes up to e9e4ef9116b12951eaee3f8447ba9bbb40ab3620:

  soc: fsl: dpio: Remove unused inline function qbman_write_eqcr_am_rt_register (2020-05-22 18:11:03 -0500)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v5.8

DPAA2 DPIO driver
- Prefer the CPU affined DPIO

QUICC Engine drivers
- Replace one-element array and use struct_size() helper

Cleanups in various drivers

----------------------------------------------------------------
Colin Ian King (1):
      soc: fsl: qe: clean up an indentation issue

Gustavo A. R. Silva (2):
      treewide: Replace zero-length array with flexible-array
      soc: fsl: qe: Replace one-element array and use struct_size() helper

Roy Pledge (1):
      soc: fsl: dpio: Prefer the CPU affine DPIO

YueHaibing (2):
      soc: fsl: qbman: Remove unused inline function qm_eqcr_get_ci_stashing
      soc: fsl: dpio: Remove unused inline function qbman_write_eqcr_am_rt_register

 drivers/soc/fsl/dpio/dpio-service.c   |  6 +++++-
 drivers/soc/fsl/dpio/qbman-portal.c   | 12 ------------
 drivers/soc/fsl/qbman/qman.c          |  5 -----
 drivers/soc/fsl/qe/qe.c               |  4 ++--
 drivers/soc/fsl/qe/ucc.c              |  2 +-
 include/linux/fsl/bestcomm/bestcomm.h |  2 +-
 include/soc/fsl/qe/qe.h               |  2 +-
 7 files changed, 10 insertions(+), 23 deletions(-)
