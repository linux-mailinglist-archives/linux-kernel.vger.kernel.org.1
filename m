Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B000275924
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgIWNvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgIWNvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:51:15 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56311C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 06:51:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e2so135222wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 06:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VoQqDm7gDg88X7x8Kh2tv3F5Q5Cs+LznuqfdOcS3c0s=;
        b=sSwDx35Pb1ruz1c+JThcEU+PkU9kI3nDb0WLrjLb/aakp2OA/aXLHOQIvxHtLeb06K
         6ijlBgtTPgDZFG0h7YrV73vsO4oM7I1ajGTrcbUlVpqsaBjTpLaXCKcMJef8NsHtGrVF
         fx1uuJz+CHuD6Hi5Pl5bWxkITMN4vsicUK5PyT0xCv0fIbvSXgvB5N/RGzZJUxP/Iixr
         tzZmT9ny52z9gmOyRS6nzXJKrYptiTwjktvV8irke7N+boruC0igodHSUZen5jHoUGnV
         Cb+iSq3TJQ0aLeUDUN2xDV9U6u2Xf2t6xhIryHFouEY85hTOe1fNnppXTqw7TlJjsylV
         KxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VoQqDm7gDg88X7x8Kh2tv3F5Q5Cs+LznuqfdOcS3c0s=;
        b=ALMoFErMt1rukSe5Esomkb2MerLP+B5S0iEwSI2KfGdIBQUUq0Kb0sZfisyg6VG4ld
         /PM3iv9Yw0/cxTWOsVev4k8qFvDF008OsaOejzfvDXcZ0jAJD6yvZcfL3MwuWY0e+O2c
         0I1Ljq5Idq91sLRnwhAff9IRQvdKFfj93pc8tZFkjIf4X9464NPlzkYafyAe+hLzSeOn
         1rnrXOjX31bR4+phUNEC4O2tQwSa4IyMd8KgVZhVOBQllzucLgH+izvV40N866ghAiSX
         XiqxJEMHN9FKtQTSdxUpbHOz0/bqWRJXCGZhrKWcJgWbSjpJ4XA5ydJo4Z1x8U8+q8pF
         ho+g==
X-Gm-Message-State: AOAM531EslyhWVgXrpKdRLsNBMLSulNJM6Agde0DR1IEJcl9L6txri+1
        Cantup0X1AQoohyMVrjCw5yipg==
X-Google-Smtp-Source: ABdhPJz11feQCSdcAZ8qNVexDftN0nhEZQThHTpl5mrAm/ps8cDYkFN1Xb/0nyT7RJiSaQ/J9npCyQ==
X-Received: by 2002:a1c:4e02:: with SMTP id g2mr6362729wmh.3.1600869074015;
        Wed, 23 Sep 2020 06:51:14 -0700 (PDT)
Received: from trex (75.red-81-34-51.dynamicip.rima-tde.net. [81.34.51.75])
        by smtp.gmail.com with ESMTPSA id m3sm29681179wrs.83.2020.09.23.06.51.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Sep 2020 06:51:13 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Wed, 23 Sep 2020 15:51:12 +0200
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>,
        sumit.garg@linaro.org, ricardo@foundries.io, mike@foundries.io,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] drivers: optee: i2c: add bus retry configuration
Message-ID: <20200923135112.GA21608@trex>
References: <20200916152732.23604-1-jorge@foundries.io>
 <20200922163859.GA1518183@jade>
 <20200923111813.GA30271@trex>
 <20200923112631.GB30271@trex>
 <20200923121356.GA1659958@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923121356.GA1659958@jade>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/20, Jens Wiklander wrote:
> On Wed, Sep 23, 2020 at 01:26:31PM +0200, Jorge Ramirez-Ortiz, Foundries wrote:
> > On 23/09/20, Jorge Ramirez-Ortiz, Foundries wrote:
> > > On 22/09/20, Jens Wiklander wrote:
> > > > On Wed, Sep 16, 2020 at 05:27:32PM +0200, Jorge Ramirez-Ortiz wrote:
> > > > > Allow OP-TEE to specify the number of retries in the adaptor.
> > > > > 
> > > > > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > > > > ---
> > > > >  drivers/tee/optee/rpc.c | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > > > > index 1e3614e4798f..2d46a9ecb1de 100644
> > > > > --- a/drivers/tee/optee/rpc.c
> > > > > +++ b/drivers/tee/optee/rpc.c
> > > > > @@ -58,6 +58,7 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> > > > >  	struct tee_param *params;
> > > > >  	size_t i;
> > > > >  	int ret = -EOPNOTSUPP;
> > > > > +	int retries = 0;
> > > > >  	u8 attr[] = {
> > > > >  		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > > > >  		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > > > > @@ -102,12 +103,17 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> > > > >  	client.addr = params[0].u.value.c;
> > > > >  	snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
> > > > >  
> > > > > +	/* cache the current value */
> > > > > +	retries = client.adapter->retries;
> > > > > +
> > > > >  	switch (params[0].u.value.a) {
> > > > >  	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
> > > > > +		client.adapter->retries = params[1].u.value.b;
> > > > Do we need to take any locks befor this?
> > > 
> > > no I dont think so: there is no need for bus locks when requesting a
> > > transfer via i2c_master_recv/send; the lock for the bus segment gets
> > > taken later on, when the actual transfer hppens ( __i2c_transfer())
> > > 
> > > the functionality implemented in this function pretty much mimicks
> > > what is done in the normal world via /dev/i2c-X
> > > (drivers/i2c/i2c_dev.c)
> > >
> > 
> > correction (of course)
> >   - i2cdev_read --> i2c_master_recv
> >   - i2cdev->write -->i2c_master_send
> > > 
> > > and now the retry count setup on the adaptor with this commit.
> > > 
> > >  - i2cdev_ioctl I2C_RETRIES
> 
> I don't understand. Do you mean that client.adapter->retries doesn't
> need to be protected from concurrent updates? Or is it already protected
> by some other mechanism?

yeah I probably misunderstood your comment. my bad.

um I thought that upon getting the adaptor there would be some
protection mechanism in place until it is put back; but that is not
the case. looking a bit into it I see no simple way of protecting
changes to the adaptor (at any given time any thread could get a
pointer to it) so it seems that setting the retry field is not a
guarantee that it will be applied.

> 
> Cheers,
> Jens
