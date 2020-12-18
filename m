Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B4A2DE3B8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 15:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgLROKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 09:10:05 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34250 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgLROKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:10:05 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BIE8MAN089019;
        Fri, 18 Dec 2020 08:08:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608300502;
        bh=yFeRY/FFE85wtwiBNGJkrb6gh9vkaA1wKxZHgsPHjts=;
        h=From:To:CC:Subject:Date;
        b=AS7kjrcwRuir6npW9rc1rE9dJyL0lN1O9HV0dTUDru1XCJus5L0coG2qlYJLDUqi9
         di4dHyu3TLFjwAZKtMQ7O38FYdHSTYCorBYNIBE973LwUKd3SyDIuqyTDfrrGzhYwR
         yBNDRyTur+/H64V24eGixi26vD6hxqgnJ7qgBvv0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BIE8M7C078139
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Dec 2020 08:08:22 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Dec 2020 08:08:22 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Dec 2020 08:08:22 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BIE8HoX035666;
        Fri, 18 Dec 2020 08:08:18 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] eeprom: eeprom_93xx46: Add support for microchip 93LC46B eeprom
Date:   Fri, 18 Dec 2020 19:38:09 +0530
Message-ID: <20201218140815.9501-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches adds support for microchip 93LC46B eeprom by
 - Adding a new compatible string
 - Adding a quirk to send extra bit after the address to ignore the
   zero bit sent before data, during a read transfer.

Aswath Govindraju (2):
  Documentation: devicetree: Add new compatible string for eeprom
    microchip 93LC46B
  misc: eeprom_93xx46: Add quirk to support Microchip 93LC46B eeprom

 .../devicetree/bindings/misc/eeprom-93xx46.txt    |  1 +
 drivers/misc/eeprom/eeprom_93xx46.c               | 15 +++++++++++++++
 include/linux/eeprom_93xx46.h                     |  2 ++
 3 files changed, 18 insertions(+)

-- 
2.17.1

