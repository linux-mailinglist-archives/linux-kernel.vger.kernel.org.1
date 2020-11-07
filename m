Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A64F2AA1AE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 01:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgKGAMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 19:12:51 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1221 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbgKGAMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 19:12:50 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa5e6800000>; Fri, 06 Nov 2020 16:12:48 -0800
Received: from [10.2.49.167] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 7 Nov
 2020 00:12:49 +0000
Subject: Re: [PATCH] mm/gup_benchmark: GUP_BENCHMARK depends on DEBUG_FS
To:     Barry Song <song.bao.hua@hisilicon.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Ralph Campbell <rcampbell@nvidia.com>,
        John Garry <john.garry@huawei.com>
References: <20201104100552.20156-1-song.bao.hua@hisilicon.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <e8ecbf3e-438e-934e-0335-ec9b3e097022@nvidia.com>
Date:   Fri, 6 Nov 2020 16:12:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201104100552.20156-1-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604707968; bh=uICF5ObOMOjytBPfkDS/1DO5kpUvXA8svTRrvMMdFPY=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=hLu0XYwqfqnbxZH6oa6TXqnUa5lw25VnW4Vsr1wf9tTfdbMkkhem/Kkie1rNRYcrv
         lI9rNLW17p0AtujAm0xhxIi5iXCWVLrDhu5OmO+fAdPwpexvo4dDb/ilG1N1GYLO8e
         EyuQyZEapjHx3YgnN9nyoyGPustKmycXD+c5wKczVQUxZB0qyVJxN3Xqp7VoaxAX7f
         JEoALhSBZVx1wSrQ1ds5PAOUjAwWGbQ4kir7C5f2+OxMqwrYHgNcS9LGLF3L9nt2hn
         CZO8gMHdJEkOorlF2HOZkGh06c2y79RLWUZHoEewONcvfD00uZzPIm5q4FjJXcvizI
         mjK26qab7m3OA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/20 2:05 AM, Barry Song wrote:
> Without DEBUG_FS, all the code in gup_benchmark becomes meaningless.
> For sure kernel provides debugfs stub while DEBUG_FS is disabled, but
> the point here is that GUP_BENCHMARK can do nothing without DEBUG_FS.
> 
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Inspired-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>   * inspired by John's comment in this patch:
>   https://lore.kernel.org/linux-iommu/184797b8-512e-e3da-fae7-25c7d662648b@huawei.com/
> 
>   mm/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index d42423f..91fa923 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -836,6 +836,7 @@ config PERCPU_STATS
>   
>   config GUP_BENCHMARK
>   	bool "Enable infrastructure for get_user_pages() and related calls benchmarking"
> +	depends on DEBUG_FS


I think "select DEBUG_FS" is better here. "depends on" has the obnoxious behavior
of hiding the choice from you, if the dependencies aren't already met. Whereas what
the developer *really* wants is a no-nonsense activation of the choice: "enable
GUP_BENCHMARK and the debug fs that it requires".

So depends on really on is better for things that you just can't control, such as
the cpu arch you're on, etc.

Also note that this will have some minor merge conflict with mmotm, Due to renaming
to GUP_TEST. No big deal though.


thanks,
-- 
John Hubbard
NVIDIA
