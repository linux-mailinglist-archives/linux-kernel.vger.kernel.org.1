Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0D52FE649
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 10:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbhAUJYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 04:24:31 -0500
Received: from ns.lineo.co.jp ([203.141.200.203]:36074 "EHLO mail.lineo.co.jp"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbhAUJXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:23:46 -0500
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jan 2021 04:23:45 EST
Received: from [172.31.10.205] (unknown [203.141.200.204])
        by mail.lineo.co.jp (Postfix) with ESMTPSA id 6E295806B4681;
        Thu, 21 Jan 2021 18:14:44 +0900 (JST)
Subject: Re: [PATCH] scripts/spelling.txt: increase error-prone spell checking
To:     Luca Ceresoli <luca@lucaceresoli.net>,
        Chunyou Tang <tangchunyou@163.com>,
        Joe Perches <joe@perches.com>
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
From:   Naoki Hayama <naoki.hayama@lineo.co.jp>
Message-ID: <b54335cd-2009-3542-a175-6118c294fd74@lineo.co.jp>
Date:   Thu, 21 Jan 2021 18:14:40 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7937a406-812e-0a41-12c5-41576737a44f@lucaceresoli.net>
Content-Type: text/plain; charset=gb18030
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Chunyou,

On 2021/01/21 17:41, Luca Ceresoli wrote:
> Hi,
> 
> On 21/01/21 04:21, Chunyou Tang wrote:
>> On Wed, 20 Jan 2021 19:09:05 -0800
>> Joe Perches <joe@perches.com> wrote:
>>
>>> On Wed, 2021-01-20 at 19:02 -0800, Randy Dunlap wrote:
>>>> On 1/20/21 6:07 PM, ChunyouTang wrote:  
>>>>> From: tangchunyou <tangchunyou@yulong.com>
>>>>>
>>>>> Increase direcly,maping,manger spelling error check  
>>>>
>>>> Hi,
>>>> I don't see all of those in the patch below.
>>>> What happened?  
>>>
>>> I think mostly it's just a poor commit message as
>>> direcly and manger are already in spelling.txt
>>>
>>>>> diff --git a/scripts/spelling.txt b/scripts/spelling.txt  
>>> []
>>>>> @@ -875,6 +875,7 @@ manger||manager
>>>>>  manoeuvering||maneuvering
>>>>>  manufaucturing||manufacturing
>>>>>  mappping||mapping
>>>>> +maping||mapping
>>>>>  matchs||matches
>>>>>  mathimatical||mathematical
>>>>>  mathimatic||mathematic  
>>>
>>
>> yes,you are right,the commit message is bad,I change the commit message
>>
>> and resend it.
> 
> While doing that, also improve the subject (1st line of commit message)
> by mentioning the typo you are adding. For example, as in previous commits:
> 
>   scripts/spelling.txt: add "maping" typo
> 
> It's more informative and even shorter.
> 
> Thanks
> 

Rules in scripts/spelling.txt are sorted
alphabetically by leftside words. It would
be better that you insert "maping||mapping"
rule between:

"manufaucturing||manufacturing"
and
"mappping||mapping" .


Best regards,

Naoki Hayama
