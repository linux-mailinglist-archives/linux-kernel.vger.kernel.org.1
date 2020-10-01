Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E50027FC67
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 11:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbgJAJ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 05:26:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56655 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731670AbgJAJ0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 05:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601544404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pq6Om9kKeW8tF3UBSbP0FuEgAGbZTYAFy9OO6raLYsg=;
        b=UHWyO9/Pgs59Sc498JRjWwhQpjAbb1l/+Vn7sxwWWiPBpsz+IrABpiAwcja3LR3bCHzoUk
        qxqt4x1FvNgFf5Cap3MZyDLoOsG54dwsPSXqhU2ZjwgMzM362tmfdMl0YtltGi24DfMfvx
        spziOPM1zq2s3PzZ0HfTleLCy7jLYZI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-Duv0xX-VPNKkAdLTysgyNA-1; Thu, 01 Oct 2020 05:26:39 -0400
X-MC-Unique: Duv0xX-VPNKkAdLTysgyNA-1
Received: by mail-ed1-f72.google.com with SMTP id q10so1961883edn.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 02:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pq6Om9kKeW8tF3UBSbP0FuEgAGbZTYAFy9OO6raLYsg=;
        b=nqfXXx812aZYuO99uQZ542s5JuaPwcYYkSBqEurnCjatLMQbEf8rnYvRXGiE04ZNon
         wDQt0PM+x6z9DEApOw92uV2vBtjNJe7/dp75Gql/bykwrJCfhGV60c1EsIUCXAzH4zCN
         0U2W/6i0O0a0ZlJXYFJV12NUbAFaxMvotjtiESX2cAe9e9XFXf/kNl9FJMEXvbpIoTPI
         rjud06/xVf7y06gJMwQAMQX00N6rPlDR6/XmO8/Yg4Thzh4rrTOHbOLyYYVVZE1lelAi
         zCOvg+Y1RAktm5Om9o5M7hDUv46SbHlV/1/auvLY6k8VFnN+WC2ohhpxPuq48myFYujd
         872w==
X-Gm-Message-State: AOAM531hoMrMs6hEFpApaf2MmVwo4KnLWpMfQlesKPIx2zEO/j8d3hsx
        dylOrtK3UDKRoXBDA62mZFRQ9kOq3REoHSCh5aJfDf1ZKd2ylpMtnxA5ZxpADhvE7+BgmzasCth
        kFsn3qOu2fMp/z9s70cst8keJ
X-Received: by 2002:a05:6402:1bc2:: with SMTP id ch2mr7017746edb.60.1601544398468;
        Thu, 01 Oct 2020 02:26:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyj4+xzrGe6BVztHE0oNVJ7K2CIjY46tbLNlUQfS1nCUvsDzagXYuzoM7P4leaeKSGwBKKLUw==
X-Received: by 2002:a05:6402:1bc2:: with SMTP id ch2mr7017733edb.60.1601544398214;
        Thu, 01 Oct 2020 02:26:38 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id r20sm2104227edw.51.2020.10.01.02.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 02:26:37 -0700 (PDT)
Subject: Re: [PATCH v5] Introduce support for Systems Management Driver over
 WMI for Dell Systems
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        Divya Bharathi <divya27392@gmail.com>
Cc:     "dvhart@infradead.org" <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
References: <20200929025521.59573-1-divya.bharathi@dell.com>
 <20200930002319.GI19084@mtg-dev.jf.intel.com>
 <DM6PR19MB2636FB3D94EBA95B7CE0DE54FA330@DM6PR19MB2636.namprd19.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <42f8e710-38f7-6f80-9f4a-af68cd376538@redhat.com>
Date:   Thu, 1 Oct 2020 11:26:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB2636FB3D94EBA95B7CE0DE54FA330@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/30/20 11:02 PM, Limonciello, Mario wrote:
>>> +		possible_values:	A file that can be read to obtain the possible
>>> +					values of the <attr>. Values are separated using
>>> +					semi-colon (``;``).
>> why not use set notation from math classes assuming intergers?  i.e.
>> (a, b)  all integers beween a and b but not including a or b (open set)
>> or
>> [a, b] all integerger betwen a and b including and b?  (closed set)
>>
>> Anyway its ambiguous if the the extremes are included in the set of possible
>> values as written.
>>
> 
> Enumeration attributes mean that there are fixed values, specifically not integers.
> Integers are in the "integer" type and explained below.
> 
> An example value that would be seen here is possible_values:
> 
> Enabled;Disabled;

That might not be the best example, because in that case arguably we
could export it as a boolean type (except that the WMI interface does
not give us boolean as an explicit / separate type).

Mark these enum attributes are really like enums in C, so we
have a fixed set of possible values which are described by
strings, since using integers for it makes no sense from a human
interaction pov. E.g. on the Lenovo X1C8 I have some attributes
have the following possible value sets:

                 Package (0x03)
                 {
                     "High",
                     "Normal",
                     "Silent"
                 },

                 Package (0x02)
                 {
                     "LCD",
                     "ExternalDisplay"
                 },

                 Package (0x02)
                 {
                     "Independent",
                     "Synchronized"
                 },

I hope this helps clarify things.

Regards,

Hans

