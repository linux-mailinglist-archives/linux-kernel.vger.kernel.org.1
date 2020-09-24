Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82745277B58
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 23:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgIXVy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 17:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgIXVyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 17:54:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9559CC0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 14:54:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n13so664696ybk.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 14:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=TuyfSxIkZi+P/JhBNIB6urUJLMN4tVR/8LkLgR5gW14=;
        b=FWvIVB4nFy3TjF5TUaGKfr+gr0IDuCj3iVXYiz3beykXZPAzbGXNgRRCPQB206Y1KQ
         WdZtttptVeUthPPTUhjCn1TS4PeYU2tViVkVdp3dP9LaFDi7T6qd8VsmnDZeQZWmODM1
         9Znb9S+vKoQy59WNTM1nvYuWItx4WnHMy0G52VerG4CajSRNUvoGkGUJIxFRLBawOzAu
         uDnJ7UAuk0mW8VgMcKRk5EJZTQohl3aUyJtzunt+Y+/gBZhM3kCWCKsblFn0HCOlJulg
         4JciRiKxwuf1siqUq3/Eu7De/jsoTXRVXgrx3AOhb83Xz/oUmnVtaT+IKXkIavPcAgjD
         vCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=TuyfSxIkZi+P/JhBNIB6urUJLMN4tVR/8LkLgR5gW14=;
        b=BcQVnLoJzGUiWnj8TkarESVsjs8gJi4SFJLf7yuF8yvJqFJfa4NsgnhIqqFGvHyKZD
         nlG3oLd8Q5j/WXC8+wAE7ysdR4xAyP7AaEuhiyQCFGXlWQrxOitHlaDh20QvZWQzmB6R
         xOYM+57tu7HNTwvinLK+aFEMt+qfbUvyyH/SL2oPQzbx1qa+sYg0HB78l+T6/7UncYTp
         yBaUkX9namPSUaet25rc/aoaZTkcgwMUqUCzRyVWJNz8lK/BMKqPfKdfdZ4KtIkZ+KQo
         BSAE7GM7MWTxRoVC7N1ReG2Mjdd3XEpoJFplsmBV1aZKFnYIKEPiFONLkjmCkcAND+0s
         OXiw==
X-Gm-Message-State: AOAM533rLJVz3WSmOznXuJOxG6nA+uc+lxz8oQ+aahtoQDXOQ8KEo0F4
        4lHG9uzktRzHTDENBi1Yk4f2E8AlKL8v9rus
X-Google-Smtp-Source: ABdhPJzk4yQgT36MZ0fV0H+HiXWybvORRJARsR02oEoMKu0Ap8ErrcXpHPJ3T5bsC1iNb+dOpAdOjLETvfnRZ1cH
Sender: "linchuyuan via sendgmr" <linchuyuan@chu-dev.c.googlers.com>
X-Received: from chu-dev.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3cfb])
 (user=linchuyuan job=sendgmr) by 2002:a25:e0d2:: with SMTP id
 x201mr1323962ybg.180.1600984494820; Thu, 24 Sep 2020 14:54:54 -0700 (PDT)
Date:   Thu, 24 Sep 2020 21:54:44 +0000
In-Reply-To: <20200924215444.2865885-1-linchuyuan@google.com>
Message-Id: <20200924215444.2865885-3-linchuyuan@google.com>
Mime-Version: 1.0
References: <20200924215444.2865885-1-linchuyuan@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 2/2] hwmon: pmbus: max20730: adjust the vout reading given
 voltage divider
From:   Chu Lin <linchuyuan@google.com>
To:     linchuyuan@google.com, jdelvare@suse.com, linux@roeck-us.net,
        robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        qiongwang@google.com, zhongqil@google.com, jasonling@google.com,
        belgaied@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
We use voltage dividers so that the voltage presented at the voltage
sense pins is confusing. We might need to convert these readings to more
meaningful readings given the voltage divider.

Solution:
Read the voltage divider resistance from dts and convert the voltage
reading to a more meaningful reading.

Testing:
max20730 with voltage divider

Signed-off-by: Chu Lin <linchuyuan@google.com>
---
 drivers/hwmon/pmbus/max20730.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
index a151a2b588a5..fbf2f1e6c969 100644
--- a/drivers/hwmon/pmbus/max20730.c
+++ b/drivers/hwmon/pmbus/max20730.c
@@ -31,6 +31,7 @@ struct max20730_data {
 	struct pmbus_driver_info info;
 	struct mutex lock;	/* Used to protect against parallel writes */
 	u16 mfr_devset1;
+	u32 vout_voltage_divider[2];
 };
 
 #define to_max20730_data(x)  container_of(x, struct max20730_data, info)
@@ -114,6 +115,14 @@ static int max20730_read_word_data(struct i2c_client *client, int page,
 		max_c = max_current[data->id][(data->mfr_devset1 >> 5) & 0x3];
 		ret = val_to_direct(max_c, PSC_CURRENT_OUT, info);
 		break;
+	case PMBUS_READ_VOUT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret > 0 && data->vout_voltage_divider[0] && data->vout_voltage_divider[1]) {
+			u64 temp = DIV_ROUND_CLOSEST_ULL((u64)ret * data->vout_voltage_divider[1],
+							 data->vout_voltage_divider[0]);
+			ret = clamp_val(temp, 0, 0xffff);
+		}
+		break;
 	default:
 		ret = -ENODATA;
 		break;
@@ -364,6 +373,15 @@ static int max20730_probe(struct i2c_client *client,
 	data->id = chip_id;
 	mutex_init(&data->lock);
 	memcpy(&data->info, &max20730_info[chip_id], sizeof(data->info));
+	if (of_property_read_u32_array(client->dev.of_node, "vout-voltage-divider",
+				       data->vout_voltage_divider,
+				       ARRAY_SIZE(data->vout_voltage_divider)) != 0)
+		memset(data->vout_voltage_divider, 0, sizeof(data->vout_voltage_divider));
+	if (data->vout_voltage_divider[1] < data->vout_voltage_divider[0]) {
+		dev_err(dev,
+			"The total resistance of voltage divider is less than output resistance\n");
+		return -ENODEV;
+	}
 
 	ret = i2c_smbus_read_word_data(client, MAX20730_MFR_DEVSET1);
 	if (ret < 0)
-- 
2.28.0.681.g6f77f65b4e-goog

