Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A870D275702
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 13:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgIWLSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 07:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWLSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 07:18:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15794C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 04:18:17 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t10so20599988wrv.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 04:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gGpFJSDKd0sKkvjB0V32Qzv/0Jq660H9TWfFOaRXVLo=;
        b=VxaUUByBrSJ78lo2nBLkBKzIXVK36/TG5bTJeA88Lk/8FBQXqy7B8maVIeXR8XoQmt
         93GpqIzOFOdP7iowRTw2PyxvJEz6wXx2QKhPSIaeDf89bHa+d/44fQPZxkAEgd+ZNomY
         szqlrp2qEXSkD+LQ6KrEODgiMfvO50SejMRuoWbMxPeckh+Xxoxt7aINOGcjMU/dPkJt
         fHEsspdWuuNPhPxcYXFnEOw4QYP4x0odSwVuJF+L1g2dVgNeeYMBhcT7ehyjxfh4yQUA
         96q0OFN8HAKhnaMNvGt69AvwaiZk/0w5TbQcp0jpV0cy7PR5rd+wKOe78fINDlZxu+0z
         jaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gGpFJSDKd0sKkvjB0V32Qzv/0Jq660H9TWfFOaRXVLo=;
        b=JphBZMi1TZNVXJ/m4tPeWiLa74+/4vEr9F4ybNup7xGKgrDd8e+1zoEz9kY/tc6DVr
         uGjjir2q1Tp+9pOyroSZNZmvMKF5x8hcVanf4YQzrzwYPvsQfSc41z3eZFaoKt6QiFaM
         Prz1ctLd9yqLle8uZUzxDb7Jk32NBk3UEcVuS4jN/GPpxmVo3f9aK9JF8H3qBC1JLvZ/
         jqzxDAQuedXcba9IGJB0O6T849oOGahTNMg2O1xSH4euFFxoCXs7+Kq5nHKRiRIHloPB
         0cR7PmUeGTnRliGWDEc7kvXpurfARbaC872Y/ZRtUkTbK+QFZX2LSd7ti2u74bn445dX
         0Ciw==
X-Gm-Message-State: AOAM532qtSw38LUXgiX4GP9/6MMFlklyAR3NeaqXI5M6i7qyPeMgWpXX
        rdIWQsjf74qIjy5oCDdym0RBHA==
X-Google-Smtp-Source: ABdhPJwfrVsjr6nvnQP0PxQ3NoAVMh3uEDHEItvjMksx4vxDZX7rFHYB+hPcLO/OMAjJYo5hcU+NMg==
X-Received: by 2002:a5d:4c52:: with SMTP id n18mr229713wrt.267.1600859895648;
        Wed, 23 Sep 2020 04:18:15 -0700 (PDT)
Received: from trex (75.red-81-34-51.dynamicip.rima-tde.net. [81.34.51.75])
        by smtp.gmail.com with ESMTPSA id 18sm7563660wmj.28.2020.09.23.04.18.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Sep 2020 04:18:15 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Wed, 23 Sep 2020 13:18:13 +0200
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Jorge Ramirez-Ortiz <jorge@foundries.io>, sumit.garg@linaro.org,
        ricardo@foundries.io, mike@foundries.io, tee-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] drivers: optee: i2c: add bus retry configuration
Message-ID: <20200923111813.GA30271@trex>
References: <20200916152732.23604-1-jorge@foundries.io>
 <20200922163859.GA1518183@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922163859.GA1518183@jade>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/20, Jens Wiklander wrote:
> On Wed, Sep 16, 2020 at 05:27:32PM +0200, Jorge Ramirez-Ortiz wrote:
> > Allow OP-TEE to specify the number of retries in the adaptor.
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > ---
> >  drivers/tee/optee/rpc.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > index 1e3614e4798f..2d46a9ecb1de 100644
> > --- a/drivers/tee/optee/rpc.c
> > +++ b/drivers/tee/optee/rpc.c
> > @@ -58,6 +58,7 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> >  	struct tee_param *params;
> >  	size_t i;
> >  	int ret = -EOPNOTSUPP;
> > +	int retries = 0;
> >  	u8 attr[] = {
> >  		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> >  		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > @@ -102,12 +103,17 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> >  	client.addr = params[0].u.value.c;
> >  	snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
> >  
> > +	/* cache the current value */
> > +	retries = client.adapter->retries;
> > +
> >  	switch (params[0].u.value.a) {
> >  	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
> > +		client.adapter->retries = params[1].u.value.b;
> Do we need to take any locks befor this?

no I dont think so: there is no need for bus locks when requesting a
transfer via i2c_master_recv/send; the lock for the bus segment gets
taken later on, when the actual transfer hppens ( __i2c_transfer())

the functionality implemented in this function pretty much mimicks
what is done in the normal world via /dev/i2c-X
(drivers/i2c/i2c_dev.c)

 - i2cdev_read --> i2c_master_send
 - i2cdev->write -->i2c_master_recv

and now the retry count setup on the adaptor with this commit.

 - i2cdev_ioctl I2C_RETRIES

> 
> Cheers,
> Jens
> 
> >  		ret = i2c_master_recv(&client, params[2].u.memref.shm->kaddr,
> >  				      params[2].u.memref.size);
> >  		break;
> >  	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
> > +		client.adapter->retries = params[1].u.value.b;
> >  		ret = i2c_master_send(&client, params[2].u.memref.shm->kaddr,
> >  				      params[2].u.memref.size);
> >  		break;
> > @@ -126,6 +132,7 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> >  			arg->ret = TEEC_SUCCESS;
> >  	}
> >  
> > +	client.adapter->retries = retries;
> >  	i2c_put_adapter(client.adapter);
> >  	kfree(params);
> >  	return;
> > -- 
> > 2.17.1
> > 
