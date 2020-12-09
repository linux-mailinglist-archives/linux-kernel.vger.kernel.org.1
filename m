Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32932D4876
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgLIR7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 12:59:01 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56162 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgLIR7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:59:01 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B9HvFRB043910;
        Wed, 9 Dec 2020 11:57:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607536635;
        bh=gQuKJIcmhuaHAc6PdF+mJGyZvI/csxvtMBHdUp9OzUk=;
        h=From:To:CC:Subject:Date;
        b=rauSUf04vRPFMTtzEgBBPQzaPgv5iLYOQ/v+mOisulvYt8yHwmTAEupwjLaqNATON
         sPFWMadS1d0YIT+brMYMJ6KEcuUCgo4ulGDEWvZi9CzDxz9k7dl8CMFoVidgI16nfR
         oIpKC15J1PHLnnv9KnSfO1MbqlWXQp/0/fV61Ow4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B9HvFbd050917
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Dec 2020 11:57:15 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 9 Dec
 2020 11:57:14 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 9 Dec 2020 11:57:14 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B9HvATF094634;
        Wed, 9 Dec 2020 11:57:11 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH RFC 0/2] eeprom: eeprom_93xx46: Add support for sending zero bits after address during read transfer
Date:   Wed, 9 Dec 2020 23:27:06 +0530
Message-ID: <20201209175708.16252-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches adds support for sending zero bits after
address during read transfer, through a device tree property.


Aswath Govindraju (2):
  Documentation: devicetree: Add property for ignoring the dummy bits
    sent before read transfer
  eeprom: eeprom_93xx46: Add support for ignoring the dummy bit
    preceding data during read transfer

 .../bindings/misc/eeprom-93xx46.txt           |  4 +++-
 drivers/misc/eeprom/eeprom_93xx46.c           | 23 +++++++++++++++++++
 include/linux/eeprom_93xx46.h                 |  6 +++++
 3 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.17.1

