Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2131E2ED481
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbhAGQl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:41:57 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45594 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbhAGQl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:41:56 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 107Ge57J020389;
        Thu, 7 Jan 2021 10:40:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610037605;
        bh=vtic02g60yfWt668WJykJ9bs7huK4Zr+VGhe+W1FY3Y=;
        h=From:To:CC:Subject:Date;
        b=JdC4kUoguZrUVN9PSUNLqLuWEcanuiOnjJuh5AN4IfRlDnKnCiPAPzOPPqA8XxELc
         YLf0/DOH7VIkyBRDlZb9Aws5Ox6vHwXAnKpvu5IVhh1l0xvrAs+7t+PwLsrI4WLTgl
         5Lq+IugNnOxVoq82Rgqwm4tdMucpqgo+iCoNgKZ8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 107Ge4cv035011
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jan 2021 10:40:05 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 7 Jan
 2021 10:40:03 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 7 Jan 2021 10:40:03 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 107GdxbM005468;
        Thu, 7 Jan 2021 10:39:59 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Anatolij Gustschin <agust@denx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] misc: eeprom_93xx46: Enable module autoprobe
Date:   Thu, 7 Jan 2021 22:09:52 +0530
Message-ID: <20210107163957.28664-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches
- fixes the modules alias for eeprom-93XX46
- enables module autprobe for microchip 93LC46B eeprom

Aswath Govindraju (2):
  misc: eeprom_93xx46: Fix module alias to enable module autoprobe
  misc: eeprom_93xx46: Enable module autoprobe for microchip 93LC46B
    eeprom

 drivers/misc/eeprom/eeprom_93xx46.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.17.1

