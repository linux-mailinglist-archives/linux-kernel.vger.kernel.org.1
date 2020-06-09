Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555371F34D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 09:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgFIH2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 03:28:47 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:17269 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgFIH2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 03:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1591687726; x=1623223726;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EdagFqo0zl2QoL9GYL8uhvzMwrGF3eoykcCf0BeB49E=;
  b=wsrUTjbeJRvqdDEJVTMAiw+O7n9iko8o9zgJInx05SOW030vfEFLmix9
   nSjQlLZ528iaLwmASHKYhrDx3YUvHyjBhtQnkb6TyIXZ0l1ZxqgZ0Ap6/
   aw20D3CKE3VqpWmmsdPO5et1E3uZliCLnMbzxu1m9eV9h533sMremas8k
   VIslCj5r0FxYdwyQn3xGBdPJiHimBPM+53iumZy/jxMbNUwyTP7riV9Wp
   qG6TPQ9MEGJ5UPk2dlaEoZWXe7qsSyA8+8vJRMNwuJ9vlAWoWEgBAqPAy
   cl+yIwxmnjDtJ1jhO2wuSz5QUngS6C07oVqwMn8y2T1mnqTDOpuME5A7O
   Q==;
IronPort-SDR: QTtMOPx1vuvYZFnLAVvFCMW2enGb9SAeWHRhv5MRLsaXsORetfBEAhhYxQLKXYFkieDoYMYirW
 Amz3wK85+sXhOCAZXaTeWjqzKcDB8Pqcuj3dFlqE9fuvEyMaT3MsW2+6EIY1vRcRCSD3ncVRP/
 ReMmXoqKMzJs5qaiwvpbIly0kc8v+VT2nNnU9vQsFQLQJAdSr0AWBeMPWtWg3HiNBzXKzC/OEt
 6oi0IyP+9b9L4IlkFTzSS28BQJFeqM7MxQeXyr0Jy5GB6a1yrjtx7awqK8L3I84erhvD73fav1
 Puo=
X-IronPort-AV: E=Sophos;i="5.73,490,1583218800"; 
   d="scan'208";a="75941395"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2020 00:28:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 9 Jun 2020 00:28:45 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1847.3 via Frontend Transport; Tue, 9 Jun 2020 00:28:43 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 0/3] hwmon: Adding support for Microchip Sparx5 SoC
Date:   Tue, 9 Jun 2020 09:28:25 +0200
Message-ID: <20200609072828.9088-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an add-on series to the main SoC Sparx5 series
(Message-ID: <20200608123024.5330-1-lars.povlsen@microchip.com>)

Changes in v2:
- Changes in driver as per review comments

Lars Povlsen (3):
  dt-bindings: hwmon: Add Sparx5 temperature sensor
  arm64: dts: sparx5: Add hwmon temperature sensor
  hwmon: sparx5: Add Sparx5 SoC temperature driver

 .../bindings/hwmon/microchip,sparx5-temp.yaml |  39 +++++
 arch/arm64/boot/dts/microchip/sparx5.dtsi     |   6 +
 drivers/hwmon/Kconfig                         |  10 ++
 drivers/hwmon/Makefile                        |   2 +-
 drivers/hwmon/sparx5-temp.c                   | 152 ++++++++++++++++++
 5 files changed, 208 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
 create mode 100644 drivers/hwmon/sparx5-temp.c

--
2.27.0
