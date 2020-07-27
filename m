Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392F222FA16
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 22:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgG0UaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 16:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG0UaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:30:08 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471F0C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 13:30:08 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p3so10576876pgh.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 13:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2KZJwIkhy/CrWVZLuUHvj+D7ETG92ZsCbDsCh9LqsAY=;
        b=bzNK7nJkhpcctw8iEyrGD9i++PcZ+43Z5mANXDqbCuWyHCiTPy2OM0p3QDbLplwOe6
         R947pngpVc+vbgYMZdf2t5it6MdECh44JwVFT4vhDi9h+AghbzXODHeZ5jXTz92BjLtl
         HfnI6jVQYnOV/rif7oCo6/hCjVKvyciSlAKe4WSub77dvopPM4L40sggklvl14EhyzsW
         nvJASc1EpYMgdBX1NZusbdAloNCuSENRlioBwBbJaOFTSHLUkk+uwQMfErLIn2/pnA7D
         Gqbncdv0tc7FBNAV4YDB74amIK+9LjC1m97MqA+T9VGH215VB/UR8y+78tUxuSXguhNA
         +EoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2KZJwIkhy/CrWVZLuUHvj+D7ETG92ZsCbDsCh9LqsAY=;
        b=SSSFhBuBk5nDR3yyPzCMOwIDLzaj5DB7QP/+Bxk4OJVJVb26D8y2HcAnEZ+KQw0Tn2
         A/fD9Vr5yMbF82oqIBvy/kRWlwE5ljET8x4TnM2g80s+tSKzTp1N5imBN+qsJUFbElUC
         1GpVPY2RMoHDe7ui+JfGTm2oWZHdj6o4NKAK0RbO3GpSMdaquxNysOI2flV8NolzAK3T
         2DVWRDVh8S7Z0F58XH/J4Je3fU/h3e2Uw/ptylE9WlqfLm6M6S+zkgk5NnjMotSTKBf2
         TULJewWcqOGduuZR6FAam+ziVW+1zzX05UlZrVPV5PKNWj3oJ2RGkAIBdzvfZ9TNEN+A
         WFAw==
X-Gm-Message-State: AOAM531z1frdMIdWihFwVI3HlXBuY3FBkI+qKUl+tkI4jUsQJkqvUPsW
        b+aOx4PFJu7mV5DkA0spOEg3P/TiRzk=
X-Google-Smtp-Source: ABdhPJxTWacB6EGQGaEQ+NPmcYzQG9/x9QEKKKQnyObZnzJ8sFdEm+YpGl6oy3JUs2H8dTaltB7V2g==
X-Received: by 2002:a62:7942:: with SMTP id u63mr21266195pfc.54.1595881807704;
        Mon, 27 Jul 2020 13:30:07 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y6sm467347pji.2.2020.07.27.13.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 13:30:07 -0700 (PDT)
Subject: Re: [PATCH v2] ata: use generic power management
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200727173923.694872-1-vaibhavgupta40@gmail.com>
 <20200727174012.GA696265@gmail.com>
 <2b4738b0-5c2c-8ee2-83f9-10b961a5d0d3@kernel.dk>
 <20200727175119.GA700880@gmail.com>
 <99b7cc57-1b4f-6c0b-00c6-08e22021c373@kernel.dk>
 <20200727181144.GA543@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9718954b-2152-1bc2-e702-ebe8799fdfb3@kernel.dk>
Date:   Mon, 27 Jul 2020 14:30:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727181144.GA543@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/20 12:11 PM, Vaibhav Gupta wrote:
> On Mon, Jul 27, 2020 at 11:59:05AM -0600, Jens Axboe wrote:
>> On 7/27/20 11:51 AM, Vaibhav Gupta wrote:
>>> On Mon, Jul 27, 2020 at 11:42:51AM -0600, Jens Axboe wrote:
>>>> On 7/27/20 11:40 AM, Vaibhav Gupta wrote:
>>>>> The patch is compile-tested only.
>>>>
>>>> Please test and verify actual functionality, if you're serious
>>>> about potentially getting this into the kernel.
>>>>
>>> Hello Jens,
>>>
>>> Sadly I don't have the hardware. This upgrade is part of my Linux
>>> Kernel Mentorship Program project. Like other PCI drivers which I
>>> have updated, I could do compile-testing only. Though this patch
>>> covers 54 drivers but the actual change is done only in
>>> drivers/ata/libata-core. Since rest of the drivers make use of the
>>> same ata_pci_device_suspend/resume(), it was a chain reaction. I
>>> only had to change variable binding in "struct pci_driver" variable
>>> of dependent drivers.
>>
>> That's understandable, but you should find at least some hardware
>> (maybe remotely accessible) to test this on. I'm not going to apply
>> this without some confidence that it actually works, and compile only
>> testing is a far cry from that. Lots of code compiles, but fails
>> miserably at runtime.
>>
>> While it's touching 54 drivers, at least basic coverage of the most
>> popular choices will give everybody some confidence that it works in
>> general.
>>
> Yes, I agree. Actually with previous drivers, I was able to get help
> from maintainers and/or supporters for the hardware testing. Is that
> possible for this patch?

It might be, you'll have to ask people to help you, very rarely do people
just test patches unsolicited unless they have some sort of interest in the
feature.

This is all part of what it takes to get code upstream. Writing the code
is just a small part of it, the bigger part is usually getting it tested
and providing some assurance that you are willing to fix issues when/if
they come up.

You might want to consider splitting up the patchset a bit - you could
have one patch for the generic bits, then one for each chipset. That
would allow you to at least get some of the work upstream, once tested.

-- 
Jens Axboe

