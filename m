Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B64628754F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 15:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbgJHNii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 09:38:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730356AbgJHNii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 09:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602164316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=28gyQXNpF1DN/ygNYXtmZFhoYYiRhK+HkImKGmUzg8Q=;
        b=Bydy+rx2uBgta/tBsYRPoBPhT454ponJVoWRdRgfoAETjmcuCTl4pUiCB759HasNNM37rU
        0CfnSnd8Al97+/2ZRFpECSQb5J/MJcST60xvhUc0ZX5ztWB1t/UX2wHHRUHdJHeRRt278A
        kJNAiC8TWDes1bwwR4OpafTXSLWS/2M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-IeMcRdowOPWe2kHBr4z2EQ-1; Thu, 08 Oct 2020 09:38:35 -0400
X-MC-Unique: IeMcRdowOPWe2kHBr4z2EQ-1
Received: by mail-ej1-f71.google.com with SMTP id c11so295242ejp.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 06:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=28gyQXNpF1DN/ygNYXtmZFhoYYiRhK+HkImKGmUzg8Q=;
        b=MKHk3jAcjRjFIUaOipe/YR2lurratAzKU2XJ0WBdHG/TWlGuYFtxo7vMO/ceAJLIAJ
         XEF+PoucRxGviZyQOfkbnTTWqnf4PA0VyTh93ZXEobj/tqQsz09ihPi8pneDjUIeZJkB
         opujbWW8kBs4F7PTVcX4JWNtxZbvwEMUj+bBZRMUG08l7jbHhzpqyLSXR8RnJzO3YIbI
         gopRUMsFWTLrusR3xU+ANak2Wv0LjYBdeSl3hux9KEGSTgvZiCUaEdcTVdAfOrFPNgQk
         oKW2nPGxdWJmdBpdlYnOfOWzE4yKCeFqT+fUkfCrorau1ury0YSACdqha3iCZ8nAHnRE
         5HKg==
X-Gm-Message-State: AOAM5301KDM61HIw0xlCgT2gn9cUX3qiBzU2Z6+2Wu5GJr6yuyzY32KD
        +vflbyeX34ypQZNA5RgiFDD6VnE0a08u74rBRVW8Hl0MAt6iRbUB22+AiZU+fJuIPMR2y8Cy9pk
        jZqNSnS57v+xPhfR9C7lyJmdU
X-Received: by 2002:a17:907:2179:: with SMTP id rl25mr9090369ejb.450.1602164313976;
        Thu, 08 Oct 2020 06:38:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzh54qp6elhh4b0bi/0hfuhxUSlSSJ4eT5ng6FX5vjZkWVuN+vp5Op50gDFY3RH/EU/AB79DA==
X-Received: by 2002:a17:907:2179:: with SMTP id rl25mr9090339ejb.450.1602164313696;
        Thu, 08 Oct 2020 06:38:33 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id j5sm4208913ejt.52.2020.10.08.06.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 06:38:33 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] platform/surface: Create a platform subdirectory
 for Microsoft Surface devices
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        platform-driver-x86@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Stephen Just <stephenjust@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org
References: <20201005160307.39201-1-luzmaximilian@gmail.com>
 <a82e3aff-801d-d116-bbf4-91f3981f713b@redhat.com>
 <deb1c682-5843-61b1-173b-a70ef51e85f2@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <389f3a38-83ca-dfcd-476a-61b1d33751bb@redhat.com>
Date:   Thu, 8 Oct 2020 15:38:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <deb1c682-5843-61b1-173b-a70ef51e85f2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/8/20 2:32 PM, Maximilian Luz wrote:
> On 10/8/20 1:44 PM, Hans de Goede wrote:
>> Hi Maximilian,
>>
>> On 10/5/20 6:03 PM, Maximilian Luz wrote:
>>> As has come up in the discussion around
>>>
>>>    [RFC PATCH] Add support for Microsoft Surface System Aggregator Module
>>>
>>> it may make sense to add a Microsoft Surface specific platform
>>> subdirectory. Andy has suggested drivers/platform/surface for that.
>>> This series follows said suggestion and creates that subdirectory, as
>>> well as moves Microsoft Surface related drivers over to it and updates
>>> their MAINTAINERS entries (if available) accordingly.
>>>
>>> This series does not modify any existing driver code, symbols, or help
>>> text.
>>
>> In case you do not know I'm taking over from any as
>> drivers/platform/x86 maintainer.
>>
>> I'm fine with the concept of this series, but who is going to maintain
>> this new drivers/platform/surface directory ?
>>
>> Ah I see that the first patch answers that question and the plan
>> is to keep this part of the pdx86 maintainership.
>>
>> I would prefer for the new dir to have its own
>> MAINTAINERS entry if I'm honest, I would like to try and
>> split maintainership for the surface stuff as follows:
>>
>> 1. Who will review (and add their Reviewed-by or ask for improvements
>>     or nack) patches to files in this dir?
>>
>> 2. Who will gather approved patches apply them to a for-next branch
>>     and send them out to Linus during the merge Window?
>>
>> I can pick up 2. but I could really use some help with 1. So I
>> was thinking having a separate MAINTAINERS entry for the new
>> dir with you (Maximilian) (and me and Mark Gross) listed as
>> MAINTAINERS; and then I'm hoping that you can do the review
>> of surface related patches. At least those which you have not
>> written yourself.
>>
>> How does that sound ?
> 
> Sounds good, I'd be happy to help review and approve any Surface related
> patches. However, I think it would be beneficial if you and Mark still
> have a final look (and say) over the ones I've reviewed and accepted (if
> that's not already a given). I feel like I may lack a bit of experience
> for this job and might miss some things.

Since Mark or I will be merging the patches we will indeed still take
a look at them, but it helps if someone else has already done a review
first.

> I'll add the MAINTAINERS entry and send a v3 later today, if that's OK.

That sounds good, thanks.

Regards,

Hans

