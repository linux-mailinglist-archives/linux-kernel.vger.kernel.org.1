Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DD82E7A18
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 15:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgL3O6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 09:58:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbgL3O6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 09:58:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0CE520770;
        Wed, 30 Dec 2020 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609340240;
        bh=DJrNV4orHoS8G7sUGAqj//BkBQLh/dNSvXPl9Az0PS8=;
        h=From:To:Cc:Subject:Date:From;
        b=rbbw+eZeQMo9YasZV8xPjtBLHtZ1E3kgyllNHotORpINKAZQIzaeSpKfhpFCoblG8
         lemYIALnVRgmF+vplPwOxK7o5QLe04t1RrPnvtmCkmKdvYiYCKkeQmKOOXAE8fUPFU
         Ew0adQQxYm+A5wQmXSQ9qVLe6avg9pOueJBNKJceUoaEMgk/l8tOTW88kTRLOZyS4n
         lyheWt9Ea7M4e+5RBEYC119j9knz45uoKis6BlwPKEXFadmYrv0J2KKv/vBirw/V7+
         f89jSlE21k/sA29fUcBEPWBTIOjlrqpnqZHntI4qOgd/0eiKo6lRJCoYH+eV1odRip
         fLzoP6y6eNx0A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Collins <collinsd@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: qcom-rpmh: add QCOM_COMMAND_DB dependency
Date:   Wed, 30 Dec 2020 15:56:23 +0100
Message-Id: <20201230145712.3133110-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A built-in regulator driver cannot link against a modular cmd_db driver:

qcom-rpmh-regulator.c:(.text+0x174): undefined reference to `cmd_db_read_addr'

There is already a dependency for RPMh, so add another one of this
type for cmd_db.

Fixes: 34c5aa2666db ("regulator: Kconfig: Fix REGULATOR_QCOM_RPMH dependencies to avoid build error")
Fixes: 46fc033eba42 ("regulator: add QCOM RPMh regulator driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/regulator/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 53fa84f4d1e1..5abdd29fb9f3 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -881,6 +881,7 @@ config REGULATOR_QCOM_RPM
 config REGULATOR_QCOM_RPMH
 	tristate "Qualcomm Technologies, Inc. RPMh regulator driver"
 	depends on QCOM_RPMH || (QCOM_RPMH=n && COMPILE_TEST)
+	depends on QCOM_COMMAND_DB || (QCOM_COMMAND_DB=n && COMPILE_TEST)
 	help
 	  This driver supports control of PMIC regulators via the RPMh hardware
 	  block found on Qualcomm Technologies Inc. SoCs.  RPMh regulator
-- 
2.29.2

