Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EC92DAFBF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgLOPHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:07:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55307 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730126AbgLOPHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:07:45 -0500
X-Greylist: delayed 1648 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Dec 2020 10:07:43 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608044774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n33BH0JIpwfiII+0rJOgiNcurtN16qylVgIcObIawoA=;
        b=eADBzkxR5CpUcXaynGheTF00+a3UlzFHUTiNV0+XfaegCt0DDidI3Qk7OIMyHGWnxs1c2e
        mwlVyMp7mGnCxDIW9dAD6ShiPys38Gf5kO7U9D+fRX9zC9LD+7UyRXzxMMCc/m6k+nhj2j
        k/w0N4O/2kXmkoWqYgpcyDzeUaBkHAw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-HwDWw-a_N6-q2lX01V_5FQ-1; Tue, 15 Dec 2020 10:06:11 -0500
X-MC-Unique: HwDWw-a_N6-q2lX01V_5FQ-1
Received: by mail-qk1-f197.google.com with SMTP id u67so15448055qkd.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 07:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=n33BH0JIpwfiII+0rJOgiNcurtN16qylVgIcObIawoA=;
        b=oKVI7Howne6AYp1FXCww15l6vVfgaj1YtFGBdk44wRIRT5ZttK4TmbZVwu3R6XlWhw
         h1RnYF7+5KXCULMKkPvFPeAJECZSLRWR2Z+ftfMhYqFreQ+7kEgN5xTAreXgauFV3RN2
         toUyDFPGj9yNmjo2Unvzh5/xdPbZqB/KIOQhblG+lUctveHoJ0fnKRsikT2DS6GpiTu8
         BE5V/Ge+v6cDcLPXx+R6VKy01+BH9IoYvrBpN4oOSoQve/yTwWT2TTjhnIZUfcU9q/hP
         q1PYIEVhFkSnbdyLfaJs/x/56b5csEsqBMbayrODMFl9xpR3IEYvkoyrBUJrAZj9P3FB
         txgA==
X-Gm-Message-State: AOAM531MJ5dOOOjrwWYc6LtQLTHG/+96+5yCLWGpGvbGJ9hLTRGYwE+3
        2KmzcsvrCCTZEpBBKUm4QErVAHjK3eIZHnK9fJ49HAw7GFOCvG9ki6euhOaAUNuQUhfz5MPzZUO
        k11iKWWefn6Z32QX3qW56QcHS53LUkn4gBI6B6q+B/7NeLALO0Ua9xYWy6JtONNWCMW2nndg=
X-Received: by 2002:ac8:7b38:: with SMTP id l24mr39525702qtu.136.1608044770831;
        Tue, 15 Dec 2020 07:06:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxFWLICLYxp/LajEPgP+Bc0xGN7GikJoY2NZ3c7YmeWN2ZadsxKAo+IZFmpbsdTfwGwLgskfw==
X-Received: by 2002:ac8:7b38:: with SMTP id l24mr39525658qtu.136.1608044770554;
        Tue, 15 Dec 2020 07:06:10 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a25sm13343088qtg.20.2020.12.15.07.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 07:06:09 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: remove h from printk format specifier
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        alexander.deucher@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        lee.jones@linaro.org, Felix.Kuehling@amd.com, nirmoy.das@amd.com,
        sonny.jiang@amd.com, xinhui.pan@amd.com, colin.king@canonical.com,
        James.Zhu@amd.com, leo.liu@amd.com, thong.thai@amd.com,
        vegopala@amd.com, boyuan.zhang@amd.com, Monk.Liu@amd.com,
        mh12gx2825@gmail.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20201215143835.1874487-1-trix@redhat.com>
 <e71eb9ef-d5f9-0829-670f-d5c2c644a493@amd.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a741836e-7f33-dcbb-d2bd-603091b9a2ad@redhat.com>
Date:   Tue, 15 Dec 2020 07:06:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <e71eb9ef-d5f9-0829-670f-d5c2c644a493@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/15/20 6:47 AM, Christian König wrote:
> Am 15.12.20 um 15:38 schrieb trix@redhat.com:
>> From: Tom Rix <trix@redhat.com>
>>
>> See Documentation/core-api/printk-formats.rst.
>> h should no longer be used in the format specifier for printk.
>
> In general looks valid to me, but my question is how does that work?
>
> I mean we specify h here because it is a short int. Are ints always 32bit on the stack?

The type of the argument is promoted to int.  This was discussed earlier here

https://lore.kernel.org/lkml/a68114afb134b8633905f5a25ae7c4e6799ce8f1.camel@perches.com/

Tom

>
> Thanks,
> Christian.
>
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 4 ++--
>>   3 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> index 7c5b60e53482..8b989670ed66 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> @@ -240,7 +240,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>>             version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
>>           version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
>> -        DRM_INFO("Found UVD firmware Version: %hu.%hu Family ID: %hu\n",
>> +        DRM_INFO("Found UVD firmware Version: %u.%u Family ID: %u\n",
>>               version_major, version_minor, family_id);
>>             /*
>> @@ -267,7 +267,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>>           dec_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
>>           enc_minor = (le32_to_cpu(hdr->ucode_version) >> 24) & 0x3f;
>>           enc_major = (le32_to_cpu(hdr->ucode_version) >> 30) & 0x3;
>> -        DRM_INFO("Found UVD firmware ENC: %hu.%hu DEC: .%hu Family ID: %hu\n",
>> +        DRM_INFO("Found UVD firmware ENC: %u.%u DEC: .%u Family ID: %u\n",
>>               enc_major, enc_minor, dec_minor, family_id);
>>             adev->uvd.max_handles = AMDGPU_MAX_UVD_HANDLES;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> index 4861f8ddc1b5..ea6a62f67e38 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> @@ -179,7 +179,7 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
>>       version_major = (ucode_version >> 20) & 0xfff;
>>       version_minor = (ucode_version >> 8) & 0xfff;
>>       binary_id = ucode_version & 0xff;
>> -    DRM_INFO("Found VCE firmware Version: %hhd.%hhd Binary ID: %hhd\n",
>> +    DRM_INFO("Found VCE firmware Version: %d.%d Binary ID: %d\n",
>>           version_major, version_minor, binary_id);
>>       adev->vce.fw_version = ((version_major << 24) | (version_minor << 16) |
>>                   (binary_id << 8));
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> index 1e756186e3f8..99b82f3c2617 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> @@ -181,7 +181,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>>           enc_major = fw_check;
>>           dec_ver = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xf;
>>           vep = (le32_to_cpu(hdr->ucode_version) >> 28) & 0xf;
>> -        DRM_INFO("Found VCN firmware Version ENC: %hu.%hu DEC: %hu VEP: %hu Revision: %hu\n",
>> +        DRM_INFO("Found VCN firmware Version ENC: %u.%u DEC: %u VEP: %u Revision: %u\n",
>>               enc_major, enc_minor, dec_ver, vep, fw_rev);
>>       } else {
>>           unsigned int version_major, version_minor, family_id;
>> @@ -189,7 +189,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>>           family_id = le32_to_cpu(hdr->ucode_version) & 0xff;
>>           version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
>>           version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
>> -        DRM_INFO("Found VCN firmware Version: %hu.%hu Family ID: %hu\n",
>> +        DRM_INFO("Found VCN firmware Version: %u.%u Family ID: %u\n",
>>               version_major, version_minor, family_id);
>>       }
>>   
>

