Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA8A2C60A4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 08:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388442AbgK0Hsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 02:48:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726408AbgK0Hsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 02:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606463311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uJsKVULyl1licVBjvw9GEXplfoS+3MJJrDnW+L+outs=;
        b=XbWhkBO0huENf76fgloHZbCSiBQ9i43X+WNBsfYQtmQDmEKuUAVxTlAF5SjAjR/med252p
        qxeFj68U70v+K3AKaQHB3L7EsBMZJPGBFe2pimqkr4qvVnupyWUuQXHpuwLeX6IV9Of6Gr
        6WFfrPEH/8w6V5lVZTMNZ1VyITGfgh4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-14UZVsf9Mqu8cDHhTT_y3w-1; Fri, 27 Nov 2020 02:48:29 -0500
X-MC-Unique: 14UZVsf9Mqu8cDHhTT_y3w-1
Received: by mail-pf1-f199.google.com with SMTP id j145so3424063pfd.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 23:48:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=uJsKVULyl1licVBjvw9GEXplfoS+3MJJrDnW+L+outs=;
        b=m/rp6Bsn2CmWDn15ujQu2vFwp+NO56ZFq92hAhr0D578k7yp+TDV6Jxq8DxcOrsYdE
         Pc+RzRgvSpO9KtDo/YiFoFbIrCzfhgXHZxwrdrWAWU4MxKQbpH9adw/zf8pZxFYG5E1W
         WLtZfZ0saCkKRmeR1Cnf3xdEdfHWv4lBY7iPXmvx7wh/IALYKWL9XvUY5VRnGgSh/mBX
         j+akmmN6tYASp8gipRdkgAbMe3KFTQaLdX2KuRpnlWeWZILaYnxCD0mlLSmJZT/bn8Ks
         mzzZSBHw4vlk69ksLtecuIZKQarQLK7ED4OGuKpVLOk58q5R1iLnQYAYQgJ2OhMxVddF
         bGEw==
X-Gm-Message-State: AOAM53226J6NjAXgTnCo1aoLy2nVkltNLvzwxbONUkg1fF/jSjqoR61F
        IMmghIjowkpv/bpj1NDwr+bOb4YucPMzPncdfwN3MtGHv6KOQffksyDl8b9TQDXHnW22qGgkm2g
        eJcqVeErlBIM9G8DxqzB+UJ6o
X-Received: by 2002:a62:ab0f:0:b029:197:f771:fe8e with SMTP id p15-20020a62ab0f0000b0290197f771fe8emr6026845pff.65.1606463307722;
        Thu, 26 Nov 2020 23:48:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwGG48pY/5mk4xwZDkQuI9zFSfHVl0aycrAZ7jYEAuS/IBOHT3O3tmmGQmXvvIcOEVeSnyoAg==
X-Received: by 2002:a62:ab0f:0:b029:197:f771:fe8e with SMTP id p15-20020a62ab0f0000b0290197f771fe8emr6026827pff.65.1606463307401;
        Thu, 26 Nov 2020 23:48:27 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id e2sm1632021pjt.2.2020.11.26.23.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 23:48:26 -0800 (PST)
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
Date:   Fri, 27 Nov 2020 00:48:25 -0700
Message-ID: <877dq7grzq.fsf@jsnitsel.users.ipa.redhat.com>
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

Yes, the host address width is 46. MGAW reports 57 (56+1), and highest
sagaw bit is for 48.


> For this failure case, domain_init() just wants to find a suitable agaw
> for the private domain. I think it makes sense to check against
> iommu->agaw instead of cap_mgaw.
>
> Best regards,
> baolu
>
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

