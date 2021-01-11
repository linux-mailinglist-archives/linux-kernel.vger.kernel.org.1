Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2BC2F1868
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbhAKOiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbhAKOiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:38:05 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC89C061794;
        Mon, 11 Jan 2021 06:37:24 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cm17so19062226edb.4;
        Mon, 11 Jan 2021 06:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=21jRwdzuelmCNx4/IPIy1mZV6+0ZKfy86dmmgxvQCxk=;
        b=aWvwN2ZYqUzKvnXb1nt3yiJu/tSulZqg2xtxicqCk3dtZR586X/pC5Xb8RB+Pr1MBv
         jjIXJGAxBsbOZnWAcE7o0JI2q3HdklbX3cvMczTh4y5Iuu2AB12oe8l/RAxajaVybT6f
         gtlG6QbqvXSuYScNOfwiIKMxaU2AgnfAzQUMWoZvhEUH1u6XDA6GAbyAWDzOSzmJc4xq
         7TYcyMz/VRJOy83zT5j8ipLYyNK5uPj7ncgEE2iJFOsXeX85rS1FV09hjktjfOZKhUSj
         YXf+4gGcmtSQjB1Leet2YsqfPo0885MFu7PolKTTZZDdr/f3KXXg92nqa0Jhm/gNfWeb
         //Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=21jRwdzuelmCNx4/IPIy1mZV6+0ZKfy86dmmgxvQCxk=;
        b=ZDt73MkQhpsnm1Gty09tJQH1Ra3AyO4YPabq12qrBRLhC+p78+K89SHNOshToH2N8a
         coUXxJTm9aRMZWnznuglaKmjr/HtM7HN+mvfv76IOKZC8llgiFjbwNutn1RVGmxi526S
         C/b2OBIAvtHEk/yHcherx4WAV+i6gl4qVnMa7p5xwjlPZkhp2dG+N5AOpi+6hfpXw7Lh
         2kjhWhd4ueFw0wLSlae6z6jRUzl8rRDFDh9gvhWyJQWE4ChVSyw5j+bAUjW9U5EZRlvg
         n5i9ieKQJ1xfI6gYMq6GBBzn2EPWPBHtCrAYp3XHRurVfVbI0wl/acjky0gEQt5mlmN9
         s7rw==
X-Gm-Message-State: AOAM530PvUxg4qIuQn3SSTZO2xOECrPYDgMGDREP9z3TBA2FDKpWfe9B
        DhmuGV1qmgSPK3IgvlJyrbVe7SfewLo=
X-Google-Smtp-Source: ABdhPJwExfM4guYhEDOpYYOxDlQJ1kdr4i6zASr6tdbF6UzwDW6sr2hoQsi8bRMKyDTIYbpEm3/NYg==
X-Received: by 2002:a50:c3c5:: with SMTP id i5mr14470606edf.166.1610375842947;
        Mon, 11 Jan 2021 06:37:22 -0800 (PST)
Received: from [192.168.2.202] (pd9ea3126.dip0.t-ipconnect.de. [217.234.49.38])
        by smtp.gmail.com with ESMTPSA id i15sm7121272ejj.28.2021.01.11.06.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 06:37:22 -0800 (PST)
Subject: Re: platform/surface: Add Surface Aggregator user-space interface
 (static analysis issues)
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <9e450370-7c5c-2e93-ac86-6f7c21652ab8@canonical.com>
 <cf5213f9-0863-eba6-0e74-2f15577dba9d@gmail.com>
 <a2e05368-42bb-b7bb-8b13-dc654d56bcbc@canonical.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <365cb250-47e0-a81e-434a-b776889853ad@gmail.com>
