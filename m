Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65348292CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgJSR2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:28:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26849 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726342AbgJSR2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603128512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=HW3zBaCtD1eYq0aK8PlR42sK9/UGx1+e0AwNTosIs2M=;
        b=fXmT3JrWqOEdoDbYTe48vqf2hUObQ1Y6xyeq4tp3cXQZ3zdKns5B0JkL2OoHwNJS03EkNo
        J1mHmDoRXZS3clUZxCuzQ9zvTTReVptReyEWS1iHZ0SXLJDCM/6vzyP75UyRKICrbjXL2y
        C925xMGA4LGw5WDaV5hXQdy8qYj1HU4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-CTtQv7xXOtmpr7kMFJ0vYA-1; Mon, 19 Oct 2020 13:28:31 -0400
X-MC-Unique: CTtQv7xXOtmpr7kMFJ0vYA-1
Received: by mail-qt1-f198.google.com with SMTP id l12so378088qtu.22
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HW3zBaCtD1eYq0aK8PlR42sK9/UGx1+e0AwNTosIs2M=;
        b=Iv8bT5nAFt6tr6rgPqN4u4jZQteiPqoWxGc+NP4pmsLNnlbSM8YxtYRyPgIsFcukQK
         pmROV+QplB1xKtiXYKfjGMEuXnLP9ae670FFsSYrYutAFpve7IcNkJZlXla0t0IPIydl
         o35GrMyPgwUycQoOrgFna93kvD/bxBtu0EFHcj1YhSjGwd5zZUkpgKeIk8uNvraPYG72
         f3P7Yb2vlDyHhhz/gEIg+FP7HkNUw1Ou8SgVtwqDQVPex/SY8VDgbnZHBkwTMYqFUobj
         h9z+XQzjacGfg99u10sOQOiCZOWKeqWSGoE0nov3huK0vuLeAEh8/VJ2/I2uJIvDm0RL
         QLyQ==
X-Gm-Message-State: AOAM531fk5mteZpZaWRhNPJTshoFSmSAf3dVBi/YVLtfZi2u3t5+od9J
        dX0zbkdheFNaBCZTmhaSzQQj+F05afdw3s4G53ZlDWYKMeX3QkGxEGVEqF1UeOJkTOnF+A4mc1Y
        /9g/+ZA6NobxkmZC5bB5prV3Z
X-Received: by 2002:ac8:5bc5:: with SMTP id b5mr508606qtb.174.1603128510492;
        Mon, 19 Oct 2020 10:28:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEOFD1teIPDOYCpl3vtGGQdIkQYBiIWt3gTZg1nPEQPWalrkE5Eig1h7A3XXVSaJPOocNZTQ==
X-Received: by 2002:ac8:5bc5:: with SMTP id b5mr508593qtb.174.1603128510296;
        Mon, 19 Oct 2020 10:28:30 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f189sm275697qkd.20.2020.10.19.10.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:28:29 -0700 (PDT)
From:   trix@redhat.com
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        khilman@baylibre.com, narmstrong@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        andy.shevchenko@gmail.com, krzk@kernel.org,
        alexandru.ardelean@analog.com, jonathan.albrieux@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: remove unneeded break
Date:   Mon, 19 Oct 2020 10:28:24 -0700
Message-Id: <20201019172824.32166-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/adc/meson_saradc.c       | 2 --
 drivers/iio/imu/bmi160/bmi160_core.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index e03988698755..66dc452d643a 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -593,13 +593,11 @@ static int meson_sar_adc_iio_info_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		return meson_sar_adc_get_sample(indio_dev, chan, NO_AVERAGING,
 						ONE_SAMPLE, val);
-		break;
 
 	case IIO_CHAN_INFO_AVERAGE_RAW:
 		return meson_sar_adc_get_sample(indio_dev, chan,
 						MEAN_AVERAGING, EIGHT_SAMPLES,
 						val);
-		break;
 
 	case IIO_CHAN_INFO_SCALE:
 		if (chan->type == IIO_VOLTAGE) {
diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 222ebb26f013..431076dc0d2c 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -486,7 +486,6 @@ static int bmi160_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		return bmi160_set_scale(data,
 					bmi160_to_sensor(chan->type), val2);
-		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return bmi160_set_odr(data, bmi160_to_sensor(chan->type),
 				      val, val2);
-- 
2.18.1

