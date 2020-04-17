Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D132F1AE597
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 21:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbgDQTOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 15:14:22 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19392 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730125AbgDQTOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:14:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e99ff9d0000>; Fri, 17 Apr 2020 12:12:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 17 Apr 2020 12:14:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 17 Apr 2020 12:14:21 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 Apr
 2020 19:14:21 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 17 Apr 2020 19:14:20 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.171.241]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e9a000b0000>; Fri, 17 Apr 2020 12:14:20 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <baolin.wang@linaro.org>, <kstewart@linuxfoundation.org>,
        <tglx@linutronix.de>, <bradleybolen@gmail.com>,
        <gregkh@linuxfoundation.org>, <faiz_abbas@ti.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>
CC:     <bbiswas@nvidia.com>, <anrao@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
Subject: [PATCH 4.19.113 0/3] Fix for long operation cmds busy detection
Date:   Fri, 17 Apr 2020 12:14:01 -0700
Message-ID: <1587150844-12003-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587150749; bh=MLMeZlGwo09nxFFR4BPaUlO5N8koBh6qfFD6TaQ2IpY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=q74mObg3UbRlzdKkJ0MO2ODy070ojZ36VSP3SOZWz5D6a47VZpuIrMeObRBRxqlZ1
         w5iJXdGi3/z/tzKieBrn7Yjow18QiVJNxNBCAweL6/qHp8Ts6ryYKCkEzbI1oD2uwm
         t69IFPGIVhJAMgLgpOWRni6efg84H00lcMLx1SejKJCHLHOgOjjz/e5zCs9yxlg7bI
         MbnMPKU7MjribqepGMOZCbLYa0vvL/3PlkDtRgMwcV4AbtrJP3LqHKZ18vLjaDUayj
         dsrw6hglkerYbee+Y3MR3HnOlrNkbgIqaXOAhTsUN4tnH85jLItL2fBJ+qJCjrknFf
         SOy5x9SSpJyiQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes manually backported changes that implements Tegra
specific timeout callback to switch between finite and infinite HW busy
detection wait modes.

sdhci-tegra driver patch implements set_timeout callback based on one of
the sdhci host driver patch that refactors sdhci_set_timeout and allows
drivers to call __sdhci_set_timeout with their timeout callback
implementation.

Both of these patches are manually backported in this series.


Sowjanya Komatineni (3):
  mmc: sdhci: Refactor sdhci_set_timeout()
  sdhci: tegra: Implement Tegra specific set_timeout callback
  sdhci: tegra: Enable MMC_CAP_WAIT_WHILE_BUSY host capability

 drivers/mmc/host/sdhci-tegra.c | 32 ++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c       | 38 ++++++++++++++++++++------------------
 drivers/mmc/host/sdhci.h       |  1 +
 3 files changed, 53 insertions(+), 18 deletions(-)

-- 
2.7.4

