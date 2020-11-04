Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090802A5E93
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 08:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbgKDHJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 02:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgKDHJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 02:09:36 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4736AC061A4D;
        Tue,  3 Nov 2020 23:09:35 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id z2so18412745ilh.11;
        Tue, 03 Nov 2020 23:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KP9/fjUPS6sBq9156U7ipqEJlCjWJHRAiLQlK2DjSj8=;
        b=ceSCYs+hRGJatnkVPmaj6b5UcrmM2mw16E7xupX4He4iwiUDaLx1YztdC1jaQW78OJ
         RkTRfjrsONiVMCNAuqnCJjFN4S2UnmlE4bo91HNN82B5LtRLPLR+HSHS4tlJP4C8zZB3
         CC+EkGLOW+gd5ikPzohB0A/RR2kmMpC0UsHX6FmCbdrPOyWuJR6XOjkl0tSNV8PPs2od
         8YGD7tS+3HYREe9M4bPXZu56XuX05kzdT0osl1GjXpSGK3ZTSSPlU6OsvR79/EHg5gNB
         DZyjw+fdDqSKcrZ8nrYylrm/hTQtnZXF2t44/sdepPy6U/t0wITHTJIT869y2J53Rtjg
         Je0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KP9/fjUPS6sBq9156U7ipqEJlCjWJHRAiLQlK2DjSj8=;
        b=qUnI80CTpNZqVdfDvd5qQBXu5kZ6NtG3KdOpxgEvmv+nKGrIW7C/MbwAyRB5RPSWtj
         3gcWcy05WYs4Wp/66LYl0akh5LeLVrT9Er0kQKnFE24Y/rEyskq/yQMi3CaeGfedT2vX
         EkkUwAGbIKvHJs7fQwLPj/h5Azbtwsv+28uefmJJKYgDN6+3OPXMfpXEw7P4sg9EdLZJ
         HFYW+appKOV7w5CJNuWxCdYKf/sL04nuIcES721qt+ISn7jUYIEpujTMOXpOMofYzz+W
         4kkUJBBHFQGtGADempfA9MaUhDCQ73OLS8yvIzXLWHtuOziLxpw4WdMhnljFByKz8/8Z
         kYzA==
X-Gm-Message-State: AOAM530x+wIJlB1ljNkwj3nvsURuJpcipKt4aN/L6uxjPR9ZMCv6aNLZ
        FGm4sgBQWRc9Qk3nqRORpu0YdUnjiBFMJ6eCJRBZQn62
X-Google-Smtp-Source: ABdhPJwgqT9+2HFOX8NwQCdqXeH7sVeRpbo96RSarvxknfpjGXy5gxwtEdqLg4KEAzHPPtRaBTCdRcwj5zUzIk5G0Eg=
X-Received: by 2002:a05:6e02:4b1:: with SMTP id e17mr17323590ils.80.1604473774368;
 Tue, 03 Nov 2020 23:09:34 -0800 (PST)
MIME-Version: 1.0
From:   Yungteng Hsu <hsu.yungteng@gmail.com>
Date:   Wed, 4 Nov 2020 15:09:23 +0800
Message-ID: <CAFT9tymDmeBoAsESyMqE=woZMcUookJ3RgEJD4F6kKeFJJaPiw@mail.gmail.com>
Subject: [PATCH] hwmon: (pmbus) Add driver for STMicroelectronics PM6764
 Voltage Regulator
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc:     Yungteng Hsu <hsu.yungteng@gmail.com>, alan@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pmbus driver for the STMicroelectronics pm6764 voltage regulator.

the output voltage use the MFR_READ_VOUT 0xD4
vout value returned is linear11

Signed-off-by: Charles Hsu <hsu.yungteng@gmail.com>
---
 drivers/hwmon/pmbus/Kconfig    |  8 ++++
 drivers/hwmon/pmbus/Makefile   |  1 +
 drivers/hwmon/pmbus/pm6764tr.c | 74 ++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)
 create mode 100644 drivers/hwmon/pmbus/pm6764tr.c

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index a25faf69fce3..2b487c401a4e 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -220,6 +220,14 @@ config SENSORS_MP2975
   This driver can also be built as a module. If so, the module will
   be called mp2975.

