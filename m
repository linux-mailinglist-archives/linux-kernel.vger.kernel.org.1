Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946C0304611
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394259AbhAZSOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389431AbhAZRgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:36:32 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFAAC061786
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 09:35:52 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id u15so961644plf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 09:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KQvASRmNKFSWsDwOaap5cWnlk031PDjPZ49o7+UJUBk=;
        b=n79mS6gaeRO4crm7wYHfr3oFNZ3vvCjPoPrt3s/wEGofawW/WreFh3E4zGKb7+N6Wh
         aDf8/YOKrQvFWyAad3XRXqdK1nSdz1kZ9ogo+odVtM9frFXzVjCzOL9ho2P2z0Yfq+xG
         c9PwjsnvQYfD9sgsKngw8NOtOU3De5d0d0XztGc0DbePH5CvQ9BPX+dqrb7/62G3NdqY
         uAj7nSzA3SfLBzRe+OFAqqfrtC4FERCIA/rNNML09fJvU/aYeKf3iU8Dp1z5e5Rmaz9k
         8lBdev3ut1q4huOOZrWXkiB30bYocRtPnspFENgPbeaAllLKfK+QOn5C8dYw5XiVsGCc
         J6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KQvASRmNKFSWsDwOaap5cWnlk031PDjPZ49o7+UJUBk=;
        b=SHGdxGyHC8f4giVG3R2VQpN/mRWIjVZqZDS4wQErPbuE4zA6zJQIdgtBz3Ovfo15KP
         KV7V1kzqkvohUWQq6JcqMvRINBI0hNAervKVsDRxZd3xyn7JQPTK27wftdvhr8i3Pevo
         7a51vX+BmL3pKv71Q11syAbuIkda1c/jQxyaFDXIzXaz0cwxY7NhLIAXuJo0JgtFHqAg
         CWt90rthZRYIVJDUhQJzR+iiZTznYvlxrYMzhcM5Il9Gqd96q+3c0JfUzrExm4VK2dWz
         2nJ36oobw4c4RM6u/29x6UbIvLY/Xdhnh1Chzf948D0zl9GdVju9EUb3oEWla/3G+hbG
         AGTw==
X-Gm-Message-State: AOAM531A0uua4C+czvwhwL1LyWY8xzX5xS1tDvCIxVS4BR+N/AfinY1X
        pHnOt4W3vaVOckfMuRDu3Zs=
X-Google-Smtp-Source: ABdhPJyhKOqn3rv3nga0EhI4URdf+3JZ5wyef5MOj4spgFted3t2Cu14A9DMrpkv8lqD5N0gTU+n+w==
X-Received: by 2002:a17:90b:1004:: with SMTP id gm4mr868360pjb.97.1611682551545;
        Tue, 26 Jan 2021 09:35:51 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c3sm19628438pfj.105.2021.01.26.09.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 09:35:50 -0800 (PST)
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e4a9fbc1-93d5-608e-44f4-45c9b64b3503@gmail.com>
Date:   Tue, 26 Jan 2021 09:35:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YA/E1bHRmZb50MlS@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/2021 11:29 PM, Greg Kroah-Hartman wrote:
> On Mon, Jan 25, 2021 at 11:55:11AM -0800, Scott Branden wrote:
>> Hi All,
>>
>> The 5.10 LTS kernel being officially LTS supported for 2 years presents a problem:
>> why would anyone select a 5.10 kernel with 2 year LTS when 5.4 kernel has a 6 year LTS.
> 
> Because they want to use all of the latest stuff that 5.10 provides
> them.  Don't you want faster and more secure kernels for your devices?
> 
>> Yet, various unofficial reports indicate it will be supported for 6 years.
> 
> Rumors are nice, aren't they :)
> 
>>   And AOSP has already declared the use
>> of 5.10 kernel in their Android S and T releases.
> 
> Publically?  Where?  And is that really the name of the new Android
> releases, I thought they switched to numbers now (hence the naming of
> the current android-common kernel branches, marketing is fun...)
> 
>> Is there some way we could make the LTS support more clear.
>> A 2 year declaration is not LTS any more.
> 
> Not true at all, a "normal" stable kernel is dropped after the next
> release happens, making their lifespan about 4 months long.  2 years is
> much longer than 4 months, so it still is a "long term supported" kernel
> in contrast, correct?
> 
>> If 5.10 is "actually" going to be supported for 6 years it would be quite valuable to make such a declaration.
>> https://www.kernel.org/category/releases.html
> 
> Why?  What would that change?

