Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD36E2A2A79
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgKBMQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 07:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgKBMQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:16:02 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C846C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 04:16:02 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h62so4454666wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 04:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wFKKn264CsG6CZ1Z/QMBHa9F5OycYTnk8m3p/pKwkTQ=;
        b=Sn7PfX7qYKMlJzXjW8ZqbgPGdDRsXDTA9ctaGKC2ALOV7HZdILzRkSIwDPd+9ozQ7Q
         +vNfHMDRIpdZlVEhaPYp3oMbD6lEesUsPmr9vTqS0/c7fhs1hSwoyHi/4OcAL5L/gdKs
         cJFB6GCgyDYc7i9dpdLDkZJJMOh6V9H1GH32ylbiBLO/RdDN9JO1674egNd6FI0SxuaG
         FSnrndvq8/1A3/zzaYVowQN0psWHP73xL0kXDIEx04G3PumyYxwJijfHEe45OdHjnUUD
         4OXDUzRGftHbX/lAjOtHIUwu35Y3hYTfRmkrTNudNiPY78IUyShgeIlsn1pNqzByXD7A
         c1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wFKKn264CsG6CZ1Z/QMBHa9F5OycYTnk8m3p/pKwkTQ=;
        b=Ay7WygMGGnqj+Saaol/67ZU9ENv+FtrA/p8SC7iXMaeqWoX1+/MVfEu8KLEM/oQl8L
         GJiaqLWiY/7wZYTAjYx+KBSyJt5+kLz20BIbNLth9vOKaz/mYefu6dy/iGIf8RvWtEYS
         F/RLO9UB727C9kkXWmlSIjo5xtopKxbKROGJ4vr51vj16B1e69ZEDfIGG1ls8gDCgcAI
         N4qC6GH3mHc7ltOlVOzk7hwMR9wgvM2HvHRfsErhIZxGHEMuDjAnRIfTUQXtsYmTn3nt
         pvCFfdpdGVkyTsvpDxEaXGDXymmJOZOgj2ysSigMVuHzSMoKs8Vogq1GmipYQAd63iAQ
         gXAQ==
X-Gm-Message-State: AOAM531zfFoqhbRJ+p321rgyY+MX2zWnlDB6S/wjsZWps/YRIHkWDjIN
        a0Nan5Ksi2MvQFtPA3HbI94=
X-Google-Smtp-Source: ABdhPJynmcgXsjWy1DpF7+nNBH0FZRei1KDJOQ7i4Ede1eLeOi9eJ76wHSYC6e5OYdpdAaw6fRYpCQ==
X-Received: by 2002:a1c:f314:: with SMTP id q20mr17516792wmq.104.1604319360886;
        Mon, 02 Nov 2020 04:16:00 -0800 (PST)
Received: from crucifix.local ([129.0.76.60])
        by smtp.gmail.com with ESMTPSA id s188sm4990470wmf.45.2020.11.02.04.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 04:16:00 -0800 (PST)
Date:   Mon, 2 Nov 2020 13:15:56 +0100
From:   Tabot Kevin <tabot.kevin@gmail.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replaced hard coded function names in debug messages
 with __func__ macro.
Message-ID: <20201102121556.GA37670@crucifix.local>
References: <20201031164059.GA5534@tabot>
 <20201102093324.dz5es32yhmga34hs@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201102093324.dz5es32yhmga34hs@holly.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings Daniel,
Thank you very much for the response. So, should I just revert back to the original 
all the changes in places where I replace hard coded functions names with  __func__?

Kind regards,

Tabot Kevin.

