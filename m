Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CD72F4389
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 06:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbhAMFOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 00:14:42 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46680 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbhAMFOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 00:14:41 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10D5D0uZ100853;
        Tue, 12 Jan 2021 23:13:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610514780;
        bh=EcjHrdf3aDug5lDthXl3K8dPfvQJSC+9US0NGk/Se6U=;
        h=From:To:CC:Subject:Date;
        b=Z0rkFWrBdrQ24U86Vq8DCSb9/Zy1IIwHWEhQCs0VbjmaTjosIszbM07bDv15JSE/y
         wwU9GsY1bZauj4PE9naKXUYsu/+uUqpnFiL0eMXxkyFlwarApasF74v/H2sZSH2rRQ
         8oTOW8mL4Uq+ZjQfD7xbqVPzJtKkklay+ecaiV14=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10D5D0Z3120766
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jan 2021 23:13:00 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 Jan 2021 23:12:59 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 Jan 2021 23:12:59 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10D5Ctf9024926;
        Tue, 12 Jan 2021 23:12:56 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] misc: eeprom_93xx46: Add module alias to avoid breaking support for non device tree users
Date:   Wed, 13 Jan 2021 10:42:52 +0530
Message-ID: <20210113051253.15061-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Module alias "spi:93xx46" is used by non device tree users like
drivers/misc/eeprom/digsy_mtc_eeprom.c  and removing it will
break support for them.

Fix this by adding back the module alias "spi:93xx46".

Fixes: 13613a2246bf ("misc: eeprom_93xx46: Fix module alias to enable module autoprobe")
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---

This change has been done based on comments at,
https://lore.kernel.org/patchwork/patch/1361939/

 drivers/misc/eeprom/eeprom_93xx46.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index 849cfea9e294..e130a0d858e9 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -511,5 +511,6 @@ module_spi_driver(eeprom_93xx46_driver);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Driver for 93xx46 EEPROMs");
 MODULE_AUTHOR("Anatolij Gustschin <agust@denx.de>");
+MODULE_ALIAS("spi:93xx46");
 MODULE_ALIAS("spi:eeprom-93xx46");
 MODULE_ALIAS("spi:93lc46b");
-- 
2.17.1

