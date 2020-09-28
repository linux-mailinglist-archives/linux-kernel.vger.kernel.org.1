Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292D127B1DF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgI1Q3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgI1Q3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:29:51 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AC3C061755;
        Mon, 28 Sep 2020 09:29:51 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id w16so1984961oia.2;
        Mon, 28 Sep 2020 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jh46diSMixVv8D+pqSNtebIwvUsOQAh+1m9WR4nVRkM=;
        b=o/0Sl8oF4GP19N6qpRJs9EIRQ2OfaZ8cdQxGihCwzp6+9aKFRL/as+6phmhDuFCip1
         R+EJaM0EPfAlDNFtJl6/0oy657xqWoB2oNhGsnCU+L0+f65N1uUoj48pylAq+r/iYDQ4
         6SVkxWdUfGWdiRE88cQweR4Vq28ifPITpQBGlzH7fWMNSVV6i5G1XdnoyHemKcCUcClQ
         umO6Y+5sf1Wx7navWSUGsMMibNK9JAZpYAqZlJCroU1HMnqVgoezJvcz04go5NnhrLlA
         aOpETXRkoLmOYuCdsY3goSNPJAxlD06/UkYLegYYtpOWzpaR0xhuiX0d4SjP1847ygju
         hT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jh46diSMixVv8D+pqSNtebIwvUsOQAh+1m9WR4nVRkM=;
        b=pDnDg/9nmqWARjqmjRkB/XJ6WirnslYKojlzgvisA6He6b/9rU76OXinXA5nObogyW
         ziwq23tD0Kz+BugTKob4JjqimUpadQrfJDVI18K/EjF5Ql+MNwHRkTqu/wv9fXPZCcmD
         Cf4TjXIDatWb3U2dwv359+MBRSyDRA8/1QFT+HrsPdfZ8ObYb8XtUIUq/+B+WoUNWLED
         4Qq02CXnx4PeR5iKxuAy7ESE653Vs+/cxJFm0p3quGr/cSh42KbiQeXl86PY7cOueyXv
         AGnFiYa+xH7HQdml9rNEbTgSkQZXqb7JK2gtx/SCo4WF71RAsvJ7fITaYxqFMMIZy3XC
         D4GA==
X-Gm-Message-State: AOAM530tUiagSf81TuKZnqi7JE0O0as9ug2Vj4eoCWayrYN48dLXChJF
        YQvl/vfbSScGpH3QCxt581I=
X-Google-Smtp-Source: ABdhPJxSqeMAfEUz7YuIK6m2YEbiBIzEfyv14oZcMruuHbIDo2vp91PvtywAq7nerZtQJSJzanQDJA==
X-Received: by 2002:aca:5110:: with SMTP id f16mr1427231oib.30.1601310590751;
        Mon, 28 Sep 2020 09:29:50 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i7sm325014oto.62.2020.09.28.09.29.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Sep 2020 09:29:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 28 Sep 2020 09:29:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Bedel, Alban" <alban.bedel@aerq.com>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 3/3] hwmon: (lm75) Add regulator support
Message-ID: <20200928162948.GC106276@roeck-us.net>
References: <20200917101819.32045-1-alban.bedel@aerq.com>
 <20200917101819.32045-4-alban.bedel@aerq.com>
 <7986c014-b826-bad1-f19c-cdda31d20804@roeck-us.net>
 <d3c7959cd1e775ae4680a446328f271e7d6c42c6.camel@aerq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3c7959cd1e775ae4680a446328f271e7d6c42c6.camel@aerq.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 03:13:53PM +0000, Bedel, Alban wrote:
> On Thu, 2020-09-17 at 22:33 -0700, Guenter Roeck wrote:
> > On 9/17/20 3:18 AM, Alban Bedel wrote:
> > > Add regulator support for boards where the sensor first need to be
> > > powered up before it can be used.
> > > 
> > > Signed-off-by: Alban Bedel <alban.bedel@aerq.com>
> > > ---
> > >  drivers/hwmon/lm75.c | 31 +++++++++++++++++++++++++++++--
> > >  1 file changed, 29 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> > > index ba0be48aeadd..b673f8d2ef20 100644
> > > --- a/drivers/hwmon/lm75.c
> > > +++ b/drivers/hwmon/lm75.c
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/of.h>
> > >  #include <linux/regmap.h>
> > >  #include <linux/util_macros.h>
> > > +#include <linux/regulator/consumer.h>
> > >  #include "lm75.h"
> > >  
> > >  /*
> > > @@ -101,6 +102,7 @@ static const unsigned short normal_i2c[] = {
> > > 0x48, 0x49, 0x4a, 0x4b, 0x4c,
> > >  struct lm75_data {
> > >  	struct i2c_client		*client;
> > >  	struct regmap			*regmap;
> > > +	struct regulator		*vs;
> > >  	u8				orig_conf;
> > >  	u8				current_conf;
> > >  	u8				resolution;	/* In bits, 9 to 16 */
> > > @@ -540,6 +542,8 @@ static void lm75_remove(void *data)
> > >  	struct i2c_client *client = lm75->client;
> > >  
> > >  	i2c_smbus_write_byte_data(client, LM75_REG_CONF, lm75->orig_conf);
> > > +	if (lm75->vs)
> > > +		regulator_disable(lm75->vs);
> > >  }
> > >  
> > >  static int
> > > @@ -567,6 +571,14 @@ lm75_probe(struct i2c_client *client, const
> > > struct i2c_device_id *id)
> > >  	data->client = client;
> > >  	data->kind = kind;
> > >  
> > > +	data->vs = devm_regulator_get_optional(dev, "vs");
> > 
> > Looking into the regulator API, it may be better if you use
> > devm_regulator_get().
> > AFAICS it returns a dummy regulator if there is none, and NULL if the
> > regulator subsystem is disabled. So
> > 	data->vs = devm_regulator_get(dev, "vs");
> > 	if (IS_ERR(data->vs))
> > 		return PTR_ERR(data->vs);
> > should work and would be less messy.
> 
> Ok, I'll change that in the next version.
> 
> > > +	if (IS_ERR(data->vs)) {
> > > +		if (PTR_ERR(data->vs) == -ENODEV)
> > > +			data->vs = NULL;
> > > +		else
> > > +			return PTR_ERR(data->vs);
> > > +	}
> > > +
> > >  	data->regmap = devm_regmap_init_i2c(client,
> > > &lm75_regmap_config);
> > >  	if (IS_ERR(data->regmap))
> > >  		return PTR_ERR(data->regmap);
> > > @@ -581,11 +593,21 @@ lm75_probe(struct i2c_client *client, const
> > > struct i2c_device_id *id)
> > >  	data->sample_time = data->params->default_sample_time;
> > >  	data->resolution = data->params->default_resolution;
> > >  
> > > +	/* Enable the power */
> > > +	if (data->vs) {
> > > +		err = regulator_enable(data->vs);
> > > +		if (err) {
> > > +			dev_err(dev, "failed to enable regulator:
> > > %d\n", err);
> > > +			return err;
> > > +		}
> > > +	}
> > > +
> > 
> > How about device removal ? Don't you have to call regulator_disable()
> > there as well ? If so, it might be best to use
> > devm_add_action_or_reset() to register a disable function.
> 
> This is handled in lm75_remove() where I added the regulator_disable()
> call.

lm75_remove() won't be called if the probe function fails.

Guenter
