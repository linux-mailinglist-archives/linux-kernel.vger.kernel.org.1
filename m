Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3306B2F65E6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbhANQZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:25:57 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:35650 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbhANQZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:25:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1610641556; x=1642177556;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GRKQZk3reL+yFIk84UhkwWjIL34yFjzkRsFwyfLowZ4=;
  b=iJ8+CcQcSCzPo8wT1TYjsgpQxbzemWNoZjjGJmGpx9hqXXg8++ykMGqK
   BUzgE/g9xHd9oorc45lPrnLfeGsDvjcp6ng5gT/R47IqqMzKnGFP6xk7s
   Bcw4yUIZZUaqqJJUF+hJ5eHcLVJ2yH/ZvgAsry8+pFZaOOtNoilS69BkV
   ZAZLzxLMyGt64y5iz6uhTMrFbBx2Obs8W69RJGhktab38YlNdLMiPVk+K
   rRWZ+VsvJ3ilrIuM+SG3iRIbK/AhYKFcNpM6v4ySwwA6lpWaFj/47cd/I
   NxbCGsiUt7E/1ZwToOaXtJVQO0DQlbbC8OTb5Z8x2MAwe9h8U/kGO1LgD
   Q==;
IronPort-SDR: 2t8mbM6CD555mZgsyC5FhpZLOkabEA2Gudy5CWufhmC147YTlOGTVsgIuIk9z3tg5BG4u20S7F
 w/zgjZ0d4seKqLEdhlwdHUyPofI68n1XWLxzqx/+RvwXI6RZpWU30npVDuqOWI1qC/RvvC4+SX
 d+OdooYJVc4hJbJnCdWlBxkUC5lkH7YIV4ZvOUZqWXvxlQlNawQJAVjsbLEHzyLyPyciO/0gUd
 zNcKiCw5ZLJTzrNS6mjErRT/Tz4dbCN4SeSBF9ZS6USRdEL3XhQxWv4Ac/f05T+4t3pPqKHwsA
 qOo=
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="105991452"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jan 2021 09:24:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 14 Jan 2021 09:24:39 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 14 Jan 2021 09:24:37 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 0/3] Adding the Sparx5 Switch Reset Driver
Date:   Thu, 14 Jan 2021 17:24:29 +0100
Message-ID: <20210114162432.3039657-1-steen.hegelund@microchip.com>
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

v2 - v3: Removed unused headers
         Renamed the reset controller dev member.
         Use regmap_read_poll_timeout instead of polling a function.
         Used two separate syscon entries in the binding
         Simplified the syscon error handling.
         Simplified the devm_reset_controller_register error handling.
         Moved the contents of the mchp_sparx5_reset_config function into
         the probe function.

v1 - v2: Removed debug prints
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

