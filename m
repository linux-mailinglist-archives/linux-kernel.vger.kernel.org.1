Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED20A2E32C7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 22:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgL0VOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 16:14:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40326 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726371AbgL0VOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 16:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609103572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LvFJh0Qn1ycOxxwBE4kQRIv/qlxm9GSq3qk1YZJCsBI=;
        b=DeVECPtTWEQNbj93ToG7HDyxrAHKHk6rEMVvxiz/BcnBSPjCbvAAKlmMo98RjQi6/X01Uw
        o2/N1OZAxlfBB9QCQ+qzCGEZNKl1wfqeP4QRnfqrHDLoQbiDCRim+p/JvsaCBB4oI9aNFY
        XRu4UZANZCdCOSc/SzDZvMyXjG1bVYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-2-wQVVySM4mPqReCKZ943A-1; Sun, 27 Dec 2020 16:12:48 -0500
X-MC-Unique: 2-wQVVySM4mPqReCKZ943A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91C69800D53;
        Sun, 27 Dec 2020 21:12:46 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-25.ams2.redhat.com [10.36.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AB641ACB9;
        Sun, 27 Dec 2020 21:12:44 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 04/14] mfd: arizona: Allow building arizona MFD-core as module
Date:   Sun, 27 Dec 2020 22:12:22 +0100
Message-Id: <20201227211232.117801-5-hdegoede@redhat.com>
In-Reply-To: <20201227211232.117801-1-hdegoede@redhat.com>
References: <20201227211232.117801-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason why the arizona core,irq and codec model specific
regmap bits cannot be build as a module. All they do is export symbols
which are used by the arizona-spi and/or arizona-i2c modules, which
themselves can be built as module.

Change the Kconfig and Makefile arizona bits so that the arizona MFD-core
can be built as a module.

This is especially useful on x86 platforms with a WM5102 codec, this
allows the arizona MFD driver necessary for the WM5102 codec to be
enabled in generic distro-kernels without growing the base kernel-image
size.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/Kconfig        |  2 +-
 drivers/mfd/Makefile       | 14 +++++++-------
 drivers/mfd/arizona-core.c |  2 ++
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index cc0b73280c68..8fe9e10eaf51 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1831,7 +1831,7 @@ config MFD_ARIZONA
 	select REGMAP
 	select REGMAP_IRQ
 	select MFD_CORE
-	bool
+	tristate
 
 config MFD_ARIZONA_I2C
 	tristate "Cirrus Logic/Wolfson Microelectronics Arizona platform with I2C"
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 14fdb188af02..3f208af1664f 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -41,24 +41,24 @@ obj-$(CONFIG_MFD_TQMX86)	+= tqmx86.o
 
 obj-$(CONFIG_MFD_LOCHNAGAR)	+= lochnagar-i2c.o
 
-obj-$(CONFIG_MFD_ARIZONA)	+= arizona-core.o
-obj-$(CONFIG_MFD_ARIZONA)	+= arizona-irq.o
+arizona-objs			:= arizona-core.o arizona-irq.o
+obj-$(CONFIG_MFD_ARIZONA)	+= arizona.o
 obj-$(CONFIG_MFD_ARIZONA_I2C)	+= arizona-i2c.o
 obj-$(CONFIG_MFD_ARIZONA_SPI)	+= arizona-spi.o
 ifeq ($(CONFIG_MFD_WM5102),y)
-obj-$(CONFIG_MFD_ARIZONA)	+= wm5102-tables.o
+arizona-objs			+= wm5102-tables.o
 endif
 ifeq ($(CONFIG_MFD_WM5110),y)
-obj-$(CONFIG_MFD_ARIZONA)	+= wm5110-tables.o
+arizona-objs			+= wm5110-tables.o
 endif
 ifeq ($(CONFIG_MFD_WM8997),y)
-obj-$(CONFIG_MFD_ARIZONA)	+= wm8997-tables.o
+arizona-objs			+= wm8997-tables.o
 endif
 ifeq ($(CONFIG_MFD_WM8998),y)
-obj-$(CONFIG_MFD_ARIZONA)	+= wm8998-tables.o
+arizona-objs			+= wm8998-tables.o
 endif
 ifeq ($(CONFIG_MFD_CS47L24),y)
-obj-$(CONFIG_MFD_ARIZONA)	+= cs47l24-tables.o
+arizona-objs			+= cs47l24-tables.o
 endif
 obj-$(CONFIG_MFD_WCD934X)	+= wcd934x.o
 obj-$(CONFIG_MFD_WM8400)	+= wm8400-core.o
diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 000cb82023e3..a9ba1c865abf 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -1478,3 +1478,5 @@ int arizona_dev_exit(struct arizona *arizona)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(arizona_dev_exit);
+
+MODULE_LICENSE("GPL v2");
-- 
2.28.0

