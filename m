Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1ED28732F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 13:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgJHLNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 07:13:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbgJHLNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 07:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602155617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBZn6nJCSKSkT+CI1BoIQTp+DUMyPcnk9FhFCR2fIho=;
        b=OdALhx1eGsz0ophlnH1/A9lTYE7oAW01jo/voVD9x2YoRVXta7k8y7XpZjsQvsL0ClRzjA
        jui13LA+gqix9UKw/nB5pS2ZRoKRuGK615CR8PXp0yaaMGZTxhJcM8xgq02ZKAxGhtxx55
        PpRuxF5wt6j/fuxSuNSubCBlyIPrOrA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-DgWZlSQXN1OwNY13iUgpVA-1; Thu, 08 Oct 2020 07:13:36 -0400
X-MC-Unique: DgWZlSQXN1OwNY13iUgpVA-1
Received: by mail-ed1-f72.google.com with SMTP id i22so2075275edu.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 04:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YBZn6nJCSKSkT+CI1BoIQTp+DUMyPcnk9FhFCR2fIho=;
        b=gYRtEb4Ob2TsP+cJiCiV3FPR1UdDXauY8s1AebzW8+TH8J+PiUu6qUnKFM4pPZsLaE
         UaR/nHKLWpT73IDVjJGH6WEY1kB+3U3tNHn3FO7IkvQCsBnBUlfemXkO6Mjr39hJEays
         q6hiT4cVg5lkZ1A72H0KMSlO6RfxecJZUejPKx1pU5etS8zWQJdgTntajZ+wgVUQTrnB
         OM5CdFno/vjRxnX0BQpgjzaUsfkB4WfNYU3gaJcLnm27qrXF3GrywuDX8CNRS2cDfCJ2
         wr4fd8AAPSC52IaU1UDBWRNutn45dLqJBOre9yO8mc7nu/dYqrYno0Kd394e4ayxUNkN
         vl+w==
X-Gm-Message-State: AOAM5317xMjhfeevmvpVYa62wzw8vJAft6ukICt954r4WgafS+06elty
        Tilif41Y6YA2kxZNP/sr/t/5pB1pLgcKXLqDEzlHK2+ClGWL6Gvw1h7Q+EuRf+pkW9RvsPWZ6re
        QxuYXv45oTMbbFnSX5ORniG5t
X-Received: by 2002:a17:906:c1c3:: with SMTP id bw3mr8032622ejb.516.1602155614909;
        Thu, 08 Oct 2020 04:13:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEgivjRQZ4xl3+6on1EF37giFgkAAQ1outiY+0shIhvn0v2U82j8Sh6TGq4UfML8q48DryFQ==
X-Received: by 2002:a17:906:c1c3:: with SMTP id bw3mr8032602ejb.516.1602155614686;
        Thu, 08 Oct 2020 04:13:34 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id g8sm3775588ejp.73.2020.10.08.04.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 04:13:34 -0700 (PDT)
Subject: Re: [PATCH V8 1/5] PCI: Add defines for Designated Vendor-Specific
 Extended Capability
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, dvhart@infradead.org,
        andy@infradead.org, bhelgaas@google.com,
        alexey.budankov@linux.intel.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20201007005118.GA3230211@bjorn-Precision-5520>
 <dcaea6b4e1d5b4a452c304fadb034b7b1e1c40af.camel@linux.intel.com>
 <20201007065451.GB6148@dell>
 <e09f4c44-e3d0-e14b-297f-6981516ea3bf@redhat.com>
 <20201008072912.GE1763265@dell>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <da9f985a-c935-8a01-3308-daaaddb723f5@redhat.com>
Date:   Thu, 8 Oct 2020 13:13:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008072912.GE1763265@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/8/20 9:29 AM, Lee Jones wrote:
> On Wed, 07 Oct 2020, Hans de Goede wrote:
> 
>> Hi,
>>
>> On 10/7/20 8:54 AM, Lee Jones wrote:
>>> On Tue, 06 Oct 2020, David E. Box wrote:
>>>
>>>> On Tue, 2020-10-06 at 19:51 -0500, Bjorn Helgaas wrote:
>>>>> On Tue, Oct 06, 2020 at 03:45:54PM -0700, David E. Box wrote:
>>>>>> Hi Bjorn,
>>>>>>
>>>>>> This patch has been acked and unchanged for weeks. Is it possible
>>>>>> to
>>>>>> get this pulled into next? We have SIOV and CXL related work that
>>>>>> is
>>>>>> using these definitions. Thanks.
>>>>>
>>>>> I acked it because I expected you to merge it along with the rest of
>>>>> the series.
>>>>>
>>>>> I guess I could merge this patch via the PCI tree if you really want,
>>>>> but that ends up being a hassle because we have to worry about which
>>>>> order things get merged to Linus' tree.  Better if the whole series
>>>>> is
>>>>> merged via the same tree.
>>>>
>>>> Agreed. The hope is that this series is ready for the next merge window
>>>> but no ack yet on V8. And if the series does not make it I'd like this
>>>> patch to at least get in.
>>>
>>> If Bjorn is happy to take this patch so late in the release cycle then
>>> please go ahead.  The other patches are due for v5.11.
>>
>> I agree (that the other patches are for 5.11) talking about merging
>> this series patch 2 is a mfd patch and patches 3-5 are drivers/platform/x86
>> patches.
>>
>> Lee, FYI I'm taking over drivers/platform/x86 maintainership from Andy.
> 
> Congratulations, Hans.
> 
>> I suggest that we merge the entire series through a single tree
>> (with acks or reviewed-by-s from the other maintainer)
>> either through the mfd tree or through the drivers/platform/x86
>> tree. Since most changes are in drivers/platform/x86 the latter
>> probably makes more sense, but either way works for me.
>> So how would you like to proceed with this series ?
> 
> I'm happy either way, but bear in mind that, due to the intrinsic
> heterogeneous nature of MFD, I already have infrastructure to easily
> apply (and send pull-requests for) cross-subsystem patch-sets.

Ok, you applying the entire series to the mfd tree is fine with me.

I'll try to review the entire series next week and then we'll see
from there.

Regards,

Hans

