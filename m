Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2B7243585
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 09:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgHMHxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 03:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgHMHxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:53:37 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA18C061383
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 00:53:36 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o18so5154984eje.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 00:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iLtk0FyRSsg4NjQXnsWcSYnmcbd4LI7Xy7HwQ4PY8ek=;
        b=qE9eBPtxzunYqjd4M9pnFOEaOq15YPauise+mixIGTj6WkaqwpD7QSnlcb71UfYHmy
         g9ADFXR+FG8B/sWwLtlhHdey57JYE8Xwovt/GjUh0zoyw84bzh3woXvxjWZuTx+O6WRM
         00IOu+qdBMFBGOlUm4/Czr5Jk6qc1tKpmXOKRiT5sUIXEWlqbxOFi3abQDgYsekMLjD7
         7jNPeKATAQBVzBDcF/DcZrbGCv5Dsi7f/S+Lr8HjFU3im8WpB7KgMdupd5M2dq+GssKF
         NW81neRciEx3r0wV1lZxv0cTamsfrvaB7VaDWH5+97KrU77goBjqCbwPPoet0epU2nBg
         NH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iLtk0FyRSsg4NjQXnsWcSYnmcbd4LI7Xy7HwQ4PY8ek=;
        b=ZT+B4woJRot1drX+SyDXqdqefkv5TltIuwakE2eKD42ZqVHk3z+SW8cqZFbrVvublv
         2if9YnsVLmRHR1qrPq2OptuzP/jMKkVlMg+2Af/SR+s/UnJkd8zAVReHWw2Mg3ovRZGM
         8rmSqN1RJU8OhwCT8LMMVlFbl2dmP5FqD4sCk2LDZA4kBsBdUcZeQ5Q1mcXDy26WMfso
         CyoPG2KQsIb4ktrW/OE0oTazaJvPaQX3WfZZsg2aryOGJ7+l2C3R/SQnewzoqVo/WMg/
         wzHev8oybC419ccjNdux6T435nPKWwSYJSiC504ks6eofX5g5sQQHwlBfVLT78F6POyc
         Kj4A==
X-Gm-Message-State: AOAM532uehdGfG+qUIKyLHgk8hg1VNoHNt3btNXGF3PKalY19cGklhFM
        CeOMvr2Z3dfIMD9JM8PS2zeH8g==
X-Google-Smtp-Source: ABdhPJxRzjgRLqcxiZFzApJ+2X0+6tigHOg/DNggzZMRsm4PyZBDw4h26zP7RPyF3gU2j7L8jqQAeg==
X-Received: by 2002:a17:906:3a85:: with SMTP id y5mr3495576ejd.507.1597305215332;
        Thu, 13 Aug 2020 00:53:35 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xajgyw9mz6ybkfgzn4.18120a2.ip6.access.telenet.be. [2a02:1810:a421:dd00:8d0a:592c:7d6d:8770])
        by smtp.gmail.com with ESMTPSA id br25sm3363449ejb.25.2020.08.13.00.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 00:53:34 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v5 5/5] iio:temperature:mlx90632: Some stylefixing leftovers
Date:   Thu, 13 Aug 2020 09:51:25 +0200
Message-Id: <20200813075125.4949-6-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813075125.4949-1-cmo@melexis.com>
References: <20200813075125.4949-1-cmo@melexis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is some inconsistency and whitespace cleanup performed in this
patch. It was done on top of my other patches, but I can rebase to head
of the togreg branch if it would go in sooner.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 41 ++++++++++++++++--------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 9fa8c078c037..4ef13509fb0f 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -94,6 +94,9 @@
 #define MLX90632_RAM_3(meas_num)	(MLX90632_ADDR_RAM + 3 * meas_num + 2)
 
 /* Name important RAM_MEAS channels */
+#define MLX90632_RAM_DSP5_AMBIENT_1 MLX90632_RAM_3(1)
+#define MLX90632_RAM_DSP5_AMBIENT_2 MLX90632_RAM_3(2)
+
 #define MLX90632_RAM_DSP5_EXTENDED_AMBIENT_1 MLX90632_RAM_3(17)
 #define MLX90632_RAM_DSP5_EXTENDED_AMBIENT_2 MLX90632_RAM_3(18)
 #define MLX90632_RAM_DSP5_EXTENDED_OBJECT_1 MLX90632_RAM_1(17)
@@ -111,10 +114,10 @@
 #define MLX90632_DSP_VERSION	5 /* DSP version */
 #define MLX90632_DSP_MASK	GENMASK(7, 0) /* DSP version in EE_VERSION */
 #define MLX90632_RESET_CMD	0x0006 /* Reset sensor (address or global) */
