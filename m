Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA32F27B214
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgI1QjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI1QjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:39:04 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E556C061755;
        Mon, 28 Sep 2020 09:39:04 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id a3so2023796oib.4;
        Mon, 28 Sep 2020 09:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qcxt6fZZMti5SbZnbeIFrcoJVPKr+jdSB80jUrubsi0=;
        b=ZNFvfiFTvBLU6BZt7lhL6OodHgRKD/kiTr/ywAUMX467n2sNFz8huYNjmlrn7KOs58
         yI9RLcCwZSd0MandklFoks4jaXfG//ZebuXL50JPHJ8IIC77KTSbidrEKmee+onNcUxF
         hc/C5opocA7CzoDANXPQnj4XEAyjpMNf+c0WqCNcsDooDDKUBaBjltu9lnJHsV4gqqnO
         oMWSNigqcp9+hwzuIcrK0HeHjLqASYfES22sH6f6eeaZx068k5ITLswhO7u/7Cj9vsIN
         cr83jRNEpvZb49IoAlqs7xZb7emwWNqeoA2sdZ3Jkqnw50gpueX9MzG2EMz4BeNQgcOf
         VE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qcxt6fZZMti5SbZnbeIFrcoJVPKr+jdSB80jUrubsi0=;
        b=ADO5c4L9QCZvdtorjEo4jQrTsB7K33w2wQAn8WAOK4E8wESR1lPO42nzK6XjyntgoK
         +9X4JlR9r/I6fsQv1uk7Q8HcPTIoZMvMZzNrBtae0DL3L8KkvuctNw7uS6mAUusTPI0H
         rH3ZMKoC6ciW3UpkMb30EXytctqckqx+nss6bZ8wgrIXxU3Z00JVXkc2HIf4xojh77+s
         57URwKsFRBiy5ZkhYicgkSRwECrbolAXZP8lw4XjwYNd33XZ5rC2I7p/bTvRM/j56fXK
         pFTwzRh1PR3aLkBXV6VoXrreYfbqXRYz51iB8tmv/CA/agWGVbs7GIckFpjoaDBowHTp
         KSZA==
X-Gm-Message-State: AOAM530Mvbe0rIhZ4tbLqWITjSfkUlHtDBqmDxoApLaw8A1FQ4aKajFb
        +3Gl8qUAQHdkb71a3eXdwRxPdK5pP0g=
X-Google-Smtp-Source: ABdhPJwEaRXFV3Znjz2Xzv8R6nTqOwt6bDCtAecdNPX11xV4byw0XPPskGdHoP+5rc9Tu+lwCZDc7Q==
X-Received: by 2002:aca:388:: with SMTP id 130mr1409984oid.145.1601311143774;
        Mon, 28 Sep 2020 09:39:03 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r20sm2187525ooh.5.2020.09.28.09.39.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Sep 2020 09:39:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 28 Sep 2020 09:39:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alban Bedel <alban.bedel@aerq.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] hwmon: (lm75) Add regulator support
Message-ID: <20200928163902.GE106276@roeck-us.net>
References: <20200928153923.134151-1-alban.bedel@aerq.com>
 <20200928153923.134151-4-alban.bedel@aerq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928153923.134151-4-alban.bedel@aerq.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 05:39:23PM +0200, Alban Bedel wrote:
> Add regulator support for boards where the sensor first need to be
> powered up before it can be used.
> 
> Signed-off-by: Alban Bedel <alban.bedel@aerq.com>
> ---
> v2: Rely on dummy regulators instead of explicitly handling missing
>     regulator
> ---
>  drivers/hwmon/lm75.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index ba0be48aeadd..e394df648c26 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -17,6 +17,7 @@
>  #include <linux/of.h>
>  #include <linux/regmap.h>
>  #include <linux/util_macros.h>
> +#include <linux/regulator/consumer.h>
>  #include "lm75.h"
>  
>  /*
> @@ -101,6 +102,7 @@ static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
>  struct lm75_data {
>  	struct i2c_client		*client;
>  	struct regmap			*regmap;
> +	struct regulator		*vs;
>  	u8				orig_conf;
>  	u8				current_conf;
>  	u8				resolution;	/* In bits, 9 to 16 */
> @@ -540,6 +542,7 @@ static void lm75_remove(void *data)
>  	struct i2c_client *client = lm75->client;
>  
>  	i2c_smbus_write_byte_data(client, LM75_REG_CONF, lm75->orig_conf);
> +	regulator_disable(lm75->vs);
>  }
>  
>  static int
> @@ -567,6 +570,10 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	data->client = client;
>  	data->kind = kind;
>  
> +	data->vs = devm_regulator_get(dev, "vs");
> +	if (IS_ERR(data->vs))
> +		return PTR_ERR(data->vs);
> +
>  	data->regmap = devm_regmap_init_i2c(client, &lm75_regmap_config);
>  	if (IS_ERR(data->regmap))
>  		return PTR_ERR(data->regmap);
> @@ -581,11 +588,19 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	data->sample_time = data->params->default_sample_time;
>  	data->resolution = data->params->default_resolution;
>  
> +	/* Enable the power */
> +	err = regulator_enable(data->vs);
> +	if (err) {
> +		dev_err(dev, "failed to enable regulator: %d\n", err);
> +		return err;
> +	}
> +
>  	/* Cache original configuration */
>  	status = i2c_smbus_read_byte_data(client, LM75_REG_CONF);
>  	if (status < 0) {
>  		dev_dbg(dev, "Can't read config? %d\n", status);
> -		return status;
> +		err = status;
> +		goto disable_regulator;

The point of using devm_add_action_or_reset() was specifically to avoid having
to have the cleanup gotos. On top of that, the lm75_remove() function was
specifically intended to clean up configuration data, not to do anything else.
While hijacking lm75_remove() to also disable the regulator is technically
correct, it makes the code more difficult to understand, and it creates a
potential source for subsequently introduced bugs. Right now I am not inclined
to accept this code as-is. Please provide arguments for handling the cleanup
this way instead of using devm_add_action_or_reset().

Thanks,
Guenter
