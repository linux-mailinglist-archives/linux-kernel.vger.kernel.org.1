Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59302C660A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 13:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgK0Mwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 07:52:51 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:26679 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgK0Mwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 07:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606481568;
        s=strato-dkim-0002; d=fossekall.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=LRj+arvWbNcXJ39Wa8vMrS3smx7S5J/b8+NMY5zufsk=;
        b=Jv7FwJ5P88CxuEdMb+wTfgAMXS63CCElWOEY91r5KvUjmdQIl8wRt5/R/921Z+xWtC
        gHdTlAxLNME5z6Ukblu63X972W2WggYFWJARnD6yr8HmTaLr024u/etoQvGkoTN0IiDP
        WkfnJu28nY74KQDQVz3ZhQRo3G80mUNOw5q8buHJsS0AxYzA+1WAJyzTupEUPDT8v1+w
        lbTjExPD9MFybn/TiWY8XWgBVWJRUXOsom4srF98ilk84EZO2+SNhDZlV2nPY8WCEt4e
        TSiYkURxlcwgxuajFYecGZ63Nar6gFH3pQD7hgEAu03SK4yiFvzaNPzPU2fz2z3k2gpp
        qWLg==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.3.4 AUTH)
        with ESMTPSA id g02087wARCqiaJa
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Fri, 27 Nov 2020 13:52:44 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1kidEu-0003pJ-FJ; Fri, 27 Nov 2020 13:52:40 +0100
Received: (nullmailer pid 23980 invoked by uid 502);
        Fri, 27 Nov 2020 12:52:40 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Andrei Stefanescu <andrei.stefanescu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        Michael Klein <michael@fossekall.de>
Subject: [PATCH v2 3/3] mfd: da9055: fix "REGULATOR" spelling in register content macro
Date:   Fri, 27 Nov 2020 13:52:02 +0100
Message-Id: <20201127125202.23917-3-michael@fossekall.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127125202.23917-1-michael@fossekall.de>
References: <20201127093142.GP2455276@dell>
 <20201127125202.23917-1-michael@fossekall.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"REGUALTOR" -> "REGULATOR"

Signed-off-by: Michael Klein <michael@fossekall.de>
---
Changes in v2:
  - split patch
  - make subject line more forthcoming

 drivers/regulator/da9055-regulator.c | 4 ++--
 include/linux/mfd/da9055/reg.h       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index 73ff5fc7d8d7..c0394ac5e60a 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -184,7 +184,7 @@ static int da9055_regulator_get_voltage_sel(struct regulator_dev *rdev)
 	ret &= info->conf.sel_mask;
 
 	/* Get the voltage for the active register set A/B */
-	if (ret == DA9055_REGUALTOR_SET_A)
+	if (ret == DA9055_REGULATOR_SET_A)
 		ret = da9055_reg_read(regulator->da9055, volt.reg_a);
 	else
 		ret = da9055_reg_read(regulator->da9055, volt.reg_b);
@@ -231,7 +231,7 @@ static int da9055_regulator_set_voltage_sel(struct regulator_dev *rdev,
 	ret &= info->conf.sel_mask;
 
 	/* Set the voltage */
-	if (ret == DA9055_REGUALTOR_SET_A)
+	if (ret == DA9055_REGULATOR_SET_A)
 		return da9055_reg_update(regulator->da9055, info->volt.reg_a,
 					 info->volt.v_mask, selector);
 	else
diff --git a/include/linux/mfd/da9055/reg.h b/include/linux/mfd/da9055/reg.h
index 54a717b6c3de..1204e6b152d5 100644
--- a/include/linux/mfd/da9055/reg.h
+++ b/include/linux/mfd/da9055/reg.h
@@ -344,8 +344,8 @@
 #define	DA9055_VLDO_GPI_MASK		0x60
 #define	DA9055_LDO_CONF_SHIFT		0x07
 #define	DA9055_LDO_CONF_MASK		0x80
-#define	DA9055_REGUALTOR_SET_A		0x00
-#define	DA9055_REGUALTOR_SET_B		0x10
+#define	DA9055_REGULATOR_SET_A		0x00
+#define	DA9055_REGULATOR_SET_B		0x10
 
 /* DA9055_REG_ADC_MAN (addr=0x1B) */
 #define	DA9055_ADC_MUX_SHIFT		0
-- 
2.29.2

