Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3542F5D57
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbhANJ0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:26:33 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:56654 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbhANJ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:26:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1610616390; x=1642152390;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+jOIFDxc8pDKUwvO+6TF9Y49yr5MBHAQgzNkRlq5hBg=;
  b=GrkuICvz01v3/fMX8TYOve4QjEMXP+VVCABvg1GYJkNzSnpawb+VDGJW
   Z8G1CBpLOdQB8Jr0GNZ0Z0FUJzrdNnCsmXyn7hF0bpECuCHV6zWk9R4N2
   oSibJw1pBqZivqrCq28ySM8yUmVnuEBGeqfs88xuAr9guNaT6Q0SCMaMb
   Lc5PXpiD4hMnkKBj3WGIChcF50Hjt+o7Ub4WEqwX7rfuDjbQ8k7DR4YEu
   C+7prM2VuobWKx+PxkJcBHCEghUabVn3JXkXvcf8jnMhyx7SF99rMREpN
   RxLhFhVfdXha4QijQJ9fUVTLQ4jA5rr5qM+/xA6xco+Vx2l8KgJfytGbv
   A==;
IronPort-SDR: 1VwdpMn/peBweqpU+tToJbEKdQKfRV2OSw56d3QPQIkGH4XCpax5al/eX4CZboYH3Y3ACdb4ey
 VcPh4yxWZUPDpG4nyRSkS9ufDqehkaQJlfL2AIUHpSfjN45JGRwGOmq5qGqIlvZ3pDmjs7kAum
 Y4iB3UV37PPfYkcIBtr2hwvonnjxZ0blWXZsCcDfalRlu3itS2bF5GDkpxbYIZIFtMTobIP6nn
 AOl2icccJEygM26/WPRF+rPRKuJy1Ec1dU5m9FYj10tXLgE07f3IcfK8nf/X0Z75OZ8b47UHlu
 bwM=
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="100058149"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jan 2021 02:25:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 14 Jan 2021 02:25:13 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 14 Jan 2021 02:25:11 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/3]  Adding the Sparx5 Switch Reset Driver
Date:   Thu, 14 Jan 2021 10:24:57 +0100
Message-ID: <20210114092500.2822208-1-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series provides the Microchip Sparx5 Switch Reset Driver

The Sparx5 Switch SoC has a number of components that can be reset
individually, but at least the Switch Core needs to be in a well defined
state at power on, when any of the Sparx5 drivers starts to access the
Switch Core, this reset driver is available.

The reset driver is loaded early via the postcore_initcall interface, and
will then be available for the other Sparx5 drivers (SGPIO, SwitchDev etc)
that are loaded next, and the first of them to be loaded can perform the
one-time Switch Core reset that is needed.

The driver has protection so that the system busses, DDR controller, PCI-E
and ARM A53 CPU and a few other subsystems are not touched by the reset.

The Sparx5 Chip Register Model can be browsed at this location:
https://github.com/microchip-ung/sparx-5_reginfo

History:

v1 - v2: Removed debug prints
         Changed the error handling to save the error code before jumping.

Steen Hegelund (3):
  dt-bindings: reset: microchip sparx5 reset driver bindings
  reset: mchp: sparx5: add switch reset driver
  arm64: dts: reset: add microchip sparx5 switch reset driver

 .../bindings/reset/microchip,rst.yaml         |  52 +++++++
 arch/arm64/boot/dts/microchip/sparx5.dtsi     |  13 +-
 drivers/reset/Kconfig                         |   8 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-microchip-sparx5.c        | 146 ++++++++++++++++++
 5 files changed, 217 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/microchip,rst.yaml
 create mode 100644 drivers/reset/reset-microchip-sparx5.c

-- 
2.29.2

