Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2A026A4A3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgIOMFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:05:49 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45578 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgIOLqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:46:46 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08FBjlfE009318;
        Tue, 15 Sep 2020 06:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600170347;
        bh=ketyk4tDTWG0vyPaqHUk09xlVnIAaXeWFX/wwUSaBIo=;
        h=From:To:CC:Subject:Date;
        b=nEwnaHQTyXb0sViQ6nLLuW9qgsUcV628vFNGZpeVyVBL8jwRpC0tMKuZGd/e0EavX
         agdF28J0AQ6OPDzv8VnAxGneIfzK7PP4D9COGG8oktCrUpNNh/JTJr0yvTwmbhDtkF
         UvNbIbKmAJvaQ55P4U2tY5CqPPE4dKnrEa/e7S24=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08FBjl7X055474
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 06:45:47 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 06:45:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 06:45:47 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FBjin6091853;
        Tue, 15 Sep 2020 06:45:45 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>
CC:     <pawell@cadence.com>, <kurahul@cadence.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 0/3] usb: cdns,usb3: Convert DT binding to YAML
Date:   Tue, 15 Sep 2020 14:45:40 +0300
Message-ID: <20200915114543.2599-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

This series converts DT binding to YAML schema.
Then adds a new property to enable workaround for USB2.0 PHY
Rx compliance issues.

cheers,
-roger

Changelog:
v3:
- removed oneOf from compatible. Added items in phy-names.

v2:
- updated commit log to better describe why DT property is required
for the quirk.

Pawel Laszczak (1):
  usb: cdns3: Enable workaround for USB2.0 PHY Rx compliance test PHY
    lockup

Roger Quadros (2):
  dt-bindings: usb: Convert cdns-usb3.txt to YAML schema
  dt-bindings: usb: cdns,usb3: Add cdns,phyrst-a-enable property

 .../devicetree/bindings/usb/cdns,usb3.yaml    | 96 +++++++++++++++++++
 .../devicetree/bindings/usb/cdns-usb3.txt     | 45 ---------
 drivers/usb/cdns3/core.c                      |  2 +
 drivers/usb/cdns3/core.h                      |  1 +
 drivers/usb/cdns3/drd.c                       | 12 +++
 drivers/usb/cdns3/drd.h                       |  5 +-
 6 files changed, 115 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/cdns,usb3.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