+config SENSORS_PM6764TR
+ tristate "PM6764TR"
+ help
+  If you say yes here you get hardware monitoring support for PM6764TR.
+
+  This driver can also be built as a module. If so, the module will
+  be called pm6764tr.
+
 config SENSORS_PXE1610
  tristate "Infineon PXE1610"
  help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 4c97ad0bd791..31ebdef5d4a6 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_SENSORS_MAX31785) += max31785.o
 obj-$(CONFIG_SENSORS_MAX34440) += max34440.o
 obj-$(CONFIG_SENSORS_MAX8688) += max8688.o
 obj-$(CONFIG_SENSORS_MP2975) += mp2975.o
+obj-$(CONFIG_SENSORS_PM6764TR) += pm6764tr.o
 obj-$(CONFIG_SENSORS_PXE1610) += pxe1610.o
 obj-$(CONFIG_SENSORS_TPS40422) += tps40422.o
 obj-$(CONFIG_SENSORS_TPS53679) += tps53679.o
diff --git a/drivers/hwmon/pmbus/pm6764tr.c b/drivers/hwmon/pmbus/pm6764tr.c
new file mode 100644
index 000000000000..b125a1cbfea5
--- /dev/null
+++ b/drivers/hwmon/pmbus/pm6764tr.c
@@ -0,0 +1,74 @@
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/i2c.h>
+#include <linux/pmbus.h>
+#include "pmbus.h"
+
+#define PM6764TR_PMBUS_READ_VOUT 0xD4
+
+static int pm6764tr_read_word_data(struct i2c_client *client, int
page, int reg)
+{
+ int ret;
+
+ switch (reg) {
+ case PMBUS_VIRT_READ_VMON:
+ ret = pmbus_read_word_data(client, page,
+   PM6764TR_PMBUS_READ_VOUT);
+ break;
+ default:
+ ret = -ENODATA;
+ break;
+ }
+ return ret;
+}
+
+static struct pmbus_driver_info pm6764tr_info = {
+ .pages = 1,
+ .format[PSC_VOLTAGE_IN] = linear,
+ .format[PSC_VOLTAGE_OUT] = vid,
+ .format[PSC_TEMPERATURE] = linear,
+ .format[PSC_CURRENT_OUT] = linear,
+ .format[PSC_POWER] = linear,
+ .func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |  PMBUS_HAVE_PIN |
+    PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT | PMBUS_HAVE_VMON |
+ PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_VOUT |
+ PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+    .read_word_data = pm6764tr_read_word_data,
+};
+
+static int pm6764tr_probe(struct i2c_client *client,
+  const struct i2c_device_id *id)
+{
+ return pmbus_do_probe(client, id, &pm6764tr_info);
+}
+
+static const struct i2c_device_id pm6764tr_id[] = {
+ {"pm6764tr", 0},
+ {}
+};
+MODULE_DEVICE_TABLE(i2c, pm6764tr_id);
+
+static const struct of_device_id pm6764tr_of_match[] = {
+ {.compatible = "pm6764tr"},
+ {}
+};
+/* This is the driver that will be inserted */
+static struct i2c_driver pm6764tr_driver = {
+ .driver = {
+   .name = "pm6764tr",
+   .of_match_table = of_match_ptr(pm6764tr_of_match),
+   },
+ .probe = pm6764tr_probe,
+ .remove = pmbus_do_remove,
+ .id_table = pm6764tr_id,
+};
+
+module_i2c_driver(pm6764tr_driver);
+
+MODULE_AUTHOR("Charles Hsu");
+MODULE_DESCRIPTION("PMBus driver for  ST PM6764TR");
+MODULE_LICENSE("GPL");
--
2.25.1
