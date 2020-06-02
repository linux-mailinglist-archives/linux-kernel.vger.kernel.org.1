Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955021EBAA9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 13:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgFBLqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 07:46:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37040 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBLqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:46:12 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 052BkAYN009550;
        Tue, 2 Jun 2020 06:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591098370;
        bh=liMQLFi0N8WC0e51YYM1LOF4pYjGjHGEb5dgVVKz+MI=;
        h=From:To:CC:Subject:Date;
        b=naNercX3nEjJ6+ZNtebF+8m9gPCxQiUp7l8+tiX+Djob24JU8ZLebu84hpPM+canx
         mEuZH/FCmsEycRHbpU7QWW9qx0wwzbMvWZItagzSyOLkH6959KB60kZJDWny2YpZkO
         Y7ivOKME0GYG5vHKMQElMzW6Yk7ANMNnW7oLXo34=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 052BkAWN100695;
        Tue, 2 Jun 2020 06:46:10 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 2 Jun
 2020 06:46:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 2 Jun 2020 06:46:10 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 052Bk8kr000625;
        Tue, 2 Jun 2020 06:46:08 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCHv2 0/3] phy: omap-usb2: add quirk to disable charger detection
Date:   Tue, 2 Jun 2020 14:46:03 +0300
Message-ID: <20200602114606.32045-1-rogerq@ti.com>
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
v2
- Address Rob's comments on YAML schema.

cheers,
-roger

Bin Liu (1):
  dts: am65: add ti,dis-chg-det-quirk flag to usb phy nodes

Roger Quadros (3):
  dt-binding: phy: convert ti,omap-usb2 to YAML
  dt-binding: phy: ti,omap-usb2: Add quirk to disable charger detection
  phy: omap-usb2-phy: disable PHY charger detect

 .../devicetree/bindings/phy/ti,omap-usb2.yaml | 74 +++++++++++++++++++
 .../devicetree/bindings/phy/ti-phy.txt        | 37 ----------
 drivers/phy/ti/phy-omap-usb2.c                | 35 +++++++--
 3 files changed, 102 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

