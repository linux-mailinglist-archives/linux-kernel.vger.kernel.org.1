Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162E21F08D0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jun 2020 22:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgFFUqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jun 2020 16:46:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45346 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgFFUqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 16:46:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id i27so4943282ljb.12
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 13:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MvVWhiWvpvRwD/vorsMUnejOFrlrgkyL1XI+3qdJE2g=;
        b=pNUmpsStX+UBI8qvTPHbhTsQ5y7ZRqkCqB1+8RAF3GyYKI/35stNVHuK0PiXP7t6Q/
         90ACadB5g6gTsQzVMrFycMyvRjnhmhZkLgM9YzQsGPRWZkkmzxFgLjlWzaK11l7MRrY4
         meqtICd6XtJ4reOf129LJyMC9DhwUats5rxaK8ifvsjRDg4nntptOAWbDzuK65mJsasp
         dwaov8ComjeY93ytLMZQ9I7HnR15aJ3RkkdaUzThuXQP14Xg6XEqqrXf6RLaaQyDU0Cj
         myJ/Ui1kpOUPzEAik+iu7bH05GjUEpAudeqCb/BBV+IX6+dTSWBp0AFyE2sjJpyCb/wz
         gOcA==
X-Gm-Message-State: AOAM533K/hCvyf5UO2tbOUg2xGra6CObqSVhh1s0y5y0IiZWEHIxC1XV
        drjkakf4l7tC4o4a0+DSkpNYe92IFq4=
X-Google-Smtp-Source: ABdhPJyLB7qeF8/u6Ad77wFmowvhkr2A2DBxnFQtRe8wb/+WRGQQJGqG5Ckka1NZQDiZ5tYOSRKKVA==
X-Received: by 2002:a05:651c:1199:: with SMTP id w25mr8034096ljo.301.1591476374418;
        Sat, 06 Jun 2020 13:46:14 -0700 (PDT)
Received: from [192.168.1.8] ([213.87.137.116])
        by smtp.gmail.com with ESMTPSA id d22sm2557577lfn.84.2020.06.06.13.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2020 13:46:14 -0700 (PDT)
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Joe Perches <joe@perches.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
References: <20200530205348.5812-1-efremov@linux.com>
 <20200530205348.5812-2-efremov@linux.com>
 <alpine.DEB.2.21.2006061024100.2578@hadrien>
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Subject: Re: [Cocci] [PATCH 1/2] Coccinelle: extend memdup_user transformation
 with GFP_USER
Message-ID: <6f83e89b-f261-5251-19f8-4ba52ef0e6f4@linux.com>
Date:   Sat, 6 Jun 2020 23:46:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006061024100.2578@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/20 11:24 AM, Julia Lawall wrote:
> 
> 
> On Sat, 30 May 2020, Denis Efremov wrote:
> 
>> Match GFP_USER allocations with memdup_user.cocci rule.
>> Commit 6c2c97a24f09 ("memdup_user(): switch to GFP_USER") switched
>> memdup_user() from GFP_KERNEL to GFP_USER. In most cases it is still
>> a good idea to use memdup_user() for GFP_KERNEL allocations. The
>> motivation behind altering memdup_user() to GFP_USER is here:
>> https://lkml.org/lkml/2018/1/6/333
> 
> Should the rule somehow document the cases in which memdup_user should now
> not be used?
> 
> julia
> 
> 
>>
>> Signed-off-by: Denis Efremov <efremov@linux.com>
>> ---
>>  scripts/coccinelle/api/memdup_user.cocci | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
>> index c809ab10bbce..49f487e6a5c8 100644
>> --- a/scripts/coccinelle/api/memdup_user.cocci
>> +++ b/scripts/coccinelle/api/memdup_user.cocci
>> @@ -20,7 +20,7 @@ expression from,to,size;
>>  identifier l1,l2;
>>  @@
>>
>> --  to = \(kmalloc\|kzalloc\)(size,GFP_KERNEL);
>> +-  to = \(kmalloc\|kzalloc\)(size,\(GFP_KERNEL\|GFP_USER\));

Actually, we can add optional __GFP_NOWARN here to match such cases as:
GFP_KERNEL | __GFP_NOWARN

However, I don't know how to express it in elegant way. Something like?
(
-  to = \(kmalloc\|kzalloc\)(size,\(GFP_KERNEL\|GFP_USER\));
|
-  to = \(kmalloc\|kzalloc\)(size, GFP_KERNEL|__GFP_NOWARN);
|
-  to = \(kmalloc\|kzalloc\)(size, GFP_USER|__GFP_NOWARN);
)

Thanks,
Denis
