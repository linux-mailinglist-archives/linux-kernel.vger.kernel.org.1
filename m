Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10DF276CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgIXJHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbgIXJHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:07:20 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE32C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:07:20 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t10so2971019wrv.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zn6SqP5HFCDpNYzm0IzfGeO48fXw90jCb6iZXuZJb5U=;
        b=KLg+E4WLUy6IQm4x3CZxIItr2ek6E2WpMO6hUM2s7uz9l0eZ4cFkb5Mp+u/01y7Uum
         8gJ6VNabyKLSB58bI6IKG4xlPIn/BRFZaQbKp/I6vjp5TL4d4Qxw8axfXFDGpgK05jxh
         7vQTj4mAvsEsXqUDNNTmW09CNEDYzgkwPSWlkwpzC10o3FRH3kzvGg9oc2czlRDKwMH5
         lJaiR9WxucZckoT8cljOtGijLv8UjC5YJrV/Bm8ljXVjW7htVmpSoe+Mnz5bA49bxmmX
         xwQ2yjLPwI7Qm/veblo9cDjNyeU8DhwlT1Y8hZZokJpKz9Rf5okgGqnuQYkQWlGXjwcn
         u0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zn6SqP5HFCDpNYzm0IzfGeO48fXw90jCb6iZXuZJb5U=;
        b=d1gT0QrmsDAhbRgo4rYkfM+tpaHJCzMwyI4IItHR3IV3Y0Ol3RMhw3snyL7LZPzdcS
         q48sV0tkmgKoqGOW2jjsxdecVLj5GdKAneIfftpiOMpCAhhS+KRSUlWE5SMcOySFk/7F
         yuj/9+MlvDu+4RDwW6Sd+AV6xJ3PUvx3aQIlHAZqg/fpEYnFZZ2MHSeKWnMp7Ph7IHzh
         ZqL0kV+zi2isUaeBWfLGRICMh5AXj1m/vEIctsNXC1vPmw6bgP6jI06Ykb8kqF2Cdb9O
         cq5b5g9acWkwZhkRJvDXOvsyVDWplu9Jh728JGGgDmGkjrosetjM+fkvFMkMudZawmSD
         +QGg==
X-Gm-Message-State: AOAM533uAazIQcNwG4Pnu3POcJPrOkhRKdZ4xdb3s2jbylk1Wqo8QN2d
        Tq1Wm6JpjuTRDJZoMRqEYNTcARRl32QYSw==
X-Google-Smtp-Source: ABdhPJxqu8Qp5RmkIS9W1eYyz/qSgyY8NazLe4kA2EbVtPY054hQyb+gMhlEzBdNZz1acDgjmqa2cg==
X-Received: by 2002:adf:dcc7:: with SMTP id x7mr4017552wrm.203.1600938438658;
        Thu, 24 Sep 2020 02:07:18 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:11e1:db8b:493b:54f4? ([2a01:e34:ed2f:f020:11e1:db8b:493b:54f4])
        by smtp.googlemail.com with ESMTPSA id 70sm2846920wmb.41.2020.09.24.02.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 02:07:18 -0700 (PDT)
Subject: Re: [GIT PULL] timer drivers fixes for v5.9-rc4
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Tony Lindgren <tony@atomide.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
References: <921c157b-7f18-52bb-2d94-513f33cf9f41@linaro.org>
 <2a20bb9f-13ee-784f-a717-baf2e466a5b1@linaro.org>
Message-ID: <0bd3aaa2-9979-b4d1-5e36-f9f24590abb1@linaro.org>
Date:   Thu, 24 Sep 2020 11:07:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2a20bb9f-13ee-784f-a717-baf2e466a5b1@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

except I'm missing something, it seems like this PR is not in the
tip/timers/urgent

  -- Daniel


On 15/09/2020 10:01, Daniel Lezcano wrote:
> 
> Gentle reminder, thanks
> 
>   -- Daniel
> 
> On 04/09/2020 12:52, Daniel Lezcano wrote:
>>
>> Hi Thomas,
>>
>> The following changes since commit b0294f30256bb6023b2044fd607855123863d98f:
>>
>>   time: Delete repeated words in comments (2020-08-10 22:14:07 +0200)
>>
>> are available in the Git repository at:
>>
>>   https://git.linaro.org/people/daniel.lezcano/linux.git
>> tags/timers-v5.9-rc4
>>
>> for you to fetch changes up to bc6717d55d07110d8f3c6d31ec2af50c11b07091:
>>
>>   clocksource/drivers/timer-gx6605s: Fixup counter reload (2020-08-24
>> 13:01:39 +0200)
>>
>> ----------------------------------------------------------------
>> - Fix wrong signed return value when checking of_iomap in the probe
>>   function for the h8300 timer (Tianjia Zhang)
>>
>> - Fix reset sequence when setting up the timer on the dm_timer (Tony
>>   Lindgren)
>>
>> - Fix counter reload when the interrupt fires on gx6605s (Guo Ren)
>>
>> ----------------------------------------------------------------
>> Guo Ren (1):
>>       clocksource/drivers/timer-gx6605s: Fixup counter reload
>>
>> Tianjia Zhang (1):
>>       clocksource/drivers/h8300_timer8: Fix wrong return value in
>> h8300_8timer_init()
>>
>> Tony Lindgren (1):
>>       clocksource/drivers/timer-ti-dm: Do reset before enable
>>
>>  drivers/clocksource/h8300_timer8.c         |  2 +-
>>  drivers/clocksource/timer-gx6605s.c        |  1 +
>>  drivers/clocksource/timer-ti-dm-systimer.c | 44
>> +++++++++++++++++++++++---------------------
>>  3 files changed, 25 insertions(+), 22 deletions(-)
>>
>>
> 
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
