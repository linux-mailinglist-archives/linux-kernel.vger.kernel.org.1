Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95BD2ED485
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbhAGQmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:42:11 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53260 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbhAGQmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:42:10 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 107GeN9k070895;
        Thu, 7 Jan 2021 10:40:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610037623;
        bh=QyiLUlhhWyqM2wiTQgiqAWHCA3bcXD1C6teh46c2weo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qMyHiHJIyqL/uN5BkFztaeSVDbQoBLdJjv5ApQGWbHATuF/Te2IWvWQ86gtmd8kiK
         xQyp11xz310yfS98eix+EmSrzW1eLfBq5d6IadEzhx9sCnlLzUlXJUW87WK59kNo/I
         LbrzOQpbRe+9co7LWfOe9d1G/MXgz39duXOd4iJo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 107GeNM0087923
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jan 2021 10:40:23 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 7 Jan
 2021 10:40:22 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 7 Jan 2021 10:40:22 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 107GdxbO005468;
        Thu, 7 Jan 2021 10:40:18 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        Anatolij Gustschin <agust@denx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] misc: eeprom_93xx46: Enable module autoprobe for microchip 93LC46B eeprom
Date:   Thu, 7 Jan 2021 22:09:54 +0530
Message-ID: <20210107163957.28664-3-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210107163957.28664-1-a-govindraju@ti.com>
References: <20210107163957.28664-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add module alias to enable autoprobe for microchip 93LC46B eeprom by using
/sys/class/.../spi1.0/modalias content.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---

This patch is dependent on,
https://lore.kernel.org/patchwork/patch/1360658/

 drivers/misc/eeprom/eeprom_93xx46.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index 890624d97774..9ca2571cab17 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -527,3 +527,4 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Driver for 93xx46 EEPROMs");
 MODULE_AUTHOR("Anatolij Gustschin <agust@denx.de>");
 MODULE_ALIAS("spi:eeprom-93xx46");
+MODULE_ALIAS("spi:93lc46b");
-- 
2.17.1

