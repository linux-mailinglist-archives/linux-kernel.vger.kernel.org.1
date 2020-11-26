Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3532C586B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390433AbgKZPmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbgKZPmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:42:54 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DE2C0613D4;
        Thu, 26 Nov 2020 07:42:54 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t3so1998257pgi.11;
        Thu, 26 Nov 2020 07:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CH+cRNcg6MuSmBZwmsnT45warB+8Gw1kJctD4TAiICU=;
        b=K31kxDd9vM9/hNaDD0lbBgcCmZiYStH3NzemVSJgFmcw8f/MPpCJ8JKrD1YQmDaaoI
         7PwA6QG/BHw9meKkyCnMlsVyTSwcCdJaILsEWHcYdcvEe3I+xUh3iu/xhqiLC01r2IYK
         Q0hDxOzw2uGumOK/hPsvjYqYXVduPo+VpQzkuymFCva+Z/ho4/tFOd5dmQlXctoRsa/0
         YIrimRiFTmmtPXizxUaGfGF0mITQV1B7EfSMnA22z1igx5h7+rTktVYM4ZzXUTeercel
         cEvUaAJmKrbatCt50YGDX5Z/CCJ+BNEfi3/TPKeDwUECZEbyX2cyt+yw1mgIULCh9A3K
         3BvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CH+cRNcg6MuSmBZwmsnT45warB+8Gw1kJctD4TAiICU=;
        b=h6Q0TdbQeeviKV0SqJX1jrF4BQpEV/bdQsomC1k9GeUzPQcSiiQKfcI2Zav2hHxUZP
         P37hxancQpmiBueApIbLGxr6hiplm7dEdnKGSLoogAEU3xJpWrGpGX4/b1mjPTDR2wBj
         DYocEKt0+TZ28mcJo8p00DegKyRaNlIfWeoR7/44jwYyiobCkmuETTislXpa3H851hyi
         JgZ9QSDvNyyUecOuk0YYGdZMwW+uRt2kUkJe2tItpgyWQqjhvdmnFs2Vm0xsUbngutPw
         UrkxPkyXgAb57qM6pcWRb9zQhOUN9UWs2PLrA97gg5WAQ+Xo3cRaWCeb0hM2Qeg2/kvB
         IlTA==
X-Gm-Message-State: AOAM53039j2WxlTy7ASYYfphM35Omz4hODHj24QCJIqGgfBb08YLkzWG
        nibsThqOPofVICQ9MOkA5Y4=
X-Google-Smtp-Source: ABdhPJzrJUJJBUX9aOuyg94JNER1KvknscYF0DOo3GMaSmBan1j7fJNSIZluMNo5qqqaxgowoPGwRA==
X-Received: by 2002:aa7:824d:0:b029:18b:ad77:1a2b with SMTP id e13-20020aa7824d0000b029018bad771a2bmr3117593pfn.25.1606405373935;
        Thu, 26 Nov 2020 07:42:53 -0800 (PST)
Received: from paju ([116.124.119.85])
        by smtp.gmail.com with ESMTPSA id fh22sm7383602pjb.45.2020.11.26.07.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 07:42:52 -0800 (PST)
Date:   Fri, 27 Nov 2020 00:42:47 +0900
From:   Dongjin Kim <tobetter@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pwm-fan) add fan pwm1_enable attribute
Message-ID: <20201126154247.GA24875@paju>
References: <20201125163242.GA1264232@paju>
 <20201126020536.GE111386@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126020536.GE111386@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 06:05:36PM -0800, Guenter Roeck wrote:
