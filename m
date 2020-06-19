Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF85200824
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 13:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732426AbgFSLzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 07:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732790AbgFSLyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 07:54:52 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FCFC0613EE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 04:54:51 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k1so3847725pls.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 04:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OL6qEmwiDI00DREj99RAu4RhZr0L6rP8DGjoGZeNxMU=;
        b=QSOfULewQhPqGkXO1surS+5mrsy5CFU9klKHs/HAtKZDikUdmzglAbtVfIJMy40dKL
         ujnuPmltmegEY3PgY2I30Mt7tubFC/2V2o5x4MEfhWsmeQohRQO1/sLhfpZThOspqqFG
         mil8x5KCsh6vwUYBj+WW+t0tHSDKnhLPGFjPmhqvMwghkjyLIqXuzSi/FOPyk5OPO2V7
         +b8KAkLIMYuRknfklgTT01RfaTl58SI/mGfS9jBdm7z/QXmtRIa0EyGPv3AwlaPyv90I
         EOjxmXh/eWnJthyhQI5b428fV0Tup+k/wHCcO525Gofp9aS4jeY9EoRG4Q/0nxpTYPP0
         8XxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OL6qEmwiDI00DREj99RAu4RhZr0L6rP8DGjoGZeNxMU=;
        b=Aq/1F8LBWjn31g8h4I1+m/jfNKSHOhx6sez66a7HiMYUpSXPYvgUyjgYqh1vLyUkF/
         +VFVQMQJq0ivs0PI5eZ5/hGdrvkUaMu4tBLJfHPAqaeBER3MrGW4gP5U0Q8GpMSP3HdC
         XfdqxMp+tbB+HWbJ+3JQVVHnj/e03q20wq6UcZgsscxh2LvOgtpediZviUUK2XymtVbL
         0bDPtMJg5/WgoytdySBDsQQoHzsaUNCjFzdP98dygYl0dMqqiwEQmEkys9TASonLSroU
         CqfTvdSCTWNabDPVt1+8Nnbjx18KscdTce4xG5SiWrAe37f6sgRJg8nDBunAKt4ovEBS
         ZFjg==
X-Gm-Message-State: AOAM531VxMFA02kY37fDhqcr8Z5r6XKFRtrVXmXO2VFPskPG8mEM2ITz
        BHERKOd1jBixEQzgsZbAXz8=
X-Google-Smtp-Source: ABdhPJytpgnbWnTDlb5gcE4DuLeIzbpACpN5MZdp+bjFW5krAlBHwmfmPVdDKmrr3+dGHfUe/mIIlQ==
X-Received: by 2002:a17:90a:1985:: with SMTP id 5mr3205948pji.123.1592567691059;
        Fri, 19 Jun 2020 04:54:51 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46c:79b7:a5d3:5b37:1d99:175a])
        by smtp.gmail.com with ESMTPSA id n64sm5026712pga.38.2020.06.19.04.54.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 04:54:50 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, jic23@kernel.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, matthias.bgg@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmurphy@ti.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Subject: [PATCH v2 3/4] iio: adc: mt6360: Add ADC driver for MT6360
Date:   Fri, 19 Jun 2020 19:53:50 +0800
Message-Id: <1592567631-20363-4-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592567631-20363-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1592567631-20363-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add MT6360 ADC driver include Charger Current, Voltage, and
Temperature.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/iio/adc/Kconfig      |  11 ++
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/mt6360-adc.c | 388 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 400 insertions(+)
 create mode 100644 drivers/iio/adc/mt6360-adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index ff35696..7c77424 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -702,6 +702,17 @@ config MCP3911
 	  This driver can also be built as a module. If so, the module will be
 	  called mcp3911.
 
+config MEDIATEK_MT6360_ADC
+	tristate "Mediatek MT6360 ADC Part"
+	depends on MFD_MT6360
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say Y here to enable MT6360 ADC Part.
+	  Integrated for System Monitoring include
+	  Charger and Battery Current, Voltage and
+	  Temperature
+
 config MEDIATEK_MT6577_AUXADC
 	tristate "MediaTek AUXADC driver"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 90f94ad..5fca90a 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_MAX9611) += max9611.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
 obj-$(CONFIG_MCP3422) += mcp3422.o
 obj-$(CONFIG_MCP3911) += mcp3911.o
+obj-$(CONFIG_MEDIATEK_MT6360_ADC) += mt6360-adc.o
 obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
 obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
 obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
