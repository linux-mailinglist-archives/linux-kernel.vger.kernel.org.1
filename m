Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233302837EA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgJEOhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgJEOhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:37:19 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB022C0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 07:37:18 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id b13so6061786qvl.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 07:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TRhkx8XpeN9CeF5cEhP4BTdxGRsLqYAybwrIXicVRyw=;
        b=g4uOyk1vF6JnppHf+cmhEsdrx/imAVEV3qm6M88McCLKeyXHxx7dQLX3Qa6+f4K0My
         aNEEKPeIc0OYkbFMLrhdHU7EAKGtr+5V3rWOURrXeVuY+9kAXkLzGYs+gyoANk/B3q7J
         n2kpYVlQhvO+pwrtf723Te8oQxFZ5DAnXQD6maNxH0U0UbJC6mcC/1qsGeKTiTcOam4e
         bgAigiy9gaLlOwc+8Br425/P/36ybGf7RRSXWxtMxRDCPHe7ISXPsahuQ07wFC86fonE
         xRlhrFth4f+7+M04giaY74oUiXtfsI7Rlv0Byxnee/7HN5UvEO6V9AxChGotTH1S55ga
         3iIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TRhkx8XpeN9CeF5cEhP4BTdxGRsLqYAybwrIXicVRyw=;
        b=UWFHmXyQ5MoK/C81LauBUmL8C1XLjdYirXlvi143SITbyhZG4zibHnNWa67tWXW1Qs
         MJU7T50QwbKMLVsH8flS3iyWTaE1/nMx+kL0F/yRhmppw9agO8mStoP6gK4vw0mJ4ZWg
         t4B5d02eUujJKMOxSbFtz9b44eVmCRX/fHNdkC//XIQ6EU0Mn7sCEs62jhzIod4qbvXr
         IanPrjUZYjN8qMUriB8mzOCgF/pzDvYqDpZciH3bGBQDNFLWnoOcV0ka/ZMyWV1Dgbfs
         tgX+FU+8i5kBWP+XkidFqUnjwiDl9AEaknyF5e1IKxU1OFdEvBhCZcbulOGgu35YQQDi
         P3Xg==
X-Gm-Message-State: AOAM533/hShvspShZ8vg6dolmFjWaKfxjnII1Yg5WqcaIQh0psGlSNCi
        EqUjtuNq2DsKgipt9JJCKG5S5McPkKszi8Xm
X-Google-Smtp-Source: ABdhPJyi+49wGLIUxrKIgGYZ337lCqeB0hW5hNuy6GwMzFj2CNJLAt9QKQKSeB3gCNxr0ID1rt688A==
X-Received: by 2002:a0c:e788:: with SMTP id x8mr14075471qvn.27.1601908637734;
        Mon, 05 Oct 2020 07:37:17 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id g7sm435832qtc.19.2020.10.05.07.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 07:37:16 -0700 (PDT)
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
 <b22fb797-67b0-a912-1d23-2b47c9a9e674@marek.ca>
 <20201005082914.GA31702@infradead.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <3e0b91be-e4a4-4ea5-7d58-6e71b8d51932@marek.ca>
Date:   Mon, 5 Oct 2020 10:35:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201005082914.GA31702@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/20 4:29 AM, Christoph Hellwig wrote:
> On Fri, Oct 02, 2020 at 08:46:35AM -0400, Jonathan Marek wrote:
>>>> +void msm_gem_sync_cache(struct drm_gem_object *obj, uint32_t flags,
>>>> +		size_t range_start, size_t range_end)
>>>> +{
>>>> +	struct msm_gem_object *msm_obj = to_msm_bo(obj);
>>>> +
>>>> +	/* TODO: sync only the required range, and don't invalidate on clean */
>>>> +
>>>> +	if (flags & MSM_GEM_SYNC_CACHE_CLEAN)
>>>> +		sync_for_device(msm_obj);
>>>> +
>>>> +	if (flags & MSM_GEM_SYNC_CACHE_INVALIDATE)
>>>> +		sync_for_cpu(msm_obj);
>>>
>>> And make to these ones as well.  They are complete abuses of the DMA
>>> API, and while we had to live with that for now to not cause regressions
>>> they absoutely must not be exposed in a userspace ABI like this.
>>>
>>
>> How do you propose that cached non-coherent memory be implemented? It is a
>> useful feature for userspace.
> 
> If the driver is using the DMA API you need to use dma_alloc_noncoherent
> and friends as of 5.10 (see the iommu list for the discussion).
> 
> If you use the raw IOMMU API (which I think the msm drm driver does) you
> need to work with the maintainers to implement a cache synchronization
> API that is not tied to the DMA API.
> 

The cache synchronization doesn't have anything to do with IOMMU (for 
example: cache synchronization would be useful in cases where drm/msm 
doesn't use IOMMU).

What is needed is to call arch_sync_dma_for_{cpu,device} (which is what 
I went with initially, but then decided to re-use drm/msm's 
sync_for_{cpu,device}). But you are also saying those functions aren't 
for driver use, and I doubt IOMMU maintainers will want to add wrappers 
for these functions just to satisfy this "not for driver use" requirement.