On Mon, Nov 02, 2020 at 09:33:24AM +0000, Daniel Thompson wrote:
> On Sat, Oct 31, 2020 at 05:41:03PM +0100, Tabot Kevin wrote:
> > This patch fixes the following:
> > - Uses __func__ macro to print function names.
> > - Got rid of unnecessary braces around single line if statements.
> > - End of block comments on a seperate line.
> > - A spelling mistake of the word "on".
> > 
> > Signed-off-by: Tabot Kevin <tabot.kevin@gmail.com>
> > ---
> >  drivers/staging/media/atomisp/i2c/atomisp-ov2680.c | 25 +++++++++++-----------
> >  1 file changed, 13 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
> > index c907305..1396a33 100644
> > --- a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
> > +++ b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
> > @@ -146,7 +146,7 @@ static int ov2680_g_bin_factor_x(struct v4l2_subdev *sd, s32 *val)
> >  	struct ov2680_device *dev = to_ov2680_sensor(sd);
> >  	struct i2c_client *client = v4l2_get_subdevdata(sd);
> >  
> > -	dev_dbg(&client->dev,  "++++ov2680_g_bin_factor_x\n");
> > +	dev_dbg(&client->dev,  "++++%s\n", __func__);
> 
> It might be better just to remove this sort of message.
> 
> They are not "wrong wrong" but are they actually useful one a
> driver's basic functions work? Even where they are useful
> dynamic techniques (ftrace, tracepoints, etc) arguably provide a
> better way to support "did my function actually run" debug
> approaches anyway.
> 
> 
> Daniel.
> 
> 
> >  	*val = ov2680_res[dev->fmt_idx].bin_factor_x;
> >  
> >  	return 0;
> > @@ -158,7 +158,7 @@ static int ov2680_g_bin_factor_y(struct v4l2_subdev *sd, s32 *val)
> >  	struct i2c_client *client = v4l2_get_subdevdata(sd);
> >  
> >  	*val = ov2680_res[dev->fmt_idx].bin_factor_y;
> > -	dev_dbg(&client->dev,  "++++ov2680_g_bin_factor_y\n");
> > +	dev_dbg(&client->dev,  "++++%s\n", __func__);
> >  	return 0;
> >  }
> >  
> > @@ -173,7 +173,7 @@ static int ov2680_get_intg_factor(struct i2c_client *client,
> >  	u16 reg_val;
> >  	int ret;
> >  
> > -	dev_dbg(&client->dev,  "++++ov2680_get_intg_factor\n");
> > +	dev_dbg(&client->dev,  "++++%s\n", __func__);
> >  	if (!info)
> >  		return -EINVAL;
> >  
> > @@ -251,8 +251,8 @@ static long __ov2680_set_exposure(struct v4l2_subdev *sd, int coarse_itg,
> >  	int ret, exp_val;
> >  
> >  	dev_dbg(&client->dev,
> > -		"+++++++__ov2680_set_exposure coarse_itg %d, gain %d, digitgain %d++\n",
> > -		coarse_itg, gain, digitgain);
> > +		"+++++++%s coarse_itg %d, gain %d, digitgain %d++\n",
> > +		__func__, coarse_itg, gain, digitgain);
> >  
> >  	vts = ov2680_res[dev->fmt_idx].lines_per_frame;
> >  
> > @@ -461,11 +461,11 @@ static int ov2680_v_flip(struct v4l2_subdev *sd, s32 value)
> >  	ret = ov2680_read_reg(client, 1, OV2680_FLIP_REG, &val);
> >  	if (ret)
> >  		return ret;
> > -	if (value) {
> > +	if (value)
> >  		val |= OV2680_FLIP_MIRROR_BIT_ENABLE;
> > -	} else {
> > +	else
> >  		val &= ~OV2680_FLIP_MIRROR_BIT_ENABLE;
> > -	}
> > +
> >  	ret = ov2680_write_reg(client, 1,
> >  			       OV2680_FLIP_REG, val);
> >  	if (ret)
> > @@ -731,7 +731,8 @@ static int gpio_ctrl(struct v4l2_subdev *sd, bool flag)
> >  	 * existing integrations often wire two (reset/power_down)
> >  	 * because that is the way other sensors work.  There is no
> >  	 * way to tell how it is wired internally, so existing
> > -	 * firmwares expose both and we drive them symmetrically. */
> > +	 * firmwares expose both and we drive them symmetrically.
> > +	 */
> >  	if (flag) {
> >  		ret = dev->platform_data->gpio0_ctrl(sd, 1);
> >  		usleep_range(10000, 15000);
> > @@ -1060,9 +1061,9 @@ static int ov2680_s_stream(struct v4l2_subdev *sd, int enable)
> >  
> >  	mutex_lock(&dev->input_lock);
> >  	if (enable)
> > -		dev_dbg(&client->dev, "ov2680_s_stream one\n");
> > +		dev_dbg(&client->dev, "%s on\n", __func__);
> >  	else
> > -		dev_dbg(&client->dev, "ov2680_s_stream off\n");
> > +		dev_dbg(&client->dev, "%s off\n", __func__);
> >  
> >  	ret = ov2680_write_reg(client, 1, OV2680_SW_STREAM,
> >  			       enable ? OV2680_START_STREAMING :
> > @@ -1226,7 +1227,7 @@ static int ov2680_remove(struct i2c_client *client)
> >  	struct v4l2_subdev *sd = i2c_get_clientdata(client);
> >  	struct ov2680_device *dev = to_ov2680_sensor(sd);
> >  
> > -	dev_dbg(&client->dev, "ov2680_remove...\n");
> > +	dev_dbg(&client->dev, "%s...\n", __func__);
> >  
> >  	dev->platform_data->csi_cfg(sd, 0);
> >  
> > -- 
> > 2.7.4
> > 
