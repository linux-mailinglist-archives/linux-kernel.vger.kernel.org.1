Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6492A18C0
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 17:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgJaQlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 12:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgJaQlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 12:41:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF413C0617A6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 09:41:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w1so9768883wrm.4
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 09:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Rp+mdbEoEg8OXhfiaKlhI1HrYvr9OmPRej9gQ86QVgw=;
        b=e38W5bJhMJEBXOZe9WcYJEbUZsQluAgzif+0AjMhH1PNRggJob2Jt6AIrsDs21tbCy
         rmooUZHgU+L2n55JznhczEc1sHvQcX+VhvmOSpIF/BSpb1Sk2kfZxkWHGiRv21zOjJr9
         g1sToYP0rbyviZQANy8JSnSLIPrA6OYpVJS0M1sadD8mopavbRA7HrWB2/Shjl1Wywvd
         ZW2mJ/XqjBjXPTSPtLdtjTJp79jPqdkzc8n9c8qSjrSA3FPy9rdt06aiCyJKvlQoOCUX
         meIEon+acIiDPeoYdugbaMnClOExs2OT/07a+QkSK5lwgMk4rPhOkSh+bcvmFKpoRxko
         JGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Rp+mdbEoEg8OXhfiaKlhI1HrYvr9OmPRej9gQ86QVgw=;
        b=DiR2M+mUVpxH3+IQJ/SZPo0pzr+v5Bsq9unN9jACwUkDbIp+qaZYE2jy8PwZYY5F97
         TpGBjGYpAqmk4i2bVgxlebBYpNn9ZrbLNfUUMoMs2e3y2ueMyhCblaGa7U+P0m+yPpZ1
         McEMGmEZpalX3iJaaUZk47nvMpD4bTnAnISNoNmsTtbCBtEnrfngT3Ii4OCGsiRSIu9k
         uCujy+32gaMBuMjb2Z84dC5BkKR0TgQRGpm58sdji7PV6NypC9+dh0OymAILQxPNO4Vo
         7gFIqrfeWkSp2H9Llf81JwoD/hAC6KU8YuVvzz1/YYYkNQXdebzD23b9RmYC+/SeWGIL
         qF1g==
X-Gm-Message-State: AOAM532t0IJv8ZTxO7SIpLlne2QQpgP0LSLqLAH4ED9djlTjKqOPomcs
        DTmKSzBLrDFbMDWp9uKU+f+rV/phCSDWDg==
X-Google-Smtp-Source: ABdhPJzaM/9CWZIh5jIgw/neoPnsUwXZHGRjEbB5YVnbtrPhCn1Uz6hYpfL6c7G0RARcOvU5Gzlmmw==
X-Received: by 2002:adf:f3c7:: with SMTP id g7mr10915197wrp.394.1604162468439;
        Sat, 31 Oct 2020 09:41:08 -0700 (PDT)
Received: from tabot ([154.72.150.196])
        by smtp.gmail.com with ESMTPSA id t199sm9199779wmt.46.2020.10.31.09.41.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Oct 2020 09:41:07 -0700 (PDT)
Date:   Sat, 31 Oct 2020 17:41:03 +0100
From:   Tabot Kevin <tabot.kevin@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Replaced hard coded function names in debug messages with
 __func__ macro.
Message-ID: <20201031164059.GA5534@tabot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following:
- Uses __func__ macro to print function names.
- Got rid of unnecessary braces around single line if statements.
- End of block comments on a seperate line.
- A spelling mistake of the word "on".

Signed-off-by: Tabot Kevin <tabot.kevin@gmail.com>
---
 drivers/staging/media/atomisp/i2c/atomisp-ov2680.c | 25 +++++++++++-----------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
index c907305..1396a33 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
@@ -146,7 +146,7 @@ static int ov2680_g_bin_factor_x(struct v4l2_subdev *sd, s32 *val)
 	struct ov2680_device *dev = to_ov2680_sensor(sd);
 	struct i2c_client *client = v4l2_get_subdevdata(sd);
 
