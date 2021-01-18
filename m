Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5AE2FA156
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392202AbhARNX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:23:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42881 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392172AbhARNXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610976107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/j6fmz4BNu5zYxXBw+JVpP+HzvjSGdu8WbaEvKmmbPI=;
        b=K+lWZrdIr+BaL/N5eRfxXp5sEduoodFh/pMI66+bIzdWeZSjA6d+JWsGKbNMoyAjybQu3d
        yK/tbXeCpUsDnhMxeWk2u4mOB1oRbT6JNxv1650sbvLsS2Lffs9HpDCpH4Bbw5P5iSU3Sl
        LMoJbsL7dbEDnPMsRBzKwFUJ/cuhgto=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-zlJrKgoZPsOd02hAl3SvPA-1; Mon, 18 Jan 2021 08:21:46 -0500
X-MC-Unique: zlJrKgoZPsOd02hAl3SvPA-1
Received: by mail-qk1-f197.google.com with SMTP id q7so17046853qki.16
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:21:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/j6fmz4BNu5zYxXBw+JVpP+HzvjSGdu8WbaEvKmmbPI=;
        b=JNArqhq1Kyhds8Kb/47BWPYns0VO9Eg5DKTPgZtKjQ+H5q3smQjlnZbvYeVK9DKSwe
         wxX076ib/v1QG2L0NDt61c1Fnmzjw17mt0d+vvsQdWIIgjdyWFH460fB+gLIHJV90Ik+
         KecYlXYM1mSd5y2S+PaDFmHgOA6ZbUiYmwEy5fEwvefh3jQd1leK6WoybN89Np1u5GO0
         uN4Md+IbvUhUrsmtKYDaHs3kjbh/u0vxZvGteOuPwSv5MkS9dLSHefo/Z5MwMJnDSpjP
         dwhSif01TUy70lPhyK+TD9aRtOkRi6iPj4TRUzD72RoSit2SFCjGFYPf+8T3jrnNwnOH
         6cug==
X-Gm-Message-State: AOAM530G41QCQIRXSfhq3U1JeU2/w/3qP0sW4FC23TNjzxjrx9IVi+rY
        QW5gW/xRZnyfdQq9zyuaFU5d1iM2IH1zfvGmKItiQm/ax33rRwYYwVDb/L4ha9zCTVfO6Kkshaj
        65yP3ZbrrXs1cTBqzT9fxu3tI
X-Received: by 2002:a0c:e5d1:: with SMTP id u17mr24021661qvm.34.1610976105903;
        Mon, 18 Jan 2021 05:21:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXJOsf27ueWFhPZhoHG46qk+JWP2MsCVrcN24OKR2tyBT58lM9r3n3KYzfCjzHxUHMnFh6eg==
X-Received: by 2002:a0c:e5d1:: with SMTP id u17mr24021643qvm.34.1610976105648;
        Mon, 18 Jan 2021 05:21:45 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j203sm10482955qke.134.2021.01.18.05.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 05:21:45 -0800 (PST)
Subject: Re: [PATCH] iio: imu: bmi160: add mutex_lock for avoiding race
To:     chiguoqing <chi962464zy@163.com>, linux-iio@vger.kernel.org
Cc:     martin.blumenstingl@googlemail.com, linux-kernel@vger.kernel.org,
        chiguoqing@yulong.com, huyue@yulong.com, zhangwen@yulong.com
References: <20210118100527.19325-1-chi962464zy@163.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a524b6c0-31ad-99cf-d6a9-0ae761370449@redhat.com>
Date:   Mon, 18 Jan 2021 05:21:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210118100527.19325-1-chi962464zy@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/18/21 2:05 AM, chiguoqing wrote:
> Adding mutex_lock, when read and write reg need to use this lock to
> avoid race.
>
> Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>
> ---
>  drivers/iio/imu/bmi160/bmi160.h      |  2 ++
>  drivers/iio/imu/bmi160/bmi160_core.c | 17 +++++++++++++----
>  2 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
> index 32c2ea2d7112..0c189a8b5b53 100644
> --- a/drivers/iio/imu/bmi160/bmi160.h
> +++ b/drivers/iio/imu/bmi160/bmi160.h
> @@ -3,9 +3,11 @@
>  #define BMI160_H_
>  
>  #include <linux/iio/iio.h>
> +#include <linux/mutex.h>
>  #include <linux/regulator/consumer.h>
>  
>  struct bmi160_data {
> +	struct mutex lock;
where is the mutex_init() ?
>  	struct regmap *regmap;
>  	struct iio_trigger *trig;
>  	struct regulator_bulk_data supplies[2];
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index 290b5ef83f77..b626e067c612 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -454,18 +454,24 @@ static int bmi160_read_raw(struct iio_dev *indio_dev,

how the read and write functions lock and return are not consistent.

to me, the write function looks better, so change the read function to look more like the write function

Tom

>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&data->lock);
>  		ret = bmi160_get_data(data, chan->type, chan->channel2, val);
> +		mutex_unlock(&data->lock);
>  		if (ret)
>  			return ret;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 0;
> +		mutex_lock(&data->lock);
>  		ret = bmi160_get_scale(data,
>  				       bmi160_to_sensor(chan->type), val2);
> +		mutex_unlock(&data->lock);
>  		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&data->lock);
>  		ret = bmi160_get_odr(data, bmi160_to_sensor(chan->type),
>  				     val, val2);
> +		mutex_unlock(&data->lock);
>  		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
> @@ -479,19 +485,22 @@ static int bmi160_write_raw(struct iio_dev *indio_dev,
>  			    int val, int val2, long mask)
>  {
>  	struct bmi160_data *data = iio_priv(indio_dev);
> +	int result;
>  
> +	mutex_lock(&data->lock);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> -		return bmi160_set_scale(data,
> +		result = bmi160_set_scale(data,
>  					bmi160_to_sensor(chan->type), val2);
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		return bmi160_set_odr(data, bmi160_to_sensor(chan->type),
> +		result = bmi160_set_odr(data, bmi160_to_sensor(chan->type),
>  				      val, val2);
>  	default:
> -		return -EINVAL;
> +		result = -EINVAL;
>  	}
> +	mutex_unlock(&data->lock);
>  
> -	return 0;
> +	return result;
>  }
>  
>  static

