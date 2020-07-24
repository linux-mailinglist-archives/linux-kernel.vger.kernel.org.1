Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4C122CBB7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 19:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgGXRMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 13:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgGXRMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:12:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60775C0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:12:52 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so8955634wrp.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CsY5cW3WXMhmwG38rsvRK1D4/ep9vkdqpuLxDaLO6ZY=;
        b=ENdczydUnM51Zqjz14BXRYs6Wtcq/VXoyg3aRYeJpRN1RHpf9Te7iKx/YVTZy5GT3w
         pMXGEwSqIUIrd3mwKhe62m6VFho5gRHpebxLJ07i0PUmRrTJdf0ezbu1OPTG/1MqiGPG
         xWikmoKFoqrAWupOrwmn+pETjBpk0avnFrAccqUsQ8xKwL3ESFvFS59PM/RqlP+16ZYs
         G76I38eJtIh7aIoEHs0C3B8gCt1dcGxQJobELShQMV8NlwU9aqsSoqGh1lG+e0Zz1BbK
         lf/w2q5W8I+Boy100Pim4QGUUg/OdTl9XyMXvw89WaQbtEertFk6TUSxutBQoiEgbsQ5
         0kYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CsY5cW3WXMhmwG38rsvRK1D4/ep9vkdqpuLxDaLO6ZY=;
        b=HhP2eL3yF/MdsnADaHkS96qgXykGIoAPKJlsj9KFwkT67/Ea2YEv/AKB9U/LXbhD/H
         u7mNlN9NTmF3SL/Poaemw/AjO5VBvY1zI7SsUacgkRmiZSlc+yyIOafjvxIWNZEHJSo8
         KjyPredaM97hDJkMJCGuMBub5EXFoKNp8zWcetffS7i1ryRwa111surueeixrhSuH4Ys
         KgeyvHEITgO/3UiyUu7o4jFoFDPeVzMI9jL3Vq5q3juH+QBGl5ZRrTrCaNLm/JbTgtzG
         cgzb+gcYIxbEHNgcpKpUJYu3hKthDZLN359IOXFoXYDA/YdKdYfFtvdiE7KLesLijhaG
         zXyw==
X-Gm-Message-State: AOAM530MoxEU/I06HHWAz54vOGbSszUggtGlQ8ZEkEGfWme2qvIFPl7U
        rw+bprgQgJvE0j59tx7sGj6PbwIfclmIag==
X-Google-Smtp-Source: ABdhPJzVyryFXYR9Gku2wPrJ/1NZPZOtbGI57W/l86IomYGROONvKgaAAlrND+wJ9s9fVjvYDq3ZvA==
X-Received: by 2002:adf:f847:: with SMTP id d7mr9052643wrq.328.1595610770634;
        Fri, 24 Jul 2020 10:12:50 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:819c:7aa9:1038:21b3? ([2a01:e34:ed2f:f020:819c:7aa9:1038:21b3])
        by smtp.googlemail.com with ESMTPSA id z11sm1834740wrw.93.2020.07.24.10.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 10:12:50 -0700 (PDT)
Subject: Re: [PATCH] thermal: Fix zone lookup by ID
To:     Thierry Reding <thierry.reding@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200724170105.2705467-1-thierry.reding@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <db6efeab-b2bc-bad5-9c75-89e3e306256c@linaro.org>
Date:   Fri, 24 Jul 2020 19:12:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724170105.2705467-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

Applied, thanks for the fix!


On 24/07/2020 19:01, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> When a thermal zone is looked up by an ID and no zone is found matching
> that ID, the thermal_zone_get_by_id() function will return a pointer to
> the thermal zone list head which isn't actually a valid thermal zone.
> 
> This can lead to a subsequent crash because a valid pointer is returned
> to the called, but dereferencing that pointer as struct thermal_zone is
> not safe.
> 
> Fixes: 329b064fbd13 ("thermal: core: Get thermal zone by id")
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/thermal/thermal_core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 007f9618e20a..9748fbb9a3a1 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -751,16 +751,18 @@ int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
>  
>  struct thermal_zone_device *thermal_zone_get_by_id(int id)
>  {
> -	struct thermal_zone_device *tz = NULL;
> +	struct thermal_zone_device *tz, *match = NULL;
>  
>  	mutex_lock(&thermal_list_lock);
>  	list_for_each_entry(tz, &thermal_tz_list, node) {
> -		if (tz->id == id)
> +		if (tz->id == id) {
> +			match = tz;
>  			break;
> +		}
>  	}
>  	mutex_unlock(&thermal_list_lock);
>  
> -	return tz;
> +	return match;
>  }
>  
>  void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