-#define MLX90632_REF_12		12LL /**< ResCtrlRef value of Ch 1 or Ch 2 */
-#define MLX90632_REF_3		12LL /**< ResCtrlRef value of Channel 3 */
-#define MLX90632_MAX_MEAS_NUM	31 /**< Maximum measurements in list */
-#define MLX90632_SLEEP_DELAY_MS 3000 /**< Autosleep delay */
+#define MLX90632_REF_12 	12LL /* ResCtrlRef value of Ch 1 or Ch 2 */
+#define MLX90632_REF_3		12LL /* ResCtrlRef value of Channel 3 */
+#define MLX90632_MAX_MEAS_NUM	31 /* Maximum measurements in list */
+#define MLX90632_SLEEP_DELAY_MS 3000 /* Autosleep delay */
 #define MLX90632_EXTENDED_LIMIT 27000 /* Extended mode raw value limit */
 
 /**
@@ -285,12 +288,12 @@ static int mlx90632_read_ambient_raw(struct regmap *regmap,
 	int ret;
 	unsigned int read_tmp;
 
-	ret = regmap_read(regmap, MLX90632_RAM_3(1), &read_tmp);
+	ret = regmap_read(regmap, MLX90632_RAM_DSP5_AMBIENT_1, &read_tmp);
 	if (ret < 0)
 		return ret;
 	*ambient_new_raw = (s16)read_tmp;
 
-	ret = regmap_read(regmap, MLX90632_RAM_3(2), &read_tmp);
+	ret = regmap_read(regmap, MLX90632_RAM_DSP5_AMBIENT_2, &read_tmp);
 	if (ret < 0)
 		return ret;
 	*ambient_old_raw = (s16)read_tmp;
@@ -488,11 +491,11 @@ static s64 mlx90632_preprocess_temp_amb(s16 ambient_new_raw,
 
 	kGb = ((s64)Gb * 1000LL) >> 10ULL;
 	VR_Ta = (s64)ambient_old_raw * 1000000LL +
-		kGb * div64_s64(((s64)ambient_new_raw * 1000LL),
-			(MLX90632_REF_3));
+		kGb * div64_s64((s64)ambient_new_raw * 1000LL,
+			MLX90632_REF_3);
 	tmp = div64_s64(
-			 div64_s64(((s64)ambient_new_raw * 1000000000000LL),
-				   (MLX90632_REF_3)), VR_Ta);
+			 div64_s64((s64)ambient_new_raw * 1000000000000LL,
+				   MLX90632_REF_3), VR_Ta);
 	return div64_s64(tmp << 19ULL, 1000LL);
 }
 
@@ -504,13 +507,13 @@ static s64 mlx90632_preprocess_temp_obj(s16 object_new_raw, s16 object_old_raw,
 
 	kKa = ((s64)Ka * 1000LL) >> 10ULL;
 	VR_IR = (s64)ambient_old_raw * 1000000LL +
-		kKa * div64_s64(((s64)ambient_new_raw * 1000LL),
-			(MLX90632_REF_3));
+		kKa * div64_s64((s64)ambient_new_raw * 1000LL,
+			MLX90632_REF_3);
 	tmp = div64_s64(
-			div64_s64(((s64)((object_new_raw + object_old_raw) / 2)
-				   * 1000000000000LL), (MLX90632_REF_12)),
+			div64_s64((s64)((object_new_raw + object_old_raw) / 2)
+				   * 1000000000000LL, MLX90632_REF_12),
 			VR_IR);
-	return div64_s64((tmp << 19ULL), 1000LL);
+	return div64_s64(tmp << 19ULL, 1000LL);
 }
 
 static s64 mlx90632_preprocess_temp_obj_extended(s16 object_new_raw, s16 ambient_new_raw,
@@ -560,8 +563,8 @@ static s32 mlx90632_calc_temp_object_iteration(s32 prev_object_temp, s64 object,
 	calcedKsTO = ((s64)((s64)Ga * (prev_object_temp - 25 * 1000LL)
 			     * 1000LL)) >> 36LL;
 	calcedKsTA = ((s64)(Fb * (TAdut - 25 * 1000000LL))) >> 36LL;
-	Alpha_corr = div64_s64((((s64)(Fa * 10000000000LL) >> 46LL)
-				* Ha_customer), 1000LL);
+	Alpha_corr = div64_s64(((s64)(Fa * 10000000000LL) >> 46LL)
+				* Ha_customer, 1000LL);
 	Alpha_corr *= ((s64)(1 * 1000000LL + calcedKsTO + calcedKsTA));
 	Alpha_corr = emissivity * div64_s64(Alpha_corr, 100000LL);
 	Alpha_corr = div64_s64(Alpha_corr, 1000LL);
@@ -589,7 +592,7 @@ static s32 mlx90632_calc_temp_object(s64 object, s64 ambient, s32 Ea, s32 Eb,
 
 	kTA = (Ea * 1000LL) >> 16LL;
 	kTA0 = (Eb * 1000LL) >> 8LL;
-	TAdut = div64_s64(((ambient - kTA0) * 1000000LL), kTA) + 25 * 1000000LL;
+	TAdut = div64_s64((ambient - kTA0) * 1000000LL, kTA) + 25 * 1000000LL;
 	TAdut4 = mlx90632_calc_ta4(TAdut, 10000LL);
 
 	/* Iterations of calculation as described in datasheet */
@@ -899,7 +902,7 @@ static int mlx90632_probe(struct i2c_client *client,
 		mlx90632->mtyp = MLX90632_MTYP_EXTENDED;
 	} else if ((read & MLX90632_DSP_MASK) == MLX90632_DSP_VERSION) {
 		dev_dbg(&client->dev,
-			"Detected Unknown EEPROM calibration %x\n", read);	
+			"Detected Unknown EEPROM calibration %x\n", read);
 	} else {
 		dev_err(&client->dev,
 			"Wrong DSP version %x (expected %x)\n",
-- 
2.25.1

