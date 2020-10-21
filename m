Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EBE2946AC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 04:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411323AbgJUCt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 22:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411316AbgJUCt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 22:49:26 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7C2C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 19:49:25 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id v200so1029105qka.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 19:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jPDwSgLYvQCo/mG9InkCNxNQ0QGNMzzuKpyCjbVUMes=;
        b=r6fW1DVNYB8qqsQ8Q4CdElTaydx0rngT2GoaULeddh00abGzniECWUirF64S+NSj8O
         2Xtpl1gyMMyIH7yPl1CthDj88CCORLsLDQDZRddwU7uFhNgiBsIZ0hQ8qyp9igYJvAGj
         sXTMkLIDh6X5X3n5gHh1FqYKVrgRsDNsmygU9awY1Qk0C3xM/CMDE87xcaiXkhoCBhTw
         RGWeEZe8E+ScCZ/1BrS3KBqgTHWoVg21g94rqrA4ZTq9ZxLlwQjRDc9oHyz4zbs5qGXh
         /hZzZHVxBEKf6LwYO3DYDY35alsLOo63Ioz2lDDjI/qPOMzGwBd1Ix81MhubSiPGqx3U
         14Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jPDwSgLYvQCo/mG9InkCNxNQ0QGNMzzuKpyCjbVUMes=;
        b=gEH8JDNDQDLuEARmK+4LUKQ6U3bYcIvQzyPfTTVKDhPTtZUJiNzo6B8x/6mTGDahHQ
         Od3T3DrCcZU7dQF7I5BtG5oDFlTkluh1haXvnKRNMCPuA4ijnSPd1HvVFwwtU0U6dMUP
         B/T91ZtVG4CNxP4DIjgAJ89cCESemvHKEoOrtqq3hSlvV30/S2yL1wvHyGLxbbHWqF0p
         djiBOOhYya2AVaGqbiIvjtZaVUa8vK8ayOisxWrdY/EuKXspabo0gLMmwInrhGbDlLhZ
         jWppPWVLY7cPodmyQi8k4eaFzyQaMBdgWTUBrV1bUSL9ucUoAQGs/a/EAx43f2FT109w
         fy9Q==
X-Gm-Message-State: AOAM532XvhgA27gnskCdhdKG2ULo6Z1apxlkl+KVB/NxXduam//DeO2h
        wBphw8aMiaa8ckhKPHEroG4Nnw==
X-Google-Smtp-Source: ABdhPJwXXc2rVhCdAquB08vs9g2den0EbIzwEowgIegC2Lu7uqjztOb0FByPJpQCNJ5wBmXRZ7Jx3w==
X-Received: by 2002:a05:620a:14a9:: with SMTP id x9mr1269165qkj.47.1603248564583;
        Tue, 20 Oct 2020 19:49:24 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id e188sm571784qkf.128.2020.10.20.19.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 19:49:23 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH 10/11] [DEBUG] firmware: arm_scmi: add custom_dummy SCMI
 devname
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20201014150545.44807-1-cristian.marussi@arm.com>
 <20201014150545.44807-11-cristian.marussi@arm.com>
Message-ID: <c0a300b7-7589-bfb1-6731-f07fdd7391fd@linaro.org>
Date:   Tue, 20 Oct 2020 22:49:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014150545.44807-11-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/20 11:05 AM, Cristian Marussi wrote:
> Add custom_dummy SCMI devname.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>   drivers/firmware/arm_scmi/driver.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 55df134c2338..5c39a738866a 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -993,6 +993,7 @@ static struct scmi_prot_devnames devnames[] = {
>   	{ SCMI_PROTOCOL_CLOCK,  { "clocks" },},
>   	{ SCMI_PROTOCOL_SENSOR, { "hwmon" },},
>   	{ SCMI_PROTOCOL_RESET,  { "reset" },},
> +	{ SCMI_PROTOCOL_CUSTOM_DUMMY,  { "custom_dummy" },},

Hi Cristian,

Thanks for the sample dummy custom protocol and driver!
The problem with adding scmi devname into the array is that every time a 
custom vendor protocol is added, the array has to be extended. Instead 
since the scmi spec supports the range 0x80-0xff for custom protocols, 
why not check for that range in scmi_create_protocol_devices and go 
ahead with registering the creating the protocol device via 
scmi_create_protocol_device?


>   };
>   
>   static inline void
> 

-- 
Warm Regards
Thara
