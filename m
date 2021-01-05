Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E152EB1F1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbhAESFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbhAESFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:05:06 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9F8C061795
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:03:49 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id q5so491880ilc.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hqrt+PwCKLvidXgUzGrHqQMSJASmhipg5696ppeG5c0=;
        b=CtCLXyNUtmtaow1eT+GTdhyEtXfzNZL9/CU7QY/upeZhPAk5e3mkRxdM5aRt8WEV84
         +73v7eoUNrmy/Yo1f8SZ6qXMz+R7FMSXQj/tUY8Q6oqcPbSm459AF4sM+SytiopQ0o76
         u0iGfBA2u28C3ZTCJbSXQ+PntXh6NgE/q1zQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hqrt+PwCKLvidXgUzGrHqQMSJASmhipg5696ppeG5c0=;
        b=inOtv4m4eXHkVLibVHA7O9zLSNs28FxX5rxhOua8nAM08JnU7YIPtZODd1EDj9br6I
         Rj8bSBSVVrq4WSKL2jkbKrS+GKS3m2k2WoBfxG1V2nKSGU9b0AQYidDCDPo/42GvoVzB
         nklXOzqYoA3yM7mNqdHbZNTrlHl74u7U/oKJUjwA5ksERDmGVBX0O/1FMRtBj6ouOcHF
         tWV1tl30Bmd8CK2DPtF1l1p1I0Z2W9zayEj/nBXz8gkNRfJIUTICQHCJSxP+tWFu4xqa
         nfnBR8zsy5mIydEA6vxJDXiXJ4ACVHIhg4M5WXlIdI5IOpHK8ZA4tMzog9mNxuX0X208
         XbKA==
X-Gm-Message-State: AOAM533udv0Y3Cxsx55C/nVZyww2E77GrpxMZVTgXQIwympmnfPQLdt4
        aMmEBAkV7FS2IfhWG48Qcnj5vA==
X-Google-Smtp-Source: ABdhPJy6UW68+zLAd4n8vMeMjV1rLdBufYPU4lfZyLPJ7J5lwkXDbUT3YAmfgIvt27sS8hfw7AsFvw==
X-Received: by 2002:a92:c561:: with SMTP id b1mr760977ilj.65.1609869829152;
        Tue, 05 Jan 2021 10:03:49 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m8sm35946ild.18.2021.01.05.10.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 10:03:48 -0800 (PST)
Subject: Re: [PATCH] cpuidle_set accepts alpha numeric values for idle-set
 operation
To:     Brahadambal Srinivasan <latha@linux.vnet.ibm.com>,
        shuah@kernel.org, trenn@suse.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210105122452.8687-1-latha@linux.vnet.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e2234e38-e18e-e0d3-1a2a-7c8b136d8817@linuxfoundation.org>
Date:   Tue, 5 Jan 2021 11:03:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210105122452.8687-1-latha@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/21 5:24 AM, Brahadambal Srinivasan wrote:
> For both the d and e options in cpuidle_set, an atoi() conversion is
> done without checking if the input argument is all numeric. So, an
> atoi conversion is done on any character provided as input and the
> CPU idle_set operation continues with that integer value, which may
> not be what is intended or entirely correct.
> 
> A similar check is present for cpufreq-set already.
> 
> This patch adds a check to see that the idle_set value is all numeric
> before doing a string-to-int conversion.
> 
> Signed-off-by: Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
> ---
>   tools/power/cpupower/utils/cpuidle-set.c | 39 +++++++++++++++++++++---
>   1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpuidle-set.c b/tools/power/cpupower/utils/cpuidle-set.c
> index 46158928f9ad..b3dec48e7141 100644
> --- a/tools/power/cpupower/utils/cpuidle-set.c
> +++ b/tools/power/cpupower/utils/cpuidle-set.c
> @@ -21,6 +21,19 @@ static struct option info_opts[] = {
>        { },
>   };
>   
> +int is_number(char *arg)
> +{
> +	size_t len, i = 0;
> +
> +	len = strlen(arg);
> +
> +	for (i = 0; i < len; i++) {
> +		if (!isdigit(arg[i]))
> +			return 0;
> +	}
> +
> +	return 1;
> +}
>   

Any reason why you can't use isdigit()? Please see isdigit()
usages examples in other tools and cpupower itself.

thanks,
-- Shuah

thanks,
-- Shuah
