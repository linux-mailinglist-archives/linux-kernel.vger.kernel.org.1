Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEA72B5B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgKQI5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgKQI5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:57:32 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A71C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 00:57:32 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h21so2467004wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 00:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HMqiiZZLZag2rkvlLNNy7cR6rI7MwKWstqbzThJFXfM=;
        b=zVP3D1eAzk2ZudoZVH19g+0DAZCknFMroNpcBSijBRdXf2/2Kojx6JUsMlpOXv3Ylg
         mquWPzboohMW1a6yevOwsTQ7o3MVRtzFG+n/2wDhN3Lz3C5XkKUsLyQhSQVHuPAx2kgs
         foJIXx25xn5xMbWiy7nJXsP/ytLIAgqsxzr+Auzjk4syMEwN9+2+X6WxcsJaqNA/oB61
         ncKwEHb/JLrZ3U/nw7a6RwI2XJjtG0q4AQS/reNVaH+qCkUWVkfXDDuPoICx7uUk+7Bo
         05LzO8bUPl1zAdV5TdcYkmlPKgMOKV4/uIntCsp7O+9v5CgTiY1bcCrxyP87zB6E19ev
         NckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HMqiiZZLZag2rkvlLNNy7cR6rI7MwKWstqbzThJFXfM=;
        b=h2ZP8JN8s42GuNX6N4jdYa4Dui7fqLUbX/7Ike36mk4UaBqBUvBMC6thDA3FPFscUs
         RCl4/VtXF6pNDYSXE/XYmx0FWaRCFE+LNmR24GLThG2AFI99LsF76S3mwVPgDXL9L/4u
         KkO6jSZB1Syg/SovNPTMJnxDBYRX9vhFOdvZnkD9ZVtPaaZpLRsHzEBId2Lcbu6rgsZx
         bioFAtbfiBhVpVvidl/gRk3wjoWBP32xEjhF+Fq4DVnSVEPqWrtPQz42h9hvFQXn2pML
         hJ47Y5yhk9JlnEu9BUF0xPG8xhPJOrdW62UF8CIy8CG/Wm4OF4766vHlSFAQwktFNRNh
         MfzQ==
X-Gm-Message-State: AOAM53105mLV/pJjc6rbbS9u0CR/f7KtjqNz5HJueUtRpdjSDZWDXdPp
        bctoZ6/CRzxYabkQxBrIoRhT9A==
X-Google-Smtp-Source: ABdhPJzU2pOWGtLAxkIyeGkFD5c7UDbuUHJfH1SD44Bal/XnZB7RyCPu9nBIFkODmtJ6EzyqpgqCcw==
X-Received: by 2002:a1c:c30a:: with SMTP id t10mr2997486wmf.183.1605603450968;
        Tue, 17 Nov 2020 00:57:30 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6186:703a:2abc:2187? ([2a01:e34:ed2f:f020:6186:703a:2abc:2187])
        by smtp.googlemail.com with ESMTPSA id p4sm2882929wmc.46.2020.11.17.00.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 00:57:30 -0800 (PST)
Subject: Re: [PATCH] thermal: Fix NULL pointer dereference issue
To:     Zhang Rui <rui.zhang@intel.com>,
        Mukesh Ojha <mojha@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     amitk@kernel.org
References: <1605544181-5348-1-git-send-email-mojha@codeaurora.org>
 <4e28affd89ba8a852e0fb7ace076458b3d43839a.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f8c436ae-0f4c-5d2e-51a8-0e856fbf8f44@linaro.org>
Date:   Tue, 17 Nov 2020 09:57:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4e28affd89ba8a852e0fb7ace076458b3d43839a.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2020 08:18, Zhang Rui wrote:
> On Mon, 2020-11-16 at 21:59 +0530, Mukesh Ojha wrote:
>> Cooling stats variable inside thermal_cooling_device_stats_update()
>> can get NULL. We should add a NULL check on stat inside for sanity.
>>
>> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
>> ---
>>  drivers/thermal/thermal_sysfs.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/thermal/thermal_sysfs.c
>> b/drivers/thermal/thermal_sysfs.c
>> index a6f371f..f52708f 100644
>> --- a/drivers/thermal/thermal_sysfs.c
>> +++ b/drivers/thermal/thermal_sysfs.c
>> @@ -754,6 +754,9 @@ void thermal_cooling_device_stats_update(struct
>> thermal_cooling_device *cdev,
>>  {
>>  	struct cooling_dev_stats *stats = cdev->stats;
>>  
>> +	if (!stats)
>> +		return;
>> +
> May I know in which case stats can be NULL?
> The only possibility I can see is that cdev->ops->get_max_state() fails
> in cooling_device_stats_setup(), right?

A few lines below, the allocation could fail.

        stats = kzalloc(var, GFP_KERNEL);
        if (!stats)
                return;

Some drivers define themselves as a cooling device state to let the
userspace to act on their power. The screen brightness is one example
with a cdev with 1024 states, the resulting stats table to be allocated
is very big and the kzalloc is prone to fail.

> thanks,
> rui
> 
>>  	spin_lock(&stats->lock);
>>  
>>  	if (stats->state == new_state)
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
