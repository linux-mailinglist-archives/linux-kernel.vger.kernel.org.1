Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBD52A5103
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 21:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgKCUhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 15:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbgKCUhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 15:37:00 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8E5C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 12:37:00 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h22so532562wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 12:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wcH2NZPmPNzAFFNFvECfAqiC7MUlowQUfusUsa9leaw=;
        b=DyQ5R89ruDr9MUS1cnFnWBUy1Du3Di7ihhnCPbgBF3tiqRtmbotj88LOWBzneQYavA
         uUfuNCf0x/QYM04K1GN0+ky/ID0ZJVRtx/BIUzd03HZ2c4cnW/3VidbIzM0/ZRRP9D4P
         t/KAzlQkPbGs3UODFgC4uO8DRTvzwj+w31ouMRFkBOUFVv/urORU4CIvpMVSjTnYmgwo
         LJUgSQBRaStoDc3hPhWm/N1KvBWLJFzV62b7/de14n+okNOCX1BgZK68ynaHOkmaVHey
         BYy+o/5PvRzHwE+n9kcL4SWqo7mbk1XrNu/C2wRO9K5jucj9dybSrFd+L5OutPOZKoVb
         UWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wcH2NZPmPNzAFFNFvECfAqiC7MUlowQUfusUsa9leaw=;
        b=OPCyDKRYRirSSU+V7JV/Mlh7FFWU4FXvaChK1/l9VT4+BkzhLlV+wFCR/I8GbWZYR+
         gQILDTByAhPeuk1OSq4jILW0ZVbSh0O6O43iBG7f3UUHVL0AuDktnmQQ7pbCDy+mnlC1
         h3HmPpQxsTnXUOjpPtbkA8ZPJTMPkBfJNl4pYUtGQHsXzgwO6fIIvv+DjvLWdx+oJMo1
         NppDtugkCoMe8LikcxkhOKogIuzqaRpYZLSB56Ghqai9bFmU4ca25dOGd5EuPXA+YjL+
         4TKCAOhiHvgulZ9R6KYrGVsdcxGdAkvWAhJJxNvLqDTqMsDR82BNXieFTfZ8Kol3O/7E
         BxUg==
X-Gm-Message-State: AOAM530c6JzN4jQXSAJrY/B9JX5g1S3nK35jzWX8YhMEw/hq8aV24b6i
        GqIsHVJSzKVOWUMKML7lL1k=
X-Google-Smtp-Source: ABdhPJwmSJ8H4pbC+ANrra2v2NZhd+NdK+ybd5KFMyS6+oGfoze4rKal5RiV1p7vwOMzKYxknlJlcQ==
X-Received: by 2002:a1c:6456:: with SMTP id y83mr1008045wmb.59.1604435819119;
        Tue, 03 Nov 2020 12:36:59 -0800 (PST)
Received: from tabot ([154.72.150.239])
        by smtp.gmail.com with ESMTPSA id a3sm3944690wmb.46.2020.11.03.12.36.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2020 12:36:58 -0800 (PST)
Date:   Tue, 3 Nov 2020 21:36:54 +0100
From:   Tabot Kevin <tabot.kevin@gmail.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replaced hard coded function names in debug messages
 with __func__ macro.
Message-ID: <20201103203652.GA1685@tabot>
References: <20201031164059.GA5534@tabot>
 <20201102093324.dz5es32yhmga34hs@holly.lan>
 <20201102121556.GA37670@crucifix.local>
 <20201103100440.wo2wkkyr5rs4qhhl@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103100440.wo2wkkyr5rs4qhhl@holly.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 10:04:40AM +0000, Daniel Thompson wrote:
> On Mon, Nov 02, 2020 at 01:15:56PM +0100, Tabot Kevin wrote:
> > On Mon, Nov 02, 2020 at 09:33:24AM +0000, Daniel Thompson wrote:
> > > On Sat, Oct 31, 2020 at 05:41:03PM +0100, Tabot Kevin wrote:
> > > > This patch fixes the following:
> > > > - Uses __func__ macro to print function names.
> > > > - Got rid of unnecessary braces around single line if statements.
> > > > - End of block comments on a seperate line.
> > > > - A spelling mistake of the word "on".
> > > > 
> > > > Signed-off-by: Tabot Kevin <tabot.kevin@gmail.com>
> > > > ---
> > > >  drivers/staging/media/atomisp/i2c/atomisp-ov2680.c | 25 +++++++++++-----------
> > > >  1 file changed, 13 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
> > > > index c907305..1396a33 100644
> > > > --- a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
> > > > +++ b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
> > > > @@ -146,7 +146,7 @@ static int ov2680_g_bin_factor_x(struct v4l2_subdev *sd, s32 *val)
> > > >  	struct ov2680_device *dev = to_ov2680_sensor(sd);
> > > >  	struct i2c_client *client = v4l2_get_subdevdata(sd);
> > > >  
> > > > -	dev_dbg(&client->dev,  "++++ov2680_g_bin_factor_x\n");
> > > > +	dev_dbg(&client->dev,  "++++%s\n", __func__);
> > > 
> > > It might be better just to remove this sort of message.
> > > 
> > > They are not "wrong wrong" but are they actually useful one a
> > > driver's basic functions work? Even where they are useful
> > > dynamic techniques (ftrace, tracepoints, etc) arguably provide a
> > > better way to support "did my function actually run" debug
> > > approaches anyway.
> >
> > Thank you very much for the response. So, should I just revert back to
> > the original all the changes in places where I replace hard coded
> > functions names with  __func__?
> 
> [Responses on LKML should be quoted like this rather than top-posted]
> 
> Personally I think it is better to remove them completely from the
> driver rather than revert to the original form. Naturally if Mauro or
> Sakari have strong views on this kind of printed message then you
> need to take that into account but, in general, messages like this
> add little or no value to the driver and can be removed.
> 
I went through the code in an attempt to completely remove all "dev_dbg"
messages, but I noticed not only are there many "dev_dbg" messages, there
are also many such messages like (dev_info, dev_err, etc). Should I
remove them all too?
> 
> > > > @@ -251,8 +251,8 @@ static long __ov2680_set_exposure(struct v4l2_subdev *sd, int coarse_itg,
> > > >  	int ret, exp_val;
> > > >  
> > > >  	dev_dbg(&client->dev,
> > > > -		"+++++++__ov2680_set_exposure coarse_itg %d, gain %d, digitgain %d++\n",
> > > > -		coarse_itg, gain, digitgain);
> > > > +		"+++++++%s coarse_itg %d, gain %d, digitgain %d++\n",
> > > > +		__func__, coarse_itg, gain, digitgain);
> 
> This case is a little less clear cut since the printed message does show
> some elements of internal state. However AFAICT this function just writes
> some state to the hardware so I still take the view that dynamic
> tools (I2C tracepoints for example) provide a better way to debug the
> driver.
> 
> 
> Daniel.
