Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E292D2247
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgLHEuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgLHEux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:50:53 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1375EC061749;
        Mon,  7 Dec 2020 20:50:13 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id 15so6972875oix.8;
        Mon, 07 Dec 2020 20:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jHkOHufgfPix7XJnCEL5dkvF/7Fypmy2uLtYXWhqwes=;
        b=EEzbqjYcjazN0cXwdMDcfLJmNNCY56rjfD4ovOHQWoIq0PjSl2+DZt4tpssS+lf6uN
         4KcG/updZ2pSSwNA7isAgug3R5F2zcKEN51CvqMFcvSiMWl0E1DKInY61Vrj0X6SUXqP
         9h8Cu97E5J3wL96zoGau0O0J3WTn/be0xdq6GJLSPuCaAaGK23Fck1Psj8+8bJMVU/Tt
         +rhkyhK4tr0Xt1wVD2l+WkrJLS8qiXl3mrVJcWKNPykDQirzpXBvZVjY1OoWi08bHj4t
         Mdrh3Ee6hEQl8m9quYNSTQwpYhOktchVLUxJXRMZAlMcw9h1l9V6umiw4VbyQqzTYocf
         V1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jHkOHufgfPix7XJnCEL5dkvF/7Fypmy2uLtYXWhqwes=;
        b=oWZ0kiqRkeLSf1/Hmti3JnTnhEUL1ZpZohW4W+bEEavyQh2xaQRs4uxIjpdKdkLBfh
         9ZJCJVGmQA1R02Ito973EzmkpnjWG4k65cBuAizTmkaZMKomD7J4TG/Pbsd8Nh/LV889
         ts1ib3Q5E1R0bI/AsyJH2wCU0W3wdS+hGU15UbPHfvfjwnmagJZNsjRtiDMI+JwG+XOg
         ioJ+1A1anNMjq5rqfpq7I2DxVFz4tCTez5ZyYMR7n4GzIQtw/+aykHrKjs7CWSyBBARY
         MtkhWr0N0FmqdrAd3sIPtLReXrTgTewHT6n4HwYP9WFBx/81cDIqvK1pSUGOTJdilHRe
         fNTw==
X-Gm-Message-State: AOAM532j2nMbmNUOjqFvRo5bxps6wroXS3pLrVnvwmbj8aAKKpBGnnN+
        yg7lJNS1wY5GOl6jlNNsv1sZXCZXCAQ=
X-Google-Smtp-Source: ABdhPJzsIwBuv4H4rkF21YxZVwyw5ietTe5Qq9IgEmpv5eSLf7lfeyOZCkot/YI+Hhs6+6nt4+MuQg==
X-Received: by 2002:aca:5c07:: with SMTP id q7mr1448521oib.178.1607403012526;
        Mon, 07 Dec 2020 20:50:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a15sm2360269oii.50.2020.12.07.20.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 20:50:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 0/3] occ: Add support for P10
To:     Joel Stanley <joel@jms.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Eddie James <eajames@linux.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-fsi@lists.ozlabs.org
References: <20201120010315.190737-1-joel@jms.id.au>
 <20201121185150.GD114144@roeck-us.net>
 <CACPK8Xcf1xhPZNqpxuZE22uqDFR7rb1Wv-RW802bx2S-nphpzA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <892cbf6d-b209-13e3-645e-082e2ce5c68c@roeck-us.net>
Date:   Mon, 7 Dec 2020 20:50:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACPK8Xcf1xhPZNqpxuZE22uqDFR7rb1Wv-RW802bx2S-nphpzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On 12/7/20 6:41 PM, Joel Stanley wrote:
> On Sat, 21 Nov 2020 at 18:55, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Fri, Nov 20, 2020 at 11:33:12AM +1030, Joel Stanley wrote:
>>> Hi Guenter, here's v2 of this series on behalf of Eddie. I made the
>>> change to the compatible string that we spoke about in v2, and I'm happy
>>> for these to go through the hwmon tree.
>>>
>>
>> I'll be happy to do that, as soon as we get a Reviewed-by: tag for the DT
>> change.
> 
> Rob has sent that through now, so this should be good to go in.
> 

Thanks for the reminder. Series applied to hwmon-next.

Thanks,
Genter

> Thank you.
> 
>>
>> Thanks,
>> Guenter
>>
>>> v1: https://lore.kernel.org/linux-hwmon/20200501150833.5251-1-eajames@linux.ibm.com/
>>>
>>> The OCC in the P10 has a number of differences from the P9. Add some logic to
>>> handle the differences in accessing the OCC from the service processor, and
>>> support the new temperature sensor type.
>>>
>>> Eddie James (3):
>>>   dt-bindings: fsi: Add P10 OCC device documentation
>>>   fsi: occ: Add support for P10
>>>   hwmon: (occ) Add new temperature sensor type
>>>
>>>  .../devicetree/bindings/fsi/ibm,p9-occ.txt    |  12 +-
>>>  drivers/fsi/fsi-occ.c                         | 125 +++++++++++++-----
>>>  drivers/hwmon/occ/common.c                    |  75 +++++++++++
>>>  3 files changed, 172 insertions(+), 40 deletions(-)
>>>
>>> --
>>> 2.29.2
>>>

