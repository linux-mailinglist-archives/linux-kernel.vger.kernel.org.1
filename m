Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F13C2CD573
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 13:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbgLCMYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 07:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgLCMYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:24:31 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AADC061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 04:23:51 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id f9so573786pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 04:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F8MVWeCRClr1yXty0PKunJoMG8zS3pGEs0D4DriH35A=;
        b=dyCIm6ORxo97pDQfbFUu9cqPhxzTI2zO3Gvokhs8JZN6E49HOpGZo6iC9l926FOxDM
         tZZK/OozkiRHmA3V6KPexlOrqXo/UDpeTmVKXsnmSbRdmxOCrwd15/VRFIX3mLkgGQM3
         s3gw9sILQzxFBBICVNhPh4WhMc0TiKw/OD/G0am3L2PqqNydwGqkGN30rFar4i36fNqR
         wGIjW+NcrsqdKJZ/RtKqacFXNxB0F9NzEgnUl41uaPMxGlAeE4/HwtpgUmLFTXEQaX58
         eS8Phcp6x950G8WBafPeZrrAUUTQQBs/xH9oSUEAmIcF5tjFzSaPB8mOEn82rXnh96oj
         ca4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F8MVWeCRClr1yXty0PKunJoMG8zS3pGEs0D4DriH35A=;
        b=TbxzPjWYj/Ly0JgdoAp6cDW3C21MLfWiMi/MT2x+bGVrh42dTqiMhKBmofLbyWil5L
         YduNRcbK9UJyJHOlhZBxCW3mLLup29vxW9D9BWzmsO+2eJ2pkp9GeDB89YzeZj1HOKH4
         MOcsdIqje99QXcUQEk50ymBhDRC9H/QUQxILP8X2vTxtm/4/NRwI8Fw/tV14vrqQMFUD
         JN5U8MBuyC7Hb0tZumEr/JFtwNOdl6UyKOhUKE7SONfy5gKYfTBeASmjzjXD9NiErCtg
         /kpY1YRbNBORgdRUBLSUj70HL5O3VV67ArufU/CknH/NIQ7BXX5N0UcG7Yp4MxSLcjkK
         WW+g==
X-Gm-Message-State: AOAM531FXh/FeANzEK0J/l7fv+d694Y3p9OxPND6Z8e1Cs9aLB6GhHT6
        Qpa3TbPi8pe91piuf915WPUxGORWcivLgNDq
X-Google-Smtp-Source: ABdhPJyPx5ij6Pn7UHdIQ1geZvaL4KUCb2taIUUHh6mRDENln3v5QDk4VDk1vqC6tSTer86yncoUQg==
X-Received: by 2002:a62:2683:0:b029:19a:9594:1abe with SMTP id m125-20020a6226830000b029019a95941abemr999212pfm.19.1606998230925;
        Thu, 03 Dec 2020 04:23:50 -0800 (PST)
Received: from [192.168.43.245] ([42.111.136.176])
        by smtp.gmail.com with ESMTPSA id s7sm1316750pju.37.2020.12.03.04.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 04:23:50 -0800 (PST)
Subject: Re: [PATCH -mmots] checkpatch: add fix for non-standard signature -
 co-authored-by
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <280235acc0e91365f3fd3b5be5a5244eced1ff61.camel@perches.com>
 <20201202183045.9309-1-yashsri421@gmail.com>
 <5afbcd1423ee8fc2dfad191d94aef6efc17198c8.camel@perches.com>
 <a2c74693-93ae-cd5a-7836-4ffff643fc09@gmail.com>
 <CAKXUXMxPMdGmnOWdYnS0VQXaAH9dTe7uNfUUPp-GLy2xTXuABw@mail.gmail.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <2c0c1501-4e53-85a6-94d5-2082f8e98885@gmail.com>
Date:   Thu, 3 Dec 2020 17:53:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKXUXMxPMdGmnOWdYnS0VQXaAH9dTe7uNfUUPp-GLy2xTXuABw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/20 4:29 pm, Lukas Bulwahn wrote:
> On Thu, Dec 3, 2020 at 10:59 AM Aditya <yashsri421@gmail.com> wrote:
>>
>> On 3/12/20 12:26 am, Joe Perches wrote:
>>> On Thu, 2020-12-03 at 00:00 +0530, Aditya Srivastava wrote:
>>>> Currently, checkpatch.pl warns us for BAD_SIGN_OFF on the usage of
>>>> non-standard signatures.
>>>>
>>>> An evaluation on v4.13..v5.8 showed that out of 539 warnings due to
>>>> non-standard signatures, 43 are due to the use of 'Co-authored-by'
>>>> tag, which may seem correct, but is not standard.
>>>>
>>>> The standard signature equivalent for 'Co-authored-by' is
>>>> 'Co-developed-by'.
>>>
>>> I'm not going to ack this as I don't mind non-standard signatures.
>>>
>>
>> What do you suggest?
>> Should I drop this patch and move on?
>>
> 
> Joe does not ack this, but he also does not nack it.
> 
> You either move on (which is perfectly fine), or
> 
> you either wait that Andrew Morton reviews it and accepts it because
> he thinks it useful, or
> 
> you reach out to the git committers that have been using
> Co-authored-by in the past and ask them if this kind of feature would
> have been helpful for them and you get an ack from them that convinces
> Andrew Morton to pick this.
> 
> I hope this helps. If nobody thinks it is a useful feature, move on to
> work others acknowledge as useful. We have enough stuff to work on.
> 

Okay. I get it now. Thanks a lot Lukas :)

--
Aditya

> Lukas
> 
