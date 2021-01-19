Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625812FB73D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403831AbhASKch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:32:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389823AbhASKRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:17:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C01523131;
        Tue, 19 Jan 2021 10:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611051267;
        bh=WCeeeo5tB7di/O38tXWCfrzQBOZ8xAKFt+MaNDaC8nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NDOVRjwgsgMnMV0n1yvnvBLuwzRdcuxQ7E/mwdgzswZ1JwxZgr9zr096Ogr+Trmfe
         +B7UigkVuZBH9qOhyY/jfAvZegWUW+sWhOf+9BV6z7oIVfDesCyVagKNFBtQgT4a05
         WhQtxgR4O5ZRSsUYHU5j1DNvlK8UYuaSzedDJK+oltIoqEOGv5UvLuKrz4eUIHJLJO
         F7eECbwYcxHuWexEZMymzCH1EEyWtw+WyNqXxFPs343f23GlRb1xcvkUMWEOIrcT6Q
         6KWXHIUNec/7Wn25UczeOgZoCAH51WNA47CHWY3YuhZbrtbYzvQT4CEfYY9ayBXj4h
         dGAL7MtKz41nw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l1o1o-000tOx-RU; Tue, 19 Jan 2021 11:14:24 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/18] staging: hikey9xx: hi6421v600-regulator: fix delay logic
Date:   Tue, 19 Jan 2021 11:14:15 +0100
Message-Id: <749073392fa6d6a76c10b947df6493be821116eb.1611048785.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611048785.git.mchehab+huawei@kernel.org>
References: <cover.1611048785.git.mchehab+huawei@kernel.org>
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
index 35a72ea1bd14..f728118e84c0 100644
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