new file mode 100644
index 0000000..a8ca80d
--- /dev/null
+++ b/drivers/iio/adc/mt6360-adc.c
@@ -0,0 +1,388 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ *
+ * Author: Gene Chen <gene_chen@richtek.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/completion.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/ktime.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+
+#define MT6360_REG_PMUCHGCTRL3	0x313
+#define MT6360_REG_PMUADCCFG	0x356
+#define MT6360_REG_PMUADCRPT1	0x35A
+
+/* PMUCHGCTRL3 0x313 */
+#define MT6360_AICR_MASK	0xFC
+#define MT6360_AICR_SHFT	2
+#define MT6360_AICR_400MA	0x6
+/* PMUADCCFG 0x356 */
+#define MT6360_ADCEN_MASK	0x8000
+/* PMUADCRPT1 0x35A */
+#define MT6360_PREFERCH_MASK	0xF0
+#define MT6360_PREFERCH_SHFT	4
+#define MT6360_RPTCH_MASK	0x0F
+
+enum {
+	MT6360_CHAN_USBID = 0,
+	MT6360_CHAN_VBUSDIV5,
+	MT6360_CHAN_VBUSDIV2,
+	MT6360_CHAN_VSYS,
+	MT6360_CHAN_VBAT,
+	MT6360_CHAN_IBUS,
+	MT6360_CHAN_IBAT,
+	MT6360_CHAN_CHG_VDDP,
+	MT6360_CHAN_TEMP_JC,
+	MT6360_CHAN_VREF_TS,
+	MT6360_CHAN_TS,
+	MT6360_CHAN_MAX,
+};
+
+struct mt6360_adc_data {
+	struct device *dev;
+	struct regmap *regmap;
+	struct completion adc_complete;
+	struct mutex adc_lock;
+	ktime_t last_off_timestamps[MT6360_CHAN_MAX];
+	int irq;
+};
+
+static inline int mt6360_adc_val_converter(int val, int multiplier,
+					   int offset, int divisor)
+{
+	return ((val * multiplier) + offset) / divisor;
+}
+
+static int mt6360_adc_convert_processed_val(struct mt6360_adc_data *info,
+					    int chan_idx, int *val)
+{
+	unsigned int regval = 0;
+	const struct converter {
+		int multiplier;
+		int offset;
+		int divisor;
+	} adc_converter[MT6360_CHAN_MAX] = {
+		{ 1250, 0, 1}, /* USBID */
+		{ 6250, 0, 1}, /* VBUSDIV5 */
+		{ 2500, 0, 1}, /* VBUSDIV2 */
+		{ 1250, 0, 1}, /* VSYS */
+		{ 1250, 0, 1}, /* VBAT */
+		{ 2500, 0, 1}, /* IBUS */
+		{ 2500, 0, 1}, /* IBAT */
+		{ 1250, 0, 1}, /* CHG_VDDP */
+		{ 105, -8000, 100}, /* TEMP_JC */
+		{ 1250, 0, 1}, /* VREF_TS */
+		{ 1250, 0, 1}, /* TS */
+	}, sp_ibus_adc_converter = { 1900, 0, 1 }, *sel_converter;
+	int ret;
+
+	sel_converter = adc_converter + chan_idx;
+	if (chan_idx == MT6360_CHAN_IBUS) {
+		/* ibus chan will be affected by aicr config */
+		/* if aicr < 400, apply the special ibus converter */
+		ret = regmap_read(info->regmap,
+				  MT6360_REG_PMUCHGCTRL3, &regval);
+		if (ret)
+			return ret;
+
+		regval = (regval & MT6360_AICR_MASK) >> MT6360_AICR_SHFT;
+		if (regval < MT6360_AICR_400MA)
+			sel_converter = &sp_ibus_adc_converter;
+	}
+
+	*val = mt6360_adc_val_converter(*val, sel_converter->multiplier,
+					sel_converter->offset,
+					sel_converter->divisor);
+
+	return 0;
+}
+
+static int mt6360_adc_read_processed(struct mt6360_adc_data *mad,
+				     int channel, int *val)
+{
+	u16 adc_enable;
+	u8 rpt[3];
+	ktime_t start_t, predict_end_t;
+	long timeout;
+	int value, ret;
+
+	mutex_lock(&mad->adc_lock);
+
+	/* select preferred channel that we want */
+	ret = regmap_update_bits(mad->regmap,
+				 MT6360_REG_PMUADCRPT1, MT6360_PREFERCH_MASK,
+				 channel << MT6360_PREFERCH_SHFT);
+	if (ret)
+		goto out_adc;
+
+	/* enable adc channel we want and adc_en */
+	adc_enable = MT6360_ADCEN_MASK | BIT(channel);
+	adc_enable = cpu_to_be16(adc_enable);
+	ret = regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG,
+			       (void *)&adc_enable, sizeof(u16));
+	if (ret)
+		goto out_adc;
+
+	start_t = ktime_get();
+	predict_end_t = ktime_add_ms(mad->last_off_timestamps[channel], 50);
+
+	if (ktime_after(start_t, predict_end_t))
+		predict_end_t = ktime_add_ms(start_t, 25);
+	else
+		predict_end_t = ktime_add_ms(start_t, 75);
+
+	enable_irq(mad->irq);
+adc_retry:
+	reinit_completion(&mad->adc_complete);
+
+	/* wait for conversion to complete */
+	timeout = wait_for_completion_timeout(&mad->adc_complete,
+					      msecs_to_jiffies(200));
+	if (timeout == 0) {
+		ret = -ETIMEDOUT;
+		goto out_adc_conv;
+	} else if (timeout < 0) {
+		ret = -EINTR;
+		goto out_adc_conv;
+	}
+
+	ret = regmap_raw_read(mad->regmap,
+			      MT6360_REG_PMUADCRPT1, rpt, sizeof(rpt));
+	if (ret)
+		goto out_adc_conv;
+
+	/* check the current reported channel */
+	if ((rpt[0] & MT6360_RPTCH_MASK) != channel) {
+		dev_dbg(mad->dev,
+			"not wanted channel report [%02x]\n", rpt[0]);
+		goto adc_retry;
+	}
+
+	if (!ktime_after(ktime_get(), predict_end_t)) {
+		dev_dbg(mad->dev, "time is not after one adc_conv_t\n");
+		goto adc_retry;
+	}
+
+	value = (rpt[1] << 8) | rpt[2];
+
+	ret = mt6360_adc_convert_processed_val(mad, channel, &value);
+	if (ret)
+		goto out_adc_conv;
+
+	*val = value;
+	ret = IIO_VAL_INT;
+
+out_adc_conv:
+	disable_irq(mad->irq);
+	adc_enable = MT6360_ADCEN_MASK;
+	adc_enable = cpu_to_be16(adc_enable);
+	regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG,
+			 (void *)&adc_enable, sizeof(u16));
+	mad->last_off_timestamps[channel] = ktime_get();
+	/* set prefer channel to 0xf */
+	regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1,
+			   MT6360_PREFERCH_MASK, 0xF << MT6360_PREFERCH_SHFT);
+out_adc:
+	mutex_unlock(&mad->adc_lock);
+
+	return ret;
+}
+
+static int mt6360_adc_read_raw(struct iio_dev *iio_dev,
+			       const struct iio_chan_spec *chan,
+			       int *val, int *val2, long mask)
+{
+	struct mt6360_adc_data *mad = iio_priv(iio_dev);
+
+	if (mask == IIO_CHAN_INFO_PROCESSED)
+		return mt6360_adc_read_processed(mad, chan->channel, val);
+
+	return -EINVAL;
+}
+
+static const struct iio_info mt6360_adc_iio_info = {
+	.read_raw = mt6360_adc_read_raw,
+};
+
+#define MT6360_ADC_CHAN(_idx, _type) {				\
+	.type = _type,						\
+	.channel = MT6360_CHAN_##_idx,				\
+	.scan_index = MT6360_CHAN_##_idx,			\
+	.scan_type =  {						\
+		.sign = 's',					\
+		.realbits = 32,					\
+		.storagebits = 32,				\
+		.shift = 0,					\
+		.endianness = IIO_CPU,				\
+	},							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),	\
+	.extend_name = #_idx,					\
+	.datasheet_name = #_idx,				\
+	.indexed = 1,						\
+}
+
+static const struct iio_chan_spec mt6360_adc_channels[] = {
+	MT6360_ADC_CHAN(USBID, IIO_VOLTAGE),
+	MT6360_ADC_CHAN(VBUSDIV5, IIO_VOLTAGE),
+	MT6360_ADC_CHAN(VBUSDIV2, IIO_VOLTAGE),
+	MT6360_ADC_CHAN(VSYS, IIO_VOLTAGE),
+	MT6360_ADC_CHAN(VBAT, IIO_VOLTAGE),
+	MT6360_ADC_CHAN(IBUS, IIO_CURRENT),
+	MT6360_ADC_CHAN(IBAT, IIO_CURRENT),
+	MT6360_ADC_CHAN(CHG_VDDP, IIO_VOLTAGE),
+	MT6360_ADC_CHAN(TEMP_JC, IIO_TEMP),
+	MT6360_ADC_CHAN(VREF_TS, IIO_VOLTAGE),
+	MT6360_ADC_CHAN(TS, IIO_VOLTAGE),
+	IIO_CHAN_SOFT_TIMESTAMP(MT6360_CHAN_MAX),
+};
+
+static irqreturn_t mt6360_pmu_adc_donei_handler(int irq, void *data)
+{
+	struct mt6360_adc_data *mad = iio_priv(data);
+
+	complete(&mad->adc_complete);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mt6360_adc_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	/* 11 ch s32 numbers + 1 s64 timestamp */
+	s32 data[MT6360_CHAN_MAX + 2] = { };
+	int i = 0, bit, val, ret;
+
+	for_each_set_bit(bit,
+			 indio_dev->active_scan_mask, indio_dev->masklength) {
+		const struct iio_chan_spec *chan = indio_dev->channels + bit;
+
+		ret = mt6360_adc_read_raw(indio_dev, chan, &val,
+					  NULL, IIO_CHAN_INFO_PROCESSED);
+		if (ret != IIO_VAL_INT) {
+			dev_warn(&indio_dev->dev,
+				 "Failed to get %d conversion val\n", bit);
+			goto out;
+		}
+
+		data[i++] = val;
+	}
+	iio_push_to_buffers_with_timestamp(indio_dev,
+					   data, iio_get_time_ns(indio_dev));
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static inline int mt6360_adc_reset(struct mt6360_adc_data *info)
+{
+	u8 configs[3] = {0x80, 0, 0};
+	ktime_t all_off_time;
+	int i;
+
+	all_off_time = ktime_get();
+	for (i = 0; i < MT6360_CHAN_MAX; i++)
+		info->last_off_timestamps[i] = all_off_time;
+
+	/* enable adc_en, clear adc_chn_en/zcv_en/adc_wait_t/adc_idle_t */
+	return regmap_raw_write(info->regmap,
+				MT6360_REG_PMUADCCFG, configs, sizeof(configs));
+}
+
+static int mt6360_adc_probe(struct platform_device *pdev)
+{
+	struct mt6360_adc_data *mad;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*mad));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	mad = iio_priv(indio_dev);
+	mad->dev = &pdev->dev;
+	init_completion(&mad->adc_complete);
+	mutex_init(&mad->adc_lock);
+
+	mad->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!mad->regmap) {
+		dev_err(&pdev->dev, "Failed to get parent regmap\n");
+		return -ENODEV;
+	}
+
+	ret = mt6360_adc_reset(mad);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to reset adc\n");
+		return ret;
+	}
+
+	mad->irq = platform_get_irq_byname(pdev, "adc_donei");
+	if (mad->irq < 0) {
+		dev_err(&pdev->dev, "Failed to get adc_done irq\n");
+		return mad->irq;
+	}
+
+	irq_set_status_flags(mad->irq, IRQ_NOAUTOEN);
+	ret = devm_request_threaded_irq(&pdev->dev, mad->irq, NULL,
+					mt6360_pmu_adc_donei_handler,
+					IRQF_TRIGGER_NONE, "adc_donei",
+					indio_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register adc_done irq\n");
+		return ret;
+	}
+
+	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->info = &mt6360_adc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = mt6360_adc_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mt6360_adc_channels);
+
+	ret = devm_iio_triggered_buffer_setup(&pdev->dev, indio_dev, NULL,
+					      mt6360_adc_trigger_handler, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to allocate iio trigger buffer\n");
+		return ret;
+	}
+
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register iio device\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	return 0;
+}
+
+static const struct of_device_id __maybe_unused mt6360_adc_of_id[] = {
+	{ .compatible = "mediatek,mt6360-adc", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mt6360_adc_of_id);
+
+static struct platform_driver mt6360_adc_driver = {
+	.driver = {
+		.name = "mt6360-adc",
+		.of_match_table = mt6360_adc_of_id,
+	},
+	.probe = mt6360_adc_probe,
+};
+module_platform_driver(mt6360_adc_driver);
+
+MODULE_AUTHOR("Gene Chen <gene_chen@richtek.com>");
+MODULE_DESCRIPTION("MT6360 ADC Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

