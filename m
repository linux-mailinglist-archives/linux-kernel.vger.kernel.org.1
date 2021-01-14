Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792642F6AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbhANT0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:26:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39822 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbhANT0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:26:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610652321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=66oqnGi+Psyfbe2ZSUGA9TNQxDSXhaFOF8md+3cgyAY=;
        b=g+lKbLsDHCk1C0BkvPRET+8+IXThwHZfQlcaQSB57kT61533S5BDQ9ug5Bdd7jPEfAfAm6
        4iHMK0cngWVYwQz4eiQ51cdKEDNgfja+17d1eoxcNWe8nk1hf9E9MAiuyuFxj1D91d8SbU
        gSaSGSr5mFG7XQDMI6CpbwR5MnqioGk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-bQ1e_f0qNpCb05QvK3OHzw-1; Thu, 14 Jan 2021 14:25:20 -0500
X-MC-Unique: bQ1e_f0qNpCb05QvK3OHzw-1
Received: by mail-qk1-f200.google.com with SMTP id x74so5635174qkb.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=66oqnGi+Psyfbe2ZSUGA9TNQxDSXhaFOF8md+3cgyAY=;
        b=VNRhMSfO6/l/ypEHtrLXYmV+dzhW/1J2c2HsMR2Hz91e44PzUpyQMg5RIu5Cf4F8Lv
         tpmFTsSW5S8o3RH/5mUk4ZYKIdzVeR5mg0R45uncdsE5vHFC5HXMywpe0os0bRiSXF0P
         nCC4lAi/y3A6pHrmMZavSjGr+l+lcZuCjtfIyi2RKXM/3t1u59dfWPC5oEJ0yOi8Ie31
         IdfjSIxdjKUaxcmFtyVV4o0ICflNjpZXa27xE1bO6U6fo8vU47sV2rmIIYTNRvFWikxF
         l4Obptdz/W77ILLjz3+J0T5/czfYrB55XWy4atP6DsFZYpNKOnAdFyfs1OtA7dKQ6sED
         26qg==
X-Gm-Message-State: AOAM5302WhZfi8rUMh4MNfzItQJnd7OsxeRnWoaTyUE8SWhn76bvN2mc
        3eZ2HzZhHiRfBCYYVsoqMAkNd241xBIrSLQGRQ2Of9u4FnykQlvwie5rllgjxp5WqHGnntfMHOv
        sEajrNe7ndoIcMgUJM2aMvk02Ly9AdBRKOx3g7gIfxvHmg0USWdu8N2FvyODmGO4G5m4ie0Y=
X-Received: by 2002:a0c:f185:: with SMTP id m5mr8794693qvl.19.1610652319468;
        Thu, 14 Jan 2021 11:25:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBmBSGOMFy6rLlPKaahiunE6UAAIlP/AZVZCw1jB0h7NTTU//6yvCX6dHPxG9UIBNIIKVo7w==
X-Received: by 2002:a0c:f185:: with SMTP id m5mr8794674qvl.19.1610652319225;
        Thu, 14 Jan 2021 11:25:19 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l20sm3603237qtu.25.2021.01.14.11.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 11:25:18 -0800 (PST)
Subject: Re: [PATCH] x86/mm/mtrr: remove definition of DEBUG
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        ying-tsun.huang@amd.com, peterz@infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210114162743.20737-1-trix@redhat.com>
 <20210114184626.GH12284@zn.tnic>
From:   Tom Rix <trix@redhat.com>
Message-ID: <24593769-e2fe-7fd4-d212-0e6da58764cd@redhat.com>
Date:   Thu, 14 Jan 2021 11:25:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210114184626.GH12284@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/14/21 10:46 AM, Borislav Petkov wrote:
> On Thu, Jan 14, 2021 at 08:27:43AM -0800, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Defining DEBUG should only be done in development.
>> So remove DEBUG.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>  arch/x86/kernel/cpu/mtrr/generic.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
>> index a29997e6cf9e..b90f3f437765 100644
>> --- a/arch/x86/kernel/cpu/mtrr/generic.c
>> +++ b/arch/x86/kernel/cpu/mtrr/generic.c
>> @@ -3,7 +3,6 @@
>>   * This only handles 32bit MTRR on 32bit hosts. This is strictly wrong
>>   * because MTRRs can span up to 40 bits (36bits on most modern x86)
>>   */
>> -#define DEBUG
>>  
>>  #include <linux/export.h>
>>  #include <linux/init.h>
> Wanna merge all 4 in arch/x86/
>
> arch/x86/kernel/cpu/mtrr/generic.c:6:#define DEBUG
> arch/x86/kernel/cpu/mtrr/mtrr.c:34:#define DEBUG
> arch/x86/kernel/pci-iommu_table.c:8:#define DEBUG 1
> arch/x86/mm/mmio-mod.c:13:#define DEBUG 1
>
> into a single patch?

Yes, i'll take care of that.

Tom

> Thx.
>

