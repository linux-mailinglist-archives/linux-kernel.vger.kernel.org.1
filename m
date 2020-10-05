Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E1A28338F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 11:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgJEJrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 05:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJEJrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 05:47:09 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E33C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 02:47:08 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b22so10021269lfs.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 02:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pgMwKazhCKZFftw47Ht1BMoXWpFBSCf7a1kv9wg1i9A=;
        b=K2LIoGVdP7xdTNMYwv4AyZ1dmRU7GcwbWIIRS6sa1Yu3Q1FfpoLwNp6siYqp3IZ/HP
         nWoWh8YGKnoIddnGE8CX3NjdYYqMmK3sFNvLoewxJmFpBhY+DkHeNbbJ00c0F1VE1Ga6
         nhKMK3Nho37X2RgXeXtPZLCawBb/5RNVmYIfGnb0Yn+UgbegeSMRgMXHT4WO6a/xBiyf
         Zbblw5jBcgJVevEkBIvg613hht1a2VPhW9uTEk9o2u9PtVB+sryZRVxipYnq/HQ//9Ba
         9JEQk3fTl9WgjcEzE2xdToWHd2JmUzfRc5mHEhN70zdDge364AhgMBtr6ZZwbLSmUzhg
         gFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pgMwKazhCKZFftw47Ht1BMoXWpFBSCf7a1kv9wg1i9A=;
        b=KAAW3SXMxA5BedDuATYUyg9wgL2ZdgA6C7SSIlnn53UpvQ7l9OCr6rsotBH/RD6KoQ
         Cw24uxewdqxt3dEaYRNQoOK6oEjp2OABor5HPJWOtuQd4GQs6btnWwX09cRDPZ8Jc/H9
         zzKfUzXmVxJ+z8BqIEh6iAAWEbaORCKQRrxuzaLi9g+YcB7ygRdQl+L9yWx040ZNXuFz
         UP+ujwrp/lkfaIN2uscn1EUyMw1g+U8K0g/jwmO7aZlqH97uYQn4IHWxN/1XngKOE3Vh
         TGopLAX+h5JkY03MqBZ0ewaZ9szI77s1g/nhqUcZv2LRsuEB0jFv4nRAXRSLPvEXr2MQ
         AVhA==
X-Gm-Message-State: AOAM530ElyLKban1ZmBopmzGbK9EwQMsxHVS1TeyDBXUfMS3TDSTmHcV
        bDFLeG1iJBECysLmekqO2sjR58TC8L8=
X-Google-Smtp-Source: ABdhPJzadCJ7vlw8hDztAmcvlVIMgVDNlVOYpHLNNiSM6ltqhUK7+VUBGbO8Vh3q/ziIQsCONc7TtQ==
X-Received: by 2002:a19:dcb:: with SMTP id 194mr5167787lfn.25.1601891227092;
        Mon, 05 Oct 2020 02:47:07 -0700 (PDT)
Received: from [192.168.1.89] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id 136sm31462lfi.176.2020.10.05.02.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 02:47:06 -0700 (PDT)
Subject: Re: [PATCH] mm: optionally disable brk()
To:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20201002171921.3053-1-toiwoton@gmail.com>
 <653873ef-2a57-37e0-1ac3-fba763652b35@redhat.com>
 <2a0f5ade-d770-c36e-50bc-ff0c8e9dacbf@gmail.com>
 <20201005061248.GN4555@dhcp22.suse.cz>
 <888e62e0-3979-207b-c516-ddfc6b9f3345@redhat.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <4d325e3e-3139-eded-6781-435fb04fb915@gmail.com>
Date:   Mon, 5 Oct 2020 12:47:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <888e62e0-3979-207b-c516-ddfc6b9f3345@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.10.2020 12.13, David Hildenbrand wrote:
> On 05.10.20 08:12, Michal Hocko wrote:
>> On Sat 03-10-20 00:44:09, Topi Miettinen wrote:
>>> On 2.10.2020 20.52, David Hildenbrand wrote:
>>>> On 02.10.20 19:19, Topi Miettinen wrote:
>>>>> The brk() system call allows to change data segment size (heap). This
>>>>> is mainly used by glibc for memory allocation, but it can use mmap()
>>>>> and that results in more randomized memory mappings since the heap is
>>>>> always located at fixed offset to program while mmap()ed memory is
>>>>> randomized.
>>>>
>>>> Want to take more Unix out of Linux?
>>>>
>>>> Honestly, why care about disabling? User space can happily use mmap() if
>>>> it prefers.
>>>
>>> brk() interface doesn't seem to be used much and glibc is happy to switch to
>>> mmap() if brk() fails, so why not allow disabling it optionally? If you
>>> don't care to disable, don't do it and this is even the default.
>>
>> I do not think we want to have config per syscall, do we?
> 
> I do wonder if grouping would be a better option then (finding a proper
> level of abstraction ...).

If hardening and compatibility are seen as tradeoffs, perhaps there 
could be a top level config choice (CONFIG_HARDENING_TRADEOFF) for this. 
It would have options
- "compatibility" (default) to gear questions for maximum compatibility, 
deselecting any hardening options which reduce compatibility
- "hardening" to gear questions for maximum hardening, deselecting any 
compatibility options which reduce hardening
- "none/manual": ask all questions like before

-Topi