Date:   Mon, 11 Jan 2021 15:37:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <a2e05368-42bb-b7bb-8b13-dc654d56bcbc@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/21 3:11 PM, Colin Ian King wrote:
> On 11/01/2021 13:55, Maximilian Luz wrote:
>> On 1/11/21 1:12 PM, Colin Ian King wrote:
>>> Hi Maximilian,
>>>
>>> Static analysis of linux-next with Coverity has found several issues
>>> with the following commit:
>>>
>>> commit 178f6ab77e617c984d6520b92e747075a12676ff
>>> Author: Maximilian Luz <luzmaximilian@gmail.com>
>>> Date:   Mon Dec 21 19:39:58 2020 +0100
>>>
>>>       platform/surface: Add Surface Aggregator user-space interface
>>>
>>> The analysis is as follows:
>>>
>>> 65static long ssam_cdev_request(struct ssam_cdev *cdev, unsigned long
>>> arg)
>>>    66{
>>>    67        struct ssam_cdev_request __user *r;
>>>    68        struct ssam_cdev_request rqst;
>>>
>>>      1. var_decl: Declaring variable spec without initializer.
>>>
>>>    69        struct ssam_request spec;
>>>    70        struct ssam_response rsp;
>>>    71        const void __user *plddata;
>>>    72        void __user *rspdata;
>>>    73        int status = 0, ret = 0, tmp;
>>>    74
>>>    75        r = (struct ssam_cdev_request __user *)arg;
>>>    76        ret = copy_struct_from_user(&rqst, sizeof(rqst), r,
>>> sizeof(*r));
>>>
>>>      2. Condition ret, taking true branch.
>>>
>>>    77        if (ret)
>>>
>>>      3. Jumping to label out.
>>>
>>>    78                goto out;
>>>
>>>    79
>>>    80        plddata = u64_to_user_ptr(rqst.payload.data);
>>>    81        rspdata = u64_to_user_ptr(rqst.response.data);
>>>    82
>>>    83        /* Setup basic request fields. */
>>>    84        spec.target_category = rqst.target_category;
>>>    85        spec.target_id = rqst.target_id;
>>>    86        spec.command_id = rqst.command_id;
>>>    87        spec.instance_id = rqst.instance_id;
>>>    88        spec.flags = 0;
>>>    89        spec.length = rqst.payload.length;
>>>    90        spec.payload = NULL;
>>>    91
>>>    92        if (rqst.flags & SSAM_CDEV_REQUEST_HAS_RESPONSE)
>>>    93                spec.flags |= SSAM_REQUEST_HAS_RESPONSE;
>>>    94
>>>    95        if (rqst.flags & SSAM_CDEV_REQUEST_UNSEQUENCED)
>>>    96                spec.flags |= SSAM_REQUEST_UNSEQUENCED;
>>>    97
>>>    98        rsp.capacity = rqst.response.length;
>>>    99        rsp.length = 0;
>>> 100        rsp.pointer = NULL;
>>> 101
>>> 102        /* Get request payload from user-space. */
>>> 103        if (spec.length) {
>>> 104                if (!plddata) {
>>> 105                        ret = -EINVAL;
>>> 106                        goto out;
>>> 107                }
>>> 108
>>>
>>> CID: Untrusted allocation size (TAINTED_SCALAR)
>>>      8. tainted_data: Passing tainted expression spec.length to kzalloc,
>>> which uses it as an allocation size
>>>
>>> 109                spec.payload = kzalloc(spec.length, GFP_KERNEL);
>>
>> I assume a constraint on the maximum length will fix this?
> 
> I believe so, it's unsigned so just an upper size check will be required
> to silence this static analysis warning. Mind you, you may want a size
> that is the full u16 max of 65535, so in that case the check is not
> required.

Right, the theoretical maximum payload (spec.length) and response size
allowed by the Surface Aggregator SSH protocol is 'U16_MAX -
sizeof(struct ssh_command)' (not that anything this size should ever be
allocated in any normal case). Meaning it is (slightly) smaller than
U16_MAX, but I'm not sure if it warrants a check here. The payload size
is later validated by ssam_request_sync(), so it does only affect the
allocation here (the response is just an output buffer and may be of
arbitrary size).

I think the limit imposed by having u16 as user-input should be enough.
I can still add an explicit check here if that is preferred, but I could
also add a comment explaining that this should be safe.

> 
>>
>>> 110                if (!spec.payload) {
>>> 111                        ret = -ENOMEM;
>>> 112                        goto out;
>>> 113                }
>>> 114
>>> 115                if (copy_from_user((void *)spec.payload, plddata,
>>> spec.length)) {
>>> 116                        ret = -EFAULT;
>>> 117                        goto out;
>>> 118                }
>>> 119        }
>>> 120
>>> 121        /* Allocate response buffer. */
>>> 122        if (rsp.capacity) {
>>> 123                if (!rspdata) {
>>> 124                        ret = -EINVAL;
>>> 125                        goto out;
>>> 126                }
>>> 127
>>>
>>> CID: Untrusted allocation size (TAINTED_SCALAR)
>>>      12. tainted_data: Passing tainted expression rsp.capacity to kzalloc,
>>> which uses it as an allocation size
>>>
>>> 128                rsp.pointer = kzalloc(rsp.capacity, GFP_KERNEL);
>>> 129                if (!rsp.pointer) {
>>> 130                        ret = -ENOMEM;
>>> 131                        goto out;
>>> 132                }
>>> 133        }
>>> 134
>>> 135        /* Perform request. */
>>> 136        status = ssam_request_sync(cdev->ctrl, &spec, &rsp);
>>> 137        if (status)
>>> 138                goto out;
>>> 139
>>> 140        /* Copy response to user-space. */
>>> 141        if (rsp.length && copy_to_user(rspdata, rsp.pointer,
>>> rsp.length))
>>> 142                ret = -EFAULT;
>>> 143
>>> 144out:
>>> 145        /* Always try to set response-length and status. */
>>>
>>>      CID: Uninitialized pointer read (UNINIT)
>>>      Using uninitialized value rsp.length
>>>
>>> 146        tmp = put_user(rsp.length, &r->response.length);
>>>
>>>      4. Condition tmp, taking true branch.
>>>
>>> 147        if (tmp)
>>> 148                ret = tmp;
>>> 149
>>> 150        tmp = put_user(status, &r->status);
>>>
>>>      5. Condition tmp, taking true branch.
>>>
>>> 151        if (tmp)
>>> 152                ret = tmp;
>>> 153
>>> 154        /* Cleanup. */
>>>
>>>      CID: Uninitialized pointer read (UNINIT)
>>>      6. uninit_use_in_call: Using uninitialized value spec.payload when
>>> calling kfree.
>>>
>>> 155        kfree(spec.payload);
>>>
>>>      CID: Uninitialized pointer read (UNINIT)
>>>      uninit_use_in_call: Using uninitialized value rsp.pointer when
>>> calling kfree
>>>
>>> 156        kfree(rsp.pointer);
>>
>> Right, taking the first jump to out leaves rsp and spec uninitialized.
>> I'll fix that.
>>
>>> 157
>>> 158        return ret;
>>>
>>> Colin
>>>
>>
>> Thank you for the analysis. I'll draft up two patches to address these
>> issues.
>>
>> Regards,
>> Max
> 
