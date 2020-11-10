Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832412AD710
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbgKJNEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730188AbgKJNEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:04:25 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Nov 2020 05:04:24 PST
Received: from mxa2.seznam.cz (mxa2.seznam.cz [IPv6:2a02:598:2::90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB75C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:04:24 -0800 (PST)
Received: from email.seznam.cz
        by email-smtpc27b.ng.seznam.cz (email-smtpc27b.ng.seznam.cz [10.23.18.39])
        id 049c592a5f920d4305359574;
        Tue, 10 Nov 2020 14:04:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1605013463; bh=SJXQwxMfRfWIiUrI2lcDhV7COepl6cFlEC3yQDtyH4g=;
        h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
         Content-Transfer-Encoding;
        b=MKDuLvE/1hAiWi8nIp8VlYeJQwbps8V9nmJBXSnWwv084MyRpnqwcaAJMcpkcTX7R
         RaLx0rRTw+t/P3tRgb6GoyoEbeQZ7Z7S47At/d0+nnRG8D00LxOmKSUsrQOTg4qxT0
         St3ixU/9RrpsYLBtWn5Vf1a8cPanzELcEHtaKhN0=
Received: from localhost.localdomain (ip-228-128.dynamic.ccinternet.cz [212.69.128.228])
        by email-relay4.ng.seznam.cz (Seznam SMTPD 1.3.121) with ESMTP;
        Tue, 10 Nov 2020 14:03:10 +0100 (CET)  
From:   michael.srba@seznam.cz
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, Michael Srba <Michael.Srba@seznam.cz>
Subject: [PATCH] mfd: rt5033: fix errorneous defines
Date:   Tue, 10 Nov 2020 14:00:47 +0100
Message-Id: <20201110130047.8097-1-michael.srba@seznam.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Srba <Michael.Srba@seznam.cz>

Fix regulators on rt5033 by converting some values to bitmasks which were 
errorneously not defined as such in the header file.

Cc: Beomho Seo <beomho.seo@samsung.com>
Fixes: 0b271258544b ("mfd: rt5033: Add Richtek RT5033 driver core.")
Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
---

Tested on Samsung Galaxy A3 (sm-a3ulte).

Other areas (e.g "RT5033 use internal timer need to set time") still look
suspicious, but without access to a datasheet it's unfortunately hard
to evaluate. Moreover, these values are not currently utilized so it's not
clear what format would be expected. (it's however hard to argue for
the removal of said values, since with the datasheet not being publicly
available, this file may be the best documentation of them)

---
 include/linux/mfd/rt5033-private.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/mfd/rt5033-private.h b/include/linux/mfd/rt5033-private.h
index 3e1be588e029..964e656272ce 100644
--- a/include/linux/mfd/rt5033-private.h
+++ b/include/linux/mfd/rt5033-private.h
@@ -91,14 +91,14 @@ enum rt5033_reg {
 #define RT5033_RT_HZ_MASK		0x01
 
 /* RT5033 control register */
-#define RT5033_CTRL_FCCM_BUCK_MASK		0x00
-#define RT5033_CTRL_BUCKOMS_MASK		0x01
-#define RT5033_CTRL_LDOOMS_MASK			0x02
-#define RT5033_CTRL_SLDOOMS_MASK		0x03
-#define RT5033_CTRL_EN_BUCK_MASK		0x04
-#define RT5033_CTRL_EN_LDO_MASK			0x05
-#define RT5033_CTRL_EN_SAFE_LDO_MASK		0x06
-#define RT5033_CTRL_LDO_SLEEP_MASK		0x07
+#define RT5033_CTRL_FCCM_BUCK_MASK		BIT(0)
+#define RT5033_CTRL_BUCKOMS_MASK		BIT(1)
+#define RT5033_CTRL_LDOOMS_MASK			BIT(2)
+#define RT5033_CTRL_SLDOOMS_MASK		BIT(3)
+#define RT5033_CTRL_EN_BUCK_MASK		BIT(4)
+#define RT5033_CTRL_EN_LDO_MASK			BIT(5)
+#define RT5033_CTRL_EN_SAFE_LDO_MASK		BIT(6)
+#define RT5033_CTRL_LDO_SLEEP_MASK		BIT(7)
 
 /* RT5033 BUCK control register */
 #define RT5033_BUCK_CTRL_MASK			0x1f
@@ -247,11 +247,11 @@ enum rt5033_fuel_reg {
 #define RT5033_FUEL_BAT_PRESENT		0x02
 
 /* RT5033 PMIC interrupts */
-#define RT5033_PMIC_IRQ_BUCKOCP		2
-#define RT5033_PMIC_IRQ_BUCKLV		3
-#define RT5033_PMIC_IRQ_SAFELDOLV	4
-#define RT5033_PMIC_IRQ_LDOLV		5
-#define RT5033_PMIC_IRQ_OT		6
-#define RT5033_PMIC_IRQ_VDDA_UV		7
+#define RT5033_PMIC_IRQ_BUCKOCP		BIT(2)
+#define RT5033_PMIC_IRQ_BUCKLV		BIT(3)
+#define RT5033_PMIC_IRQ_SAFELDOLV	BIT(4)
+#define RT5033_PMIC_IRQ_LDOLV		BIT(5)
+#define RT5033_PMIC_IRQ_OT		BIT(6)
+#define RT5033_PMIC_IRQ_VDDA_UV		BIT(7)
 
 #endif /* __RT5033_PRIVATE_H__ */
-- 
2.28.0

