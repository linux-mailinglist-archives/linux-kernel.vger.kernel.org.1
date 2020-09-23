Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBB32757BE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 14:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgIWMOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 08:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgIWMOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 08:14:01 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF81C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 05:14:01 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y11so21819028lfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 05:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gu4sashNSj+VH6cRzrQqHqohCiePOYZ2b0ZQyk6s8S8=;
        b=efBEwPlCOEckuBHmgMtHsoL/fnc89D+RwIxdTXkNsIWcKYxF4MHDRa/XbiNq8w8roF
         RLPyKGNAnickTWWDrsiDm3Xsq/te01jOqjie7RowPoLes3REaHJ+v3trKHKIgkW5sFQF
         QGFWs1eFaehk+bu5r1FtlgQmeDf63cT2acVsTat7GVNM7eoHZTdfr9LgS8sVuL0dZILm
         Azba0pHV5L9CD///TbiMU1n780XsJxWcIA8MmzbOl2BSUYX62sYHXw8u1tO71tV26M8X
         9SjzEzcxQ1IlXz0HyjS4Bn1MnD41irUv4QhC9AoDRblTXLlYhV9LWWMniJJNVQ8wgZxc
         YgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gu4sashNSj+VH6cRzrQqHqohCiePOYZ2b0ZQyk6s8S8=;
        b=etaB+IP3NS0wd8RjtoD8gDGWxBTbjyejKnX9d0sstiapSUF2S14JPVyqYZVS9umCU9
         dQAf8vSIcA9QZh0gw6LEHLA35t5O3mqrlBXb4qUaFtg1huvc69T9+iAkTyoiT9HeL3n3
         e6BDojoaUeEwhN+QB6oYSc2UTyQw5ER1wmYNdHcfU9zClW7/WfxP7naF/WC+1G47xrjH
         dwqhXgngJaarWneJDde94+kh6YAwnBCu6M43eSzATixswyhKi6YyLEn+VTAOA0HSI7q9
         pM6sY1Yp/qGVYaVTUXz5wG8gbqcDH8ztq78BhNcHl+V0G3gSn72+QKZoeh7w6FtzHcns
         wWyg==
X-Gm-Message-State: AOAM533ZW1uN9s/5uJQtSq4Nj7B9iNM+iwvf0ohtLunXe6SgpdM85V62
        WCV27jBUz5BhLbegFYqarsT4DchXQSuIzg==
X-Google-Smtp-Source: ABdhPJxsVf6A6ijcCACsYuxmwLAW2/C9483xfi7pscoEyxfoWWCkgWXDk/OslRudnBpalDKqORY7FQ==
X-Received: by 2002:a19:404e:: with SMTP id n75mr3133593lfa.172.1600863239608;
        Wed, 23 Sep 2020 05:13:59 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id t2sm4723809lff.150.2020.09.23.05.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 05:13:58 -0700 (PDT)
Date:   Wed, 23 Sep 2020 14:13:56 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc:     sumit.garg@linaro.org, ricardo@foundries.io, mike@foundries.io,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] drivers: optee: i2c: add bus retry configuration
Message-ID: <20200923121356.GA1659958@jade>
References: <20200916152732.23604-1-jorge@foundries.io>
 <20200922163859.GA1518183@jade>
 <20200923111813.GA30271@trex>
 <20200923112631.GB30271@trex>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200923112631.GB30271@trex>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 01:26:31PM +0200, Jorge Ramirez-Ortiz, Foundries wrote:
> On 23/09/20, Jorge Ramirez-Ortiz, Foundries wrote:
> > On 22/09/20, Jens Wiklander wrote:
> > > On Wed, Sep 16, 2020 at 05:27:32PM +0200, Jorge Ramirez-Ortiz wrote:
> > > > Allow OP-TEE to specify the number of retries in the adaptor.
> > > > 
> > > > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > > > ---
> > > >  drivers/tee/optee/rpc.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > > > index 1e3614e4798f..2d46a9ecb1de 100644
> > > > --- a/drivers/tee/optee/rpc.c
> > > > +++ b/drivers/tee/optee/rpc.c
> > > > @@ -58,6 +58,7 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> > > >  	struct tee_param *params;
> > > >  	size_t i;
> > > >  	int ret = -EOPNOTSUPP;
> > > > +	int retries = 0;
> > > >  	u8 attr[] = {
> > > >  		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > > >  		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > > > @@ -102,12 +103,17 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> > > >  	client.addr = params[0].u.value.c;
> > > >  	snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
> > > >  
> > > > +	/* cache the current value */
> > > > +	retries = client.adapter->retries;
> > > > +
> > > >  	switch (params[0].u.value.a) {
> > > >  	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
> > > > +		client.adapter->retries = params[1].u.value.b;
> > > Do we need to take any locks befor this?
> > 
> > no I dont think so: there is no need for bus locks when requesting a
> > transfer via i2c_master_recv/send; the lock for the bus segment gets
> > taken later on, when the actual transfer hppens ( __i2c_transfer())
> > 
> > the functionality implemented in this function pretty much mimicks
> > what is done in the normal world via /dev/i2c-X
> > (drivers/i2c/i2c_dev.c)
> >
> 
> correction (of course)
>   - i2cdev_read --> i2c_master_recv
>   - i2cdev->write -->i2c_master_send
> > 
> > and now the retry count setup on the adaptor with this commit.
> > 
> >  - i2cdev_ioctl I2C_RETRIES

I don't understand. Do you mean that client.adapter->retries doesn't
need to be protected from concurrent updates? Or is it already protected
by some other mechanism?

Cheers,
Jens
