Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801232AA793
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 20:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgKGTQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 14:16:57 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5701 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgKGTQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 14:16:57 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa6f2ac0000>; Sat, 07 Nov 2020 11:17:00 -0800
Received: from [10.2.62.222] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 7 Nov
 2020 19:16:51 +0000
Subject: Re: [PATCH] mm/gup_benchmark: GUP_BENCHMARK depends on DEBUG_FS
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linuxarm <linuxarm@huawei.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Garry <john.garry@huawei.com>
References: <20201104100552.20156-1-song.bao.hua@hisilicon.com>
 <e8ecbf3e-438e-934e-0335-ec9b3e097022@nvidia.com>
 <9286e2d0e17a47a1874dc4a96d83a38f@hisilicon.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <e6b74390-6a80-9aae-17b2-536ffa0d1aae@nvidia.com>
Date:   Sat, 7 Nov 2020 11:16:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <9286e2d0e17a47a1874dc4a96d83a38f@hisilicon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604776620; bh=z9G72tVup8O2A+uYCE4iLdEZGkH3YDL/9eIcfi0obdI=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=VSTeVp6sZVmnhQhQlDFisn89K+j+8nAB7GisZzjyfL7S/hIDw1iy2LltQSvlEbrKi
         BDkXqJVS5IY1gmD3d42SBwQVv+pairjUVG+mgf0XYBhVOLGPGQDZInC6g4Jqz14+NS
         9gnnAtKJIGtdyfemMZxRMxuTsbwrTZMus+tlO/Riq/GpWbPzrwR9kkDm3LP5G9d5k0
         sbIyjewaPH269z8K7SnsT6H4luXnxI/Cc9qlzPreJKVoRQM6anzAfKKxo9XPp/cjSk
         lPLdh297B1jAtj9JsvoJFiTQUTm4nfbzghxrjw+3qJPaVx8FkJ45At3omhDXjSwd3R
         obVLOzjmyBXJg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/20 11:05 AM, Song Bao Hua (Barry Song) wrote:
>> -----Original Message-----
>> From: John Hubbard [mailto:jhubbard@nvidia.com]
...
>>>    config GUP_BENCHMARK
>>>    	bool "Enable infrastructure for get_user_pages() and related calls
>> benchmarking"
>>> +	depends on DEBUG_FS
>>
>>
>> I think "select DEBUG_FS" is better here. "depends on" has the obnoxious
>> behavior of hiding the choice from you, if the dependencies aren't already met.
>> Whereas what the developer *really* wants is a no-nonsense activation of the
>> choice: "enable GUP_BENCHMARK and the debug fs that it requires".
>>
> 
> To some extent, I agree with you. But I still think here it is better to use "depends on".
> According to
> https://www.kernel.org/doc/Documentation/kbuild/kconfig-language.txt
> 
> 	select should be used with care. select will force
> 	a symbol to a value without visiting the dependencies.
> 	By abusing select you are able to select a symbol FOO even
> 	if FOO depends on BAR that is not set.
> 	In general use select only for non-visible symbols
> 	(no prompts anywhere) and for symbols with no dependencies.
> 	That will limit the usefulness but on the other hand avoid
> 	the illegal configurations all over.
> 
> On the other hand, in kernel there are 78 "depends on DEBUG_FS" and
> only 14 "select DEBUG_FS".
> 

You're not looking at the best statistics. Go look at what *already* selects
DEBUG_FS, and you'll find about 50 items.


thanks,
-- 
John Hubbard
NVIDIA
