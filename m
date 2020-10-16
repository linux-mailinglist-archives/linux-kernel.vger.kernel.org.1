Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF77290CC1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 22:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395342AbgJPUbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 16:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391218AbgJPUbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 16:31:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C91DC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 13:31:33 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j7so343531wrt.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 13:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1/2DVyuLmVjG5utJc1170VeVzEsF5Yt1L3A443X8J0g=;
        b=o8KIgZCXKOMGGQSD+fc3xEyhQf7IZTFsaBqFfb6Qf8N+Z3Wkyiw5Dbgu4mGTDuNQjt
         DRSnghWylfoP0I5ZClwQnXgqFNKogK2mFZuByr/M5CbkXuGvNe7GgAcxfROoGto21IDF
         ialnFWgiAA/PIbegfiFqwsTa+w2ij6rgRZmJ1XWTf12Mnc2sbIbbTqh7gotBhLnhoD+2
         VPMoDaXYtr9QUmiPZs/EzzuRz0+onW5Ga5kzizeDAHd00EH0UswQMZBApoDnM9x/5bTU
         UupR+0ZFYE6CfCAGL5YBghdjfXk01LCiFrNBnvht6dOSJB+zuc7nfJbcMNexVklqZD7g
         +JMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1/2DVyuLmVjG5utJc1170VeVzEsF5Yt1L3A443X8J0g=;
        b=G6zkVU+Wq1W5Y9+2WSq5T+oo6qOeTlY5QBVn2EMa2BjE4uF8TK3l9rLj4ch6rSVY6d
         WnqRFpEJYaNQGNngs9PakpWCtZfcay1W/476zWT+VV92fpYTa5EC4Suebfi7jImDlDb/
         ULxYsRua/MzO+J3uylRYC0WRpKF0y+/0LbCaPfXrT7fWNiaI/XKwHyHuzmKO1DOHqpdt
         TUS7TWzI6MX8N7qrxml7Qngp9GeGA2usfPZZmn133XFGdai7tnII0VTPX0OSp3w8F4t4
         sPG+cW8mAzJcqVbXYl2T/7HMrowxtwRlWCjOaUvsr9DO3Xwfbn0bWixE2MVYpQ9GZoQn
         qTSA==
X-Gm-Message-State: AOAM531HO7JXFPlsiGGELU71yIiJU87fOBA9NR+/RjSx61Lp/Z/8K8O7
        oSWkP38FBL6/jz2ejxPGC1fazA==
X-Google-Smtp-Source: ABdhPJxZPXqkkGeQ3NnluGfMQsIwuWy2LtxIZzKdhUjHxBSP7b25GGXi3Tq9B6UxaQC4PdvhgersJA==
X-Received: by 2002:adf:cd82:: with SMTP id q2mr6351812wrj.118.1602880289463;
        Fri, 16 Oct 2020 13:31:29 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c9d8:1700:5168:39b? ([2a01:e34:ed2f:f020:c9d8:1700:5168:39b])
        by smtp.googlemail.com with ESMTPSA id f14sm5064340wrt.53.2020.10.16.13.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 13:31:28 -0700 (PDT)
Subject: Re: [PATCH 1/5] cpuidle: Remove pointless stub
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lina Iyer <ilina@codeaurora.org>
References: <20201015144431.9979-1-daniel.lezcano@linaro.org>
 <CAJZ5v0gPYXhqP4CF+ep3tE7ov5zza0FW9_9cuDsiqznUX8CTCQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8fef63ad-a081-e543-0c18-3797f3aaf1be@linaro.org>
Date:   Fri, 16 Oct 2020 22:31:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gPYXhqP4CF+ep3tE7ov5zza0FW9_9cuDsiqznUX8CTCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

On 16/10/2020 17:24, Rafael J. Wysocki wrote:
> On Thu, Oct 15, 2020 at 4:44 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> The cpuidle.h header is declaring functions with an empty stub when
>> cpuidle is not enabled. However these functions are only called from
>> the governors which depends on cpuidle. In other words, when the
>> function is called it is when cpuidle is enabled, there is no
>> situation when it is called with cpuidle disabled.
>>
>> Remove the pointless stub.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

> Applied (this patch alone) as 5.10-rc material with some minor edits
> in the changelog, thanks!

Does it mean you disagree the other patches? Or are you waiting for more
comments?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
