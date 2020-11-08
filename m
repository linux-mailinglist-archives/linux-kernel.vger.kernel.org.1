Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2862AA91C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 05:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgKHE4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 23:56:04 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10701 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgKHE4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 23:56:03 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa77a670000>; Sat, 07 Nov 2020 20:56:07 -0800
Received: from [10.2.62.222] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 8 Nov
 2020 04:56:00 +0000
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
 <869059977c224a3aa31bfb42a4a8148d@hisilicon.com>
 <dd9e5f78-d627-89d6-2b9d-f2912213171f@nvidia.com>
 <8eaa47c0-a62d-46da-4fd6-93f2b5b2910d@nvidia.com>
 <e08c812d-80bf-12ec-794e-a726a1b37433@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <28eb72a6-37de-6e60-9127-d1678aac5f5c@nvidia.com>
Date:   Sat, 7 Nov 2020 20:55:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e08c812d-80bf-12ec-794e-a726a1b37433@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604811367; bh=n7JohPxe47NLq/s+5NVOBn2IMVPA0oA7c5Ar0Cznu4w=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=enZ9dg3PPDfsIiVrzre9R206Hh5/rbXMJUuhYxcqjfzSY2cu8qyTKo6RVLJwH0Gmm
         KVCMvUoEPmYxJtTTeQTS8bQox6JWGVJbj72Pwl5YJ/o75FJvs0GOXMulX3rAYUIQuh
         M35ntpU3XMpbU58ZbHTSDxo1a/7ba1qgwcFiJOiQEbArpaT20HAZl2yDQv0jyqmRri
         hh9ql7ErfUrQ6L5PFvVPiPJLPKTal1qWWQ1risEwnp41sn0xNMc6dkDYaVW2ALTHee
         nKpDcxnnpyDo3l5LTbn+Qn9uWNysclhLkC82Grr34PgWRzXwiLUAVULf4QNpOL6Ltx
         DlgNcCOUH2qww==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/20 8:11 PM, Randy Dunlap wrote:
...
> Look at kconfig-language.rst instead.

aha, yes.

> 
> One thing that could be done (and is done in a few places for other reasons) is to add
> a Kconfig comment if DEBUG_FS is not enabled:
> 
> comment "GUP_TEST needs to have DEBUG_FS enabled"
> 	depends on !GUP_TEST && !DEBUG_FS
> 

Sweet--I just applied that here, and it does exactly what I wanted: puts a nice clear
message on the "make menuconfig" screen. No more hidden item. Brilliant!

Let's go with that, shall we?

thanks,
-- 
John Hubbard
NVIDIA
