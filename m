Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD7D2F1260
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 13:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbhAKMgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 07:36:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbhAKMgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 07:36:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0561E2242A;
        Mon, 11 Jan 2021 12:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610368526;
        bh=lyrqn/YKGeP0Jj9QNzTMSXTnF1LuV/RkfrUdbtb+apA=;
        h=From:To:Cc:Subject:Date:From;
        b=Unv1BIJ9Jm9n+7R6/SBgSgI2EeU6Gd8l6XFtjv3uktKBZDcM665rLGPm9XW8ILqCT
         MJ/79cu9oTuIo6OlkAOwDIXU/xH4/TtdQZRiSBYTxx5UO30qliRol/yVr9p8qiVGrw
         ZcSWdpWWmMB1fTDlCtB8wS5bgH7/Ef9WLsYSu/yzar+OMWwHKJ4RHReYE1euwDm6MX
         wcZsRS2riLLS7OqjhdiyThqGM2BJPNGEvdMcZcS5JwB+GCIwbsPshOX2yvoYAUefTi
         KYQfrTZZRFU4wzmuvRcbJOA8JqhX2JmlTt00vIN7bQ2FyD9NYIZgHjTphwEZnIVC32
         1ROC2WwKypFXQ==
From:   matthias.bgg@kernel.org
To:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Gene Chen <gene_chen@richtek.com>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Gene Chen <gene.chen.richtek@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] mfd: mt6360: Fix MFD cell names and compatibles
Date:   Mon, 11 Jan 2021 13:35:18 +0100
Message-Id: <20210111123518.30438-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

MFD cell names and compatibles use '_' instead of '-', which is common
practice for names and the standard for DT compatibles.
This will also fix the probing for the drivers already implemented
(mt6360-adc and mt6360-tcpc).

Fixes: 7edd363421da ("mfd: Add support for PMIC MT6360")
Fixes: 1f4877218f7e ("iio: adc: mt6360: Add ADC driver for MT6360")
Fixes: e1aefcdd394f ("usb typec: mt6360: Add support for mt6360 Type-C driver")
Signed-off-by: Matthias Brugger <mbrugger@suse.com>

---

 drivers/mfd/mt6360-core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 4661c1b29a72..14e649ffe50f 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -292,18 +292,18 @@ static const struct resource mt6360_ldo_resources[] = {
 };
 
 static const struct mfd_cell mt6360_devs[] = {
-	OF_MFD_CELL("mt6360_adc", mt6360_adc_resources,
-		    NULL, 0, 0, "mediatek,mt6360_adc"),
-	OF_MFD_CELL("mt6360_chg", mt6360_chg_resources,
-		    NULL, 0, 0, "mediatek,mt6360_chg"),
-	OF_MFD_CELL("mt6360_led", mt6360_led_resources,
-		    NULL, 0, 0, "mediatek,mt6360_led"),
-	OF_MFD_CELL("mt6360_pmic", mt6360_pmic_resources,
-		    NULL, 0, 0, "mediatek,mt6360_pmic"),
-	OF_MFD_CELL("mt6360_ldo", mt6360_ldo_resources,
-		    NULL, 0, 0, "mediatek,mt6360_ldo"),
-	OF_MFD_CELL("mt6360_tcpc", NULL,
-		    NULL, 0, 0, "mediatek,mt6360_tcpc"),
+	OF_MFD_CELL("mt6360-adc", mt6360_adc_resources,
+		    NULL, 0, 0, "mediatek,mt6360-adc"),
+	OF_MFD_CELL("mt6360-chg", mt6360_chg_resources,
+		    NULL, 0, 0, "mediatek,mt6360-chg"),
+	OF_MFD_CELL("mt6360-led", mt6360_led_resources,
+		    NULL, 0, 0, "mediatek,mt6360-led"),
+	OF_MFD_CELL("mt6360-pmic", mt6360_pmic_resources,
+		    NULL, 0, 0, "mediatek,mt6360-pmic"),
+	OF_MFD_CELL("mt6360-ldo", mt6360_ldo_resources,
+		    NULL, 0, 0, "mediatek,mt6360-ldo"),
+	OF_MFD_CELL("mt6360-tcpc", NULL,
+		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
 };
 
 static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
-- 
2.29.2

