Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D1E3014ED
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 12:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbhAWL7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 06:59:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50007 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726781AbhAWL7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 06:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611403056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2y/kKmoTB9zchXCiBT1BMXEPgDpr8Q0dNowjFc5DkvU=;
        b=deQV0ZdWQqJC+8jX4BhWdmMRXA9PXXWMAjsFWnNCG9cptFx6q7x2Mh1SNW0oFkZQbfICS3
        3BuRT+upUa64RDjItdKPdgZatzh+zPn6IJlQdXBltMfFEjOvVgA0eqoDwAbDpOYGy6o97y
        CXK5ZT+MBx3vlnWNsGu6zsQNP5J0PDc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-sVv1wwJEPoyHcCWQp_7cpQ-1; Sat, 23 Jan 2021 06:57:34 -0500
X-MC-Unique: sVv1wwJEPoyHcCWQp_7cpQ-1
Received: by mail-ej1-f70.google.com with SMTP id rl8so2945571ejb.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 03:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2y/kKmoTB9zchXCiBT1BMXEPgDpr8Q0dNowjFc5DkvU=;
        b=NMflWVlN+JseKjQ1DzTZ9cjxJVLp//4XVzq9SKumusT2CdF/kGZg1vX1YPa9eV8A1X
         GZwx0Pk4VpmdhIEdyPDbmz3QqbM8mc7q0MdiSjJzBC34P5VHNvOVYmSr9EQjUHwhkotC
         2YsBjd6BTwRq8Jqmjsn5ZEcAiyZrbQi0VXWgXzef7XjzyKqI1Mb7a0p1t7KXIJmCvFIn
         Y8csW7blP43I+OUvUmIRNHjPpNGfJ6yBbkpYqGE3/o6dd0T/YpEN8jrnkOvE/mIquCMx
         mYqfMRIXTEardKVABVY20tHKZWhGBYRN/AwFU+3GiYZkxRRZ1eaibPGkEONG2uoUml7g
         WpDg==
X-Gm-Message-State: AOAM531b13wOe1R5425eHTltStd2eU1E2KQBclcwsz23gz34MzD3P9II
        z5I8m5jEsTVV3QZO6ed6UoUhnPaGhtMscRl82T7kOVspnRX7+r9INTuCOn4pfAdXVVRJvsr2Lcc
        qkjaHBGsUTTuDPxSgvGiZoaUk4lWMY7SpPxdzxoLCtZJX3SdI5WLWwSjJhcSj8ZPj939WdXsOIP
        zh
X-Received: by 2002:a17:906:d0c1:: with SMTP id bq1mr500712ejb.202.1611403052719;
        Sat, 23 Jan 2021 03:57:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwM0j0OEhNogsZ5Yo7RzHOoi69GUvLI5qTKgtm8Q5Ez7f0Oj+CW0kBqtgQ8dvMyNBK8EYC/jQ==
X-Received: by 2002:a17:906:d0c1:: with SMTP id bq1mr500698ejb.202.1611403052522;
        Sat, 23 Jan 2021 03:57:32 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id z13sm7167891edc.73.2021.01.23.03.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jan 2021 03:57:31 -0800 (PST)
Subject: Re: [PATCH] regulator: core: Avoid debugfs: Directory ... already
 present! error
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20210122183250.370571-1-hdegoede@redhat.com>
 <20210123102941.GK106851@ediswmail.ad.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7a35e23c-700a-9a58-8f18-3e093db20ce5@redhat.com>
Date:   Sat, 23 Jan 2021 12:57:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210123102941.GK106851@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/23/21 11:29 AM, Charles Keepax wrote:
> On Fri, Jan 22, 2021 at 07:32:50PM +0100, Hans de Goede wrote:
>> Sometimes regulator_get() gets called twice for the same supply on the
>> same device. This may happen e.g. when a framework / library is used
>> which uses the regulator; and the driver itself also needs to enable
>> the regulator in some cases where the framework will not enable it.
>>
>> Commit ff268b56ce8c ("regulator: core: Don't spew backtraces on
>> duplicate sysfs") already takes care of the backtrace which would
>> trigger when creating a duplicate consumer symlink under
>> /sys/class/regulator/regulator.%d in this scenario.
>>
>> Commit c33d442328f5 ("debugfs: make error message a bit more verbose")
>> causes a new error to get logged in this scenario:
>>
>> [   26.938425] debugfs: Directory 'wm5102-codec-MICVDD' with parent 'spi-WM510204:00-MICVDD' already present!
>>
>> There is no _nowarn variant of debugfs_create_dir(), but we can detect
>> and avoid this problem by checking the return value of the earlier
>> sysfs_create_link_nowarn() call.
>>
>> Add a check for the earlier sysfs_create_link_nowarn() failing with
>> -EEXIST and skip the debugfs_create_dir() call in that case, avoiding
>> this error getting logged.
>>
>> Fixes: c33d442328f5 ("debugfs: make error message a bit more verbose")
>> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
> 
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> 
> Thanks,
> Charles
> 
>> -	int err;
>> +	int err = 0;
>>  
>> @@ -1663,8 +1663,8 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
>>  
>> -	regulator->debugfs = debugfs_create_dir(supply_name,
>> -						rdev->debugfs);
>> +	if (err != -EEXIST)
>> +		regulator->debugfs = debugfs_create_dir(supply_name, rdev->debugfs);
> 
> There is a slight oddity here in that if this regulator has
> no struct device we will still get the warning. However, I
> am totally not clear on when/why a regulator might not have a
> dev, and am fairly sure it isn't common. So my vote would be
> to cross that bridge if we ever come to it.

Yes, I expect the combination of having 2 consumers which both get the
regulator with a NULL device pointer to be very rare and hopefully
it does not happen at all.

Regards,

Hans

