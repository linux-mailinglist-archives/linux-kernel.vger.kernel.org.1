Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6A7214BE4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jul 2020 12:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgGEKyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 06:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgGEKyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 06:54:43 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC178C061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 03:54:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z15so26393936wrl.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 03:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V2/S+yNoGHpUJ9bJY/RbASk+sGjYPO/+M81PbWRsQ7o=;
        b=HPXaoEx7Yrrh7UmEEs257qwaUwfxkffA/l7T6symo8Usd88flPhvR7WQWEluE+HIgH
         lK52KG66S1aUcdknFCGfJfr9ue2QxJIHjQkA9wFqX5kIhNpQKBJFE8SHKtRbQAhAAk3Q
         2Vc60SBORd3IWYtQy3Xsb2eQdQa89vtFTUCLGllN3BLnJdgUHdk2eZ3t4dufPCDAMwdc
         AFqF8P3UnwJdRhu1rukRmJYoKQmSGLmEXq8zGxMODFJeJVj9ZdMJN0DffomoY8ngfEmp
         fe3rqnsmp+Em3N+0IOCDt3CVY3BdZPIoHaHlmgsXi+so+vRLUKZ+LORjmGOpun0ov1vC
         xV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V2/S+yNoGHpUJ9bJY/RbASk+sGjYPO/+M81PbWRsQ7o=;
        b=Exoh7igMnoNJ4Jj+8478iUzxjN7SjIP20puDWaksy5ST0gKmRF5cauMVvYyjt5FAeC
         4FfEBgK5nOjcFZyNHfDZxHmSlwMjoqqpCXHkO60apDVLowgvRpbMkfKKgjSzXa1P1R+o
         ++WfxsBG10QEqnQimUZ1GEEYqC0iI7/UvTwUe4c+IidZRSRagcK/mLBxZ7KxplZHGOka
         EMmebPbTmIoVa+xSG9oNKXWqOLlxrqNpk75IYjTxZ4nlecYvvsiP9GAM8MZw4yGtpq8H
         e46u5LCKkaBUEEGNBrSLgz/78BmoZT4E6gbC5o6MEE+5y66P5q8X7Wi+eoau5ObuEqHV
         8NdA==
X-Gm-Message-State: AOAM532RLvsE+Ye8wkXkWEG4rIxZ7uPqHBDgG8yi3oy7T/STUgP+E07m
        FWd61u9+Gjgpg9Jwy+rY8v9Rpw==
X-Google-Smtp-Source: ABdhPJw1FNQesFiJorDH5W5rwkXy6/mDKJadBzv/X0H2UHjyz4POGHCVVlh5mCgcqi8PDEDbKJcaMw==
X-Received: by 2002:a5d:4b0f:: with SMTP id v15mr8863053wrq.216.1593946481219;
        Sun, 05 Jul 2020 03:54:41 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:3d6a:34c2:1d56:827? ([2a01:e34:ed2f:f020:3d6a:34c2:1d56:827])
        by smtp.googlemail.com with ESMTPSA id w12sm20668447wrm.79.2020.07.05.03.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2020 03:54:40 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] thermal: core: genetlink support for
 events/cmd/sampling
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20200703085309.32166-1-daniel.lezcano@linaro.org>
 <20200703085309.32166-3-daniel.lezcano@linaro.org>
 <191a868fc02f6fca93250240cf6c3f7576c6a2c3.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6c859054-1ede-b66c-b28a-c3d7903431b3@linaro.org>
Date:   Sun, 5 Jul 2020 12:54:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <191a868fc02f6fca93250240cf6c3f7576c6a2c3.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2020 08:03, Zhang Rui wrote:
> On Fri, 2020-07-03 at 10:53 +0200, Daniel Lezcano wrote:
>> Initially the thermal framework had a very simple notification
>> mechanism to send generic netlink messages to the userspace.
>>
>> The notification function was never called from anywhere and the
>> corresponding dead code was removed. It was probably a first attempt
>> to introduce the netlink notification.
>>
>> At LPC2018, the presentation "Linux thermal: User kernel interface",
>> proposed to create the notifications to the userspace via a kfifo.
>>
>> The advantage of the kfifo is the performance. It is usually used
>> from
>> a 1:1 communication channel where a driver captures data and sends it
>> as fast as possible to a userspace process.
>>
>> The drawback is that only one process uses the notification channel
>> exclusively, thus no other process is allowed to use the channel to
>> get temperature or notifications.
>>
>> This patch defines a generic netlink API to discover the current
>> thermal setup and adds event notifications as well as temperature
>> sampling. As any genetlink protocol, it can evolve and the versioning
>> allows to keep the backward compatibility.
>>
>> In order to prevent the user from getting flooded with data on a
>> single channel, there are two multicast channels, one for the
>> temperature sampling when the thermal zone is updated and another one
>> for the events, so the user can get the events only without the
>> thermal zone temperature sampling.
>>
>> Also, a list of commands to discover the thermal setup is added and
>> can be extended when needed.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

[ ... ]

>> +static int thermal_genl_event_cdev_update(struct param *p)
>> +{
>> +	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_ID,
>> +			p->cdev_id) ||
>> +	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_CUR_STATE,
>> +			p->cdev_state) ||
>> +	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_MAX_STATE,
>> +			p->cdev_max_state))
>> +		return -EMSGSIZE;
>> +
>> +	return 0;
>> +}
> 
>> +int thermal_notify_cdev_update(int cdev_id, int cdev_state)
>>> +{
>>> +	struct param p = { .cdev_id = cdev_id, .cdev_state = cdev_state
>>> };
>>
> 
> .cdev_max_state is not set here.
> I think we need to add a second parameter for cdev_max_state when
> invoking thermal_nofify_cdev_update().

Ah, right. I forgot to add the parameter, thanks for pointing this out.

  -- Daniel

[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
