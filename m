Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D722AA8B1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 02:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgKHBKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 20:10:31 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2447 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKHBKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 20:10:31 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa7458a0000>; Sat, 07 Nov 2020 17:10:34 -0800
Received: from [10.2.62.222] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 8 Nov
 2020 01:10:29 +0000
Subject: Re: [PATCH] mm/gup_benchmark: GUP_BENCHMARK depends on DEBUG_FS
To:     Randy Dunlap <rdunlap@infradead.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linuxarm <linuxarm@huawei.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Garry <john.garry@huawei.com>
References: <20201104100552.20156-1-song.bao.hua@hisilicon.com>
 <e8ecbf3e-438e-934e-0335-ec9b3e097022@nvidia.com>
 <9286e2d0e17a47a1874dc4a96d83a38f@hisilicon.com>
 <e6b74390-6a80-9aae-17b2-536ffa0d1aae@nvidia.com>
 <a5f5b63a-ff9d-ed74-212f-f959f038b781@infradead.org>
 <2c968615-587c-b978-7961-8391c70382b2@nvidia.com>
 <1c8b6d14-7d14-4bd6-0eac-c60fa98aec0b@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <1269bf18-2b29-b380-3fd1-092534866c1d@nvidia.com>
Date:   Sat, 7 Nov 2020 17:10:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1c8b6d14-7d14-4bd6-0eac-c60fa98aec0b@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604797834; bh=cz8PmIrnacq8HnNrXgr4efiH0i+u9qmb15T6lj4ZmiU=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=Ew4nXuewQa7EhaPQBn3qHDLdhmvA6ZHB72mMbjh+mJOgboQHlWSO8II1ghOeEXpH7
         6vSTPLiEKByEomyFaGgvrOGjzDR5WhMpjXTPqMPSiuAiMbHUIPpKyp0Pb4GkbZ86yb
         Hk2tZjOC6q9/JvODwxgY4durlIrzG16nk14kSE98qsL9tsI7t0uPHkkqci7J9ZKzKW
         idZ8sru/KeWfItnI+AdjD+TgEWxyQr+lEW7cNZXfoS8NhCQ4vcq71PlmrDNfTS2Y87
         TiWESsJfEOx1WSUgAWUp9RFyqrQ4HxoN37UVSwYVlHHmVgaqzj+URihtMeKDp60zEK
         gYa5EZkNPp0Iw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/20 4:24 PM, Randy Dunlap wrote:
> On 11/7/20 4:03 PM, John Hubbard wrote:
>> On 11/7/20 2:20 PM, Randy Dunlap wrote:
>>> On 11/7/20 11:16 AM, John Hubbard wrote:
>>>> On 11/7/20 11:05 AM, Song Bao Hua (Barry Song) wrote:
...
> OK, thanks, I see how you get that list now.
> 
> JFTR, those are not 42 independent users of DEBUG_FS. There are lots of &&s
> and a few ||s in that list.
> 

You are right, and that means that I have to withdraw my earlier claim that
"42 committers" made such a decision.

> 
> xconfig shows this for DEBUG_FS: (13 selects for x86_64 allmodconfig)
> 

...maybe only 13 committers and dependency chain, then. :)


thanks,
-- 
John Hubbard
NVIDIA
