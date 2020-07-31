Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626BA234986
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 18:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbgGaQt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 12:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733278AbgGaQtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:49:15 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A449C06138D
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:49:12 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id y18so17431626ilp.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iPeLJC5RmTN6zDPmUvW9ZmlL+f5oIqstFwOQkWarKhY=;
        b=mauPgZkR3yYh8jMCKGBfhJgq+IYZTD+hGEW8hqlsiaoHIDa0vLMFwZe4WfYVuZomqY
         jtRGoYgexlntCTpWBbHsCfNbM/gtMxMzcby/7U7qFV4QHjFfBeLy1uS1nbHKtvPAcszc
         U2e+TmFMkQcSkVnL1xYWl+W/FGUXTZwaFp4OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iPeLJC5RmTN6zDPmUvW9ZmlL+f5oIqstFwOQkWarKhY=;
        b=eHUm/IVsgTKNoUJL4QmGg5ZZ+4k9q+FAX+bKf8CurSzG4jsQzpXL9W9NUzYBDv2PBY
         +/Hf07iIFha5L7XQW3Y/8Y4Tr3wEtDGj52moq687+9M1EW4zsxH+sQVYDyxuCcaU9KTs
         o+D1Yi4ifCqsMPLcpimNays9YsHC95fEVpTnTJvsiU8hnWGqkV03X9saFTShaGDly3Dt
         TJuXDDCol1L2uHtdoLFV4EoTdzlC35p+B7ibstg9YuP3/bnAv8Wq8wRduyOW7++9xSfY
         vLtQXviy38aUmvZL/rHLcwf+FJFmnFsv2fiAdn4Gb4hPYG9Uwi5ujUyt92+GuNgSx9L7
         U5ow==
X-Gm-Message-State: AOAM532y3M0t1JIetLDINT0LyZsrvhHp2wJ1EelT1f4X6VH3JdIyBmVv
        cMY/NVXpP7GV/JBOK6/OhnzL+Q==
X-Google-Smtp-Source: ABdhPJwKKkMUhHTHs8liqqiZEw6QbqKsR0VH1EETQ++13b9+/gCqkxAPhTie6BCSmDUT+IdW8uzOrQ==
X-Received: by 2002:a92:8b51:: with SMTP id i78mr4391748ild.179.1596214151902;
        Fri, 31 Jul 2020 09:49:11 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id e84sm5122083ill.60.2020.07.31.09.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:49:11 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 14/15] iio: sx9310: Enable vdd and svdd regulators at probe
Date:   Fri, 31 Jul 2020 10:48:51 -0600
Message-Id: <20200731104555.v3.14.Ib7bdc8340021d8515b430498fb6686eedf22c9f2@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200731164853.3020946-1-campello@chromium.org>
References: <20200731164853.3020946-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

Enable the main power supply (vdd) and digital IO power supply (svdd)
during probe so that the i2c communication and device works properly on
boards that aggressively power gate these supplies.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v3: None
Changes in v2: None

 drivers/iio/proximity/sx9310.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index aa21f6f1a58e3c..a20cd6a4dad729 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 #include <linux/iio/buffer.h>
@@ -120,6 +121,7 @@ struct sx9310_data {
 	struct i2c_client *client;
 	struct iio_trigger *trig;
 	struct regmap *regmap;
+	struct regulator_bulk_data supplies[2];
 	/*
 	 * Last reading of the proximity status for each channel.
 	 * We only send an event to user space when this changes.
@@ -879,6 +881,13 @@ static int sx9310_set_indio_dev_name(struct device *dev,
 	return 0;
 }
 
+static void sx9310_regulator_disable(void *_data)
+{
+	struct sx9310_data *data = _data;
+
+	regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
+}
+
 static int sx9310_probe(struct i2c_client *client)
 {
 	int ret;
@@ -892,6 +901,8 @@ static int sx9310_probe(struct i2c_client *client)
 
 	data = iio_priv(indio_dev);
 	data->client = client;
+	data->supplies[0].supply = "vdd";
+	data->supplies[1].supply = "svdd";
 	mutex_init(&data->mutex);
 	init_completion(&data->completion);
 
@@ -899,6 +910,21 @@ static int sx9310_probe(struct i2c_client *client)
 	if (IS_ERR(data->regmap))
 		return PTR_ERR(data->regmap);
 
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->supplies),
+				      data->supplies);
+	if (ret)
+		return ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies), data->supplies);
+	if (ret)
+		return ret;
+	/* Must wait for Tpor time after initial power up */
+	usleep_range(1000, 1100);
+
+	ret = devm_add_action_or_reset(dev, sx9310_regulator_disable, data);
+	if (ret)
+		return ret;
+
 	ret = regmap_read(data->regmap, SX9310_REG_WHOAMI, &data->whoami);
 	if (ret) {
 		dev_err(dev, "error in reading WHOAMI register: %d\n", ret);
-- 
2.28.0.163.g6104cc2f0b6-goog

