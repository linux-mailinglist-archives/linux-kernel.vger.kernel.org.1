Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C935285632
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 03:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgJGBSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 21:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgJGBRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 21:17:43 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174F0C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 18:17:43 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x22so357565pfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 18:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gw1RFzK+yqUfrbLUb2+nTAxxqoc8k7XTSgedNtFofyE=;
        b=KW1eYdUOTFYv/3AJKwfDa46x4IHQKU4VsU0Ai9HLubvbn49YCdTUy0dvdakyVi8pcu
         2wTWd07WlSi1SBZvhcfM1hN1yk+hZ6SGkwar3a52QBmfYx29sjI+kMUBBnFADmc2Ns42
         E8WQnaT3NHUfzSoTra+rfHcrmcmNxOxnZapqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gw1RFzK+yqUfrbLUb2+nTAxxqoc8k7XTSgedNtFofyE=;
        b=AZ9cv95N5ZS4wwlPwF4CxfWuY0n46fORNB4SkEnO2cI71vVw7l3+VMNjVRZhAMn91x
         a/pKf5SeJVxZ653dokn4J/e3CnRXuCZdk30nfw18cSHr/6m6Kce0fxe+sTMIexVffwZ/
         rXxiE99diK4QNG1+h0ctHeUoet1el/oLkuV1K3jP9WgPnSiCiki214n3JFDKrboHLngE
         u0MaXqINlyNn0YUiiOjw1ocW0S0AgOSRIcjdouKC0aMPrGP2K2Bu1wyT2xSHyxqPhCcZ
         /4SCYxuPOzUjTKC85+b0XMMVduSJlUu76ssrgCeS2qq3PbuExLdsjKro1YbP+OzAaBQn
         o9Sw==
X-Gm-Message-State: AOAM531NoeBHDV/ZZC1yR2Q0hOUBjtBoZnYJK3jzd94OP8O66RIyPtsm
        agYkqi3XKHqV/HbTOjLqzyaC0Q==
X-Google-Smtp-Source: ABdhPJypa1SfsOcel80AqtvZE0mEezoKDSIuNuAQkrgOrTnA6dZN7jKoIiKTUNsgaHbPcspUqpl00A==
X-Received: by 2002:a63:2246:: with SMTP id t6mr835470pgm.103.1602033462671;
        Tue, 06 Oct 2020 18:17:42 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z190sm482654pfc.89.2020.10.06.18.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 18:17:42 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH v3 4/6] iio: sx9310: Support setting debounce values
Date:   Tue,  6 Oct 2020 18:17:33 -0700
Message-Id: <20201007011735.1346994-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
In-Reply-To: <20201007011735.1346994-1-swboyd@chromium.org>
References: <20201007011735.1346994-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rising and falling directions can be debounced in the hardware as
"close" and "far" debounce settings. Add support for these as rising and
falling debounce settings.

Cc: Daniel Campello <campello@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Evan Green <evgreen@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/iio/proximity/sx9310.c | 100 +++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 9eb10e8263e7..3f909177eca9 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -77,6 +77,8 @@
 #define SX9310_REG_PROX_CTRL10				0x1a
 #define   SX9310_REG_PROX_CTRL10_HYST_MASK		GENMASK(5, 4)
 #define   SX9310_REG_PROX_CTRL10_HYST_6PCT		(0x01 << 4)
+#define   SX9310_REG_PROX_CTRL10_CLOSE_DEBOUNCE_MASK	GENMASK(3, 2)
+#define   SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_MASK	GENMASK(1, 0)
 #define   SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_2		0x01
 #define SX9310_REG_PROX_CTRL11				0x1b
 #define SX9310_REG_PROX_CTRL12				0x1c
@@ -147,6 +149,16 @@ struct sx9310_data {
 };
 
 static const struct iio_event_spec sx9310_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
+	},
 	{
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_EITHER,
@@ -601,6 +613,42 @@ static int sx9310_read_hysteresis(struct sx9310_data *data,
 	return IIO_VAL_INT;
 }
 
+static int sx9310_read_far_debounce(struct sx9310_data *data, int *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL10, &regval);
+	if (ret)
+		return ret;
+
+	regval = FIELD_GET(SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_MASK, regval);
+	if (regval)
+		*val = 1 << regval;
+	else
+		*val = 0;
+
+	return IIO_VAL_INT;
+}
+
+static int sx9310_read_close_debounce(struct sx9310_data *data, int *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL10, &regval);
+	if (ret)
+		return ret;
+
+	regval = FIELD_GET(SX9310_REG_PROX_CTRL10_CLOSE_DEBOUNCE_MASK, regval);
+	if (regval)
+		*val = 1 << regval;
+	else
+		*val = 0;
+
+	return IIO_VAL_INT;
+}
+
 static int sx9310_read_event_val(struct iio_dev *indio_dev,
 				 const struct iio_chan_spec *chan,
 				 enum iio_event_type type,
@@ -615,6 +663,15 @@ static int sx9310_read_event_val(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		return sx9310_read_thresh(data, chan, val);
+	case IIO_EV_INFO_PERIOD:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return sx9310_read_far_debounce(data, val);
+		case IIO_EV_DIR_FALLING:
+			return sx9310_read_close_debounce(data, val);
+		default:
+			return -EINVAL;
+		}
 	case IIO_EV_INFO_HYSTERESIS:
 		return sx9310_read_hysteresis(data, chan, val);
 	default:
@@ -682,6 +739,40 @@ static int sx9310_write_hysteresis(struct sx9310_data *data,
 	return ret;
 }
 
+static int sx9310_write_far_debounce(struct sx9310_data *data, int val)
+{
+	int ret;
+	unsigned int regval;
+
+	val = ilog2(val);
+	regval = FIELD_PREP(SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_MASK, val);
+
+	mutex_lock(&data->mutex);
+	ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL10,
+				 SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_MASK,
+				 regval);
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int sx9310_write_close_debounce(struct sx9310_data *data, int val)
+{
+	int ret;
+	unsigned int regval;
+
+	val = ilog2(val);
+	regval = FIELD_PREP(SX9310_REG_PROX_CTRL10_CLOSE_DEBOUNCE_MASK, val);
+
+	mutex_lock(&data->mutex);
+	ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL10,
+				 SX9310_REG_PROX_CTRL10_CLOSE_DEBOUNCE_MASK,
+				 regval);
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
 static int sx9310_write_event_val(struct iio_dev *indio_dev,
 				  const struct iio_chan_spec *chan,
 				  enum iio_event_type type,
@@ -696,6 +787,15 @@ static int sx9310_write_event_val(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		return sx9310_write_thresh(data, chan, val);
+	case IIO_EV_INFO_PERIOD:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return sx9310_write_far_debounce(data, val);
+		case IIO_EV_DIR_FALLING:
+			return sx9310_write_close_debounce(data, val);
+		default:
+			return -EINVAL;
+		}
 	case IIO_EV_INFO_HYSTERESIS:
 		return sx9310_write_hysteresis(data, chan, val);
 	default:
-- 
Sent by a computer, using git, on the internet

