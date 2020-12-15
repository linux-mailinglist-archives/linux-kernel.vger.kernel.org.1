Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946062DB4C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgLOUBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgLOUBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:01:01 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE51C06179C;
        Tue, 15 Dec 2020 12:00:20 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id ga15so29475413ejb.4;
        Tue, 15 Dec 2020 12:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Vz7t0MFC5aymielea2K5QZe7zJV0QES4cE9gABPJn8=;
        b=Q4WCrOW0+BY8Ove2ALhxmDuJVAc1mFBZuFCThWib4oaGHMmFPkgDPObVMf76WTi07I
         IhNCaPJm3waAuoEeTclzo/JBGEEa4WmyVEY+cDM15y+YgfNn33gVXL9f1Dskvk+Orddy
         A68zbuF7OpPektmYs9hmJoQTK2bF+ZVxlxvjLcNIc/Y3xwhoOMf1GWhm14HugifuDgXn
         uSIgFgDnktItru/DC/u+7vZYj8pRUKXhlLPvubwhdFgIQrkhBCYTww3cVPwOjHDHlwSq
         Jj6U37dgXWwb5AzDNaGN0rlBcGylkAHmoDsdl9PzfU8KeWPDsVB6A7oB9EHQWv1OTuII
         dnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Vz7t0MFC5aymielea2K5QZe7zJV0QES4cE9gABPJn8=;
        b=OccsZ+VD8MeEZUBY3xDnDbl8PNAGABGw1GC92nrQKy//iYL6zIXrQtL7+DmGgZXbY9
         3+CbC8rapsiODVw6Q3FCtswCvAWirPSaM1xLy2zqbmbb2P/bG9x4cmB7FreCHukMA5D9
         eFC/RYW8oI70u88Tg8HHeN6oHCHJMs5MYczaia/rKRWXgtzCuKqBO3S5q7HA4fJgOgFW
         pSkSUIC3kQBMf0/2dlJB9n/h3MIDPTfHloh4HoUVSSLHAY+YsYxM+AuEuqWNQyVrOcV2
         mtfNpYqq0rBXKqlMHMyOFyKIg5fgz7HCK2yJC/axUOxqX40g9M5O5o7KgjnRXNjv/3XK
         t/Zg==
X-Gm-Message-State: AOAM5331ERhOlnwjPFajXYIMhemxpKb27b6qvwXebqS2ETG7ke5b42Ex
        wqH12PBkzkHwkot/q8XC+jEvwYbdo9K4Ag==
X-Google-Smtp-Source: ABdhPJyE0ZZRr6wCpsJqhDlJwTci5gPOadVCpJgoWjoG3kVB+gBjuaIYxDhxfbFJJtDUPr9M+I2bfw==
X-Received: by 2002:a17:906:7243:: with SMTP id n3mr27611178ejk.246.1608062419143;
        Tue, 15 Dec 2020 12:00:19 -0800 (PST)
Received: from [192.168.2.202] (pd9e5a7aa.dip0.t-ipconnect.de. [217.229.167.170])
        by smtp.gmail.com with ESMTPSA id q5sm2117746ejr.89.2020.12.15.12.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 12:00:18 -0800 (PST)
Subject: Re: [PATCH v2 8/9] platform/surface: Add Surface Aggregator
 user-space interface
To:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
 <20201203212640.663931-9-luzmaximilian@gmail.com>
 <13b24eb0-e60f-e1d6-fcea-a19f62c40b4f@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <a22def75-a4e5-4ae4-f527-7695630be1ee@gmail.com>
Date:   Tue, 15 Dec 2020 21:00:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <13b24eb0-e60f-e1d6-fcea-a19f62c40b4f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/20 5:35 PM, Hans de Goede wrote:
> Hi,
> 
> On 12/3/20 10:26 PM, Maximilian Luz wrote:
>> Add a misc-device providing user-space access to the Surface Aggregator
>> EC, mainly intended for debugging, testing, and reverse-engineering.
>> This interface gives user-space applications the ability to send
>> requests to the EC and receive the corresponding responses.
>>
>> The device-file is managed by a pseudo platform-device and corresponding
>> driver to avoid dependence on the dedicated bus, allowing it to be
>> loaded in a minimal configuration.
>>
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> 
> 1 review comment inline:
>

[...]

>> +static long ssam_cdev_request(struct ssam_cdev *cdev, unsigned long arg)
>> +{
>> +	struct ssam_cdev_request __user *r;
>> +	struct ssam_cdev_request rqst;
>> +	struct ssam_request spec;
>> +	struct ssam_response rsp;
>> +	const void __user *plddata;
>> +	void __user *rspdata;
>> +	int status = 0, ret = 0, tmp;
>> +
>> +	r = (struct ssam_cdev_request __user *)arg;
>> +	ret = copy_struct_from_user(&rqst, sizeof(rqst), r, sizeof(*r));
>> +	if (ret)
>> +		goto out;
>> +
>> +	plddata = u64_to_user_ptr(rqst.payload.data);
>> +	rspdata = u64_to_user_ptr(rqst.response.data);
>> +
>> +	/* Setup basic request fields. */
>> +	spec.target_category = rqst.target_category;
>> +	spec.target_id = rqst.target_id;
>> +	spec.command_id = rqst.command_id;
>> +	spec.instance_id = rqst.instance_id;
>> +	spec.flags = rqst.flags;
>> +	spec.length = rqst.payload.length;
>> +	spec.payload = NULL;
>> +
>> +	rsp.capacity = rqst.response.length;
>> +	rsp.length = 0;
>> +	rsp.pointer = NULL;
>> +
>> +	/* Get request payload from user-space. */
>> +	if (spec.length) {
>> +		if (!plddata) {
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>> +
>> +		spec.payload = kzalloc(spec.length, GFP_KERNEL);
>> +		if (!spec.payload) {
>> +			status = -ENOMEM;
>> +			ret = -EFAULT;
>> +			goto out;
>> +		}
>> +
>> +		if (copy_from_user((void *)spec.payload, plddata, spec.length)) {
>> +			ret = -EFAULT;
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	/* Allocate response buffer. */
>> +	if (rsp.capacity) {
>> +		if (!rspdata) {
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>> +
>> +		rsp.pointer = kzalloc(rsp.capacity, GFP_KERNEL);
>> +		if (!rsp.pointer) {
>> +			status = -ENOMEM;
>> +			ret = -EFAULT;
> 
> This is weird, -EFAULT should only be used if a SEGFAULT
> would have been raised if the code was running in
> userspace rather then in kernelspace, IOW if userspace
> has provided an invalid pointer (or a too small buffer,
> causing the pointer to become invalid at some point in
> the buffer).

Oh, right.

> IMHO you should simply do ret = -ENOMEM here.

Yes. that looks better. I will change that as suggested.
> Otherwise this looks good to me.

Thanks,
Max
