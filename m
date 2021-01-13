Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B036C2F53FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 21:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbhAMUUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 15:20:45 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:28321 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbhAMUUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 15:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1610569245; x=1642105245;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vyb7CQ6nyLWrfBCj8s1tPmDghz3xw50HtYERQ9KzYCw=;
  b=iplV8SPbN5ahbifzISgUwHFIDisWj1/0qsWIddSV8sxdAkK9HF6yRyj7
   TSHUZ8bLlhDrlB4ngbIm8evFdbNVNzN5W+buJB4XM4O9Q3hmipeEQxceX
   tK3n6BYmTGqBUuvXMb+Z8VNaMSRCRnWOhyWS/lO2K/Qf8fOI/6lyxqez3
   Hewn+Zaou3yFP/QNdrKqDN0oA7nJ4f4JGPnkSHQNuCwZv5OmBS29d2yql
   beECLdfpiFGfiHn0l+JvV81VZfuc3ZjVLx6VXErmKewFmqVek7wICtiea
   J4Zkx69QQjwt96833/KgaKg4feumZJAtegyQ6fwUWRcIbrofHFEETt0zJ
   w==;
IronPort-SDR: nKzK8mOnHpsFmc3s7wnvRbJRxgJLu2qL5TTKUPXBofiz7dNcr4ragnzNhAMWjrY7flxqTNFI0B
 g/OTaSlyovQScKiuPxQcpvXqvdvFdYCRes1DENdeTtmek+QgwZ7ZbSxTPLrYpVlk+t9NKJfTbh
 1Oc2Pg3Ua1vhJ0ox/x2dxA7uvt3/N6ut2eNb57BMLCsaqAUjXXcTIQUu9Dh4zH3jOOpz6RwgRa
 JzyuOPNZwnpi1tQQchozq2hUDwzIgAtXoGg+h8GkTB8Hvx4e1dAh4j3IT0nsLZSxSaU0HwIOuC
 jcI=
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="scan'208";a="105346310"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2021 13:19:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 13 Jan 2021 13:19:28 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 13 Jan 2021 13:19:27 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        "Microchip Linux Driver Support" <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/3] Adding the Sparx5 Switch Reset Driver
Date:   Wed, 13 Jan 2021 21:19:12 +0100
Message-ID: <20210113201915.2734205-1-steen.hegelund@microchip.com>
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

Steen Hegelund (3):
  dt-bindings: reset: microchip sparx5 reset driver bindings
  reset: mchp: sparx5: add switch reset driver
  arm64: dts: reset: add microchip sparx5 switch reset driver

 .../bindings/reset/microchip,rst.yaml         |  52 +++++++
 arch/arm64/boot/dts/microchip/sparx5.dtsi     |  13 +-
 drivers/reset/Kconfig                         |   8 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-microchip-sparx5.c        | 145 ++++++++++++++++++
 5 files changed, 216 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/microchip,rst.yaml
 create mode 100644 drivers/reset/reset-microchip-sparx5.c

--
2.29.2

