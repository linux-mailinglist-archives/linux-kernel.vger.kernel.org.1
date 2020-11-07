Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E246A2AA83E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 23:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbgKGWVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 17:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKGWVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 17:21:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971BAC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 14:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=bu8yT7HYn3OwlgueptTlX3p5x8+22WhUMml2fA/1UvE=; b=qexLaU9EdvqFZJYsCPLzWkJ5XL
        ZO17Dbh/WcXqQDaWcXfLnTeUMSjE/4jGsxcxGvzfxHLXWEF66UlqzRAg/jnuyxZQwgyyQKwZXiRzd
        8iB4DC57YVaQOrS09N0aE0ksVo1a1uivMqNh14SzadhuZUmXnY8GukpbZNRsiJwcdNeGRp97x8R3S
        KUIGajliM6aXx6IWFp1lnyDvwCJlXf7SYiNUJybZ5c8Y1PiBtoXxSSp7uLdZXhngbDA54t9YuhePe
        MTYyibatSobwG/KT64edht5NufqLNeZBvFDy721cN7ikHmn629+SyznrNCswnqjek/YPhg/S7eU+E
        GhA7eALA==;
Received: from [2601:1c0:6280:3f0::a1cb]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kbWZw-0005yX-Ad; Sat, 07 Nov 2020 22:21:00 +0000
Subject: Re: [PATCH] mm/gup_benchmark: GUP_BENCHMARK depends on DEBUG_FS
To:     John Hubbard <jhubbard@nvidia.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Linuxarm <linuxarm@huawei.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Garry <john.garry@huawei.com>
References: <20201104100552.20156-1-song.bao.hua@hisilicon.com>
 <e8ecbf3e-438e-934e-0335-ec9b3e097022@nvidia.com>
 <9286e2d0e17a47a1874dc4a96d83a38f@hisilicon.com>
 <e6b74390-6a80-9aae-17b2-536ffa0d1aae@nvidia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a5f5b63a-ff9d-ed74-212f-f959f038b781@infradead.org>
Date:   Sat, 7 Nov 2020 14:20:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e6b74390-6a80-9aae-17b2-536ffa0d1aae@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/20 11:16 AM, John Hubbard wrote:
> On 11/7/20 11:05 AM, Song Bao Hua (Barry Song) wrote:
>>> -----Original Message-----
>>> From: John Hubbard [mailto:jhubbard@nvidia.com]
> ...
>>>>    config GUP_BENCHMARK
>>>>        bool "Enable infrastructure for get_user_pages() and related calls
>>> benchmarking"
>>>> +    depends on DEBUG_FS
>>>
>>>
>>> I think "select DEBUG_FS" is better here. "depends on" has the obnoxious
>>> behavior of hiding the choice from you, if the dependencies aren't already met.
>>> Whereas what the developer *really* wants is a no-nonsense activation of the
>>> choice: "enable GUP_BENCHMARK and the debug fs that it requires".
>>>
>>
>> To some extent, I agree with you. But I still think here it is better to use "depends on".
>> According to
>> https://www.kernel.org/doc/Documentation/kbuild/kconfig-language.txt
>>
>>     select should be used with care. select will force
>>     a symbol to a value without visiting the dependencies.
>>     By abusing select you are able to select a symbol FOO even
>>     if FOO depends on BAR that is not set.
>>     In general use select only for non-visible symbols
>>     (no prompts anywhere) and for symbols with no dependencies.
>>     That will limit the usefulness but on the other hand avoid
>>     the illegal configurations all over.
>>
>> On the other hand, in kernel there are 78 "depends on DEBUG_FS" and
>> only 14 "select DEBUG_FS".
>>
> 
> You're not looking at the best statistics. Go look at what *already* selects
> DEBUG_FS, and you'll find about 50 items.

Sorry, I'm not following you. I see the same 14 "select DEBUG_FS" as Barry.

In general we don't want any one large "feature" (or subsystem) to be enabled
by one driver. If someone has gone to the trouble to disable DEBUG_FS (or whatever),
then a different Kconfig symbol shouldn't undo that.

-- 
~Randy

