Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E9A2F24A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404810AbhALAZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404021AbhAKXTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:19:38 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEBCC061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 15:18:58 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id q5so1018615ilc.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 15:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DzM+l+OrORvWleo/gSP2T8zlV12gITtUclo5BsatvVk=;
        b=DF/Xx8LaQ4UemEllrG1BNDUDXHS5E/kqcfqqvnCnUKMOPYX742aPvcegZ3ciVt/5a3
         dfCyWBvA0S1HTg4faZaqpGykLBtHBXb7sWfVKziAkARrcSjSnXrVSa+QMuK7KWYV0lgO
         nH3JVa4Sk8Srv4BHVui1lKVdsVmmiyaH18CU22DoLXXmsDmQv1d8g04tYO5tB7sPU7h1
         IOTT6nWyHVXcstbMT7gAOCaR/jkXbfL4mG3KwVhvUS3K3n9SGfRzR4xU6uwK6+P4vera
         9eT90W0vhYEZ/J6LqkS5pg0m1N8oz1wjCj/4PZNxvJTh9Zf7wzMtBx23XvDfVyUeMIm9
         dsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DzM+l+OrORvWleo/gSP2T8zlV12gITtUclo5BsatvVk=;
        b=aOmN/LKeEBFboaStZwz5/Kby2uo4T05bX+0oBDVwZOZzNMGK/oW+T95yf7s1ndHniw
         Jbaj9oAqCLzUEaSp5kJqx2KTf/u8CyJH9dsLyhvyVC86zbmnlKADiIVgyo178OeMiMfQ
         zBy8gxFk8L7Esz5u6zk397k6Ct4BtrqJKSIxZxsp4Ol474M0OkqLtfCULMeT00iEo9W5
         QoJyX89aOp7M282YS3cU/C/PL7Gj5S+LXQx3vUw4GKSbTTz68nF17FaEznHHolehIkwT
         iV0T3ZkMNVJ6NjSw0pwB9kVY0ggLSRSCIuA55S9EE58mCkT8MBKVQ8W1xbIDYETJ0sHd
         cknA==
X-Gm-Message-State: AOAM532DIXQSu11MQ2xmB2g/25FX1fcpF4KKvkwAu9YiA73PnchALMmi
        3/E73wSy5iJ4HaRrYztTgOOhwpu21wSwxg==
X-Google-Smtp-Source: ABdhPJzZqdOXJaohzzZtDz50ASTwrjoZKe7xMde8PAXwlMCjmyvILxigfyXlLK3pJV2BdP8D9/wuzA==
X-Received: by 2002:a05:6e02:1c8d:: with SMTP id w13mr1285591ill.301.1610407137843;
        Mon, 11 Jan 2021 15:18:57 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id h1sm821992ilj.8.2021.01.11.15.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 15:18:57 -0800 (PST)
Subject: Re: [PATCH 6/6] thermal/core: Remove unused macro THERMAL_TRIPS_NONE
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     mjg59@codon.org.uk, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amitk@kernel.org
References: <20201214233811.485669-1-daniel.lezcano@linaro.org>
 <20201214233811.485669-6-daniel.lezcano@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <50f6df7f-2ac7-4fa5-c605-4dd476c7ffbc@linaro.org>
Date:   Mon, 11 Jan 2021 18:18:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201214233811.485669-6-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/20 6:38 PM, Daniel Lezcano wrote:
> The macro THERMAL_TRIPS_NONE is no longer used, remove it.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>

>   include/linux/thermal.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index a57232a9a6f9..060a2160add4 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -17,7 +17,6 @@
>   #include <linux/workqueue.h>
>   #include <uapi/linux/thermal.h>
>   
> -#define THERMAL_TRIPS_NONE	-1
>   #define THERMAL_MAX_TRIPS	12
>   
>   /* invalid cooling state */
> 

-- 
Warm Regards
Thara
