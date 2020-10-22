Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8D3295DE5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897749AbgJVMAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897741AbgJVMAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:00:21 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B434BC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 05:00:20 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i2so1631562ljg.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 05:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=n58NkZJzVjLKTzwsAFYxWlkrSZkVUrs3TijMJQaRZaw=;
        b=tVs6v7AliIf5OqxudM1o6/t24E2fdeL3c/N6yildMXqE7ac4i2kitgODKkNxeoLDoy
         wf/QOYJi9/gt2ye8kemMXJGC9v5qz6wwWdeMa3GmsABxI42n+ps0HYltOhRlBOj7GTcj
         pZUEJuy2AQAAiOIGaXPNY6HExKWrKEI8SPO+zgED8skofiUZEd6teVIeApWxNztIpWvR
         BVY+T+BrEjTD35I3oF4k+7S25aub8HPha4qsLKgnMwEzXQLSfD6XiELHt9CsAVZRtUlK
         ohYU8Ygo1D3J6bbSqFMCbfHzn6ASG+6w6//kVXCzFtmq7BbbxitM+yDJloLPkNgP1V1P
         Kziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=n58NkZJzVjLKTzwsAFYxWlkrSZkVUrs3TijMJQaRZaw=;
        b=qyNuNdW8lLLUehnCim79ma/Bbt1QDYnNQ0htSFXPVAobUKGxnLzW+vkNvHuAkMOy7y
         Hlw0TDkpg6aGsH1ED8Gvrx+rE/M8H9Txh1jrv2a4eh+Q/5EaSoU4ViiAcdsf3u+yHBr9
         hpGcqkBUT3VZQraukcZokGerfhg+sWDaPa/sMp9ROAs6rN1y0Kzohh+oaCJJSexnraEk
         QfdqvnXioQrE39zxGq0SBvZARjh1vG/rZgX/o7jjQnxKwI+i85B94N9hxEp04+Ltf0vE
         r+gQjZZkfgENnBgLh+QB8Ibie1L2ROzrywx5WYF/BmLy2deDLl6+ass/qq0EY42Q8+3S
         tjOA==
X-Gm-Message-State: AOAM530CV6WW2dkdbn8pdKRx94LmzJHwXa5PiimRK29UGqIjAwljltyw
        RjypAmqqyN01mTmABpnUNIL+mH4ENCwjCDq+5p1I/PNVcR8VCA==
X-Google-Smtp-Source: ABdhPJx/1Sdm5Xf6Slas9JKc+pC55zIgZlvcY3x67auMXV6X9l2ZdunX+0IIpBeZGXe19Ptaa5Fr8pFdq9OdXrLObdo=
X-Received: by 2002:a2e:a41a:: with SMTP id p26mr801300ljn.126.1603368018683;
 Thu, 22 Oct 2020 05:00:18 -0700 (PDT)
MIME-Version: 1.0
From:   Charles Hsu <hsu.yuegteng@gmail.com>
Date:   Thu, 22 Oct 2020 20:00:07 +0800
Message-ID: <CAJArhDZ2nTc-wHLKRon8_Oqo8WG28m7ni08saHrW=HqbJAHoew@mail.gmail.com>
Subject: [PATCH] hwmon: (pmbus) Add driver for STMicroelectronics PM6764TR
 Voltage Regulator
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pmbus driver for the STMicroelectronics pm6764tr voltage regulator.

Signed-off-by: Charles Hsu <hsu.yungteng@gmail.com>
---
 drivers/hwmon/pmbus/Kconfig    |  8 ++++
 drivers/hwmon/pmbus/Makefile   |  1 +
 drivers/hwmon/pmbus/pm6764tr.c | 76 ++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 drivers/hwmon/pmbus/pm6764tr.c

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index a25faf69fce3..e976997ee163 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -287,4 +287,12 @@ config SENSORS_ZL6100
   This driver can also be built as a module. If so, the module will
   be called zl6100.

+config SENSORS_PM6764TR
+ tristate "PM6764TR"
+ help
+  If you say yes here you get hardware monitoring support for PM6764TR.
+
+  This driver can also be built as a module. If so, the module will
+  be called pm6764tr.
+
 endif # PMBUS
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 4c97ad0bd791..bb89fcf9544d 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -32,3 +32,4 @@ obj-$(CONFIG_SENSORS_UCD9000) += ucd9000.o
 obj-$(CONFIG_SENSORS_UCD9200) += ucd9200.o
 obj-$(CONFIG_SENSORS_XDPE122) += xdpe12284.o
 obj-$(CONFIG_SENSORS_ZL6100) += zl6100.o
+obj-$(CONFIG_SENSORS_PM6764TR) += pm6764tr.o
\ No newline at end of file
diff --git a/drivers/hwmon/pmbus/pm6764tr.c b/drivers/hwmon/pmbus/pm6764tr.c
new file mode 100644
index 000000000000..e03b1441268e
--- /dev/null
+++ b/drivers/hwmon/pmbus/pm6764tr.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
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
+
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
+MODULE_DESCRIPTION("PMBus driver for ST PM6764TR");
+MODULE_LICENSE("GPL");
--
2.25.1
