Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C262AA8FB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 04:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgKHDWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 22:22:12 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8005 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgKHDWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 22:22:12 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa764680000>; Sat, 07 Nov 2020 19:22:16 -0800
Received: from [10.2.62.222] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 8 Nov
 2020 03:22:11 +0000
Subject: Re: [PATCH] mm/gup_benchmark: GUP_BENCHMARK depends on DEBUG_FS
From:   John Hubbard <jhubbard@nvidia.com>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Randy Dunlap <rdunlap@infradead.org>,
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
 <869059977c224a3aa31bfb42a4a8148d@hisilicon.com>
 <dd9e5f78-d627-89d6-2b9d-f2912213171f@nvidia.com>
Message-ID: <8eaa47c0-a62d-46da-4fd6-93f2b5b2910d@nvidia.com>
Date:   Sat, 7 Nov 2020 19:22:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <dd9e5f78-d627-89d6-2b9d-f2912213171f@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604805736; bh=YGcLdm9d0VYDsmVEG1tRIXb/IlxQJmH1cfsqcVcm74k=;
        h=Subject:From:To:CC:References:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=jZWJehsiSxpYO1odWNB3iw+cEQa263UyQEp0cqUU9L5fu2Y01DuU2D8qmU2Ebz2Tv
         76YGhMH3HHTxZekz4NH4eSGmlihCyK21ybBYZiWfCcnpqiTzD9NawHwBAkqtvE2HQu
         psnOU3baQC7galC+jLEHsQxvQTPZurRDrw6qX3+I5q2+GU/a9GFCKHUsSiQqF585Lp
         rCeLRptsUtcABsionZbdwdCWtp+qLPPmpF0Uj4Hqzu5jrDANyQ+8zalbCyiUeOqVZS
         bYz5lyPiFFzyBd2fiBHid6G4fgiR+dQAhO1bcH8kCutKeolFLivRM9Z/k8jkyF33pu
         LJ+6R4DY5jl7g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/20 7:14 PM, John Hubbard wrote:
> On 11/7/20 6:58 PM, Song Bao Hua (Barry Song) wrote:
>>> On 11/7/20 2:20 PM, Randy Dunlap wrote:
>>>> On 11/7/20 11:16 AM, John Hubbard wrote:
>>>>> On 11/7/20 11:05 AM, Song Bao Hua (Barry Song) wrote:
>>>>>>> From: John Hubbard [mailto:jhubbard@nvidia.com]
>>>>> ...
>>> But if you really disagree, then I'd go with, just drop the patch entirely, because
>>> it doesn't really make things better as written...IMHO anyway. :)
>>
>> Just imagine a case, we don't enable DEBUG_FS but we enable GUP_TEST, we will
>> get an image with totally useless code section since GUP_TEST depends on debugfs
>> entry to perform any useful functionality.
>>
> 
> Looking at the choices, from the user's (usually kernel developer's) experience:
> 
> a) The user enables GUP_TEST, then boots up, runs, and is briefly surprised by a
> runtime failure. But it's a very quick diagnosis: "open: No such file or directory",
> when trying to make that ioctl call. The path indicates that it's a debug fs path,
> so the solution is pretty clear, at least for the main audience.
> 
> b) The other choice: the user *never even sees* GUP_TEST as a choice. This especially
> bothers me because sometimes you find things by poking around in the menu, although
> of course "you should already know about it"...but there's a lot to "already know"
> in a large kernel.
> 
>  From a user experience, it's way better to simply see what you want, and select it
> in the menu. Or, at least get some prompt that you need to pre-select something else.
> 

...and again, this is all fallout from Kconfig. I might be missing some advanced
feature, because it seems surprising to only be allowed to choose between
missing dependencies (which this patch would correct), or a poorer user experience
(which I argue that this patch would also provide).

Ideally, we'd just set up the dependencies, and then have some options for
visibility, but I'm not aware of any way to do that...and after a quick peek
at Documentation/kbuild/kconfig-macro-language.rst it looks pretty bare bones.

thanks,
-- 
John Hubbard
NVIDIA
