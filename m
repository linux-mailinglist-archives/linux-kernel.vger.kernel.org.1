Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC592C462C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732347AbgKYQ70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:59:26 -0500
Received: from inva020.nxp.com ([92.121.34.13]:52970 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730293AbgKYQ7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:59:25 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C6C851A1897;
        Wed, 25 Nov 2020 17:59:23 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8E9121A189F;
        Wed, 25 Nov 2020 17:59:23 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id C4C6640011;
        Wed, 25 Nov 2020 09:59:22 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] soc/fsl driver fix for 5.10
Date:   Wed, 25 Nov 2020 10:59:22 -0600
Message-Id: <20201125165922.15487-1-leoyang.li@nxp.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-fix-v5.10

for you to fetch changes up to 2663b3388551230cbc4606a40fabf3331ceb59e4:

  soc: fsl: dpio: Get the cpumask through cpumask_of(cpu) (2020-11-23 19:27:45 -0600)

----------------------------------------------------------------
NXP/FSL SoC driver fix for 5.10

DPAA2 DPIO driver
- Fix non-static cpumask for irq affinity setting

----------------------------------------------------------------
Hao Si (1):
      soc: fsl: dpio: Get the cpumask through cpumask_of(cpu)

 drivers/soc/fsl/dpio/dpio-driver.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)
