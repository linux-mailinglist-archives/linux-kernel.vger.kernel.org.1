Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FEA2A2716
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgKBJd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbgKBJd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:33:28 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633E6C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 01:33:28 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id n18so13709107wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 01:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6qHZ700WUYY9NGqSXubTQpWE+vLIHw4U201cb0qvWog=;
        b=KAifZLycQBuuuHoayJaBjB7AaUxCQfXLhKAJL514R3ypQnVq9RzgJIFlEDZ4BmKyfu
         BTdf+tsbbqURQwpW04fHK60uOJBL7A61hL0ne6FGDFuH4tK+8MFcoA4r0HEdstzuLcCT
         Zk/uEWnZW4n9hy9bLH9JN8Wi53lQNR5G2dunT0DIqMWN3B92Iv1YqLdcbae8xeAJZS0L
         4WqgFJqDv8k1w/6nazfeBQvmhAzSKJRAija5H8onFQJoBvdWKiXcFngqUK0dDFfz35Z9
         os/h1YRFXxwIEuWw+H5Y2bbsPkGIry4td988nX7AUqBDgqlCM74uwmehMIjCWLCQuICu
         SI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6qHZ700WUYY9NGqSXubTQpWE+vLIHw4U201cb0qvWog=;
        b=ksuS2o3QMo2J3vhpKt7dK8t1Gf9oxq+hXvhJyLsV3uhHhzN897Y0YDMjtJcmGFSbNy
         IYEfnCfp0tcqhcXLNZpq2IFtRtoVaQRzun0lJjf+Pu6IFTMzGtxzIqeE0RhJtt4mDQRF
         7HwV6nEy+MBNTJNyy7Mbqk325cDniWg7LcFjGeA2JpZLClhE6deJ7k6dl0IoilBs1T1K
         eYoiVSLhbjI8k4h7vfRrDCJyeEFsBHA5XCGTEwbp/qbGNzsnSlZswN4OTfmxZqCk88zq
         oGqOtfQTGtQQfk6vv13QmNruRPT/dD4WepVKUhzM4+w0+GZLFgTC8FadK6zfnV2eusTe
         yy8w==
X-Gm-Message-State: AOAM533tLvvDXBkiEifskDtC4bezAq1ymBwjeAXzkWxhDmbXYseo+3Xb
        3iGdMQw2fd77pSx3macEuuepPA==
X-Google-Smtp-Source: ABdhPJx5cU/yKM1JcDO/Cb5upHEvZXwpk1NN9FGzrRKlrktKkkCnxvSB41PeYpxpCCNeLgAApDMZuw==
X-Received: by 2002:adf:ef48:: with SMTP id c8mr18528378wrp.399.1604309607094;
        Mon, 02 Nov 2020 01:33:27 -0800 (PST)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id r18sm23489228wrj.50.2020.11.02.01.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 01:33:26 -0800 (PST)
Date:   Mon, 2 Nov 2020 09:33:24 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Tabot Kevin <tabot.kevin@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replaced hard coded function names in debug messages
 with __func__ macro.
Message-ID: <20201102093324.dz5es32yhmga34hs@holly.lan>
References: <20201031164059.GA5534@tabot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031164059.GA5534@tabot>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 05:41:03PM +0100, Tabot Kevin wrote:
> This patch fixes the following:
> - Uses __func__ macro to print function names.
> - Got rid of unnecessary braces around single line if statements.
> - End of block comments on a seperate line.
> - A spelling mistake of the word "on".
> 
> Signed-off-by: Tabot Kevin <tabot.kevin@gmail.com>
> ---
>  drivers/staging/media/atomisp/i2c/atomisp-ov2680.c | 25 +++++++++++-----------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
> index c907305..1396a33 100644
> --- a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
> +++ b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
> @@ -146,7 +146,7 @@ static int ov2680_g_bin_factor_x(struct v4l2_subdev *sd, s32 *val)
>  	struct ov2680_device *dev = to_ov2680_sensor(sd);
>  	struct i2c_client *client = v4l2_get_subdevdata(sd);
>  
> -	dev_dbg(&client->dev,  "++++ov2680_g_bin_factor_x\n");
> +	dev_dbg(&client->dev,  "++++%s\n", __func__);

It might be better just to remove this sort of message.

