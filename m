Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532B72C5FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 06:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgK0Fgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 00:36:46 -0500
Received: from smtpbg702.qq.com ([203.205.195.102]:51315 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729830AbgK0Fgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 00:36:46 -0500
X-Greylist: delayed 78025 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Nov 2020 00:36:45 EST
X-QQ-mid: bizesmtp17t1606455382tq2xz4a8
Received: from localhost.localdomain (unknown [115.238.52.186])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 27 Nov 2020 13:36:21 +0800 (CST)
X-QQ-SSF: 0120000000800070B000B00A0000000
X-QQ-FEAT: zN8aTbUO6yNNgGYJ4vOtjrU8x/KUgr9Mba0IGxwhgvtjzXkKwduROXQmvU9iv
        m0Cp1K+6ryqXRSJyJ9qCR7eJYNhsiyKyz9a/qY4rIwi3S2hOH1MAaREoKEKCvuBe6qnlulr
        zRB1XWX95icSf2tqZo9J79f7tdELdhMpGE2txZR84Vd27MTw/hOEBzyTqRrKYtqJcvsJAmC
        DvZljsttQF31S4mTOlph2cdMRTslCPN4r0BlYzoJWN1/zMDqZIfJmt4BffcTeROUmmqPigF
        bXrZe1CSF9sNbey6fI4b2X0avor/68/XRrEzqwGVeSW3OE75i8ow0LXo0=
X-QQ-GoodBg: 0
From:   linshenghuan@hangtu-china.com
To:     linus.walleij@linaro.org, khilman@baylibre.com,
        narmstrong@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, linshenghuan@hangtu-china.com
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lin shenghuan <linsheng_111@163.com>
Subject: [PATCH] add amlogic gpio to irq
Date:   Fri, 27 Nov 2020 13:36:19 +0800
Message-Id: <1606455379-7236-1-git-send-email-linshenghuan@hangtu-china.com>
X-Mailer: git-send-email 2.7.4
Signed-off-by: Lin shenghuan <linshenghuan@hangtu-china.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:hangtu-china.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin shenghuan <linsheng_111@163.com>

---
 drivers/pinctrl/meson/pinctrl-meson.c | 36 +++++++++++++++++++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson.h |  1 +
 2 files changed, 37 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 20683cd..b91ff2c 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -51,6 +51,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
+#include <linux/of_irq.h>
 
 #include "../core.h"
 #include "../pinctrl-utils.h"
@@ -598,6 +599,34 @@ static int meson_gpio_get(struct gpio_chip *chip, unsigned gpio)
 	return !!(val & BIT(bit));
 }
 
+static int meson_gpio_to_irq(struct gpio_chip *chip, unsigned int gpio)
+{
+	struct meson_pinctrl *pc = gpiochip_get_data(chip);
+	struct meson_bank *bank;
+	struct irq_fwspec fwspec;
+	int hwirq;
+
+	if (meson_get_bank(pc, gpio, &bank))
+		return -EINVAL;
+
+	if (bank->irq_first < 0) {
+		dev_warn(pc->dev, "no support irq for pin[%d]\n", gpio);
+		return -EINVAL;
+	}
+	if (!pc->of_irq) {
+		dev_err(pc->dev, "invalid device node of gpio INTC\n");
+		return -EINVAL;
+	}
+
+	hwirq = gpio - bank->first + bank->irq_first;
+	fwspec.fwnode = of_node_to_fwnode(pc->of_irq);
+	fwspec.param_count = 2;
+	fwspec.param[0] = hwirq;
+	fwspec.param[1] = IRQ_TYPE_NONE;
+
+	return irq_create_fwspec_mapping(&fwspec);
+}
+
 static int meson_gpiolib_register(struct meson_pinctrl *pc)
 {
 	int ret;
@@ -612,6 +641,7 @@ static int meson_gpiolib_register(struct meson_pinctrl *pc)
 	pc->chip.direction_output = meson_gpio_direction_output;
 	pc->chip.get = meson_gpio_get;
 	pc->chip.set = meson_gpio_set;
+	pc->chip.to_irq = meson_gpio_to_irq;
 	pc->chip.base = -1;
 	pc->chip.ngpio = pc->data->num_pins;
 	pc->chip.can_sleep = false;
@@ -682,6 +712,12 @@ static int meson_pinctrl_parse_dt(struct meson_pinctrl *pc,
 
 	pc->of_node = gpio_np;
 
+	pc->of_irq = of_find_compatible_node(NULL,
+			NULL, "amlogic,meson-gpio-intc");
+	if (!pc->of_irq)
+		pc->of_irq = of_find_compatible_node(NULL,
+			NULL, "amlogic,meson-gpio-intc-ext");
+
 	pc->reg_mux = meson_map_resource(pc, gpio_np, "mux");
 	if (IS_ERR_OR_NULL(pc->reg_mux)) {
 		dev_err(pc->dev, "mux registers not found\n");
diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
index f8b0ff9..0f808bb 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.h
+++ b/drivers/pinctrl/meson/pinctrl-meson.h
@@ -131,6 +131,7 @@ struct meson_pinctrl {
 	struct regmap *reg_ds;
 	struct gpio_chip chip;
 	struct device_node *of_node;
+	struct device_node *of_irq;
 };
 
 #define FUNCTION(fn)							\
-- 
2.7.4



