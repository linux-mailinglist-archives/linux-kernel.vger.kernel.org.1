Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520912FF357
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbhAUSkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbhAUS0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 13:26:35 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88776C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 10:25:40 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o17so3904481lfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 10:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=naHVEnSYOWef7MvwaqCJ+q7eHIkeW6Zanvb4EHnCtZs=;
        b=2SOjPlI9iq/n6X9HOZBwldDRy0DTeUL4fXlMPdU7TiZIp8RruDeGDWpPnoYC1i7SPq
         LbNczGf2Yrq9RNl+4UHR7Wt52YQFxvTnzofu6cdCFM+eDzX50FjtSg8a3quPEKNGr1MQ
         c9LqOmnZbly73Mhr4tLcZP5JtMORbFScG64d3eHbX1XYLV4yxgX3zgGMZlyUBZ8SX0op
         osZR0oHEHNSnOipVYYkd93XCpYe6iflcHfhQv1fgaRSg7m9JF8q/0OWOGaPfmWXOiVO5
         976K0ZrlNU8VTsuWxJOeGcv5WmHAcKenE72lndFv0HMGDYLes86pTPJ1bOpFrzHRRvTX
         8xGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=naHVEnSYOWef7MvwaqCJ+q7eHIkeW6Zanvb4EHnCtZs=;
        b=Hay8C5N1aVQBymQWwYGZDHny/D6o739jD3Acemu1x/kP3VHq+8X3xC0Y69I+KOVb6r
         H49H50k7rWt4sQ+J48u2FOg/+H5wA0D5REWxnZeY3yIyWmTla+Z80chyRTJ77J3R9Yi3
         qF9hR9TNVqOEw/eU2GV6WrtwajfiuMTtxDjwdli/WzTzKGjeiSbV54PBkZb+1QzR54rz
         jAnLDTlEjPggcqMTqlXSrYNoktDIiFaWWZkmV3gZyEMYnO+VUZecQoXTl+aXV6uOu4Dd
         NDDvBV38oR8+xHUjmolW/JyzBsVbbiNPVF2NttIomoeGzheYcp+wyz+l6UPIEoVZ7TKU
         F3gQ==
X-Gm-Message-State: AOAM532FuepSbFwXF/7PlmIMuclqalH8gtOb7Zei9Hj/TAbpLS9pWUHt
        91azI42wePDHZrq7SvUx3vrSMhAcS0XyYw==
X-Google-Smtp-Source: ABdhPJyRWQ0qyA2AKW9WeVu1GaFeBM5sBtIw2LijGJVzw3EsuQQND/aukYGI7ZLIr0fqrUdv/J/igw==
X-Received: by 2002:a05:6512:745:: with SMTP id c5mr224191lfs.489.1611253538797;
        Thu, 21 Jan 2021 10:25:38 -0800 (PST)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id n13sm599375lfu.265.2021.01.21.10.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 10:25:38 -0800 (PST)
Subject: Re: [PATCH] lightnvm: fix memory leak when submit fails
To:     Heiner Litz <hlitz@ucsc.edu>
Cc:     Jens Axboe <axboe@kernel.dk>, Pan Bian <bianpan2016@163.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210121072202.120810-1-bianpan2016@163.com>
 <55045608-01cb-d5af-682b-5a213944e33d@kernel.dk>
 <474055ad-978a-4da5-d7f0-e2dc862b781c@lightnvm.io>
 <CAJbgVnWxmwfmdgk-e290kcMfhUNAjP9uO2k45rx7R=x8jBdJcw@mail.gmail.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <59a735f0-9fef-5e6d-f7eb-851e14a2883e@lightnvm.io>
Date:   Thu, 21 Jan 2021 19:25:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAJbgVnWxmwfmdgk-e290kcMfhUNAjP9uO2k45rx7R=x8jBdJcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2021 17.58, Heiner Litz wrote:
> I don't think that ZNS supersedes OCSSD. OCSSDs provide much more
> flexibility and device control and remain valuable for academia. For
> us, PBLK is the most accurate "SSD Emulator" out there that, as
> another benefit, enables real-time performance measurements.
> That being said, I understand that this may not be a good enough
> reason to keep it around, but I wouldn't mind if it stayed for another
> while.

The key difference between ZNS SSDs, and OCSSDs is that wear-leveling is 
done on the SSD, whereas it is on the host with OCSSD.

While that is interesting in itself, the bulk of the research that is 
based upon OCSSD, is to control which dies are accessed. As that is 
already compatible with NVMe Endurance Groups/NVM Sets, there is really 
no reason to keep OCSSD around to have that flexibility.

If we take it out of the kernel, it would still be maintained in the 
github repository and available for researchers. Given the few changes 
that have happened over the past year, it should be relatively easy to 
rebase for each kernel release for quite a while.

Best, Matias



>
> On Thu, Jan 21, 2021 at 5:57 AM Matias Bjørling <mb@lightnvm.io> wrote:
>> On 21/01/2021 13.47, Jens Axboe wrote:
>>> On 1/21/21 12:22 AM, Pan Bian wrote:
>>>> The allocated page is not released if error occurs in
>>>> nvm_submit_io_sync_raw(). __free_page() is moved ealier to avoid
>>>> possible memory leak issue.
>>> Applied, thanks.
>>>
>>> General question for Matias - is lightnvm maintained anymore at all, or
>>> should we remove it? The project seems dead from my pov, and I don't
>>> even remember anyone even reviewing fixes from other people.
>>>
>> Hi Jens,
>>
>> ZNS has superseded OCSSD/lightnvm. As a result, the hardware and
>> software development around OCSSD have also moved on to ZNS. To my
>> knowledge, there is not anyone implementing OCSSD1.2/2.0 commercially at
>> this point, and what has been deployed in production does not utilize
>> the Linux kernel stack.
>>
>> I do not mind continuing to keep an eye on it, but on the other hand, it
>> has served its purpose. It enabled the "Open-Channel SSD architectures"
>> of the world to take hold in the market and thereby gained enough
>> momentum to be standardized in NVMe as ZNS.
>>
>> Would you like me to send a PR to remove lightnvm immediately, or should
>> we mark it as deprecated for a while before pulling it?
>>
>> Best, Matias
>>
>>