They are not "wrong wrong" but are they actually useful one a
driver's basic functions work? Even where they are useful
dynamic techniques (ftrace, tracepoints, etc) arguably provide a
better way to support "did my function actually run" debug
approaches anyway.


Daniel.


>  	*val = ov2680_res[dev->fmt_idx].bin_factor_x;
>  
>  	return 0;
> @@ -158,7 +158,7 @@ static int ov2680_g_bin_factor_y(struct v4l2_subdev *sd, s32 *val)
>  	struct i2c_client *client = v4l2_get_subdevdata(sd);
>  
>  	*val = ov2680_res[dev->fmt_idx].bin_factor_y;
> -	dev_dbg(&client->dev,  "++++ov2680_g_bin_factor_y\n");
> +	dev_dbg(&client->dev,  "++++%s\n", __func__);
>  	return 0;
>  }
>  
> @@ -173,7 +173,7 @@ static int ov2680_get_intg_factor(struct i2c_client *client,
>  	u16 reg_val;
>  	int ret;
>  
> -	dev_dbg(&client->dev,  "++++ov2680_get_intg_factor\n");
> +	dev_dbg(&client->dev,  "++++%s\n", __func__);
>  	if (!info)
>  		return -EINVAL;
>  
> @@ -251,8 +251,8 @@ static long __ov2680_set_exposure(struct v4l2_subdev *sd, int coarse_itg,
>  	int ret, exp_val;
>  
>  	dev_dbg(&client->dev,
> -		"+++++++__ov2680_set_exposure coarse_itg %d, gain %d, digitgain %d++\n",
> -		coarse_itg, gain, digitgain);
> +		"+++++++%s coarse_itg %d, gain %d, digitgain %d++\n",
> +		__func__, coarse_itg, gain, digitgain);
>  
>  	vts = ov2680_res[dev->fmt_idx].lines_per_frame;
>  
> @@ -461,11 +461,11 @@ static int ov2680_v_flip(struct v4l2_subdev *sd, s32 value)
>  	ret = ov2680_read_reg(client, 1, OV2680_FLIP_REG, &val);
>  	if (ret)
>  		return ret;
> -	if (value) {
> +	if (value)
>  		val |= OV2680_FLIP_MIRROR_BIT_ENABLE;
> -	} else {
> +	else
>  		val &= ~OV2680_FLIP_MIRROR_BIT_ENABLE;
> -	}
> +
>  	ret = ov2680_write_reg(client, 1,
>  			       OV2680_FLIP_REG, val);
>  	if (ret)
> @@ -731,7 +731,8 @@ static int gpio_ctrl(struct v4l2_subdev *sd, bool flag)
>  	 * existing integrations often wire two (reset/power_down)
>  	 * because that is the way other sensors work.  There is no
>  	 * way to tell how it is wired internally, so existing
> -	 * firmwares expose both and we drive them symmetrically. */
> +	 * firmwares expose both and we drive them symmetrically.
> +	 */
>  	if (flag) {
>  		ret = dev->platform_data->gpio0_ctrl(sd, 1);
>  		usleep_range(10000, 15000);
> @@ -1060,9 +1061,9 @@ static int ov2680_s_stream(struct v4l2_subdev *sd, int enable)
>  
>  	mutex_lock(&dev->input_lock);
>  	if (enable)
> -		dev_dbg(&client->dev, "ov2680_s_stream one\n");
> +		dev_dbg(&client->dev, "%s on\n", __func__);
>  	else
> -		dev_dbg(&client->dev, "ov2680_s_stream off\n");
> +		dev_dbg(&client->dev, "%s off\n", __func__);
>  
>  	ret = ov2680_write_reg(client, 1, OV2680_SW_STREAM,
>  			       enable ? OV2680_START_STREAMING :
> @@ -1226,7 +1227,7 @@ static int ov2680_remove(struct i2c_client *client)
>  	struct v4l2_subdev *sd = i2c_get_clientdata(client);
>  	struct ov2680_device *dev = to_ov2680_sensor(sd);
>  
> -	dev_dbg(&client->dev, "ov2680_remove...\n");
> +	dev_dbg(&client->dev, "%s...\n", __func__);
>  
>  	dev->platform_data->csi_cfg(sd, 0);
>  
> -- 
> 2.7.4
> 
