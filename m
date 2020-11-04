Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED222A638A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgKDLoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgKDLnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:43:00 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B3AC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 03:42:59 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id s9so21681009wro.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 03:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wAWLmJb5c6PW7CmF9VvfIIPie2QKXBj5NneKuryEerU=;
        b=iH0UsKHHNviBiltJEGJKnH3EoL3Kojr7PDwJich1KOWqumHNPW0vp4rnoA4yK2Rosj
         Sc0CukLKJ2Q7FFbMuLD1fKV/M3KAOfUCJoqTMZm2dtuVymCcrqrDSzpeCPYg3qHvZi9W
         lgI1zDWRWRhFHxXwBoH6f38N4X4LNk3h2AJtlljWsHboHMbHrhAtXj/zCM315nqleimm
         JkY19aLxPtpxHvyoMXHKHR+J1ay3/8IZgtaa4CWInwG2hZO5FMIp70RQnNJj3z4of8p/
         e0ZoRXwTh920iNS6bZE8YQS/DQhhMRDKSQMv5WrXh8ct8ZcUGxN8hRbXwVjDpIWvdX4o
         l3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wAWLmJb5c6PW7CmF9VvfIIPie2QKXBj5NneKuryEerU=;
        b=bxIP8pd1iCXWKqBBL63TGVie/pCFCqW3A4JYEZ4KhLuWiUR4tBh7LtprZooXgWrAYA
         Z2s3By/YC3cQMakqcC/4p4eqhXgpJlwZQk56UEqFvn3/gcZm6KO9efklEc4JdK4ePsDA
         JwbwCEGFcxW7FoAr9QPxZIAWNnqqsjlLPvgGD+xvyCRfuHADxwZL82NYnwx/mCevhUZA
         1/cbGql169cEyTa6HDxZDE1cn83lT9KUUDTw7OnFRiKQ6JLxhdamrzbcMiF+DLM7CUME
         24qUNGyQF+9c+ykV+vinWBwjEtnT3ItcxxJhIL88cS1OoKqjl9kjxo77nvQe14NMijkI
         Ncxw==
X-Gm-Message-State: AOAM531Sq3VWDDab4porMJgLWIRlqjvVLaAz9NcbJ1l1QtY0dArPLGh7
        9KavdLnMLQHKsAPXqcFxL+jAIFS5Tv0=
X-Google-Smtp-Source: ABdhPJwSHeVG9HR9oVv+oJpzCJjH79PGGQNbbiK5S1c7cVQp6PkLn8HKpPk47H5kxTt2B/rppMPd9w==
X-Received: by 2002:a5d:6ac6:: with SMTP id u6mr22560145wrw.145.1604490178574;
        Wed, 04 Nov 2020 03:42:58 -0800 (PST)
Received: from tabot ([154.72.150.236])
        by smtp.gmail.com with ESMTPSA id v6sm1801370wmj.6.2020.11.04.03.42.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2020 03:42:58 -0800 (PST)
Date:   Wed, 4 Nov 2020 12:42:54 +0100
From:   Tabot Kevin <tabot.kevin@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Took out unuseful dev_dbg messages.
Message-ID: <20201104114249.GA1786@tabot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following:
- Got rid of unnecessary braces around single line if statements.
- End of block comments on a seperate line.
- A spelling mistake of the word "on".

Signed-off-by: Tabot Kevin <tabot.kevin@gmail.com>
---
 drivers/staging/media/atomisp/i2c/atomisp-ov2680.c | 25 +++-------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
index 1396a33..b70979d 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
@@ -146,7 +146,6 @@ static int ov2680_g_bin_factor_x(struct v4l2_subdev *sd, s32 *val)
 	struct ov2680_device *dev = to_ov2680_sensor(sd);
 	struct i2c_client *client = v4l2_get_subdevdata(sd);
 
-	dev_dbg(&client->dev,  "++++%s\n", __func__);
 	*val = ov2680_res[dev->fmt_idx].bin_factor_x;
 
 	return 0;
