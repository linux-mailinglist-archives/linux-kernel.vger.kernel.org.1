Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E297F2C8BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387817AbgK3Rve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:51:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51876 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387411AbgK3Rve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:51:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606758607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HSCV7T+Nrw6Gul8hhY06LNx7QhAZMZ6fOF3OCzdbisE=;
        b=Tys5SdwTaNUH+aui1dhaTifh5z1MLFeU7jFI+ynRCvJ3L4IjFXLxJSoLWOhVDQp8T6lWe0
        zfxYYq8f30MHy2IiUyEuPdFu3k/JKhuPVV4JjzgnyufKw/T/K0eL5tvsX5Rsih39W1FJiZ
        UtDUIbJhRxUaZAsX3qCdavruAHU7SEo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-6baJMqMxP9-QGjEcY3qq_A-1; Mon, 30 Nov 2020 12:50:04 -0500
X-MC-Unique: 6baJMqMxP9-QGjEcY3qq_A-1
Received: by mail-qk1-f198.google.com with SMTP id u67so1056632qkd.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 09:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=HSCV7T+Nrw6Gul8hhY06LNx7QhAZMZ6fOF3OCzdbisE=;
        b=szLPleCccHDq7YX6LUnb1rDfvy5OAn9WiZ/7wVnwTo0ovXGbtvI4yDdnKh8DPb0ctj
         gE3uv8iUpd7+80Dxmxbsd3Y8wOElp30IL4ljODN4Z0FUGmnthkcIwwsyimSlPezojD1V
         Ax2l7MkX4BBOPql4sup/oSe4sBGVw2rqFZMSo78rRhC6t7gAP1taZdBbosacDzSG+pyK
         hRK/m0L0k2g8nAp2j2Cs6pYYRiKyYUCYXMI+RAxWYadDwxqINvu9HTO8TH6lyAq1c8Ug
         DmkpqlHmUajmx21RSftSSTE6wRiq50gM85YSkeUfSUPEJRHjqRiDYuEnPjD1t1SitgB/
         MXCQ==
X-Gm-Message-State: AOAM5308hO4wLtEHfMWizg/m8hRYoKnRyylSi0YzwlXoFLLr6PL7j1Ng
        aW3J8ECtetURUWiy8ggPDODaS2qcE/7ySM4ppz20AaTZ/Zc/lfWr+yjVc7Svjjn3CGwEzKLaeHy
        DR7puZVCxIR/4iqBg+ZdzM56C
X-Received: by 2002:ac8:588e:: with SMTP id t14mr22837100qta.375.1606758603656;
        Mon, 30 Nov 2020 09:50:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzeE1KMRYS8ZnehWgh0wHCpn3AyJ9/3hJkmwxezbbi5OKJ+2cW7RrT9y4YlUKC7CiuoaENtYA==
X-Received: by 2002:ac8:588e:: with SMTP id t14mr22837070qta.375.1606758603403;
        Mon, 30 Nov 2020 09:50:03 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id w65sm16073360qtd.94.2020.11.30.09.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 09:50:02 -0800 (PST)
References: <87h7pd6v2k.fsf@redhat.com>
 <bd1fd204-3596-b16c-5617-7e691ceac83b@linux.intel.com>
 <87a6v3hkd9.fsf@jsnitsel.users.ipa.redhat.com>
 <72a7b338-2481-8c0a-5641-6f448557f6ee@linux.intel.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, stable@kernel.vger.org
Subject: Re: Question about domain_init (v5.3-v5.7)
In-reply-to: <72a7b338-2481-8c0a-5641-6f448557f6ee@linux.intel.com>
Date:   Mon, 30 Nov 2020 10:50:01 -0700
Message-ID: <87r1oaka46.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lu Baolu @ 2020-11-26 19:12 MST:

> Hi Jerry,
>
> On 11/27/20 5:35 AM, Jerry Snitselaar wrote:
>> Lu Baolu @ 2020-11-26 04:01 MST:
>> 
>>> Hi Jerry,
>>>
>>> On 2020/11/26 4:27, Jerry Snitselaar wrote:
>>>> Is there a reason we check the requested guest address width against
>>>> the
>>>> iommu's mgaw, instead of the agaw that we already know for the iommu?
>>>> I've run into a case with a new system where the mgaw reported is 57,
>>>> but if they set PAE to 46 instead of 52 in the bios, then sagaw reports
>>>> the highest supported agaw is 48 and the domain_init code fails here. In
>>>
>>> Isn't this a platform bug? If it's too late to fix it in the BIOS, you
>>> maybe have to add a platform specific quirk to set mgaw to the highest
>>> supported agaw?
>>>
>>> Best regards,
>>> baolu
>> Is there somewhere you can point me to that discusses how they
>> should be
>> setting the mgaw? I misunderstood when I previously asked you about
>> whether the mgaw could be a value that was greater than any of sagaw.
>> If it is a bios issue, then they should fix it there.
>
> MGAW indicates the max gpa width supported by 2nd translation. The VT-d
> spec requires that this value must be at least equal to the host
> physical addressibility. According to this, BIOS is good, right?
>
> For this failure case, domain_init() just wants to find a suitable agaw
> for the private domain. I think it makes sense to check against
> iommu->agaw instead of cap_mgaw.
>
> Best regards,
> baolu
>

From this bit in the spec about MGAW:

    Guest addressability for a given DMA request is limited to the
    minimum of the value reported through this field and the adjusted
    guest address width of the corresponding page-table structure.
    (Adjusted guest address widths supported by hardware are reported
    through the SAGAW field).

That does suggest it should be adjusted down to the sagaw value in this case, yes?
Just want to make sure I'm understanding it correctly.

>> 
>>>
>>>> other places like prepare_domain_attach_device, the dmar domain agaw
>>>> gets adjusted down to the iommu agaw. The agaw of the iommu gets
>>>> determined based off what is reported for sagaw. I'm wondering if it
>>>> can't instead do:
>>>> ---
>>>>    drivers/iommu/intel-iommu.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>> diff --git a/drivers/iommu/intel-iommu.c
>>>> b/drivers/iommu/intel-iommu.c
>>>> index 6ca5c92ef2e5..a8e41ec36d9e 100644
>>>> --- a/drivers/iommu/intel-iommu.c
>>>> +++ b/drivers/iommu/intel-iommu.c
>>>> @@ -1862,8 +1862,8 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
>>>>    	domain_reserve_special_ranges(domain);
>>>>    	/* calculate AGAW */
>>>> -	if (guest_width > cap_mgaw(iommu->cap))
>>>> -	        guest_width = cap_mgaw(iommu->cap);
>>>> +	if (guest_width > agaw_to_width(iommu->agaw))
>>>> +	        guest_width = agaw_to_width(iommu->agaw);
>>>>    	domain->gaw = guest_width;
>>>>    	adjust_width = guestwidth_to_adjustwidth(guest_width);
>>>>    	agaw = width_to_agaw(adjust_width);
>>>> --
>>>> 2.27.0
>>>>
>>>> Thoughts? With the former code the ehci device for the ilo fails when
>>>> trying to get a private domain.
>>>> Thanks,
>>>> Jerry
>>>>
>> 

