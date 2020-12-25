Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC90F2E2C17
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 19:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgLYSuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 13:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgLYSuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 13:50:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBC6C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 10:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=EdDFnTX5eVqVgnBw9WoNCKn6WLuOLWSd8Ojj2d9PvXA=; b=DBMVdWuh2mZ6+qNo9tEX3h2o1u
        LOpYcIVo5WiivTERaaC3oBZor/1CnDzvp4thXgVEpJ8mPxaJrGCyWdqO+KI9p0g5pAdLNxqnMgp8+
        CnWFNTtA7qAoyoORwhM0i17WDqerIryn+z6HHZQBApHukOeI0pI0o3BeSLLb214tf+pQuM/R0Z9Q0
        4wypfPtqxvuiLeCyLgJQXHE3mA0JO+MietQkGHuF+kvJ83b8qWxMLGAn8NZ9fNG9mLr5I2ExKPHg8
        4W0RwCOXCIVdxuZQGsQAtRNXgTZBRUowtjfsJ0mUgp1wOEXkO8WLRBXTGtYmzWmVAnTVXvYcKW9gL
        wdAnQHFw==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kssAC-0005jj-H7; Fri, 25 Dec 2020 18:50:09 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH -next] regulator: qcom-rpmh: fix build after QCOM_COMMAND_DB is tristate
Date:   Fri, 25 Dec 2020 10:50:04 -0800
Message-Id: <20201225185004.20747-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restrict REGULATOR_QCOM_RPMH to QCOM_COMMAND_DB it the latter is enabled.

Fixes this build error:
  microblaze-linux-ld: drivers/regulator/qcom-rpmh-regulator.o: in function `rpmh_regulator_probe':
  (.text+0x354): undefined reference to `cmd_db_read_addr'

Fixes: 778279f4f5e4 ("soc: qcom: cmd-db: allow loading as a module")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20201223.orig/drivers/regulator/Kconfig
+++ linux-next-20201223/drivers/regulator/Kconfig
@@ -881,6 +881,7 @@ config REGULATOR_QCOM_RPM
 config REGULATOR_QCOM_RPMH
 	tristate "Qualcomm Technologies, Inc. RPMh regulator driver"
 	depends on QCOM_RPMH || (QCOM_RPMH=n && COMPILE_TEST)
+	depends on QCOM_COMMAND_DB || !QCOM_COMMAND_DB
 	help
 	  This driver supports control of PMIC regulators via the RPMh hardware
 	  block found on Qualcomm Technologies Inc. SoCs.  RPMh regulator
