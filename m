Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B302230E63
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 17:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbgG1Pvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 11:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731052AbgG1Pve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:51:34 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BE7C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:51:33 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id s189so13998175iod.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dH6pnqUmNf/i6iHZHPZfywyFLxvK6otPa1F0GV7pPjo=;
        b=lUyKTfB3WctkmeX1eVNXVJsib+4c9wLasaDqX42aNbolOJ/Db81up7EUZaq5uewE5y
         IYU3oqcYaUYZ454VgTeKMXmydqHpW3FyOYn/40dsD0ilLFMApi5T3FxPp+3rdDBh60FX
         AAuXKSKF3tYTwuqD/Gx4yfyKi94EvY5+Et/0l8HFOSUPhcTeNCKKXVZ04RennniWcntG
         BtkTCl7zFLu+lcTpQh0oNliQK/j/bKCKCakhJ6O37xgNOgI185wqYqZi4NWm8FubelAJ
         WdOnUnarGCi7BWPyCcpDKh1TIv1eHcyRwj1KpbE6KZHFT48Pl0SoKcfNqJWURzwsQoVN
         MoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dH6pnqUmNf/i6iHZHPZfywyFLxvK6otPa1F0GV7pPjo=;
        b=S7uhiLOs/dZ5g0X1iuVBGbqYtJQrGhrfrHOddQZBUcyDFPenpO2RYNEWgO7fcWskZw
         Vllh74JWJwd4itnSnOwKfwvEbZd60Cveumae0heLBaTyUpaexc5Y0CwGaHJmbTnELR4u
         dsoHukia+D1SHF+YhH7PYLr2DAoRIeQk37qnC0Asuejqu0G3039yPG4LHObKEYke5g8Y
         1f9qjksN/bJ5TNotyxLmgiNfMV54oZNFwYeJVwMhTTrwXFXcGLP/nv9vCtRJMXQFvZoX
         FbOSKpk14Yk3YhFgpdvJTGmJS7p6XP+OSM4VTUc5w1qy6gS5BzaWfgMR5SR0EylIJd0Q
         JjcQ==
X-Gm-Message-State: AOAM531EBRBvN/9ESyMNp9iKojuqPkt8jA/nen4jfoamuRBCsM5UeDLJ
        5cEk6Rq04eVGdcDmieHwLfI+3w==
X-Google-Smtp-Source: ABdhPJyYLGifiiVBXQbvt/BcnUbYuXMillxP6k4q0gn80oLYD1wDMGPlzF0lDW5ajNIzGkaOI+jY1g==
X-Received: by 2002:a02:5502:: with SMTP id e2mr32643518jab.56.1595951492249;
        Tue, 28 Jul 2020 08:51:32 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j4sm10596866iog.35.2020.07.28.08.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 08:51:31 -0700 (PDT)
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
 <9718954b-2152-1bc2-e702-ebe8799fdfb3@kernel.dk>
 <20200728051742.GA198538@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f8ae9a1a-ba89-497a-c539-30f3f6dac5e9@kernel.dk>
Date:   Tue, 28 Jul 2020 09:51:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728051742.GA198538@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/20 11:17 PM, Vaibhav Gupta wrote:
> On Mon, Jul 27, 2020 at 02:30:03PM -0600, Jens Axboe wrote:
>> On 7/27/20 12:11 PM, Vaibhav Gupta wrote:
>>> On Mon, Jul 27, 2020 at 11:59:05AM -0600, Jens Axboe wrote:
>>>> On 7/27/20 11:51 AM, Vaibhav Gupta wrote:
>>>>> On Mon, Jul 27, 2020 at 11:42:51AM -0600, Jens Axboe wrote:
>>>>>> On 7/27/20 11:40 AM, Vaibhav Gupta wrote:
>>> Yes, I agree. Actually with previous drivers, I was able to get help
>>> from maintainers and/or supporters for the hardware testing. Is that
>>> possible for this patch?
>>
>> It might be, you'll have to ask people to help you, very rarely do people
>> just test patches unsolicited unless they have some sort of interest in the
>> feature.
>>
>> This is all part of what it takes to get code upstream. Writing the code
>> is just a small part of it, the bigger part is usually getting it tested
>> and providing some assurance that you are willing to fix issues when/if
>> they come up.
>>
>> You might want to consider splitting up the patchset a bit - you could
>> have one patch for the generic bits, then one for each chipset. That
>> would allow you to at least get some of the work upstream, once tested.
>>
> I think I can break this patch into one commit per driver. The reason that
> all updates got into one single patch is that I made
> ata_pci_device_suspend/resume() static and exported just the
> ata_pci_device_pm_ops variable. Thus, all the driver using .suspend/.resume()
> had to be updated in a single patch.
> 
> First I will make changes in drivers/ata/libata-core.c, but won't make any
> function static. Thus, each driver can be updated in independent commits
> without breaking anything. And then in the last commit, I can hide the
> unnecessary .suspend()/.resume() callbacks. This will create patch-series of 55
> or 56 patches.
> 
> Will this approach work?

That should work, but more importantly, ensure you get some folks signed up
for testing this functionality.

-- 
Jens Axboe