> On Thu, Nov 26, 2020 at 01:32:42AM +0900, Dongjin Kim wrote:
> > This patch adds to new attribute 'pwm1_enable' to change the fan speed
> > control method as documented in 'Documentation/hwmon/sysfs-interface'.
> > 
> > Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> 
> The new attribute needs to be documented in
> Documentation/hwmon/pwm-fan.rst, with supported values.
> 
> > ---
> >  drivers/hwmon/pwm-fan.c | 52 ++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 46 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> > index 1f63807c0399..834275309421 100644
> > --- a/drivers/hwmon/pwm-fan.c
> > +++ b/drivers/hwmon/pwm-fan.c
> > @@ -39,6 +39,7 @@ struct pwm_fan_ctx {
> >  	unsigned int pwm_fan_max_state;
> >  	unsigned int *pwm_fan_cooling_levels;
> >  	struct thermal_cooling_device *cdev;
> > +	int enable;
> >  };
> >  
> >  /* This handler assumes self resetting edge triggered interrupt. */
> > @@ -76,6 +77,10 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
> >  	struct pwm_state state = { };
> >  
> >  	mutex_lock(&ctx->lock);
> > +
> > +	if (ctx->enable == 0)
> > +		pwm = MAX_PWM;
> > +
> >  	if (ctx->pwm_value == pwm)
> >  		goto exit_set_pwm_err;
> >  
> > @@ -137,11 +142,42 @@ static ssize_t rpm_show(struct device *dev,
> >  	return sprintf(buf, "%u\n", ctx->rpm);
> >  }
> >  
> > +static ssize_t enable_store(struct device *dev,
> > +		struct device_attribute *attr,
> > +		const char *buf, size_t count)
> > +{
> > +	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> > +	int err;
> > +	unsigned long val;
> > +
> > +	err = kstrtoul(buf, 10, &val);
> > +	if (err)
> > +		return err;
> > +
> 
> 'val' must be validated and only accept permitted values.
Sure.
> 
> > +	mutex_lock(&ctx->lock);
> > +	ctx->enable = val;
> > +	mutex_unlock(&ctx->lock);
> > +
> > +	err = __set_pwm(ctx, ctx->pwm_fan_cooling_levels[ctx->pwm_fan_state]);
> > +
> > +	return err ? err : count;
> > +}
> > +
> > +static ssize_t enable_show(struct device *dev, struct device_attribute *attr,
> > +			   char *buf)
> > +{
> > +	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> > +
> > +	return sprintf(buf, "%u\n", ctx->enable);
> > +}
> > +
> >  static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
> > +static SENSOR_DEVICE_ATTR_RW(pwm1_enable, enable, 0);
> >  static SENSOR_DEVICE_ATTR_RO(fan1_input, rpm, 0);
> >  
> >  static struct attribute *pwm_fan_attrs[] = {
> >  	&sensor_dev_attr_pwm1.dev_attr.attr,
> > +	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
> >  	&sensor_dev_attr_fan1_input.dev_attr.attr,
> >  	NULL,
> >  };
> > @@ -153,7 +189,7 @@ static umode_t pwm_fan_attrs_visible(struct kobject *kobj, struct attribute *a,
> >  	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> >  
> >  	/* Hide fan_input in case no interrupt is available  */
> > -	if (n == 1 && ctx->irq <= 0)
> > +	if (n == 2 && ctx->irq <= 0)
> >  		return 0;
> >  
> >  	return a->mode;
> > @@ -200,7 +236,7 @@ static int
> >  pwm_fan_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state)
> >  {
> >  	struct pwm_fan_ctx *ctx = cdev->devdata;
> > -	int ret;
> > +	int ret = 0;
> >  
> >  	if (!ctx || (state > ctx->pwm_fan_max_state))
> >  		return -EINVAL;
> > @@ -208,10 +244,12 @@ pwm_fan_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state)
> >  	if (state == ctx->pwm_fan_state)
> >  		return 0;
> >  
> > -	ret = __set_pwm(ctx, ctx->pwm_fan_cooling_levels[state]);
> > -	if (ret) {
> > -		dev_err(&cdev->device, "Cannot set pwm!\n");
> > -		return ret;
> > +	if (ctx->enable >= 2) {
> 
> What is "automatic" here ? I don't see how this driver or the underlying
> pwm controller/chip would support automatic fan speed control. This is
> completely independent of thermal control: thermal device support does _not_
> imply or suggest "automatic" fan speed control from a pwm chip perspective.
> 
My understanding of 'automatic' is to set the fan speed by a thermal device
with the trip points, it changes the cooling state and change the fan speed.
Please correct me if I am wrong.

> This makes me also very concerned about this attribute in the first please:
> All it does, in its current implementation, is to disable thermal device 
> control. That is not the idea here, and it doesn't make any sense to me.
> On the contrary, all I can find is that it is dangerous.
> 
I don't intend to change the thermal control itself in 'manual' mode, but does
not change the fan speed with given cooling state. In 'automatic' mode, the
fan speed will be changed by the thermal device.

> Please describe in detail what you think this attribute is supposed to
> accomplish, and why you think it is needed or even makes sense. Overriding
> thermal control doesn't make sense to me: If you want that, just disable
> thermal control, or don't register this device as cooling device in the
> first place.  Other than that, the whole driver implies manual pwm control.
> That means pwm can already be "disabled" by writing a 0 pwm value. An
> additional attributes doesn't add value and only makes the driver ABI
> unnecessarily complex. So please prepare a detailed rationale to convince
> me otherwise.
>
I am using this driver to run a fan on ARM SBC and thought 'fancontrol' can
help to map the fan speed with pwm value if necessary instead of using the pwm
values in a device tree by writing '1' to 'pwm1_enable'. When this driver is
not registered as a cooling device, as you suggested, OS should provide the
default fancontrol config to run fully in manual mode if my understanding is
correct. Based on this what I am thinking is that OS images for ARM SBC should
have a fan control service or a tool if it allows user to change the fan speed.
But this could be very various for all SBC, I would prefer to provide the
default cooling device in the device tree to prevent the absence of fan
control due to the missing or wrong config.

> We can have a separate discussion if disabling a pwm controller using the
> hwmon ABI should disable that pwm controller from a thermal (cooling) device
> perspective. If so, we'll need to think about the implications. We can not
> just disable thermal cooling device support without telling the thermal
> subsystem that this means of temperature control doesn't work anymore.
> That should, however, be a completely separate discussion, independent
> of this driver, and it should include thermal subsystem maintainers
> and the thermal subsystem mailing list.
Ok, thank you for your advice and review. :)

Dongjin.
> 
> Thanks,
> Guenter
> 
> > +		ret = __set_pwm(ctx, ctx->pwm_fan_cooling_levels[state]);
> > +		if (ret) {
> > +			dev_err(&cdev->device, "Cannot set pwm!\n");
> > +			return ret;
> > +		}
> >  	}
> >  
> >  	ctx->pwm_fan_state = state;
> > @@ -298,6 +336,8 @@ static int pwm_fan_probe(struct platform_device *pdev)
> >  	if (IS_ERR(ctx->pwm))
> >  		return dev_err_probe(dev, PTR_ERR(ctx->pwm), "Could not get PWM\n");
> >  
> > +	ctx->enable = 2;
> > +
> >  	platform_set_drvdata(pdev, ctx);
> >  
> >  	ctx->irq = platform_get_irq_optional(pdev, 0);
> > -- 
> > 2.25.1
> > 
