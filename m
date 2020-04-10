Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 497A71A489A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 18:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgDJQn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 12:43:56 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:9933 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgDJQn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 12:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1586537036; x=1618073036;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=IZtgr281NErrC4ObsXh3MQXKvxHUfMzv2fvTAErzi5s=;
  b=i3fRgdHSLlxLX8yvx8K1kCDJS3Izh5vJc/eZnR4UjlD/zD4DO8fkz0UJ
   a4rEeoDZRvKyAoXMP9f3X8l3OPtW7MSFSGLO6ysMeZrWgG13sVdPMjDE6
   z1Sg4ZC4cVrX5Rh1nKoTEfsuic5X7m0BLgXKdFdtULGelqCDS9nt++14l
   XupSn5R10CFe2IWPPR+aDOW7kuwPS3jWHQ+hYMklvu7LHduubdhercA6G
   +7rduybxGppHTUr5pYZLbaPruQcxe3nid7acMQ1dsNaBUT2aaGGjifJ4y
   fauZsC9HTf1opLmjPoDyFf51NqC/TKo5GwbRMsOTtgQLO84fCCQKv1Xqb
   w==;
IronPort-SDR: PXJOqZSFecMhn6NVignQpMzVGcP3WR0oAaJwMXHXQjJZXUM0iCdbt094IHyDB21H6SVQdf0Uo7
 2ALtn/JsADLBdmOwTP1XTMIbqbjdpHib3ranqxO0PuRIMTaPtV6Od8G2JKiyzakdJOjbWpI2mU
 QVVQEVu7tYcbGJmsYU7WlA8aoLsV9H8/hYNZMBLfbEnTlXHmyaOdj5FPM4EkfGD05IgEevYSKa
 eYYcAg56gZdXQKFGTaBXAtqOWzSLEdpSW1s6iBd4yhJHxqfmsv6JWmedSy+SF1iizx/oS/WRgT
 Dwg=
X-IronPort-AV: E=Sophos;i="5.72,367,1580799600"; 
   d="scan'208";a="75501639"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Apr 2020 09:43:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 10 Apr 2020 09:43:50 -0700
Received: from cristi-P53.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 10 Apr 2020 09:43:43 -0700
From:   <cristian.birsan@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH 0/2] ARM: at91: Add initial support for SAMA5D2-ICP
Date:   Fri, 10 Apr 2020 19:43:18 +0300
Message-ID: <20200410164320.7658-1-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

This patch series adds initial support for SAMA5D2 Industrial
Communication Platform.

Codrin Ciubotariu (1):
  dt-bindings: ARM: Document SAMA5D2-ICP

Cristian Birsan (1):
  ARM: dts: at91: sama5d2-icp: add SAMA5D2-ICP

 .../devicetree/bindings/arm/atmel-at91.yaml   |   7 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/at91-sama5d2_icp.dts        | 797 ++++++++++++++++++
 3 files changed, 805 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-sama5d2_icp.dts

-- 
2.17.1

