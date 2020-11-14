Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E142B2FED
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 20:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgKNS6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 13:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbgKNS6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 13:58:18 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC1CC0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 10:58:17 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id t5so9780345qtp.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 10:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TMf2jxejJABWBtAoBfzp32PpWj6QOIcuhJX0eJtviss=;
        b=l1maGaFvkD5AOSuo4Qexi7zHiWYdaj6mZj2RJOfDhVQJdWMuucB6Hr5X1kBAyG7IXc
         b4Bk0SezvyTtO1bRuZtyjUV74IcDoI97SV3WFMTzfwQUSUOBjEZOS6Tl0cVoW3/k2zD6
         CX1HIEnu1WI98EbO5aPl2oacD3VJlkshZz9xG+OXKNfsLXkGbrD+kRemaa6hbfF0CPHa
         QMavRtqLiyqc9sBWY8Bre5p9H3ldMvinRQw5osIF0Athr1lP5EgKy/08eZt03yajtXWF
         aPwQAB1tipFG+1TtJ9KG8zyY6ZT+ho6viCkEQzkWP0pLpu6G7aTxQgr0EQTC1wR2dQin
         FX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TMf2jxejJABWBtAoBfzp32PpWj6QOIcuhJX0eJtviss=;
        b=fbJPtrApaKWFdPbextSu7yHru4T1h8yrh1a5rq16nqq6AV2tL7qQdRb73/1biMJIIR
         /oX8akgw+8LOlnFUQmQh6JbZ7jNPEAL70+bGhnU3nBDy4OnEH0mp1qVU8HHZtD8MYvIz
         d+gbX3F1OF1KoMv4/7exlEBxnRi6GE/Rv3eRGBRNZwYDEKmy2+KJyiMjqhV+vVQyfWdI
         ceBuEdgVkY+sf4FYOMYc4x2s6P1JmjEDRL+/Vh9t33I1ep6okbY1Q+lreRCBZNNxfzgJ
         Yuj7c5txOxW07VHqTZTc2+DwjfeNLjTx41GyXk2pKjZu3wb0IFlrCTjuq6+KczxMYf/l
         kUpA==
X-Gm-Message-State: AOAM532tFBpF63p9UxBf+yECuhmmKbPhFzfe4K9+asYlG1NdsQdZwG9I
        rTmr3d7YMEUwCn1bM5bcOP3IyZL26Yq72jM1ogE=
X-Google-Smtp-Source: ABdhPJxqZ5MRkhVOHMMlYoXt6FMs0Q1n0lO/hML4Gxe4LBfm06kaYgpkAO5Oe++wwspoHS1AbdrdUA==
X-Received: by 2002:ac8:7559:: with SMTP id b25mr7495604qtr.51.1605380295552;
        Sat, 14 Nov 2020 10:58:15 -0800 (PST)
Received: from [192.168.0.189] (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id z133sm4788908qka.20.2020.11.14.10.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2020 10:58:14 -0800 (PST)
Subject: Re: [RESEND PATCH v2 4/5] drm/msm: add DRM_MSM_GEM_SYNC_CACHE for
 non-coherent cache maintenance
To:     Rob Clark <robdclark@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201114151717.5369-1-jonathan@marek.ca>
 <20201114151717.5369-5-jonathan@marek.ca> <20201114162406.GC24411@lst.de>
 <CAF6AEGvujttEkFuRqtt7i+0o7-=2spKXfAvJZrj96uWAFRLYuA@mail.gmail.com>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <50ddcadb-c630-2ef6-cdc4-724d9823fba7@marek.ca>
Date:   Sat, 14 Nov 2020 13:54:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAF6AEGvujttEkFuRqtt7i+0o7-=2spKXfAvJZrj96uWAFRLYuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/20 1:46 PM, Rob Clark wrote:
> On Sat, Nov 14, 2020 at 8:24 AM Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Sat, Nov 14, 2020 at 10:17:12AM -0500, Jonathan Marek wrote:
>>> +void msm_gem_sync_cache(struct drm_gem_object *obj, uint32_t flags,
>>> +             size_t range_start, size_t range_end)
>>> +{
>>> +     struct msm_gem_object *msm_obj = to_msm_bo(obj);
>>> +     struct device *dev = msm_obj->base.dev->dev;
>>> +
>>> +     /* exit early if get_pages() hasn't been called yet */
>>> +     if (!msm_obj->pages)
>>> +             return;
>>> +
>>> +     /* TODO: sync only the specified range */
>>> +
>>> +     if (flags & MSM_GEM_SYNC_FOR_DEVICE) {
>>> +             dma_sync_sg_for_device(dev, msm_obj->sgt->sgl,
>>> +                             msm_obj->sgt->nents, DMA_TO_DEVICE);
>>> +     }
>>> +
>>> +     if (flags & MSM_GEM_SYNC_FOR_CPU) {
>>> +             dma_sync_sg_for_cpu(dev, msm_obj->sgt->sgl,
>>> +                             msm_obj->sgt->nents, DMA_FROM_DEVICE);
>>> +     }
>>
>> Splitting this helper from the only caller is rather strange, epecially
>> with the two unused arguments.  And I think the way this is specified
>> to take a range, but ignoring it is actively dangerous.  User space will
>> rely on it syncing everything sooner or later and then you are stuck.
>> So just define a sync all primitive for now, and if you really need a
>> range sync and have actually implemented it add a new ioctl for that.
> 
> We do already have a split of ioctl "layer" which enforces valid ioctl
> params, etc, and gem (or other) module code which is called by the
> ioctl func.  So I think it is fine to keep this split here.  (Also, I
> think at some point there will be a uring type of ioctl alternative
> which would re-use the same gem func.)
> 
> But I do agree that the range should be respected or added later..
> drm_ioctl() dispatch is well prepared for extending ioctls.
> 
> And I assume there should be some validation that the range is aligned
> to cache-line?  Or can we flush a partial cache line?
> 

The range is intended to be "sync at least this range", so that 
userspace doesn't have to worry about details like that.

> BR,
> -R
> 