@@ -158,7 +157,7 @@ static int ov2680_g_bin_factor_y(struct v4l2_subdev *sd, s32 *val)
 	struct i2c_client *client = v4l2_get_subdevdata(sd);
 
 	*val = ov2680_res[dev->fmt_idx].bin_factor_y;
-	dev_dbg(&client->dev,  "++++%s\n", __func__);
+
 	return 0;
 }
 
@@ -173,7 +172,6 @@ static int ov2680_get_intg_factor(struct i2c_client *client,
 	u16 reg_val;
 	int ret;
 
-	dev_dbg(&client->dev,  "++++%s\n", __func__);
 	if (!info)
 		return -EINVAL;
 
@@ -250,10 +248,6 @@ static long __ov2680_set_exposure(struct v4l2_subdev *sd, int coarse_itg,
 	u16 vts;
 	int ret, exp_val;
 
-	dev_dbg(&client->dev,
-		"+++++++%s coarse_itg %d, gain %d, digitgain %d++\n",
-		__func__, coarse_itg, gain, digitgain);
-
 	vts = ov2680_res[dev->fmt_idx].lines_per_frame;
 
 	/* group hold */
@@ -457,7 +451,6 @@ static int ov2680_v_flip(struct v4l2_subdev *sd, s32 value)
 	u16 val;
 	u8 index;
 
-	dev_dbg(&client->dev, "@%s: value:%d\n", __func__, value);
 	ret = ov2680_read_reg(client, 1, OV2680_FLIP_REG, &val);
 	if (ret)
 		return ret;
@@ -490,8 +483,6 @@ static int ov2680_h_flip(struct v4l2_subdev *sd, s32 value)
 	u16 val;
 	u8 index;
 
-	dev_dbg(&client->dev, "@%s: value:%d\n", __func__, value);
-
 	ret = ov2680_read_reg(client, 1, OV2680_MIRROR_REG, &val);
 	if (ret)
 		return ret;
@@ -524,13 +515,9 @@ static int ov2680_s_ctrl(struct v4l2_ctrl *ctrl)
 
 	switch (ctrl->id) {
 	case V4L2_CID_VFLIP:
-		dev_dbg(&client->dev, "%s: CID_VFLIP:%d.\n",
-			__func__, ctrl->val);
 		ret = ov2680_v_flip(&dev->sd, ctrl->val);
 		break;
 	case V4L2_CID_HFLIP:
-		dev_dbg(&client->dev, "%s: CID_HFLIP:%d.\n",
-			__func__, ctrl->val);
 		ret = ov2680_h_flip(&dev->sd, ctrl->val);
 		break;
 	default:
@@ -704,8 +691,6 @@ static int power_ctrl(struct v4l2_subdev *sd, bool flag)
 	if (!dev || !dev->platform_data)
 		return -ENODEV;
 
-	dev_dbg(&client->dev, "%s: %s", __func__, flag ? "on" : "off");
-
 	if (flag) {
 		ret |= dev->platform_data->v1p8_ctrl(sd, 1);
 		ret |= dev->platform_data->v2p8_ctrl(sd, 1);
@@ -1227,8 +1212,6 @@ static int ov2680_remove(struct i2c_client *client)
 	struct v4l2_subdev *sd = i2c_get_clientdata(client);
 	struct ov2680_device *dev = to_ov2680_sensor(sd);
 
-	dev_dbg(&client->dev, "%s...\n", __func__);
-
 	dev->platform_data->csi_cfg(sd, 0);
 
 	v4l2_device_unregister_subdev(sd);
@@ -1297,13 +1280,11 @@ static int ov2680_probe(struct i2c_client *client)
 	dev->sd.ctrl_handler = &dev->ctrl_handler;
 
 	ret = media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
-	if (ret) {
+	if (ret)
 		ov2680_remove(client);
-		dev_dbg(&client->dev, "+++ remove ov2680\n");
-	}
+
 	return ret;
 out_free:
-	dev_dbg(&client->dev, "+++ out free\n");
 	v4l2_device_unregister_subdev(&dev->sd);
 	kfree(dev);
 	return ret;
-- 
2.7.4

