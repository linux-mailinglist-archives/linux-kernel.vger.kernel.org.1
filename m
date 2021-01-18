Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599C92FA1A6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391620AbhARNaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:30:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392211AbhARN27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:28:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECC4622B4E;
        Mon, 18 Jan 2021 13:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610976499;
        bh=ZekYSafbEnIUfwwCZbjMZPXuSqYEP7FpvgKVVMVijj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r0ke8eQUKYIu49HyCDgqeB8sJ/0x2+EAZzlNWgPxmCzo8YuG0TCJwtcgCgCvSpz6l
         War1LC+YdteW+vEiSnMwA2Ya5mpJWBom8v7x6JdT6dw9IcBj16W7pKiW6dDoDbJQld
         C4m7nsvXzqdzU9YlY+Ac9CjRWF0d7pe7vyiaRoQWAXMY5RBqfrz3iJVKt1oWmQB2u8
         2w9mYKcoV6OqHkexd+d288Olb/TLbCZKaW+puH06t92xZqDFgkJie0Yt+ISI02LNIS
         de7dEIKlrx9MuTusfu9WxFSjAgFR2iXl1vt/Nc19iWa9iwBbY2m4TQq1CCsp99IQz1
         8vGgUwWEcbU+w==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l1UZs-000Vkq-IY; Mon, 18 Jan 2021 14:28:16 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/13] staging: hikey970: get rid of an static data
Date:   Mon, 18 Jan 2021 14:28:08 +0100
Message-Id: <2798cdc89ec7641c30bfc53cc2ae2a898d108d61.1610975633.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610975633.git.mchehab+huawei@kernel.org>
References: <cover.1610975633.git.mchehab+huawei@kernel.org>
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
index 1aed5b37fa23..8c64c0a86a3d 100644
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

