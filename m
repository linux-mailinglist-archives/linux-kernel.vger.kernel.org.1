Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDE328E609
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgJNSLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgJNSLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:11:15 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC1FC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:11:13 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n14so280502pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kfFiUxOZKWzzs2I7A2X5SXoe7asuY8qVgnbF40y4GdU=;
        b=s9A8QFEEbnanF4A9aEisLXgyhWELaYUqI9KuwNjnoVdJyjONGJK556ktEM05bIOdOE
         vBdYCIN8BYpyXpEX1rgke3yQcaJsmTtUsXXCqWLgwy8TjKuN2Tmv1r0FsOTwjRHh28iT
         mLG7NISm6XIjUGmNK4tbxKbdk2igeIL6dLPcwwHDyGrOp/yxaNvd3RoZHfGWPHftE3bc
         KkjAEvbtfBFBtyRnfPz1MRMa2+6PTS5tvJbu1/sJAK59ASc7g+w+MDP0xHaAy2e4+E2W
         aGvI4Mr0Uxx9134c9HbYsnqjH1jZOEkIH9bYxGBdzz/ofZy8oCd3SkNMlYmkJ+hgz9Ps
         5Osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kfFiUxOZKWzzs2I7A2X5SXoe7asuY8qVgnbF40y4GdU=;
        b=f3LKfXPXLNGl1dQZL3rp/B4SCLSbXzrtp9l7LFhf8/YA4yW2OyWhMFwI25ISDHiVyU
         XsExlRkXufoCaguNCT1TkXsX4z83LHYlacAsgWuSqZr9z73w9Hn9qhgZNQmDROFQrYMi
         yoz1sN/Pi9sq1htdUgiXGJt2/bGe7yZOHiwh1EoLBpY09KAzkXP3gnqAg06caQIBGW1W
         6cX039mmaeGXqd0jA/wdhcQ4fdhq4bLWR6iObTa/kYqu+8l6xETEAqePoMGtmiswq7nX
         sRUhAblL/UufqS+IiMa6Q8IRDIUQUN1eVh72sYxBr7eD6MRY5Du/tysV7d1w5qNSgp9k
         2dAQ==
X-Gm-Message-State: AOAM532kekMpmAz42iRsYZPVCKW7iUYa4M7KkxLyxBZaklAWHfDg0x/R
        a4gwQzuQbko8tj3ze3nTayo=
X-Google-Smtp-Source: ABdhPJzxLbSnEyEqYGAT1eyxjUbIhXclWrzXrWH0dQfoLaGhuV9rWl0PuSJWe7+Tr41zVZHiHFv7Yg==
X-Received: by 2002:a62:d10b:0:b029:152:56c0:df72 with SMTP id z11-20020a62d10b0000b029015256c0df72mr554703pfg.10.1602699073063;
        Wed, 14 Oct 2020 11:11:13 -0700 (PDT)
Received: from [10.67.48.230] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g3sm187266pjl.6.2020.10.14.11.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 11:11:12 -0700 (PDT)
Subject: Re: [PATCH] firmware: arm_scmi: Fix duplicate workqueue name
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20201014021737.287340-1-f.fainelli@gmail.com>
 <20201014091806.GB20315@bogus> <20201014130524.cj42wknvzdpgsbsr@bogus>
 <20201014134819.GA24061@e120937-lin> <20201014160120.4x2l7hozf376gk3l@bogus>
 <fdb270ef-bec0-9592-1d33-3339872bbffe@gmail.com>
 <20201014173906.aytbl4bjbwjwa6wr@bogus>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <25ae326c-eceb-5479-8910-b8ab427ae192@gmail.com>
Date:   Wed, 14 Oct 2020 11:11:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014173906.aytbl4bjbwjwa6wr@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/20 10:39 AM, Sudeep Holla wrote:
> On Wed, Oct 14, 2020 at 10:13:04AM -0700, Florian Fainelli wrote:
>> On 10/14/20 9:18 AM, Sudeep Holla wrote:
>>> On Wed, Oct 14, 2020 at 02:48:19PM +0100, Cristian Marussi wrote:
>>>
>>> [...]
>>>
>>>>>
>>>>> I have pushed a version with above change [1], please check if you are
>>>>> happy with that ?
>>>>>
>>>>> [1] https://git.kernel.org/sudeep.holla/linux/c/b2cd15549b
>>>>
>>>> I agree with the need to retain _notify name, but I'm not so sure about
>>>> the above patch...which is:
>>>>
>>>
>>> I agree, I thought about it and just cooked up this as a quick solution.
>>> I will move to that, even I wasn't happy with this TBH.
>>
>> The reason why I went with just dev_name() was such that the workqueue
>> name and the device nodes under /sys would strictly match, which helps
>> as an user, and also it avoided the temporary buffer and its size
>> limitations.
> 
> Agreed. I just showed that as example and was hoping to use some nice
> kstr* APIs to achieve what I wanted but soon realised there exists none.
> So as replied earlier, I will take this change as it for now. Let us
> address this in future if it becomes an issue.
> 
> Thanks for quick test, we now know whom to bother if we need more testing
> 😉 as out internal platforms are not that great to cover all the aspects
> we add in the spec and even in the kernel.

No problem! I still need to find the time to upgrade the ATF equivalent
implementation to support SCMI 3.0, have not done that just yet.
-- 
Florian