-	dev_dbg(&client->dev,  "++++ov2680_g_bin_factor_x\n");
+	dev_dbg(&client->dev,  "++++%s\n", __func__);
 	*val = ov2680_res[dev->fmt_idx].bin_factor_x;
 
 	return 0;
@@ -158,7 +158,7 @@ static int ov2680_g_bin_factor_y(struct v4l2_subdev *sd, s32 *val)
 	struct i2c_client *client = v4l2_get_subdevdata(sd);
 
 	*val = ov2680_res[dev->fmt_idx].bin_factor_y;
-	dev_dbg(&client->dev,  "++++ov2680_g_bin_factor_y\n");
+	dev_dbg(&client->dev,  "++++%s\n", __func__);
 	return 0;
 }
 
@@ -173,7 +173,7 @@ static int ov2680_get_intg_factor(struct i2c_client *client,
 	u16 reg_val;
 	int ret;
 
-	dev_dbg(&client->dev,  "++++ov2680_get_intg_factor\n");
+	dev_dbg(&client->dev,  "++++%s\n", __func__);
 	if (!info)
 		return -EINVAL;
 
@@ -251,8 +251,8 @@ static long __ov2680_set_exposure(struct v4l2_subdev *sd, int coarse_itg,
 	int ret, exp_val;
 
 	dev_dbg(&client->dev,
-		"+++++++__ov2680_set_exposure coarse_itg %d, gain %d, digitgain %d++\n",
-		coarse_itg, gain, digitgain);
+		"+++++++%s coarse_itg %d, gain %d, digitgain %d++\n",
+		__func__, coarse_itg, gain, digitgain);
 
 	vts = ov2680_res[dev->fmt_idx].lines_per_frame;
 
@@ -461,11 +461,11 @@ static int ov2680_v_flip(struct v4l2_subdev *sd, s32 value)
 	ret = ov2680_read_reg(client, 1, OV2680_FLIP_REG, &val);
 	if (ret)
 		return ret;
-	if (value) {
+	if (value)
 		val |= OV2680_FLIP_MIRROR_BIT_ENABLE;
-	} else {
+	else
 		val &= ~OV2680_FLIP_MIRROR_BIT_ENABLE;
-	}
+
 	ret = ov2680_write_reg(client, 1,
 			       OV2680_FLIP_REG, val);
 	if (ret)
@@ -731,7 +731,8 @@ static int gpio_ctrl(struct v4l2_subdev *sd, bool flag)
 	 * existing integrations often wire two (reset/power_down)
 	 * because that is the way other sensors work.  There is no
 	 * way to tell how it is wired internally, so existing
-	 * firmwares expose both and we drive them symmetrically. */
+	 * firmwares expose both and we drive them symmetrically.
+	 */
 	if (flag) {
 		ret = dev->platform_data->gpio0_ctrl(sd, 1);
 		usleep_range(10000, 15000);
@@ -1060,9 +1061,9 @@ static int ov2680_s_stream(struct v4l2_subdev *sd, int enable)
 
 	mutex_lock(&dev->input_lock);
 	if (enable)
-		dev_dbg(&client->dev, "ov2680_s_stream one\n");
+		dev_dbg(&client->dev, "%s on\n", __func__);
 	else
-		dev_dbg(&client->dev, "ov2680_s_stream off\n");
+		dev_dbg(&client->dev, "%s off\n", __func__);
 
 	ret = ov2680_write_reg(client, 1, OV2680_SW_STREAM,
 			       enable ? OV2680_START_STREAMING :
@@ -1226,7 +1227,7 @@ static int ov2680_remove(struct i2c_client *client)
 	struct v4l2_subdev *sd = i2c_get_clientdata(client);
 	struct ov2680_device *dev = to_ov2680_sensor(sd);
 
-	dev_dbg(&client->dev, "ov2680_remove...\n");
+	dev_dbg(&client->dev, "%s...\n", __func__);
 
 	dev->platform_data->csi_cfg(sd, 0);
 
-- 
2.7.4

