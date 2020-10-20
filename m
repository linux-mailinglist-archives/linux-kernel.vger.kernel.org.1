Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D5A293E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 16:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407789AbgJTOBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 10:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407761AbgJTOBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:01:32 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEBEC0613CE;
        Tue, 20 Oct 2020 07:01:31 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id w141so2252924oia.2;
        Tue, 20 Oct 2020 07:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eV8Qm7gEOxRXitBzZlCD866ixtrTlZl+PdLiNQm+4Rs=;
        b=KIOkMaR+xgikLjNfFY6MoCOuGLLfV5odzjo6goJ8rKsRKC7ER4ZEWzrZq1+QALyz92
         OLZjAOuB9yy9mDzUU6PTpIVHfOUc0NOl+P7JBOOJnpqG8i3ZxUEkBKMwByHIhD0TbG7G
         6PwXpV4ynfFTKDaOukPCrazXF0DjW2CeKGCOyn+LEB4jjuwp4x0WRs83lIRvTEgO6GC0
         kcNpf/LgBxbf6BgQB5ELNEGNOGu8JcN0ScKFoQnl2nOnxzsIoDFB97f5gLQWTlQdHyoL
         2nPIlwMXJiWBpi7njvJQIlprd6l9jZ9mBKBk91Ljc1NW6lBj2PcHU2HngOgI3M/oJVSa
         o42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eV8Qm7gEOxRXitBzZlCD866ixtrTlZl+PdLiNQm+4Rs=;
        b=n+ztyfmV/jL3S/Ngro0ZxZN13vO8PPl84CpAxo56TOfQpAPptdpZ6HEB9Koeio+I1K
         mTYSYTEYo6xMR2axl2/CfT9/YD2k0E/rbOd1m8GpoDkZdRR+hfZ2sXEy+x1sNxAXDDPN
         xnWAD4GPLSZI7NsmM1juLHte1VZBpkQCFh3f70/cPoi3Bn+hw4YTXzpIoA2LwiK700b1
         qEm81iLuTwmFr+0Km5bpXLTPJUPBn4LUVtQgTw8XBwUBCaCnpWCRnZQQ6xiOGE0Tbxr3
         txwnVyfGB7vPt+2esVDBWwKsUhpWDVcvHhNGPNSy4EcTZjS555WPtenBxtt7KZMPpeAs
         8zmg==
X-Gm-Message-State: AOAM530/im/d8YQijANcNbpXRVux1szfVd8z/lbJCXxVdFnNHHhxWtqc
        6wrkFauNV6v5qFQo58PFDd4=
X-Google-Smtp-Source: ABdhPJz96OxyT8iyC0IE4Iv4A+26UjobchLzlieGvOBLB0JJpiOumMEENEaX6qE7xLpkRxGIN6mGSg==
X-Received: by 2002:aca:cd0a:: with SMTP id d10mr2037540oig.52.1603202489420;
        Tue, 20 Oct 2020 07:01:29 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id y5sm473639ool.30.2020.10.20.07.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 07:01:28 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] drm/bridge: sii902x: Enable I/O and core VCC
 supplies if present
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Mark Brown <broonie@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        open list <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20200924200507.1175888-1-mr.nuke.me@gmail.com>
 <20200928173056.1674274-1-mr.nuke.me@gmail.com>
 <d74c7626-8f16-db85-c23f-79bf0cc400d0@gmail.com>
 <20201020071628.GA1737816@ravnborg.org>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <5c21a4a4-717c-9f8a-9764-6e3fb9554e46@gmail.com>
Date:   Tue, 20 Oct 2020 09:01:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201020071628.GA1737816@ravnborg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/20 2:16 AM, Sam Ravnborg wrote:
> Hi Alex.

[snip]

