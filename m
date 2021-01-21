Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888252FE54C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbhAUIpD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Jan 2021 03:45:03 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:33407 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727029AbhAUImp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:42:45 -0500
Received: from [77.244.183.192] (port=64474 helo=[192.168.178.24])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1l2VXA-00FUnG-L5; Thu, 21 Jan 2021 09:41:40 +0100
Subject: Re: [PATCH] scripts/spelling.txt: increase error-prone spell checking
To:     Chunyou Tang <tangchunyou@163.com>, Joe Perches <joe@perches.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        colin.king@canonical.com, xndchn@gmail.com, j.neuschaefer@gmx.net,
        naoki.hayama@lineo.co.jp, ebiggers@google.com, sjpark@amazon.de,
        linux-kernel@vger.kernel.org, zhangwen@yulong.com,
        tangchunyou@yulong.com
References: <20210121020731.2316-1-tangchunyou@163.com>
 <47008cd9-2b87-f5b2-5fad-e8f009869dda@infradead.org>
 <1a3ab487bfb0365991355147fadbf51df14a4772.camel@perches.com>
 <20210121112115.00005cb6@163.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <7937a406-812e-0a41-12c5-41576737a44f@lucaceresoli.net>
Date:   Thu, 21 Jan 2021 09:41:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210121112115.00005cb6@163.com>
Content-Type: text/plain; charset=gb18030
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/01/21 04:21, Chunyou Tang wrote:
> On Wed, 20 Jan 2021 19:09:05 -0800
> Joe Perches <joe@perches.com> wrote:
> 
>> On Wed, 2021-01-20 at 19:02 -0800, Randy Dunlap wrote:
>>> On 1/20/21 6:07 PM, ChunyouTang wrote:  
>>>> From: tangchunyou <tangchunyou@yulong.com>
>>>>
>>>> Increase direcly,maping,manger spelling error check  
>>>
>>> Hi,
>>> I don't see all of those in the patch below.
>>> What happened?  
>>
>> I think mostly it's just a poor commit message as
>> direcly and manger are already in spelling.txt
>>
>>>> diff --git a/scripts/spelling.txt b/scripts/spelling.txt  
>> []
>>>> @@ -875,6 +875,7 @@ manger||manager
>>>>  manoeuvering||maneuvering
>>>>  manufaucturing||manufacturing
>>>>  mappping||mapping
>>>> +maping||mapping
>>>>  matchs||matches
>>>>  mathimatical||mathematical
>>>>  mathimatic||mathematic  
>>
> 
> yes,you are right,the commit message is bad,I change the commit message
> 
> and resend it.

While doing that, also improve the subject (1st line of commit message)
by mentioning the typo you are adding. For example, as in previous commits:

  scripts/spelling.txt: add "maping" typo

It's more informative and even shorter.

Thanks
-- 
Luca

