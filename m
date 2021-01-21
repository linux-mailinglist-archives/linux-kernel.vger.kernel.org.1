Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C4A2FE3CF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbhAUHVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:21:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbhAUHTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:19:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 201F92396D;
        Thu, 21 Jan 2021 07:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611213508;
        bh=mbuAyjc4Gf5cdswGQdNod+LYe43pzG2SbMc0YDjJRSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hFpfIk8I5BsaOX3iTzyisFeULUJn4IMuzKVQJ3lFYUfw5y4R4dJDWmgKLA1OeOBbY
         jaB6Xoua3CabscBAg1hFfbWitm7nRGExESARa+d6Jnap07yxVS58iiqQlUDGuZzzXG
         kxrnmdMI8vVr9vs9rvA0jNUhS9y0NLYWWs01NA6m2wTAVnLhnHYS32VcUeYRkE2YEs
         Nu8Cn0RGW4g5RidtlbfwGwbZ2d/mJPjVluIS181Cho5XOah6EcnxTlGbQv97DivVvx
         0zI96T0cH6TJSHZlWvnj0HFqUql9SyihQJe5Ekd9H3pA+JmI0aYucQsNVku8RkKwN3
         tO5VZQuo010uA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l2UEb-004BsE-IY; Thu, 21 Jan 2021 08:18:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/21] staging: hikey9xx: hi6421v600-regulator: fix delay logic
Date:   Thu, 21 Jan 2021 08:18:12 +0100
Message-Id: <6733dac9813ba6688def404142cb7b964accf758.1611212783.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611212783.git.mchehab+huawei@kernel.org>
References: <cover.1611212783.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original driver, which can be seen at
commit 42f24d9d446a ("staging: regulator: add a regulator driver for HiSilicon 6421v600 SPMI PMIC")
had a complex logic to ensure that there won't be multiple power
enable/disable commands running at the same time. At the original
logic, it were ensured that:

- a next power up/down would wait for at least the on/off period;
- an extra delay would be granted. It turns that such extra delay
  has a value of zero, but it was relying on gettimeofday()
  call, which can take some time.

This was later simplified, but there are still some possible
issues. In order to avoid that, let's simply add a delay
to wait for the power up line to stabilize after powering up
a device.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421v600-regulator.c | 5 +++--
 include/linux/mfd/hi6421-spmi-pmic.h            | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index 5e78eebfc1f3..e5a492ee7121 100644
--- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
+++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
@@ -113,14 +113,15 @@ static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 
 	/* cannot enable more than one regulator at one time */
 	mutex_lock(&sreg->enable_mutex);
-	usleep_range(HISI_REGS_ENA_PROTECT_TIME,
-		     HISI_REGS_ENA_PROTECT_TIME + 1000);
 
 	/* set enable register */
 	ret = hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
 				   rdev->desc->enable_mask,
 				   rdev->desc->enable_mask);
 
+	/* Avoid powering up multiple devices at the same time */
+	usleep_range(rdev->desc->off_on_delay, rdev->desc->off_on_delay + 60);
+
 	mutex_unlock(&sreg->enable_mutex);
 
 	return ret;
diff --git a/include/linux/mfd/hi6421-spmi-pmic.h b/include/linux/mfd/hi6421-spmi-pmic.h
index 2c8896fd852e..0c2214612c4e 100644
--- a/include/linux/mfd/hi6421-spmi-pmic.h
+++ b/include/linux/mfd/hi6421-spmi-pmic.h
@@ -13,7 +13,6 @@
 
 #include <linux/irqdomain.h>
 
-#define HISI_REGS_ENA_PROTECT_TIME	(0)	/* in microseconds */
 #define HISI_ECO_MODE_ENABLE		(1)
 #define HISI_ECO_MODE_DISABLE		(0)
 
-- 
2.29.2

