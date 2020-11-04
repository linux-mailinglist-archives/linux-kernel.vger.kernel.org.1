Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770C12A612D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgKDKGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgKDKGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:06:45 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C1FC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 02:06:43 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id x7so21396686wrl.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 02:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LyLd5+wtt+rcFTZV9I8i0DwEVeOUvh0R/U6n/R8AAug=;
        b=z0wjBvh2Mypqk54j9BwP1mMUE1+V6CzKdPuQ6rh/2ZjOrYtZy6HtnkDhD4ESro3taU
         k5Ljc1jprhSrZ2C7vJw+pNVy/kYroFLMXMy6vzvUDTKKj41KVUEa0eeCLKEJNXs2/1vI
         nZjJK6pPxA4Wazmcm1rkRYaFlEWK87NA8OJFaESKRPsLd533+3TTfikoSvrh/cai9r1V
         cSn/cgJmI1UvEa81g8WMsQpv/aNhUakVKWocsS7VMfA9RfnBajPbcSANerbwyviaRjvz
         j32Om2qbDWsic0LRwM9n+1BOOKjUtIZcTkY/Aksc1ZDG2R2JuJCM0X9/7Ktxu9pddZ47
         IfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LyLd5+wtt+rcFTZV9I8i0DwEVeOUvh0R/U6n/R8AAug=;
        b=XsL3uv8sybMMI0r1OHpmDUhxPRrlCtsstHv0MIv2AnnDngHhogCVeYO3bd5wuapv9Q
         VOCq6wa8EYbVGPDYBOMPQFyQhRJzBC54oC5wKkJoLcKEf+qwqorcVWAPeZUrDnT+e3XG
         zJmyl8z7450Ls8WnWT8B9/5LH0HLMRJksJ75W1djDyawosNyg1vGWe33+NgjbhxUztbE
         yhs2pq/rFklc5nq6+4rPAUCeFlNz+faU2OFCu7tCHOtFzReKRGnx2xdi0FSAA/eX6HLB
         A+XLk5anHUvHZuLEGcGytGJ2WplkmU0x0L9wEXIHEG9AVRMMkBEtcWlVODOOkpYM5o8S
         SODA==
X-Gm-Message-State: AOAM532BfEgcXGbsWnYyJafqniaqqY25DrYT8SThglXPBSt0DFcHfmgT
        prZHoTwIk4FfjZ03Dq3lBtXkaA==
X-Google-Smtp-Source: ABdhPJxaJlG6ldDgzj9uuZlD2all63aztwPnauBhwS5a3dBATE0btFS+Mn2YVNS+M8WvAtqXN1qW0g==
X-Received: by 2002:a5d:688c:: with SMTP id h12mr32049471wru.92.1604484402063;
        Wed, 04 Nov 2020 02:06:42 -0800 (PST)
Received: from holly.lan (82-132-214-54.dab.02.net. [82.132.214.54])
        by smtp.gmail.com with ESMTPSA id u10sm1914775wrw.36.2020.11.04.02.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 02:06:40 -0800 (PST)
Date:   Wed, 4 Nov 2020 10:06:34 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Tabot Kevin <tabot.kevin@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replaced hard coded function names in debug messages
 with __func__ macro.
Message-ID: <20201104100634.4badc2mmau2tk5ct@holly.lan>
References: <20201031164059.GA5534@tabot>
 <20201102093324.dz5es32yhmga34hs@holly.lan>
 <20201102121556.GA37670@crucifix.local>
 <20201103100440.wo2wkkyr5rs4qhhl@holly.lan>
 <20201103203652.GA1685@tabot>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103203652.GA1685@tabot>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 09:36:54PM +0100, Tabot Kevin wrote:
> On Tue, Nov 03, 2020 at 10:04:40AM +0000, Daniel Thompson wrote:
> > On Mon, Nov 02, 2020 at 01:15:56PM +0100, Tabot Kevin wrote:
> > > On Mon, Nov 02, 2020 at 09:33:24AM +0000, Daniel Thompson wrote:
> > > > > @@ -146,7 +146,7 @@ static int ov2680_g_bin_factor_x(struct v4l2_subdev *sd, s32 *val)
> > > > >  	struct ov2680_device *dev = to_ov2680_sensor(sd);
> > > > >  	struct i2c_client *client = v4l2_get_subdevdata(sd);
> > > > >  
> > > > > -	dev_dbg(&client->dev,  "++++ov2680_g_bin_factor_x\n");
> > > > > +	dev_dbg(&client->dev,  "++++%s\n", __func__);
> > > > 
> > > > It might be better just to remove this sort of message.
> > > > 
> > > > They are not "wrong wrong" but are they actually useful one a
> > > > driver's basic functions work? Even where they are useful
> > > > dynamic techniques (ftrace, tracepoints, etc) arguably provide a
> > > > better way to support "did my function actually run" debug
> > > > approaches anyway.
> > >
> > > Thank you very much for the response. So, should I just revert back to
> > > the original all the changes in places where I replace hard coded
> > > functions names with  __func__?
> > 
> > Personally I think it is better to remove them completely from the
> > driver rather than revert to the original form. Naturally if Mauro or
> > Sakari have strong views on this kind of printed message then you
> > need to take that into account but, in general, messages like this
> > add little or no value to the driver and can be removed.
> > 
> I went through the code in an attempt to completely remove all "dev_dbg"
> messages,

The goal should not be to remove all dev_dbg() messages. I have only
suggested removing dev_dbg() that print things that are not useful or
redundantly duplicate what can be achieved with ftrace or tracepoints.

Maybe that will remove the dev_dbg() messages and maybe it won't. That
depends entirely what the function actually prints when executed.


> but I noticed not only are there many "dev_dbg" messages, there
> are also many such messages like (dev_info, dev_err, etc). Should I
> remove them all too?

The resulting patch will have your name on it rather than mine. That
means it is you that must make the decisions here.

Firstly you can review each message output to decide if it is useful.
Only remove message whose output is not useful (same as for dev_dbg() ).

If it is useful then you should think about whether the log level
matches the importance of the message. For example, are the dev_err()
message really covering error conditions? are there warnings for normal"
conditions? is the dev_info() useful to someone who is not the driver
author?).


Daniel.




> > 
> > > > > @@ -251,8 +251,8 @@ static long __ov2680_set_exposure(struct v4l2_subdev *sd, int coarse_itg,
> > > > >  	int ret, exp_val;
> > > > >  
> > > > >  	dev_dbg(&client->dev,
> > > > > -		"+++++++__ov2680_set_exposure coarse_itg %d, gain %d, digitgain %d++\n",
> > > > > -		coarse_itg, gain, digitgain);
> > > > > +		"+++++++%s coarse_itg %d, gain %d, digitgain %d++\n",
> > > > > +		__func__, coarse_itg, gain, digitgain);
> > 
> > This case is a little less clear cut since the printed message does show
> > some elements of internal state. However AFAICT this function just writes
> > some state to the hardware so I still take the view that dynamic
> > tools (I2C tracepoints for example) provide a better way to debug the
> > driver.
> > 
> > 
> > Daniel.
