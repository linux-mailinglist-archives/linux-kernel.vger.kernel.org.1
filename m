Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D3D2FB731
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390552AbhASK3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:29:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:39854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389730AbhASKPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:15:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05BB02312B;
        Tue, 19 Jan 2021 10:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611051267;
        bh=9sJuiRaH9YoTTEL9TAIlpGXfKAAfiZ//TDkV9Z3S4Ws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gqQ9h+ps6w031wGOL9aEJw07zFDY3gt7szzUBM082o7L0uZrP6L3AcHj+6p8qanRS
         +ZwUNFfVHs1qcVD0akZMSqAygeMHU21iNWuKyfg3y1OiDpoCc/UmpUWn4bewW8KMZt
         /jASoNG1uReVnwIre+k4ob36mwaQ2uqoF9rqd3ImPK+QW1pB0/QwcLX45+p0u7scKs
         4PQKigv+2J3sKYiQ4P1B4rLvVBYJWXa/eOtcqG+iY/onQmhYHCNhVhM/1QTkxUPIOf
         5EA2XUZkjJ5fSahX7d/z6GSDhF8MLv/05VadxP0ZhSqTmVU4BJKpiMP2vh3EjmOGSd
         BMaHXxSA9W55w==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l1o1o-000tOq-Ox; Tue, 19 Jan 2021 11:14:24 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/18] staging: hikey9xx: hi6421v600-regulator: get rid of an static data
Date:   Tue, 19 Jan 2021 11:14:12 +0100
Message-Id: <e4c7ed9321df9d5772b9ab381f98ded879dbcd3c.1611048785.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611048785.git.mchehab+huawei@kernel.org>
References: <cover.1611048785.git.mchehab+huawei@kernel.org>
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
index 5469089a3daf..e96aab17a499 100644
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

