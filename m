Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB2D2DDB2D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 23:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbgLQWEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 17:04:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727132AbgLQWEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 17:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608242592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C0sgbGiFG7XgKZ99IeYyXSL6vj+ZYcARGRfsHU94m7Y=;
        b=iWfJx2GUrHUBWNMxuc1gCqS15JYhvKtJbClq/zd4TCJeF5KU/7dYRNdksHcWxvgWFrHfuo
        U8PSX0oUSovbv9t613i/yUzDvYRVLlLwfpSf082v4vxYUtB8dbx212gix/l5Fw2xJxiW2n
        9VPC334D4yGUdITFOTzKJb5oi2xHJCo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-34ybj2CaNRO62ZmuCVfwIg-1; Thu, 17 Dec 2020 17:03:10 -0500
X-MC-Unique: 34ybj2CaNRO62ZmuCVfwIg-1
Received: by mail-qk1-f197.google.com with SMTP id v66so188461qkh.16
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 14:03:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=C0sgbGiFG7XgKZ99IeYyXSL6vj+ZYcARGRfsHU94m7Y=;
        b=syd3JYNlw4/1NhBwmWOklRnARSPJ7+TeQkfCCknQUKs/bZM//Jhg4ycGp+jJkdJD7T
         glaJxIvjIVJ3l8KqZ7fyrEDWiKUnoDjbapHseiyhfCi8nS1tc3MTn3tFWtHIGrwHWRd7
         76daDnWP207A19UcCqKSShUR7OEJZn7rep0a9N0iS5bcJmwjzENyLGRPG5stE28WjYu5
         /pHBHykbMfuwNLhQLIcA3jazA6TLlDLy8Jr4IIm4xUGYGLps/a4uS+3i07GfSe52F1he
         M5rf3FE1qM3/8FFe3xzKSZlu+Xc0ArCi4hcxR1fGoqH4ws7e8l+lB8tmGxPRCYcSuwZb
         gzDg==
X-Gm-Message-State: AOAM530ac71M3Wp6ZDnaUfDEhOruAQ1zELvNY/OOMgn9X+IV3xKdqshY
        B8/Wda5oxQRx9LmCBrKZx1DloOa5nP8fHWwksK/od+Ihp5WaNYxOH7XEy8c5NhNCBWlaGoM+sNd
        8G/FlRDKqU7yFIACA67bfDrUyy7mL6YFhA4Af7TBNeDl5VjijIXqpNtYAS/LeHtoCPNMWGbo=
X-Received: by 2002:a37:a1d6:: with SMTP id k205mr1573196qke.384.1608242589758;
        Thu, 17 Dec 2020 14:03:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmkx2if7Kw2NwuxIsapTJwjnUAUWq9916p4JEscDmDC0JfDUcetA9R7rcyXDUDXWXhtiYy9g==
X-Received: by 2002:a37:a1d6:: with SMTP id k205mr1573171qke.384.1608242589530;
        Thu, 17 Dec 2020 14:03:09 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x134sm2488905qka.1.2020.12.17.14.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 14:03:08 -0800 (PST)
Subject: Re: [PATCH] atm: ambassador: remove h from printk format specifier
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201215142228.1847161-1-trix@redhat.com>
 <20201216164510.770454d8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <6ada03ed-1ecb-493b-96f8-5f9548a46a5e@redhat.com>
 <20201217092816.7b739b8c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <ae7d363b-99ec-d75f-bae3-add3ee4789bd@redhat.com>
Date:   Thu, 17 Dec 2020 14:03:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201217092816.7b739b8c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/17/20 9:28 AM, Jakub Kicinski wrote:
> On Thu, 17 Dec 2020 05:17:24 -0800 Tom Rix wrote:
>> On 12/16/20 4:45 PM, Jakub Kicinski wrote:
>>> On Tue, 15 Dec 2020 06:22:28 -0800 trix@redhat.com wrote:  
>>>> From: Tom Rix <trix@redhat.com>
>>>>
>>>> See Documentation/core-api/printk-formats.rst.
>>>> h should no longer be used in the format specifier for printk.
>>>>
>>>> Signed-off-by: Tom Rix <trix@redhat.com>  
>>> That's for new code I assume?
>>>
>>> What's the harm in leaving this ancient code be?  
>> This change is part of a tree wide cleanup.
> What's the purpose of the "clean up"? Why is it making the code better?
>
> This is a quote from your change:
>
> -  PRINTK (KERN_NOTICE, "debug bitmap is %hx", debug &= DBG_MASK);
> +  PRINTK (KERN_NOTICE, "debug bitmap is %x", debug &= DBG_MASK);
>
> Are you sure that the use of %hx is the worst part of that line?

In this case, it means this bit of code is compliant with the %h checker in checkpatch.

why you are seeing this change for %hx and not the horrible debug &= or the old PRINTK macro is because the change was mechanical.

leveraging the clang build and a special fixit for %h, an allyesconfig for x86_64 cleans this problem from most of the tree in about an hour.  atm/ was just one of the places it hit, there are about 100 more.

If you want the debug &= fixed, i can do that.

The macro is a treewide problem and i can add that to the treewide cleanups i am planning.

Tom

>
>> drivers/atm status is listed as Maintained in MAINTAINERS so changes
>> like this should be ok.
>>
>> Should drivers/atm status be changed?
> Up to Chas, but AFAIU we're probably only a few years away from ATM as 
> a whole walking into the light. So IMHO "Obsolete" would be justified.
>

