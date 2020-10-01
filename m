Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FA528076E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 21:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732934AbgJATF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 15:05:59 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48436 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgJATF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:05:58 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 091J5oQ9034177;
        Thu, 1 Oct 2020 14:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601579150;
        bh=4o911QoPtRmo9v0dPSy0bJk5ofbB/X+AjEc+G4ud9hY=;
        h=From:To:CC:Subject:Date;
        b=zVcsg5nIJOHfYWgFLDTW5ofPvM2VxVALK2S7JbnjISKnHtdFwHIjjRsBP2t0CwgmV
         qhNo7Gd6ijQkZ1us0497zAYE0XZgzg+b5dFTq4sQ90yxPJ9fJ+bofL3iQcQOe7K3j6
         XzdebEVe95yZ847T8ZlGSq9VSlFQppkvX5VHnCAE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 091J5oGg106138;
        Thu, 1 Oct 2020 14:05:50 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 14:05:50 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 14:05:50 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 091J5gYl070134;
        Thu, 1 Oct 2020 14:05:44 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <will@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <t-kristo@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH 0/8] Add support for UHS modes in TI's J721e and J7200 boards
Date:   Fri, 2 Oct 2020 00:35:33 +0530
Message-ID: <20201001190541.6364-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add support for UHS modes for TI's j721e and j7200
boards.

Patches 1-3 add support for gpios to j7200-evm

Patches 4-6 add support for voltage regulators for required by the
SD card in both devices as well as enable UHS modes at 1.8V

Patches 5-6 add some required configs to the arm64 defconfig.

This series depends on driver patches adding tuning support here:
https://lore.kernel.org/linux-arm-kernel/20200923105206.7988-1-faiz_abbas@ti.com/

Faiz Abbas (8):
  arm64: dts: ti: k3-j7200-main: Add gpio nodes in main domain
  arm64: dts: ti: k3-j7200: Add gpio nodes in wakeup domain
  arm64: dts: ti: k3-j7200-common-proc-board: Disable unused gpio
    modules
  arm64: dts: ti: k3-j721e-main: Add output tap delay values
  arm64: dts: ti: k3-j721e-common-proc-board: Add support SD card UHS
    modes
  arm64: dts: ti: k3-j7200-common-proc-board: Add support SD card UHS
    modes
  arm64: defconfig: Enable OMAP I2C driver
  arm64: defconfig: Enable DAVINCI_GPIO driver

 .../dts/ti/k3-j7200-common-proc-board.dts     | 48 +++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 69 ++++++++++++++++++-
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 32 +++++++++
 .../dts/ti/k3-j721e-common-proc-board.dts     | 35 +++++++++-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 22 ++++--
 arch/arm64/configs/defconfig                  |  2 +
 6 files changed, 201 insertions(+), 7 deletions(-)

-- 
2.17.1

