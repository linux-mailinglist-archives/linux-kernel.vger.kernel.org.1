Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87832ABE60
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbgKIOPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730467AbgKIOPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:15:01 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5AFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 06:15:00 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q10so8307944pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 06:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dW3iaMNRaK29PFwXsdN2BpW3nrFRdjVd9RZvzmco9OQ=;
        b=mOSQ8eXb8EWF51GfkbaMjtB9cy5675N6ueGCBtvgX1tvlPheBO+5kJq9y46H20QJ1w
         8P7Gqjb88nW0PLQwCitwLY9o6PzqZnaDq1hIgVLzyXM6FHKY9HKRHvHKsh6WpoVje5YC
         rdXTTmZXpZyDp8YWDdvEIU4WMx22yYN0yLp6N0lGO4k7RAD2qPHnkVFVm0H7iDevOC82
         WfL4Pnq1ebUGOxhKXCNQsMKKGv8TLGae6wYZH7kdy8amPwKQesfUl1k+ECO8SJC0wF/4
         GIlvtjTPB6KMgxapZ6aW9u2loV4rPqvWLHL0ICsFAC3DNModFwSFPyzjellsJknxB78/
         MWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dW3iaMNRaK29PFwXsdN2BpW3nrFRdjVd9RZvzmco9OQ=;
        b=YxMh/YxeIkkojIeiZy9YkP24oCGBuEnaNIbiepporAX9I531EZbWdAE6cdWB82p4Z4
         vBAHB6nvS3i+SCohw2kvX862qQh9EGGonlLpq8GZGGU6MRptRAzphRf+wlFaXQylWNg5
         2157AlqBUP6WhGXQYpD2w5RnWC2tTX9DmkYjCKWbbArXffWdv2/NPIJEMAG0QoVbEkdz
         AUKuu6guxNJOw06ElDW9wjQIwWKaGwKz7R3sosPI/nfhlfwIqiWO0IC2m9LmN9wEOsyB
         gMXRFgFODaKuqjYZzT/rr+URyK/9o5q64z2/Z+QPS2/zHcnyEeUOF9pcO7UkOaFh4ktR
         tNIw==
X-Gm-Message-State: AOAM530nKYd3AzrBJJTcrh9U+2BswzIe/Tz9zflvfc8LgO2CwZIu3VDS
        GVsdixTRU5IKJOk0dwVxLiX8MsUFm4DT/Q==
X-Google-Smtp-Source: ABdhPJzjnR2tsju5hVZt+y1dI1ErLnSX344xymJetu9VL8AcwF1hO7ULykTAQ+OeDx+LGGFXWHci6g==
X-Received: by 2002:a92:ab04:: with SMTP id v4mr9184739ilh.18.1604930816707;
        Mon, 09 Nov 2020 06:06:56 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c66sm7504741ilg.46.2020.11.09.06.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 06:06:55 -0800 (PST)
Subject: Re: linux-next: manual merge of the tip tree with the block tree
To:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20201109141446.3370914b@canb.auug.org.au>
 <871rh2k5jq.fsf@nanos.tec.linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <02e6aad7-dbea-6820-df01-76263080b169@kernel.dk>
Date:   Mon, 9 Nov 2020 07:06:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <871rh2k5jq.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/20 6:45 AM, Thomas Gleixner wrote:
> On Mon, Nov 09 2020 at 14:14, Stephen Rothwell wrote:
>> Today's linux-next merge of the tip tree got a conflict in:
>>
>>   include/linux/sched/signal.h
>>   include/linux/tracehook.h
>>   kernel/signal.c
>>   kernel/task_work.c
>>
>> between commits:
>>
>>   fdb5f027ce66 ("task_work: use TIF_NOTIFY_SIGNAL if available")
>>   bf6996650675 ("task_work: remove legacy TWA_SIGNAL path")
>>   ceb39b7c17b7 ("kernel: remove checking for TIF_NOTIFY_SIGNAL")
>>
>> from the block tree and commit:
>>
>>   114518eb6430 ("task_work: Use TIF_NOTIFY_SIGNAL if available")
>>   12db8b690010 ("entry: Add support for TIF_NOTIFY_SIGNAL")
>>
>> from the tip tree.
> 
> Jens, how is that supposed to work?
> 
> You need to merge the 'core-entry-notify-signal' tag from the tip tree
> into your next branch to make the follow up changes actually work.

I just haven't rebased with that pulled in yet, will do that this
morning.

> Ideally you send the whole arch + core cleanup muck my way once the
> architecture people are happy.

Crossing fingers that I'll be able to collect all of the reviews in
time, some of them have been picked up in arch trees though. So probably
the easiest if we keep the setup as it is, which should work fine as
soon as I pull in your core branch.

-- 
Jens Axboe

