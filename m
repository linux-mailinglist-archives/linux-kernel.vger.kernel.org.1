Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0F3304EEE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392128AbhA0B2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:28:54 -0500
Received: from relay.smtp-ext.broadcom.com ([192.19.221.30]:46782 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390551AbhAZSbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:31:24 -0500
Received: from [10.136.13.65] (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 6D5B97DAE;
        Tue, 26 Jan 2021 10:30:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6D5B97DAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1611685820;
        bh=w9u36Tqbr1gtxIpbNcHJrRfi7XevX07wJWUk96CDaJI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aQW6BiW6ypHXSRdZ/hyr3b5BmbnUubSvQiVzM4uv2glxMnDDX5ZOPsV3UdTafyrvy
         cklVuaeDgqgJWPLhr/6de+RbqfLN1ATY3vaR+bDDfY/QLS73Lm4GsWx2hw01LYudhS
         MlHbzXnTszhIxmUbtxmAy4fI+jGaIWr/ceHNEud0=
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
Date:   Tue, 26 Jan 2021 10:30:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YA/E1bHRmZb50MlS@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,


On 2021-01-25 11:29 p.m., Greg Kroah-Hartman wrote:
> On Mon, Jan 25, 2021 at 11:55:11AM -0800, Scott Branden wrote:
>> Hi All,
>>
>> The 5.10 LTS kernel being officially LTS supported for 2 years presents a problem:
>> why would anyone select a 5.10 kernel with 2 year LTS when 5.4 kernel has a 6 year LTS.
> Because they want to use all of the latest stuff that 5.10 provides
> them.  Don't you want faster and more secure kernels for your devices?
Yes, 5.10 is a more secure and less buggy kernel than 5.4.
You don't need to convince me which is the better kernel to start using.
The kernel improves every version and we are at a point where regressions rarely happen.
But, it is not our choice what version a customer chooses as they have many valid reasons to stabilize their code.
They do have extensive QA cycles to go through and cannot simply pick up a newer kernel version to get a security fix or bug fix.
As everyone, we also have testing and cannot test every kernel version extensively so must choose wisely what to test.
We also track the mainline a test as well to ensure functionality - but stress testing is not done at the same level as a full QA cycle.
Unfortunately some people think that 5.4 LTS is more stable than 5.10.  And it also has a longer lifetime.
So, people starting a new project today decide to use 5.4 (or even earlier) kernels as they deem these stable.
For these reasons we would be forced to backport (upstreamed code) to an old kernel for new features and processors, etc not supported in 5.4.
You can see how such a kernel would not be as stable as 5.10 if a single subtle fix is not backported.  But, try convincing people to go with 5.10 with only a 2 year LTS lifespan vs. 5.4 with many more years.
Hopefully you understand the kernel is not the product - the end solution is what is tested and QA'd.
And, picking up small, safe LTS versions requires a much smaller QA cycle than a kernel upgrade with thousands of possible changes in the code every kernel version.
>
>> Yet, various unofficial reports indicate it will be supported for 6 years.
> Rumors are nice, aren't they :)
>
>>   And AOSP has already declared the use
>> of 5.10 kernel in their Android S and T releases.
> Publically?  Where?  And is that really the name of the new Android
> releases, I thought they switched to numbers now (hence the naming of
> the current android-common kernel branches, marketing is fun...)
https://source.android.com/devices/architecture/kernel/android-common
Feature and launch kernels provides kernels supported per version.
>
>> Is there some way we could make the LTS support more clear.
>> A 2 year declaration is not LTS any more.
> Not true at all, a "normal" stable kernel is dropped after the next
> release happens, making their lifespan about 4 months long.  2 years is
> much longer than 4 months, so it still is a "long term supported" kernel
> in contrast, correct?
Perhaps a new name needs to be made for "LTS" for 6 years to distinguish it from 2 years.
The timeframes are very different.
>
>> If 5.10 is "actually" going to be supported for 6 years it would be quite valuable to make such a declaration.
>> https://www.kernel.org/category/releases.html
> Why?  What would that change?
>
> Ok, seriously, this happens every year, and every year we go through the
> same thing, it's not like this is somehow new, right?
No, but why do we need to keep playing the same game every year now.
>
> I want to see companies _using_ the kernel, and most importantly,
> _updating_ their devices with it, to know if it is worth to keep around
> for longer than 2 years.  I also, hopefully, want to see how those
> companies will help me out in the testing and maintenance of that kernel
> version in order to make supporting it for 6 years actually possible.
>
> So, are you planning on using 5.10?  Will you will be willing to help
> out in testing the -rc releases I make to let me know if there are any
> problems, and to help in pointing out and backporting any specific
> patches that your platforms need for that kernel release?
> When I get this kind of promises and support from companies, then I am
> glad to bump up the length of the kernel support from 2 to 6 years, and
> I mark it on the web site.  Traditionally this happens in Febuary/March
> once I hear from enough companies.  Can I count on your support in this
> endeavor?
It is a chicken and egg problem and 2 year LTS declaration is not helping customers commit to 5.10.
We are using 5.10 right now and testing it.  But, we don't make the end products.
If customers decide to use 5.10 we will continue to test, support, and backport any specific patches to it.
If they choose 5.4 that would be the one we would have to backport and try and support.
The backport is not just for simple drivers.
VFIO, IOMMU, and other unidentified architecture support would need to be backported.

So 5.10 is the much better decision to pickup any LTS fixes in the future.

LTS 6 year support isn't the only decision factor though but makes it a showstopper
in convincing some management decisions for those not savvy with kernel LTS support.
Yes, customers have their own code they add to the kernel which we never see.
Unfortunately "they have other products on old LTS version".
So we need to convince them to move to new kernel version AND port their code.
>
> Also, a meta-comment.  Please reconsider using a single kernel version
> for longer than 2 years on systems that you actively support and
> maintain.  It's generally a bad idea unless you are stuck with millions
> of out-of-tree code that something like a customer-unfriendly SoC vendor
> provides.  If you are stuck in that type of situation, well they have
> decided to spend extra money to keep their out-of-tree code alive, so
> why are they forcing you to also spend extra money and energy?
Obviously a management decision out of supplier's complete control.
>
> I can go on about this topic at length if you want me to, I have lots of
> examples of how to, and not to, maintain a kernel for a device for a
> long period of time...
You don't need to convince me.
>
> thanks,
>
> greg k-h

