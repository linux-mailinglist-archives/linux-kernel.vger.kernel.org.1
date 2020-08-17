Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08003245DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 09:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgHQHMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 03:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbgHQHL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:11:27 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 913D822CAD;
        Mon, 17 Aug 2020 07:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597648277;
        bh=9y3YY2uy8a9xwFvbUzX/REtb13wDHN83q+XnhOPjVT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQZJnneQCL2XhKZv763RJZQrQzCIuMj6uiy7qYkUk7/CPoS8wK8uqmpbRyAe2aIno
         ksbS3w5eTcBkJ/s4Wr0gmJf5GCWZgEMe2wldPYFY7Nk1QQWhwC6bfHfEOyPtWBRRx0
         dg5SA2WpNnIUMG+nQl7cp3MOB/hvFhiA3ytyAVrc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZIZ-00BdkB-OW; Mon, 17 Aug 2020 09:11:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH v3 21/44] staging: mfd: hi6421-spmi-pmic: add it to the building system
Date:   Mon, 17 Aug 2020 09:10:40 +0200
Message-Id: <952e11ea1a33beaf67d6dc355d5c0f99ab4fb964.1597647359.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597647359.git.mchehab+huawei@kernel.org>
References: <cover.1597647359.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver is ready, place it at the build system.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/Kconfig  | 17 +++++++++++++++++
 drivers/staging/hikey9xx/Makefile |  3 ++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/hikey9xx/Kconfig b/drivers/staging/hikey9xx/Kconfig
index 31eb01b5ef2b..7ca083b7e94d 100644
--- a/drivers/staging/hikey9xx/Kconfig
+++ b/drivers/staging/hikey9xx/Kconfig
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
+# to be placed at drivers/spmi
 config SPMI_HISI3670
 	tristate "Hisilicon 3670 SPMI Controller"
 	select IRQ_DOMAIN_HIERARCHY
@@ -8,3 +9,19 @@ config SPMI_HISI3670
 	  If you say yes to this option, support will be included for the
 	  built-in SPMI PMIC Arbiter interface on Hisilicon 3670
 	  processors.
+
+# to be placed at drivers/mfd
+config MFD_HI6421_SPMI
+	tristate "HiSilicon Hi6421v600 SPMI PMU/Codec IC"
+	depends on OF
+	select MFD_CORE
+	select REGMAP_MMIO
+	help
+	  Add support for HiSilicon Hi6421v600 SPMI PMIC. Hi6421 includes
+	  multi-functions, such as regulators, RTC, codec, Coulomb counter,
+	  etc.
+
+	  This driver includes core APIs _only_. You have to select
+	  individual components like voltage regulators under corresponding
+	  menus in order to enable them.
+	  We communicate with the Hi6421v600 via a SPMI bus.
diff --git a/drivers/staging/hikey9xx/Makefile b/drivers/staging/hikey9xx/Makefile
index e8085abce444..79de37da7a8f 100644
--- a/drivers/staging/hikey9xx/Makefile
+++ b/drivers/staging/hikey9xx/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_SPMI_HISI3670) += hisi-spmi-controller.o
+obj-$(CONFIG_SPMI_HISI3670)	+= hisi-spmi-controller.o
+obj-$(CONFIG_MFD_HI6421_SPMI)	+= hi6421-spmi-pmic.o
-- 
2.26.2

