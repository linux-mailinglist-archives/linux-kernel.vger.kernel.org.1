Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818042C3F3F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgKYLlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbgKYLlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:41:39 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36042C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 03:41:32 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c198so1737502wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 03:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nVuOJb86RZnub8WbfD5mttdsK/algndOavgLCFXuCFE=;
        b=IB5nW+14riZtbKeB2ho1hmjZSLlS5UWP6ld07DKzgKjkyjiJFvMqpw/Xua9U3/i8zT
         w7Rltfm0A0JmWNWXXR0a2oxK3qsd0UhiXFQYeJaNiELo4iJvJevE0LRy2PcGqkceBuru
         OIu9gh5XsPWSKnP1bMaNU2Ky5fbqUpZTWerq3Eq80JYkfjvzUCCnI95iWh56H+EDCrkf
         QVUW7kbcdiDYoktSHWmsXWqLdd1KvZd6k5HkgPKggsVh5qojGzvomp5H6by/KOTln7N5
         bybwv7LNfYhdh75I0OSoAHezAdhNtWw1qk449I9VxHO49Wshq8/5ysew5fzKy9Cj5IAi
         iQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nVuOJb86RZnub8WbfD5mttdsK/algndOavgLCFXuCFE=;
        b=aWluXjInmr493Lb74P5vBeVexpfR6kZO2Gg3Yabb6Fx9LC2qx9f+jEX2PwCunn5OBH
         dAaGP67JU3A8y6H9YEUqftknOO33+q6I6r1JU5WmYJ081ztCNwqbJCC67aGvaVM1z55m
         sN6Ty7klqMcZx+ou1q8kVo5bvDqvS+eeZtM0tUutfiHle32YGHWog7XUHVbafQxh7uPb
         ksQSNl/mga8yWqqfIsmUwNZlO+xo5PNIaNZc8g5T3Fb089x/s9h5UDKKRa6d3wkC0tac
         IYY2rJnypf6CgnGxSnsKEM7iMqsvtfUc0OcTOKk3OfBeu7ZSjYn/MG9bf1zbtSC6B2bY
         odNQ==
X-Gm-Message-State: AOAM531uVVJFzWccEqIwHnI+wpWZOoeoDTqOnYFmNhSMgqjHuegxG8Uy
        3LNvRWGyVgYDCq8Aq5pZGXSibYdKlSFlVjvO
X-Google-Smtp-Source: ABdhPJxriUDnleNU9MZcmnzjjrOm3PoiDDlX6f3m8a9tRoYYm4aIv0fWu7awhi65a6onyI/A3229GQ==
X-Received: by 2002:a05:600c:294c:: with SMTP id n12mr3463963wmd.66.1606304490874;
        Wed, 25 Nov 2020 03:41:30 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id u7sm4357558wmb.20.2020.11.25.03.41.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Nov 2020 03:41:30 -0800 (PST)
Subject: Re: drivers/soundwire/qcom.c:767: undefined reference to
 `slimbus_bus'
To:     Vinod Koul <vkoul@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>,
        Jonathan Marek <jonathan@marek.ca>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
References: <202011030351.iq9CBMO3-lkp@intel.com>
 <e0d74391-18ae-0493-b8a1-cbeb6f00bde8@infradead.org>
 <20201125055155.GD8403@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c0d24710-b2c6-aff0-c28a-fe276dd7eb46@linaro.org>
Date:   Wed, 25 Nov 2020 11:41:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201125055155.GD8403@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/11/2020 05:51, Vinod Koul wrote:
> Hi Randy,
> 
> On 04-11-20, 19:32, Randy Dunlap wrote:
>> On 11/2/20 11:47 AM, kernel test robot wrote:
>>> All errors (new ones prefixed by >>):
>>>
>>>     or1k-linux-ld: drivers/soundwire/qcom.o: in function `qcom_swrm_probe':
>>>>> drivers/soundwire/qcom.c:767: undefined reference to `slimbus_bus'
>>>>> or1k-linux-ld: drivers/soundwire/qcom.c:771: undefined reference to `slimbus_bus'
>>>
>>> 09309093d5e8f87 Jonathan Marek       2020-09-08  770  #if IS_ENABLED(CONFIG_SLIMBUS)
>>> 02efb49aa805cee Srinivas Kandagatla  2020-01-13 @771  	if (dev->parent->bus == &slimbus_bus) {
>>> 5bd773242f75da3 Jonathan Marek       2020-09-05  772  #else
>>> 5bd773242f75da3 Jonathan Marek       2020-09-05  773  	if (false) {
>>> 5bd773242f75da3 Jonathan Marek       2020-09-05  774  #endif
>>
>> config SOUNDWIRE_QCOM
>> 	tristate "Qualcomm SoundWire Master driver"
>> 	imply SLIMBUS
>> 	depends on SND_SOC
>>
>> The kernel config that was attached has:
>> CONFIG_SOUNDWIRE_QCOM=y
>> CONFIG_SLIMBUS=m
>>
>> I expected that "imply" would make SLIMBUS=y since SOUNDWIRE_QCOM=y,
>> but I guess that's not the case. :(
>>
>> Any ideas about what to do here?
> 
> Sorry to have missed this earlier. I did some digging and found the
> Kconfig code to be correct, but not the driver code. Per the
> Documentation if we are using imply we should use IS_REACHABLE() rather
> than IS_ENABLED.
> 
> This seems to take care of build failure for me on arm64 and x64 builds.
> 
> Can you confirm with below patch:
> 
> ---><8---
> 
> From: Vinod Koul <vkoul@kernel.org>
> Date: Wed, 25 Nov 2020 11:15:22 +0530
> Subject: [PATCH] soundwire: qcom: Fix build failure when slimbus is module
> 
> Commit 5bd773242f75 ("soundwire: qcom: avoid dependency on
> CONFIG_SLIMBUS") removed hard dependency on Slimbus for qcom driver but
> it results in build failure when:
> CONFIG_SOUNDWIRE_QCOM=y
> CONFIG_SLIMBUS=m
> 
> drivers/soundwire/qcom.o: In function `qcom_swrm_probe':
> qcom.c:(.text+0xf44): undefined reference to `slimbus_bus'
> 
> Fix this by using IS_REACHABLE() in driver which is recommended to be
> sued with imply.
> 
> Fixes: 5bd773242f75 ("soundwire: qcom: avoid dependency on CONFIG_SLIMBUS")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Thanks Vinod,

Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini
>   drivers/soundwire/qcom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index fbca4ebf63e9..6d22df01f354 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -799,7 +799,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>   	data = of_device_get_match_data(dev);
>   	ctrl->rows_index = sdw_find_row_index(data->default_rows);
>   	ctrl->cols_index = sdw_find_col_index(data->default_cols);
> -#if IS_ENABLED(CONFIG_SLIMBUS)
> +#if IS_REACHABLE(CONFIG_SLIMBUS)
>   	if (dev->parent->bus == &slimbus_bus) {
>   #else
>   	if (false) {
> 
