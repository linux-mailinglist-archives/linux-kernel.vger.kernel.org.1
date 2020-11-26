Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A2A2C5D8D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 22:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388678AbgKZVfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 16:35:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30894 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726178AbgKZVfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 16:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606426536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z982jnqmuXNIrAhimGtzkblqKSt24Z3qnI8EZ/1iDQY=;
        b=haJwrw/lHDJi6u7357ieuFEuzotNvbt9IjFVV8S88ui+F2R+1v+GgPSW6B8LB0IIIsrwwW
        hmZOwVQEIWbT9UIukwqGiZtT7YiFhWTqpH/zCqDjuQxBtPFV87xvr1cMUsuSNQgHkWmmeb
        FvCKeOsNUsabPDIRrOph1io96SqbY9M=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-Y23xNNg7NqiLq7oC30JAWw-1; Thu, 26 Nov 2020 16:35:34 -0500
X-MC-Unique: Y23xNNg7NqiLq7oC30JAWw-1
Received: by mail-pl1-f198.google.com with SMTP id bd1so2156334plb.22
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 13:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=z982jnqmuXNIrAhimGtzkblqKSt24Z3qnI8EZ/1iDQY=;
        b=PrCd9bCa3MlDGDXu69Imt2pETRjzMZKa35AB6ZMfWHtr710RQvdiOcGwDA1lDLT+T4
         puxNHgpm5s/bxqApylBlwgTfvMl7TUBd70ZlYOlbNZu0XydrXXsVwRgIye4HO0u1x+5J
         foFFrrKN3JOuGwee+p/50mL5Q4j3y9mUTKRlqYxBhVGWkhtL4ORHeoDxucrLeW0ChWoU
         WBF7aCfljL/bVpUN7S5dwAZwXMUga/I0KG2/c3KOHOeK7m7SOKPl45iWqEtidR8WrEeq
         TXCLdjaDj1TxoN9NpBDKjRpF2fECtHH0k/FYBojJlw276oBvOZc0tT/Tqv6+VD8y5pBO
         p4Ow==
X-Gm-Message-State: AOAM5307HQUETKnzrCCfwPw1LKFgE4iMAvjevFaq3v0WWXayNt4IdrWK
        LOYK9yBBx36HsQiRYPYPJL4CB108prCBQFpa0cFKICWUcfb7+xAlLww5W4qKGE3G8wNwSfc1c2m
        QpE/1JryZSSFL3/IxOJWpYyW1
X-Received: by 2002:a17:90a:de86:: with SMTP id n6mr5636642pjv.214.1606426533157;
        Thu, 26 Nov 2020 13:35:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAlUToijww7RFSIadHfTUIsFRgP0jROP7USN5shf1kH7HUlqvESAgcIckwBz8UQwmCwAYwNw==
X-Received: by 2002:a17:90a:de86:: with SMTP id n6mr5636628pjv.214.1606426532884;
        Thu, 26 Nov 2020 13:35:32 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id z126sm5587671pfz.120.2020.11.26.13.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 13:35:31 -0800 (PST)
References: <87h7pd6v2k.fsf@redhat.com>
 <bd1fd204-3596-b16c-5617-7e691ceac83b@linux.intel.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, stable@kernel.vger.org
Subject: Re: Question about domain_init (v5.3-v5.7)
In-reply-to: <bd1fd204-3596-b16c-5617-7e691ceac83b@linux.intel.com>
Date:   Thu, 26 Nov 2020 14:35:30 -0700
Message-ID: <87a6v3hkd9.fsf@jsnitsel.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lu Baolu @ 2020-11-26 04:01 MST:

> Hi Jerry,
>
> On 2020/11/26 4:27, Jerry Snitselaar wrote:
>> Is there a reason we check the requested guest address width against
>> the
>> iommu's mgaw, instead of the agaw that we already know for the iommu?
>> I've run into a case with a new system where the mgaw reported is 57,
>> but if they set PAE to 46 instead of 52 in the bios, then sagaw reports
>> the highest supported agaw is 48 and the domain_init code fails here. In
>
> Isn't this a platform bug? If it's too late to fix it in the BIOS, you
> maybe have to add a platform specific quirk to set mgaw to the highest
> supported agaw?
>
> Best regards,
> baolu

Is there somewhere you can point me to that discusses how they should be
setting the mgaw? I misunderstood when I previously asked you about
whether the mgaw could be a value that was greater than any of sagaw.
If it is a bios issue, then they should fix it there.

>
>> other places like prepare_domain_attach_device, the dmar domain agaw
>> gets adjusted down to the iommu agaw. The agaw of the iommu gets
>> determined based off what is reported for sagaw. I'm wondering if it
>> can't instead do:
>> ---
>>   drivers/iommu/intel-iommu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> diff --git a/drivers/iommu/intel-iommu.c
>> b/drivers/iommu/intel-iommu.c
>> index 6ca5c92ef2e5..a8e41ec36d9e 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -1862,8 +1862,8 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
>>   	domain_reserve_special_ranges(domain);
>>   	/* calculate AGAW */
>> -	if (guest_width > cap_mgaw(iommu->cap))
>> -	        guest_width = cap_mgaw(iommu->cap);
>> +	if (guest_width > agaw_to_width(iommu->agaw))
>> +	        guest_width = agaw_to_width(iommu->agaw);
>>   	domain->gaw = guest_width;
>>   	adjust_width = guestwidth_to_adjustwidth(guest_width);
>>   	agaw = width_to_agaw(adjust_width);
>> --
>> 2.27.0
>> 
>> Thoughts? With the former code the ehci device for the ilo fails when
>> trying to get a private domain.
>> Thanks,
>> Jerry
>> 

