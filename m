Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAF5275717
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 13:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgIWL0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 07:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWL0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 07:26:34 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2BFC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 04:26:34 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a9so6739696wmm.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 04:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z9VKGjKxokCUVP+ftiRzO+Crpn3ybZWc9gnMvs0u7a0=;
        b=x6JzwCxqt+gTefV0C8whuQFYWAKZG0fkJJ+nMKuRBLxvzayFer8tuHXJU7HikiBmn5
         uGpS8Lg7ua6rbNMKBdYDWfgcWTkJ7mUwPvbO3IcX7Tj9U3uU7BE3nafbx3HUoP3N0clK
         iQmr/KAPwF753TIfpbT3WQmJPw9yHe1aCfZ07+F0KWwpX80CvS1rhqWrLH258jzazWp6
         8FE5u2g/XArGnqcQKbTuJCuyDtw+Zp7bXjSstSYLsJH9pmPQaVS7zW6RLDq9PKug/rns
         TOc2nHKCyIBOPkln4T8fhVgxzHlkSn8DxTTGhb4+zyLfL7jTT1yTxAh3e9OiWYTM15KC
         /eTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z9VKGjKxokCUVP+ftiRzO+Crpn3ybZWc9gnMvs0u7a0=;
        b=ABQOkGaAuuMjy523mM2Soz1EOxrP5E1J5JoQnnvZ1mu41IKJcLCQnUBtCBkmF+PlX0
         9vCqX22j4IEl9qTasul8CU78VE1517iOlmparhwlT+x/mGAUVFTXP+I+qjjy08Lh7BTi
         uaFL+3WzTyKDW8K9m9Lf66awghTNs9uhQyGgDphy7dpgKSoqTc+EOPCW1LkK/yh4Jrkb
         nCmyxxLRDXrh8QqdyT6qpyb/D3o2ACOH3Qe5Mcjvh8fLb2tHNlUCHN5Y4SiN2LBVSKHL
         yOn2/UV5nfE6HbbqMitJKom8frIqVFJWkDBGB/1jplzvkSjyX/fqB3i+pHUe8bXCvNs9
         n5Rg==
X-Gm-Message-State: AOAM532ezwh3maoOUF1SBpaNSMmRmVjNl3BQtqTTOIIUs5BFddGUWkOn
        GX676DAPtWRF+G0TuzukTzZHkw==
X-Google-Smtp-Source: ABdhPJwPedm+acIX+VIdAQMD9bJlw+e73kK6BEgJU1RoziYijBVMD4A9c0b10ed6a75IsrQT84VqcA==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr5916980wmh.74.1600860393060;
        Wed, 23 Sep 2020 04:26:33 -0700 (PDT)
Received: from trex (75.red-81-34-51.dynamicip.rima-tde.net. [81.34.51.75])
        by smtp.gmail.com with ESMTPSA id f12sm7996651wmf.26.2020.09.23.04.26.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Sep 2020 04:26:32 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Wed, 23 Sep 2020 13:26:31 +0200
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>, sumit.garg@linaro.org,
        ricardo@foundries.io, mike@foundries.io, tee-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] drivers: optee: i2c: add bus retry configuration
Message-ID: <20200923112631.GB30271@trex>
References: <20200916152732.23604-1-jorge@foundries.io>
 <20200922163859.GA1518183@jade>
 <20200923111813.GA30271@trex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923111813.GA30271@trex>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/20, Jorge Ramirez-Ortiz, Foundries wrote:
> On 22/09/20, Jens Wiklander wrote:
> > On Wed, Sep 16, 2020 at 05:27:32PM +0200, Jorge Ramirez-Ortiz wrote:
> > > Allow OP-TEE to specify the number of retries in the adaptor.
> > > 
> > > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > > ---
> > >  drivers/tee/optee/rpc.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > > index 1e3614e4798f..2d46a9ecb1de 100644
> > > --- a/drivers/tee/optee/rpc.c
> > > +++ b/drivers/tee/optee/rpc.c
> > > @@ -58,6 +58,7 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> > >  	struct tee_param *params;
> > >  	size_t i;
> > >  	int ret = -EOPNOTSUPP;
> > > +	int retries = 0;
> > >  	u8 attr[] = {
> > >  		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > >  		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > > @@ -102,12 +103,17 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> > >  	client.addr = params[0].u.value.c;
> > >  	snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
> > >  
> > > +	/* cache the current value */
> > > +	retries = client.adapter->retries;
> > > +
> > >  	switch (params[0].u.value.a) {
> > >  	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
> > > +		client.adapter->retries = params[1].u.value.b;
> > Do we need to take any locks befor this?
> 
> no I dont think so: there is no need for bus locks when requesting a
> transfer via i2c_master_recv/send; the lock for the bus segment gets
> taken later on, when the actual transfer hppens ( __i2c_transfer())
> 
> the functionality implemented in this function pretty much mimicks
> what is done in the normal world via /dev/i2c-X
> (drivers/i2c/i2c_dev.c)
>

correction (of course)
  - i2cdev_read --> i2c_master_recv
  - i2cdev->write -->i2c_master_send
> 
> and now the retry count setup on the adaptor with this commit.
> 
>  - i2cdev_ioctl I2C_RETRIES
> 
> > 
> > Cheers,
> > Jens
> > 
> > >  		ret = i2c_master_recv(&client, params[2].u.memref.shm->kaddr,
> > >  				      params[2].u.memref.size);
> > >  		break;
> > >  	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
> > > +		client.adapter->retries = params[1].u.value.b;
> > >  		ret = i2c_master_send(&client, params[2].u.memref.shm->kaddr,
> > >  				      params[2].u.memref.size);
> > >  		break;
> > > @@ -126,6 +132,7 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> > >  			arg->ret = TEEC_SUCCESS;
> > >  	}
> > >  
> > > +	client.adapter->retries = retries;
> > >  	i2c_put_adapter(client.adapter);
> > >  	kfree(params);
> > >  	return;
> > > -- 
> > > 2.17.1
> > > 
