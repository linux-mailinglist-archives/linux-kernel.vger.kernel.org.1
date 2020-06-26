Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A008920AF8B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 12:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgFZKUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 06:20:20 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1574 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgFZKTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 06:19:37 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef5cba90002>; Fri, 26 Jun 2020 03:19:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Jun 2020 03:19:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Jun 2020 03:19:34 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jun
 2020 10:19:28 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Jun 2020 10:19:28 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ef5cbae0000>; Fri, 26 Jun 2020 03:19:28 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH V4 0/7] Tegra XUSB charger detect support
Date:   Fri, 26 Jun 2020 15:48:55 +0530
Message-ID: <1593166742-23592-1-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593166761; bh=MeRpiUTHRQCSz0IBjSCnOZDVvinouGc/TonRKJ7voTs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=Y/T9KzNNpuwtGMFNcOShAKOVq1Aq95fpVjvVgx/qZzwx5KtXM6yU/UeuB+6OaYcUc
         1nOPN3xBIGvBQIPTOy7RiW294pZjccgIzunkuLxtDer+ctLjSRG5PD3JEzMtYU6LBB
         /++YduIX3+LivZPxIMK2/1IzIWLWvett5fxQSyTbYElC+Kq1dz5+Arzc7Bqd1reW9C
         g3skvfZ3Z7o5pYw9xGvIfhlWvpJEdrJvNblXqzJvTTD6pB6XmkD2f59tOWmQ1Se8V8
         lm2lU8dcZrBY/wnlhmiNjVw6Q97BTW9gceJXU1BSpFLjgxxRq4pwBhQNvGnF9AfOlt
         MgKg8FQB3OD4A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds charger detect support on XUSB hardware used in
Tegra210 and Tegra186 SoCs.

This patchset is composed with :
 - dt bindings of XUSB Pad Controller
 - Tegra XUSB device mode driver to add vbus_draw support 
 - Tegra PHY driver for charger detect support

Tests done:
 - Connect USB cable from ubuntu host to micro-B port of DUT to detect
   SDP_TYPE charger
 - Connect USB cable from external powered USB hub(which inturn connects
   to ubuntu host) to micro-B port of DUT to detect CDP_TYPE charger.
 - Connect USB cable from USB charger to micro-B port of DUT to detect
   DCP_TYPE charger.
DUT: Jetson-tx1, Jetson tx2.

V4:
 - Added ACKed-by details for PHY driver.
 - Used BIT macro instead of (1 << index) usage as suggested by Chunfeng Yun.
V3:
 - Added ACKed-by details for PHY driver and DT changes.
 - Functions and its arguments are aligned.
 - Tabs are used for alignment of MACRO's
 - For vbus_draw USDC callback, usb_phy set_power error is propogated.
 - Fixed various comments given by thierry.
V2:
 - Added ACKed-by details for DT patches.
 - All patches rebased.

Nagarjuna Kristam (7):
  dt-bindings: phy: tegra-xusb: Add charger-detect property
  phy: tegra: xusb: Add support for UTMI pad power control
  phy: tegra: xusb: Add USB2 pad power control support for Tegra210
  phy: tegra: xusb: Add soc ops API to enable UTMI PAD protection
  phy: tegra: xusb: Add support for charger detect
  phy: tegra: xusb: Enable charger detect for Tegra186
  phy: tegra: xusb: Enable charger detect for Tegra210

 .../bindings/phy/nvidia,tegra124-xusb-padctl.txt   |   4 +
 drivers/phy/tegra/Makefile                         |   2 +-
 drivers/phy/tegra/cd.c                             | 283 +++++++++++++++++++++
 drivers/phy/tegra/xusb-tegra186.c                  |  92 +++++--
 drivers/phy/tegra/xusb-tegra210.c                  | 223 +++++++++++-----
 drivers/phy/tegra/xusb.c                           |  80 ++++++
 drivers/phy/tegra/xusb.h                           |  22 ++
 7 files changed, 621 insertions(+), 85 deletions(-)
 create mode 100644 drivers/phy/tegra/cd.c

-- 
2.7.4