I believe what Scott is looking for is a form of official statement that
indicates that 5.10 is indeed a 6 years Long Term Stable kernel, as
opposed to an informal piece of information like this:

https://twitter.com/kernellogger/status/1320731458311491587

(personally that is how I got to hear about 5.10 being selected, taking
this with a grain of salt).

> 
> Ok, seriously, this happens every year, and every year we go through the
> same thing, it's not like this is somehow new, right?

It is not new indeed but there is a recurring pattern, and I have been
told by some of our customers who use the kernel.org's releases.html
page that this is how they know which kernel is going to be LTS and plan
ahead accordingly.

If you feel making such a statement actually hurts the kernel project as
a whole, or sort of steers people into cramming all of their desired
features/bug fixes towards particular versions of the kernel that may,
or may not be 6 years LTS, that may be an argument against announcing
before, but maybe not after the kernel is released?

> 
> I want to see companies _using_ the kernel, and most importantly,
> _updating_ their devices with it, to know if it is worth to keep around
> for longer than 2 years.  I also, hopefully, want to see how those
> companies will help me out in the testing and maintenance of that kernel
> version in order to make supporting it for 6 years actually possible.

This really depends on which market you are in we have (Set-top-box and
cable modem) customers that do *want* to use newer kernels but are so
slow in adopting new ones that by the time they start the kernel has
already been phased out 2 years ago.

We have worked (and are still working) with a customer who wanted so
badly 4.1 they rattled our whole organization and had my team on call to
get there, only to start working on it seriously in 2019. The problem
was not necessarily the SoC vendor but the various OEMs and their bigger
pile of out of tree patches and the fact that the platforms were so old
that the essential knowledge of all of their little details was gone
(fired, retired, moved on) already.

6 years provides a great window of time for people to get to a quality
production with the kernel while offering enough time for slow users to
transition over and yet still have a comfortable window of updates. 2
years is a bit too short and will result in the SoC vendor or whoever
gets paid for to either continue support and maybe endorse the
responsibility of doing critical back ports themselves (meltdown,
spectre, etc.) with all the implied liability, or completely drop
support for the unmaintained kernel. In both situations, the device's
security is not as great as if a 6 years LTS kernel had been chosen.

People who can jump on the 2 year stable kernel will, and those who
cannot will not, so having 6 years is a good way to avoid skipping too
much yet try to live with what is/was current at the time.

> 
> So, are you planning on using 5.10?  Will you will be willing to help
> out in testing the -rc releases I make to let me know if there are any
> problems, and to help in pointing out and backporting any specific
> patches that your platforms need for that kernel release?
> 
> When I get this kind of promises and support from companies, then I am
> glad to bump up the length of the kernel support from 2 to 6 years, and
> I mark it on the web site.  Traditionally this happens in Febuary/March
> once I hear from enough companies.  Can I count on your support in this
> endeavor?

I cannot comment on Scott's plan since we don't work in the same
business group, however we have active customers on Set-top-box and
cable modem devices that actively use the 4.9, start adopting 5.4 now
and by the end of this year the 5.10 kernel and I believe you do see me
requesting specific patches to be included once in a while ;). These
customers are a mix of RDK video, Android and just custom made Linux,
they all want a 6 years LTS kernel though because it puts them on a
support timeline they can work with given their pace and kernel expertise.

> 
> Also, a meta-comment.  Please reconsider using a single kernel version
> for longer than 2 years on systems that you actively support and
> maintain.  It's generally a bad idea unless you are stuck with millions
> of out-of-tree code that something like a customer-unfriendly SoC vendor
> provides.  If you are stuck in that type of situation, well they have
> decided to spend extra money to keep their out-of-tree code alive, so
> why are they forcing you to also spend extra money and energy?

We may get paid extra money by said customers to keep maintaining
whatever old kernel they have because it still is cheaper for them than
doing new shipments and deployments of devices in the field. This means
we sell fewer devices to them for a while, but by the same token we have
exclusivity for a while and do not yet open up a window for a new
project to be with a different vendor. Is not that great conflict of
self interest?

The other thing that we have seen, especially with Android is that you
start a project on one of the 3 kernels maintained at the time, get to
market, get maintenance updates on a branch (so many branches) and
that's it, no more updates for you, which is where the 6 year LTS is
sort of handy.

PS: the usual stuff: I am not expressing ideas from my employer here,
just my own.
-- 
Florian
