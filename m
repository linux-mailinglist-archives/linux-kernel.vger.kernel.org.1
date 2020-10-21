Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC6D2946AA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 04:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411311AbgJUCrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 22:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411301AbgJUCrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 22:47:31 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD68C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 19:47:30 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id t6so369821qvz.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 19:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v3ZIEdHQfLLzm/P+Ct5cHY1Me2E++bPihPMu41U8QkQ=;
        b=lVG67OeM3b+nj7K6KFzb0Xrbv8PbURCAuhsrtKalBDGFc9UTug3iBPbA3MgE685Hvt
         uUujA0knDqIl+3Q6yb+JkvpWVyVdtxfygSdcdHzhFkUO5ipUGda/rYm6Ly7COWFyGGs2
         vjopCoh8vla81UsSbQKBvgEsG/KZNFWTl/JMlY5qYW2JSMFrdi5HvjtZlyLjPYyhzeBf
         SN/uJse5OxB+7HwuDo1R2IlY5wFTHSxQX79lXOU4UF/PQIZcN8mKVX5uWcflhq5vj72N
         5rXk4l0GL6nHlOY5oN9Tu4ZgEUnhlm+k2b5kRnZuA2VXSmrJQkVAkaUTymVX1RjYV/t/
         Z1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v3ZIEdHQfLLzm/P+Ct5cHY1Me2E++bPihPMu41U8QkQ=;
        b=UF6hUUlMnLPcaYiQyPlwuDCA+Fmd0L6hj72oDt9+XxEf6Z5IxZN6jnfvj8StAr6b9f
         VNhHGO3dFussJFYnhxUeYCNaaxrpMujgd7WyhmT3v19ClumSAyNG9ZKX6zPY/XxlE3w3
         4G1nPrt39FH1LCm4WWu5WEVykRGgRVMUXdeAKyk6kMW7uXEh1s/W0WKkr3sU3NYUReBD
         JpCd+scw14Rv1Hl8niD+5FLsY0pfzg+SwTkmNVSVeQGobbsKE3qswkB3lOYtR0k30dLf
         JwBqhyUZA9TyjwvWARtmGZGKLdGcx0Z4PHyGqvd6ZagpF6wCXnwSn3VLRFlfdu2to0zf
         5gCg==
X-Gm-Message-State: AOAM530qtuIslMi/KZoOLDdkvjiZDw8zy3+4i3ipM28ybxzqEMDB/X4P
        Sz16msDpjynwRXVJg1rK3jRUlA==
X-Google-Smtp-Source: ABdhPJzNK7DzVtnNIc41sKBtvkoG8AgJ09aUkLnLngPzRVYf1huGu8anNgPJNWPswnYUsy5tcIex8w==
X-Received: by 2002:a0c:b741:: with SMTP id q1mr929362qve.37.1603248449608;
        Tue, 20 Oct 2020 19:47:29 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id h4sm424193qtq.41.2020.10.20.19.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 19:47:29 -0700 (PDT)
Subject: Re: [PATCH 06/11] firmware: arm_scmi: add support for protocol
 modularization
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20201014150545.44807-1-cristian.marussi@arm.com>
 <20201014150545.44807-7-cristian.marussi@arm.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <c52f9598-eb33-767c-8181-6e839c884313@linaro.org>
Date:   Tue, 20 Oct 2020 22:47:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014150545.44807-7-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/20 11:05 AM, Cristian Marussi wrote:
> Modify protocol initialization callback adding a new parameter representing
> a reference to the available xfer core operations and introduce a macro to
> simply register with the core new protocols as loadable drivers.
> Keep standard protocols as builtin.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>   drivers/firmware/arm_scmi/base.c    | 56 ++++++++++--------
>   drivers/firmware/arm_scmi/bus.c     | 14 ++++-
>   drivers/firmware/arm_scmi/clock.c   | 56 +++++++++---------
>   drivers/firmware/arm_scmi/common.h  | 42 +++++++++-----
>   drivers/firmware/arm_scmi/driver.c  | 50 ++++++++++------
>   drivers/firmware/arm_scmi/perf.c    | 88 +++++++++++++++--------------
>   drivers/firmware/arm_scmi/power.c   | 46 ++++++++-------
>   drivers/firmware/arm_scmi/reset.c   | 46 ++++++++-------
>   drivers/firmware/arm_scmi/sensors.c | 52 +++++++++--------
>   drivers/firmware/arm_scmi/system.c  | 16 ++++--
>   include/linux/scmi_protocol.h       | 18 +++++-
>   11 files changed, 288 insertions(+), 196 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
> index f40821eeb103..8d7214fd2187 100644
> --- a/drivers/firmware/arm_scmi/base.c
> +++ b/drivers/firmware/arm_scmi/base.c
> @@ -15,6 +15,8 @@
>   #define SCMI_BASE_NUM_SOURCES		1
>   #define SCMI_BASE_MAX_CMD_ERR_COUNT	1024
>   
> +static const struct scmi_xfer_ops *ops;

Minor nit. I would consider renaming ops to something more
meaningful like xfer_ops (or anything that makes sense). ops by
itself leads to confusion with ops in scmo_protocol and  in 
scmi_protocol_events.

Same suggestion for all other declarations of ops in this patch.

-- 
Warm Regards
Thara
