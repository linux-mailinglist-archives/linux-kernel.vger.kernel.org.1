Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6F92FE6C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 10:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbhAUJwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 04:52:15 -0500
Received: from ns.lineo.co.jp ([203.141.200.203]:36128 "EHLO mail.lineo.co.jp"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbhAUJuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:50:39 -0500
Received: from [172.31.10.205] (unknown [203.141.200.204])
        by mail.lineo.co.jp (Postfix) with ESMTPSA id 5206780313535;
        Thu, 21 Jan 2021 18:49:47 +0900 (JST)
Subject: Re: [PATCH] scripts/spelling.txt: increase error-prone spell checking
To:     Joe Perches <joe@perches.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Chunyou Tang <tangchunyou@163.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        colin.king@canonical.com, xndchn@gmail.com, j.neuschaefer@gmx.net,
        ebiggers@google.com, sjpark@amazon.de,
        linux-kernel@vger.kernel.org, zhangwen@yulong.com,
        tangchunyou@yulong.com
References: <20210121020731.2316-1-tangchunyou@163.com>
 <47008cd9-2b87-f5b2-5fad-e8f009869dda@infradead.org>
 <1a3ab487bfb0365991355147fadbf51df14a4772.camel@perches.com>
 <20210121112115.00005cb6@163.com>
 <7937a406-812e-0a41-12c5-41576737a44f@lucaceresoli.net>
 <b54335cd-2009-3542-a175-6118c294fd74@lineo.co.jp>
 <6223e06f2a45b8772f04d97d840fe7da960a8037.camel@perches.com>
From:   Naoki Hayama <naoki.hayama@lineo.co.jp>
Message-ID: <61f26111-f769-641b-e8ca-e031177582b9@lineo.co.jp>
Date:   Thu, 21 Jan 2021 18:49:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6223e06f2a45b8772f04d97d840fe7da960a8037.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Joe,

On 2021/01/21 18:36, Joe Perches wrote:
> On Thu, 2021-01-21 at 18:14 +0900, Naoki Hayama wrote:
>> On 2021/01/21 17:41, Luca Ceresoli wrote:
>>> On 21/01/21 04:21, Chunyou Tang wrote:
>>>> On Wed, 20 Jan 2021 19:09:05 -0800 Joe Perches <joe@perches.com> wrote:
>>>>> On Wed, 2021-01-20 at 19:02 -0800, Randy Dunlap wrote:
>>>>>> On 1/20/21 6:07 PM, ChunyouTang wrote:  
>>>>>>> From: tangchunyou <tangchunyou@yulong.com>
> []
>>>>>>> diff --git a/scripts/spelling.txt b/scripts/spelling.txt  
>>>>> []
>>>>>>> @@ -875,6 +875,7 @@ manger||manager
>>>>>>>  manoeuvering||maneuvering
>>>>>>>  manufaucturing||manufacturing
>>>>>>>  mappping||mapping
>>>>>>> +maping||mapping
>>>>>>>  matchs||matches
>>>>>>>  mathimatical||mathematical
>>>>>>>  mathimatic||mathematic  
> []
>> Rules in scripts/spelling.txt are sorted
>> alphabetically by leftside words. It would
>> be better that you insert "maping||mapping"
>> rule between:
>>
>> "manufaucturing||manufacturing"
>> and
>> "mappping||mapping" .
> 
> That's not really true.  Try a diff of $ sort < scripts/spelling.txt
> 
> The general rule of thumb, and it's only a rule of thumb and it is
> not strictly enforced, is that similar misspellings are grouped
> together.
> 
> 

Thank you for pointing out. I misunderstood about it.
Sorry for the confusion.