>>
>>
>>> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
>>> index 33fd33f953ec..d15e9f2c0d8a 100644
>>> --- a/drivers/gpu/drm/bridge/sii902x.c
>>> +++ b/drivers/gpu/drm/bridge/sii902x.c
>>> @@ -17,6 +17,7 @@
>>>    #include <linux/i2c.h>
>>>    #include <linux/module.h>
>>>    #include <linux/regmap.h>
>>> +#include <linux/regulator/consumer.h>
>>>    #include <linux/clk.h>
>>>    #include <drm/drm_atomic_helper.h>
>>> @@ -168,6 +169,8 @@ struct sii902x {
>>>    	struct drm_connector connector;
>>>    	struct gpio_desc *reset_gpio;
>>>    	struct i2c_mux_core *i2cmux;
>>> +	struct regulator *iovcc;
>>> +	struct regulator *cvcc12;
>>>    	/*
>>>    	 * Mutex protects audio and video functions from interfering
>>>    	 * each other, by keeping their i2c command sequences atomic.
>>> @@ -954,13 +957,13 @@ static const struct drm_bridge_timings default_sii902x_timings = {
>>>    		 | DRM_BUS_FLAG_DE_HIGH,
>>>    };
>>> +static int sii902x_init(struct sii902x *sii902x);
> Please re-arrange the code so this prototype is not needed.

I'd be happy to re-arrange things. It will make the diff look a lot 
bigger than what it is. Is that okay?

Alex

>>> +
>>>    static int sii902x_probe(struct i2c_client *client,
>>>    			 const struct i2c_device_id *id)
>>>    {
>>>    	struct device *dev = &client->dev;
>>> -	unsigned int status = 0;
>>>    	struct sii902x *sii902x;
>>> -	u8 chipid[4];
>>>    	int ret;
>>>    	ret = i2c_check_functionality(client->adapter,
>>> @@ -989,6 +992,43 @@ static int sii902x_probe(struct i2c_client *client,
>>>    	mutex_init(&sii902x->mutex);
>>> +	sii902x->iovcc = devm_regulator_get(dev, "iovcc");
>>> +	if (IS_ERR(sii902x->iovcc))
>>> +		return PTR_ERR(sii902x->iovcc);
>>> +
>>> +	sii902x->cvcc12 = devm_regulator_get(dev, "cvcc12");
>>> +	if (IS_ERR(sii902x->cvcc12))
>>> +		return PTR_ERR(sii902x->cvcc12);
>>> +
>>> +	ret = regulator_enable(sii902x->iovcc);
>>> +	if (ret < 0) {
>>> +		dev_err_probe(dev, ret, "Failed to enable iovcc supply");
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = regulator_enable(sii902x->cvcc12);
>>> +	if (ret < 0) {
>>> +		dev_err_probe(dev, ret, "Failed to enable cvcc12 supply");
>>> +		regulator_disable(sii902x->iovcc);
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = sii902x_init(sii902x);
>>> +	if (ret < 0) {
>>> +		regulator_disable(sii902x->cvcc12);
>>> +		regulator_disable(sii902x->iovcc);
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int sii902x_init(struct sii902x *sii902x)
>>> +{
>>> +	struct device *dev = &sii902x->i2c->dev;
>>> +	unsigned int status = 0;
>>> +	u8 chipid[4];
>>> +	int ret;
>>> +
>>>    	sii902x_reset(sii902x);
>>>    	ret = regmap_write(sii902x->regmap, SII902X_REG_TPI_RQB, 0x0);
>>> @@ -1012,11 +1052,11 @@ static int sii902x_probe(struct i2c_client *client,
>>>    	regmap_read(sii902x->regmap, SII902X_INT_STATUS, &status);
>>>    	regmap_write(sii902x->regmap, SII902X_INT_STATUS, status);
>>> -	if (client->irq > 0) {
>>> +	if (sii902x->i2c->irq > 0) {
>>>    		regmap_write(sii902x->regmap, SII902X_INT_ENABLE,
>>>    			     SII902X_HOTPLUG_EVENT);
>>> -		ret = devm_request_threaded_irq(dev, client->irq, NULL,
>>> +		ret = devm_request_threaded_irq(dev, sii902x->i2c->irq, NULL,
>>>    						sii902x_interrupt,
>>>    						IRQF_ONESHOT, dev_name(dev),
>>>    						sii902x);
>>> @@ -1031,9 +1071,9 @@ static int sii902x_probe(struct i2c_client *client,
>>>    	sii902x_audio_codec_init(sii902x, dev);
>>> -	i2c_set_clientdata(client, sii902x);
>>> +	i2c_set_clientdata(sii902x->i2c, sii902x);
>>> -	sii902x->i2cmux = i2c_mux_alloc(client->adapter, dev,
>>> +	sii902x->i2cmux = i2c_mux_alloc(sii902x->i2c->adapter, dev,
>>>    					1, 0, I2C_MUX_GATE,
>>>    					sii902x_i2c_bypass_select,
>>>    					sii902x_i2c_bypass_deselect);
>>> @@ -1051,6 +1091,8 @@ static int sii902x_remove(struct i2c_client *client)
>>>    	i2c_mux_del_adapters(sii902x->i2cmux);
>>>    	drm_bridge_remove(&sii902x->bridge);
>>> +	regulator_disable(sii902x->cvcc12);
>>> +	regulator_disable(sii902x->iovcc);
>>>    	return 0;
>>>    }
>>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
