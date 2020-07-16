Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9B3221E21
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 10:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgGPIW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 04:22:59 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47874 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPIW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:22:58 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06G8Mu71029471;
        Thu, 16 Jul 2020 03:22:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594887776;
        bh=unHdhvVc3KqUmoNw9TPayL1iGlRp9XkaaB6wq8CJEOk=;
        h=From:To:CC:Subject:Date;
        b=MUdAmi3/jNpwkbCsXx1R0uOBLxGV+1eCFga/74l/YfM5W7aaFI5ckaarA4ucRhE+M
         NGCfuFpVx3UE8B/yR65uljQ+VWJEAdKi+MZ04nSIK1I9juDXtplZFBwFb+TI3+q2pz
         ZGYKyOte+VrCeW5WMFXbCcaLW0tlqgR0YPDQvXgs=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06G8MuGY116244
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Jul 2020 03:22:56 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 16
 Jul 2020 03:22:56 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 16 Jul 2020 03:22:55 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06G8MrSF049495;
        Thu, 16 Jul 2020 03:22:54 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <robh+dt@kernel.org>, <nsekhar@ti.com>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 0/3] phy: omap-usb2: add quirk to disable charger detection
Date:   Thu, 16 Jul 2020 11:22:49 +0300
Message-ID: <20200716082252.21266-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

- convert DT binding to YAML
- add DT property to disable charger detection
  (Errata i2075 for AM65 SR1.0)

Changelog:
v4
- fix example to fix dt_binding_check warnings
- '#phy-cells' -> "#phy-cells"
- Add 'oneOf' to compatible logic to allow just "ti,omap-usb2" as valid

v3
- Removed quotes from compatibles
- changed property to "ti,disable-charger-det"

v2
- Address Rob's comments on YAML schema.

cheers,
-roger

Roger Quadros (3):
  dt-binding: phy: convert ti,omap-usb2 to YAML
  dt-binding: phy: ti,omap-usb2: Add quirk to disable charger detection
  phy: omap-usb2-phy: disable PHY charger detect

 .../devicetree/bindings/phy/ti,omap-usb2.yaml | 77 +++++++++++++++++++
 .../devicetree/bindings/phy/ti-phy.txt        | 37 ---------
 drivers/phy/ti/phy-omap-usb2.c                | 35 +++++++--
 3 files changed, 105 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

