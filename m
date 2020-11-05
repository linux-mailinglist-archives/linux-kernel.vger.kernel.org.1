Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AC22A812A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbgKEOol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:44:41 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:29897 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730461AbgKEOok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604587480; x=1636123480;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IrH5FSDcMPOqJtRlGkkd70blJua/Vlz2Q/w2GK/bdpw=;
  b=x7dpGvC4PAhnlPBBNo+DX30999jyYWU9dE+LyIXcmErX4Ja5a94uAQAd
   yCEU845s2FtxavP27ROfNXFy4UJhJ5Nhv5EjOPu3yyc37G90/R1vVzrtr
   shY9zYZKbSKhoY13LmYwjA/X/EHR7BPV4qyk3FnRxTw3ZMxhOHYgFQi7G
   +Vgv/D61H4HJaV/TONoy0YYwzTH8gofPPZbJHihBGC7QktZoc9Bkuu0xb
   0J50wYGk8OpOQtE1wRlv2fs2O+X2l+EW49+Nb5GVV+YEZUAcyjREVctMr
   Hv0e40zgPKRbmRoiyPslJu30l93/dBJqC2zAL05UxepKfe9RznNdSuXY7
   A==;
IronPort-SDR: Ne/TxPlLuN6XUTIf08UJpoxjOK7LM5JLhK22X7DktCBwr1WPGDJUaNCw4/3v16HqnR54rhX3N0
 Za11ndZYynWxMutNE+Hgn94nLmaTqeTwPA3RwsW2ce3Dcq8OovcnhgXcxM/7QeZLSRG4W3IexX
 UMCD1YAZ+rzQqn/Rw+gY+JzAymGIWQQKkC0NqjSozDiaY2w63uTvYQNpXArvcahHBtFb6tffpo
 7rs4vEVDDn19jPxVH87EphwhrAhyjlCuBlGOCRLSVNO0kVmTGHdbWtnHb/YkOYWqcmk3XI+5Sm
 SzA=
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="97880054"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Nov 2020 07:44:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 07:44:38 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 5 Nov 2020 07:44:36 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Bjarni Jonasson <bjarni.jonasson@microchip.com>,
        Microsemi List <microsemi@lists.bootlin.com>,
        Microchip UNG Driver List <UNGLinuxDriver@microchip.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/4] Adding the Sparx5 Serdes driver
Date:   Thu, 5 Nov 2020 15:44:25 +0100
Message-ID: <20201105144429.2438358-1-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the Sparx5 Serdes driver

This series of patches provides the serdes driver for the Microchip Sparx5
ethernet switch.

The serdes driver supports the 10G and 25G serdes instances available in the
Sparx5.

The Sparx5 serdes support several interface modes with several speeds and also
allows the client to change the mode and the speed according to changing in the
environment such as changing cables from DAC to fiber.

The serdes driver is to be used by the Sparx5 switchdev driver that
will follow in subsequent series.

Lars Povlsen (2):
  dt-bindings: phy: Add sparx5-serdes bindings
  arm64: dts: sparx5: Add Sparx5 serdes driver node

Steen Hegelund (2):
  phy: Add ethernet serdes configuration option
  phy: Add Sparx5 ethernet serdes PHY driver

 .../bindings/phy/microchip,sparx5-serdes.yaml |  283 ++
 arch/arm64/boot/dts/microchip/sparx5.dtsi     |  195 ++
 drivers/phy/Kconfig                           |    1 +
 drivers/phy/Makefile                          |    1 +
 drivers/phy/microchip/Kconfig                 |   12 +
 drivers/phy/microchip/Makefile                |    6 +
 drivers/phy/microchip/sparx5_serdes.c         | 2468 +++++++++++++++
 drivers/phy/microchip/sparx5_serdes_regs.h    | 2773 +++++++++++++++++
 include/linux/phy/phy-ethernet-serdes.h       |   49 +
 include/linux/phy/phy.h                       |    4 +
 10 files changed, 5792 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
 create mode 100644 drivers/phy/microchip/Kconfig
 create mode 100644 drivers/phy/microchip/Makefile
 create mode 100644 drivers/phy/microchip/sparx5_serdes.c
 create mode 100644 drivers/phy/microchip/sparx5_serdes_regs.h
 create mode 100644 include/linux/phy/phy-ethernet-serdes.h

--
2.29.2

