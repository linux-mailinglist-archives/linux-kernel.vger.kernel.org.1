Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F326B26BE45
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 09:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgIPHim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 03:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgIPHil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:38:41 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B8DC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 00:38:40 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u4so5038475ljd.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 00:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/Ve+uN77l2mNjSGSgchzbGo6elSRLw4c+esXt/wG3n8=;
        b=qfJOIvaWp0ltvhKrrA/Qb3zKGpq6LMq5IucxqsOYjGKBEHE282iCaS3duAGkufnxIy
         yroKYAoaD4QcvSsAFQScxnOdrPvAPdveBzEHfdqUTDNp2eryQpcj7PD3xBbV3PjrOvgl
         /siK36295K0OBgg9JXKmPTSdTu1MNv0iJYOcb2fSJHYr5YeUTau8dnKA9HFOKXtvRKrK
         f1hRtFa5tEwaektfwHpHJC2r/V1XCH0OErpsof22px2Y3cV6qxgUV8tudTONmEXnohjf
         cY9/XWzXvJSJiQNe8PyHICqxxib8he4KCMsCU+djAsYLFno5O7Dkqc0fg2/BPf54r0ve
         QJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=/Ve+uN77l2mNjSGSgchzbGo6elSRLw4c+esXt/wG3n8=;
        b=n0bXaxbZiRzhK7STc4eQBaFNNcjoU06SyvKMRNRdKBUmodmNG24AQviAE1Qv0nkZNC
         Fe4Azk8IS/n2qjrTabptxLXH8p/0ELqxwdZFDwWf3Eg8H+eJdSfLjUQoQz8Zje2LwJIx
         LihWlUnhVWbCiLcBBggzKVXw97pl6Ts2W8nywQdULrp4xwAUCA9rqh4lJ5rcfJWPtzm3
         bTj6j4HtCUhuOrCnXCcYZ9cmA3qDHIO4oM8Ay17HCIcqHt5OZUiWbr7VzudYCJjZWIzF
         f4PGOPMn0Fcjn4J6XHVZFcDtt0AJ0Cde5eY6SVRvw706gR/Ku64qoVFrcVk8KANyCDjd
         NwrA==
X-Gm-Message-State: AOAM531P7oKBaOKfne2kRR6b3YrdmllUt0ZtSXI2hNSf+mWXA6jutGor
        jbXgfhoFW/4N/BW4m0gbpb8=
X-Google-Smtp-Source: ABdhPJwJbGNg9ljapuYPbuUtj0KvB1atxCILhskbIHoedwzAIw9tKZs2o0vx5QnfLSEpKIncKq74Lg==
X-Received: by 2002:a05:651c:1307:: with SMTP id u7mr8617236lja.267.1600241917282;
        Wed, 16 Sep 2020 00:38:37 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id m203sm4405724lfd.195.2020.09.16.00.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 00:38:36 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH -next 0/8] drm/amd/amdgpu: fix comparison pointer to bool
 warning
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     yi.zhang@huawei.com, Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Zheng Bin <zhengbin13@huawei.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20200909130720.105234-1-zhengbin13@huawei.com>
 <1fce0f2a-3777-e6d8-5a09-30261f843cfd@amd.com>
 <CADnq5_NoeFbBAMT6s_ictVXsUc2tx1U48MLxnMbAr2Sd58jyYA@mail.gmail.com>
 <20200915193549.GP6112@intel.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6658f89f-6957-e6ea-af41-7625f1fd3cb1@gmail.com>
Date:   Wed, 16 Sep 2020 09:38:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915193549.GP6112@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 15.09.20 um 21:35 schrieb Ville Syrjälä:
> On Tue, Sep 15, 2020 at 03:16:32PM -0400, Alex Deucher wrote:
>> I question the value of these warnings.  Why even have a boolean type
>> if you are going to get warnings when you use them...
>> That said, applied to avoid getting these patches again and again
>> every time someone sees this.
> if (this_is_sparta)
> if (this_is_sparta == true)
> if (this_is_sparta != false)
>
> I think the first one reads the best, and avoids having to
> decide between truth and falsehood :)

+1

Christian.

>
>> Alex
>>
>> On Wed, Sep 9, 2020 at 9:21 AM Christian König <christian.koenig@amd.com> wrote:
>>> Acked-by: Christian König <christian.koenig@amd.com> for the series.
>>>
>>> Am 09.09.20 um 15:07 schrieb Zheng Bin:
>>>> Zheng Bin (8):
>>>>     drm/amd/amdgpu: fix comparison pointer to bool warning in gfx_v9_0.c
>>>>     drm/amd/amdgpu: fix comparison pointer to bool warning in gfx_v10_0.c
>>>>     drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v5_0.c
>>>>     drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v5_2.c
>>>>     drm/amd/amdgpu: fix comparison pointer to bool warning in si.c
>>>>     drm/amd/amdgpu: fix comparison pointer to bool warning in uvd_v6_0.c
>>>>     drm/amd/amdgpu: fix comparison pointer to bool warning in
>>>>       amdgpu_atpx_handler.c
>>>>     drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v4_0.c
>>>>
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 4 ++--
>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c           | 2 +-
>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c            | 2 +-
>>>>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c           | 4 ++--
>>>>    drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c           | 2 +-
>>>>    drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c           | 2 +-
>>>>    drivers/gpu/drm/amd/amdgpu/si.c                  | 2 +-
>>>>    drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c            | 4 ++--
>>>>    8 files changed, 11 insertions(+), 11 deletions(-)
>>>>
>>>> --
>>>> 2.26.0.106.g9fadedd
>>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel

