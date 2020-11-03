Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAE92A4123
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgKCKEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgKCKEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:04:45 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4800C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 02:04:44 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id a9so17797837wrg.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 02:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5lu50qFm8L1DSINuBZg0YFvMxk2Md1fGQ09VkSAEYo4=;
        b=ht4I4ExpM7uuI+bnMKCHBkqs8xcx5/GcUDZ4F/wcBtV7GS8N04BGkCjYho+/Q3mBXM
         dqiqnCDFWvGgMH4NG0DRRUUmaBVJoShJpcdgXhwApH5RjrFkEuOj001EWLrtOVq7DBcU
         1dYWIinSL2j7ArFPthlpYZzggws7NyKjzdBsamE+QMndT5b6WGfswHtybspd0afVhWE4
         J99tnS5HHqnMz8NrPX1oAbHCXa/eHt8aG5WlX/dIm/+82a5uIOtgGalAGwUfo+YNLa/F
         rJRVss0T1JLO7oiQPgI4SPC0hDx0BFdlyZc9V3r3IsUSCqBQN/ywIFxjNTrM5sYuSZx9
         roEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5lu50qFm8L1DSINuBZg0YFvMxk2Md1fGQ09VkSAEYo4=;
        b=EghGnq8i830PStsmM77WH/snXfkwG204czPw8slbT+qXbwexJHP8DkSUvQUqynrYLB
         hf4ZVD7uF6OEQ5TScALv0iUI+Fb50y0NOlxyXct6dyTH4r6LtHz9cL3NHVAnS00rzrK6
         F4WqgLRkF/SgFH++bJWsS+gQm0Al4//jdDMNd7wLAr2R/JHGzZjCo6Fasf9Uk94vw/Cq
         VLtU5qRmjD/nBfwHSs5A9hgQlYfJKuRM0PGPjUaxdc7CWWvwyCvXwwIlUHF1Aal6664/
         HRroKcNLb0vlEv9Vfu42v4k92qCpWR9GZjj/sBzMoZtRmiiicY4CU/eOmJrrd7pkSPoC
         fkxw==
X-Gm-Message-State: AOAM531LJe0CMrI/696JqHvqm0ozEaZL/zzpd9GgbdMnE/8ngpVVZkyL
        2ps2UTCjbUbqIoLdwBQ4Up/yhQ==
X-Google-Smtp-Source: ABdhPJxdCm3UGcx1fTAEo2K7wdIYBJfPpaElpkQXFYFDHgcCW2D3w1e63aLniv7/fvkxeQKftf+3tA==
X-Received: by 2002:adf:914c:: with SMTP id j70mr26499358wrj.170.1604397883447;
        Tue, 03 Nov 2020 02:04:43 -0800 (PST)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id w4sm11870091wrk.28.2020.11.03.02.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 02:04:42 -0800 (PST)
Date:   Tue, 3 Nov 2020 10:04:40 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Tabot Kevin <tabot.kevin@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replaced hard coded function names in debug messages
 with __func__ macro.
Message-ID: <20201103100440.wo2wkkyr5rs4qhhl@holly.lan>
References: <20201031164059.GA5534@tabot>
 <20201102093324.dz5es32yhmga34hs@holly.lan>
 <20201102121556.GA37670@crucifix.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201102121556.GA37670@crucifix.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 01:15:56PM +0100, Tabot Kevin wrote:
> On Mon, Nov 02, 2020 at 09:33:24AM +0000, Daniel Thompson wrote:
> > On Sat, Oct 31, 2020 at 05:41:03PM +0100, Tabot Kevin wrote:
> > > This patch fixes the following:
> > > - Uses __func__ macro to print function names.
> > > - Got rid of unnecessary braces around single line if statements.
> > > - End of block comments on a seperate line.
> > > - A spelling mistake of the word "on".
> > > 
> > > Signed-off-by: Tabot Kevin <tabot.kevin@gmail.com>
> > > ---
> > >  drivers/staging/media/atomisp/i2c/atomisp-ov2680.c | 25 +++++++++++-----------
> > >  1 file changed, 13 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
> > > index c907305..1396a33 100644
> > > --- a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
> > > +++ b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
> > > @@ -146,7 +146,7 @@ static int ov2680_g_bin_factor_x(struct v4l2_subdev *sd, s32 *val)
> > >  	struct ov2680_device *dev = to_ov2680_sensor(sd);
> > >  	struct i2c_client *client = v4l2_get_subdevdata(sd);
> > >  
> > > -	dev_dbg(&client->dev,  "++++ov2680_g_bin_factor_x\n");
> > > +	dev_dbg(&client->dev,  "++++%s\n", __func__);
> > 
> > It might be better just to remove this sort of message.
> > 
> > They are not "wrong wrong" but are they actually useful one a
> > driver's basic functions work? Even where they are useful
> > dynamic techniques (ftrace, tracepoints, etc) arguably provide a
> > better way to support "did my function actually run" debug
> > approaches anyway.
>
> Thank you very much for the response. So, should I just revert back to
> the original all the changes in places where I replace hard coded
> functions names with  __func__?

[Responses on LKML should be quoted like this rather than top-posted]

Personally I think it is better to remove them completely from the
driver rather than revert to the original form. Naturally if Mauro or
Sakari have strong views on this kind of printed message then you
need to take that into account but, in general, messages like this
add little or no value to the driver and can be removed.


> > > @@ -251,8 +251,8 @@ static long __ov2680_set_exposure(struct v4l2_subdev *sd, int coarse_itg,
> > >  	int ret, exp_val;
> > >  
> > >  	dev_dbg(&client->dev,
> > > -		"+++++++__ov2680_set_exposure coarse_itg %d, gain %d, digitgain %d++\n",
> > > -		coarse_itg, gain, digitgain);
> > > +		"+++++++%s coarse_itg %d, gain %d, digitgain %d++\n",
> > > +		__func__, coarse_itg, gain, digitgain);

This case is a little less clear cut since the printed message does show
some elements of internal state. However AFAICT this function just writes
some state to the hardware so I still take the view that dynamic
tools (I2C tracepoints for example) provide a better way to debug the
driver.


Daniel.
