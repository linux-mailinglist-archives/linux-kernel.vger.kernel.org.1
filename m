Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB782FFA40
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 03:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbhAVB73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 20:59:29 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11474 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbhAVB72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 20:59:28 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DMMpT0L3rzjBtN;
        Fri, 22 Jan 2021 09:57:37 +0800 (CST)
Received: from [10.174.177.2] (10.174.177.2) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Fri, 22 Jan 2021
 09:58:36 +0800
Subject: Re: [PATCH] mm/zswap: Add return value in zswap_frontswap_load
To:     Nathan Chancellor <natechancellor@gmail.com>
CC:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tian Tao <tiantao6@hisilicon.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210121214804.926843-1-natechancellor@gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2438a24b-b312-dc91-0ebd-63e3baa2ad6b@huawei.com>
Date:   Fri, 22 Jan 2021 09:58:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210121214804.926843-1-natechancellor@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.2]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/1/22 5:48, Nathan Chancellor wrote:
> Clang warns:
> 
> mm/zswap.c:1271:6: warning: variable 'ret' is used uninitialized
> whenever 'if' condition is true [-Wsometimes-uninitialized]
>         if (!entry->length) {
>             ^~~~~~~~~~~~~~
> mm/zswap.c:1322:9: note: uninitialized use occurs here
>         return ret;
>                ^~~
> mm/zswap.c:1271:2: note: remove the 'if' if its condition is always
> false
>         if (!entry->length) {
>         ^~~~~~~~~~~~~~~~~~~~~
> mm/zswap.c:1259:9: note: initialize the variable 'ret' to silence this
> warning
>         int ret;
>                ^
>                 = 0
> 1 warning generated.
> 
> Prior to "mm/zswap: add the flag can_sleep_mapped", this path always
> returned 0. Restore that so we are not returning uninitialized memory.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1263
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Reported-by: kernel test robot <lkp@intel.com>

Looks like commit 6753c561f653 ("mm/zswap: add the flag can_sleep_mapped") introduced this warning.

> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> Andrew, please fold this into
> 
> mm-zswap-add-the-flag-can_sleep_mapped.patch
> 
>  mm/zswap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 6e0bb61d2a2c..a85334b719b9 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1272,6 +1272,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
>  		dst = kmap_atomic(page);
>  		zswap_fill_page(dst, entry->value);
>  		kunmap_atomic(dst);
> +		ret = 0;
>  		goto freeentry;
>  	}
>  
> 
> base-commit: bc085f8fc88fc16796c9f2364e2bfb3fef305cad
> 

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
