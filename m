Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9755428131A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 14:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387787AbgJBMsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 08:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgJBMsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 08:48:10 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AABC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 05:48:10 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id d20so1138129qka.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qqs8ifS6kGN7LaOJsBRoUbMeD52hvAgPJsDQbcB16Ww=;
        b=teN6lt9dYbTfeK4iHJe5EwHYYiMp8qbujal8f2CalekS8vb2pw+hAbarMaC3Dyy9/g
         ZfIA6rxZ9+yK1ffdf1KM9aXD59XN5OfD6qRSiLddDtflDi4Ns2xS4ysacecYmjOd7o/Y
         yxEz9yyXAVHbarO0UEK5GcYkbh6LYgtCsMFINrC1goIVzmQcfcXJ0TdsTCOQ04mn42DW
         /AlRtZTPtEqGBYUA1DQfKR//S00/OvShWyJNcVZIzaLAcz9/Wc+28PbrogAtHRSlGAAI
         sQsJAebzVERb8ad8PnaY3cuZPZc9FzzPw7D1bDFLlaueXV9yx3ZzezN5CqLgQgId8xb4
         aB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qqs8ifS6kGN7LaOJsBRoUbMeD52hvAgPJsDQbcB16Ww=;
        b=n6WzT97SEJ9MW41Aeh1xiY7/5dGcc1paRRUyFjAaC4qNqbev/GoRPiN6YWywWCADQy
         Wq4/SSXRba5VHthUo+AvtYq7XcY7HV+MGFeM/j56kq0ee7PZ2iuQnKbzNATf+L9tzzsE
         E6IVPIY8XgRwHN2aAnD0PHTqA5sCpIsMEm4GTbC2GXbujcqn1RavvWoqOBWK7LL3MEv5
         VH4DmRSwiQ3hYQR/ny8CQQxWxmjRAWWMDXNe7Dlm/x+laMQSkRFmtK2kk3XcLfvsK3ED
         mWYiL6GZOW8KC6wBvrvAVGtOL3bakmfOhRAh6TumD1hScAhgfVQ7KKGfLlseLbjSSQ9P
         6SSg==
X-Gm-Message-State: AOAM5332Svi437Scea++MEX8WUVQNNuY6PXhllLTxp3e63wNl+xZqQBr
        VuJn9O5YECMIxpc9GdId80goNGgWqsI+Nzt6
X-Google-Smtp-Source: ABdhPJyQ2dJDmsq+UUaIzuzIq5vMU2J1btgFAxj6GOPoha5mgRKT6bHemLD/hK/dXSldsS3NSojT2A==
X-Received: by 2002:a05:620a:13f9:: with SMTP id h25mr1764964qkl.283.1601642888962;
        Fri, 02 Oct 2020 05:48:08 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id j25sm921577qtr.83.2020.10.02.05.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 05:48:08 -0700 (PDT)
Subject: Re: [PATCH 2/3] drm/msm: add DRM_MSM_GEM_SYNC_CACHE for non-coherent
 cache maintenance
To:     Christoph Hellwig <hch@infradead.org>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201001002709.21361-1-jonathan@marek.ca>
 <20201001002709.21361-3-jonathan@marek.ca>
 <20201002075321.GA7547@infradead.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <b22fb797-67b0-a912-1d23-2b47c9a9e674@marek.ca>
Date:   Fri, 2 Oct 2020 08:46:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201002075321.GA7547@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/20 3:53 AM, Christoph Hellwig wrote:
>> @@ -8,6 +8,7 @@
>>   #include <linux/shmem_fs.h>
>>   #include <linux/dma-buf.h>
>>   #include <linux/pfn_t.h>
>> +#include <linux/dma-noncoherent.h>
> 
> NAK, dma-noncoherent.h is not for driver use.  And will in fact go
> away in 5.10.
> 

Not actually used, so can be removed.

>>   
>>   #include <drm/drm_prime.h>
>>   
>> @@ -808,6 +809,20 @@ int msm_gem_cpu_fini(struct drm_gem_object *obj)
>>   	return 0;
>>   }
>>   
>> +void msm_gem_sync_cache(struct drm_gem_object *obj, uint32_t flags,
>> +		size_t range_start, size_t range_end)
>> +{
>> +	struct msm_gem_object *msm_obj = to_msm_bo(obj);
>> +
>> +	/* TODO: sync only the required range, and don't invalidate on clean */
>> +
>> +	if (flags & MSM_GEM_SYNC_CACHE_CLEAN)
>> +		sync_for_device(msm_obj);
>> +
>> +	if (flags & MSM_GEM_SYNC_CACHE_INVALIDATE)
>> +		sync_for_cpu(msm_obj);
> 
> And make to these ones as well.  They are complete abuses of the DMA
> API, and while we had to live with that for now to not cause regressions
> they absoutely must not be exposed in a userspace ABI like this.
> 

How do you propose that cached non-coherent memory be implemented? It is 
a useful feature for userspace.

