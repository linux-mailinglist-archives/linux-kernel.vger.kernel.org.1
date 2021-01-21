Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73AC2FE3C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbhAUHT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:19:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:39918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbhAUHTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:19:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BA6E2389B;
        Thu, 21 Jan 2021 07:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611213508;
        bh=PGUSgFawbeGNKLqlR2hZt2YgAv8hjjVilpqNUkuQq1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRqVLkbkyAzuild0XRGrkLvK7YrG22opL+jsKA0p+d5Eu+POIND2culba9PCnIyXR
         E0jEhvpgUGVLllM4RLuopSxTeaw6NfCdBmjnVnf738vlG8K1W6k1eZeceSgzXOKi/C
         WrJDzJ+v3Dr3Ugs9NMk2lHMNmcca5Su6CoUcMIhiatesNkufK+nj0QXKxcH1gss0dJ
         x3ujyEmFgzxD6xsXWTHfT5C97C45Wy/QxKtVnBLq1Ko/ZKi0GHLdDTIryfeeWougWS
         rtFMy9fqgQvalPDl23dVipfXm7dDm4QCy2Ko5TV66lpBL/diC0Q5FFrH9c5xSS4NBN
         ddxFS6o7TtEoA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l2UEb-004Bs8-G7; Thu, 21 Jan 2021 08:18:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/21] staging: hikey9xx: hi6421v600-regulator: get rid of an static data
Date:   Thu, 21 Jan 2021 08:18:09 +0100
Message-Id: <ff8b6852c788fd476743eb4ce556e4a97f4b928e.1611212783.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611212783.git.mchehab+huawei@kernel.org>
References: <cover.1611212783.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move it to be inside the private data struct.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421v600-regulator.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index 54ad07418ec2..e25e596f58cf 100644
--- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
+++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
@@ -28,9 +28,10 @@ struct hi6421_spmi_reg_info {
 	struct hi6421_spmi_pmic *pmic;
 	u8			eco_mode_mask;
 	u32			eco_uA;
-};
 
-static DEFINE_MUTEX(enable_mutex);
+	/* Serialize regulator enable logic */
+	struct mutex enable_mutex;
+};
 
 static const unsigned int ldo3_voltages[] = {
 	1500000, 1550000, 1600000, 1650000,
@@ -118,7 +119,7 @@ static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 
 	/* cannot enable more than one regulator at one time */
-	mutex_lock(&enable_mutex);
+	mutex_lock(&sreg->enable_mutex);
 	usleep_range(HISI_REGS_ENA_PROTECT_TIME,
 		     HISI_REGS_ENA_PROTECT_TIME + 1000);
 
@@ -127,7 +128,7 @@ static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 			     rdev->desc->enable_mask,
 			     rdev->desc->enable_mask);
 
-	mutex_unlock(&enable_mutex);
+	mutex_unlock(&sreg->enable_mutex);
 
 	return 0;
 }
@@ -312,6 +313,7 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	sreg->pmic = pmic;
+	mutex_init(&sreg->enable_mutex);
 
 	for (i = 0; i < ARRAY_SIZE(regulator_info); i++) {
 		/* assign per-regulator data */
-- 
2.29.2

