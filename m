Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB88D2FCCA6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbhATIYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:24:22 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:10949 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730517AbhATIUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611130846; x=1642666846;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qy4YGPgtKsgIbGN4KY0kms4H3gLMY2uz1QkKByYiaew=;
  b=LnoxWybUx8PfIEzIFwR33uEnhNvmXC24wRW9C+tDlM/cVuT9sXZTVn8s
   7ic/mnHbXxuKg2dcy1ZHE8j29zHJV0Xou+/o8/CXyMxbpmfTroCInA7kD
   pfsGHiCYoRXfS02QZxYxl0pmw5ucQcGPDRsizN0lymm1LTNfzqxZL+2c6
   Jroa9rX0PMFqHNMg5IkRXhHpETmUPP7dVeCcHzVGBmCRWrRD25b/qg3vy
   2uIN78W9gMOz+it6HEhJyo7hZRLiFjanSQIJyQX69pdRCsqqsfGlb43vN
   O6FnW3ZJK4pWzGdZP5nBkinZQRYPiMYX1CmOgBGj9SDAnIAgLdpXZlNYS
   w==;
IronPort-SDR: sh498HeuxQp8tKuQQ1BX0gAxT/1c3Pa/nlqBJOtK202E6CnE1H+g4OESP28Ez6naLhUXLRXELi
 YgwnTGDwjQUzATmjixYwyyHF9reGntCchPPkak55g4Wv7KcgFiVElb2utjeAh6Ug+wvf1Mgbna
 1iW3hzVdgZMKstE5mKOGUFyaN9EoMy8T/9ENpC0mc+FBVmt3JdGJ9wdeSzWgRUO2LYVUeUASS4
 MITiMYqWKTIzeHLXhD62MiCfX7iJ+7TrazDMPHiQVST64qlo+X/l2ORl0dZlAYxRsLF+iDrwNH
 rMc=
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="106072377"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2021 01:19:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 20 Jan 2021 01:19:29 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 20 Jan 2021 01:19:27 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 0/3] Adding the Sparx5 Switch Reset Driver
Date:   Wed, 20 Jan 2021 09:19:18 +0100
Message-ID: <20210120081921.3315847-1-steen.hegelund@microchip.com>
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

v3 -> v4 Added commit message descriptions

v2 -> v3 Removed unused headers
         Renamed the reset controller dev member.
         Use regmap_read_poll_timeout instead of polling a function.
         Used two separate syscon entries in the binding
         Simplified the syscon error handling.
         Simplified the devm_reset_controller_register error handling.
         Moved the contents of the mchp_sparx5_reset_config function into
         the probe function.

v1 -> v2 Removed debug prints
         Changed the error handling to save the error code before jumping.

Steen Hegelund (3):
  dt-bindings: reset: microchip sparx5 reset driver bindings
  reset: mchp: sparx5: add switch reset driver
  arm64: dts: reset: add microchip sparx5 switch reset driver

 .../bindings/reset/microchip,rst.yaml         |  59 +++++++++
 arch/arm64/boot/dts/microchip/sparx5.dtsi     |  14 +-
 drivers/reset/Kconfig                         |   8 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-microchip-sparx5.c        | 120 ++++++++++++++++++
 5 files changed, 199 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/microchip,rst.yaml
 create mode 100644 drivers/reset/reset-microchip-sparx5.c

-- 
2.29.2

