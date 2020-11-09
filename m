Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8B32AB1DC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 08:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgKIHqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 02:46:03 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2863 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIHqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 02:46:02 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa8f3be0000>; Sun, 08 Nov 2020 23:46:06 -0800
Received: from [10.2.49.75] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Nov
 2020 07:45:57 +0000
Subject: Re: [PATCH v2] mm/gup_test: GUP_TEST depends on DEBUG_FS
To:     Barry Song <song.bao.hua@hisilicon.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Ralph Campbell <rcampbell@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        John Garry <john.garry@huawei.com>
References: <20201108083732.15336-1-song.bao.hua@hisilicon.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <cf1b1b35-c608-9b5e-0c1a-216431b83750@nvidia.com>
Date:   Sun, 8 Nov 2020 23:45:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201108083732.15336-1-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604907966; bh=SdZB+6OvR+B2m6Dr8AYTdQURpW4L9D2aslhmIOhFRFc=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=d5ei2FuMITj7tyXBKpA5nYPJ5X9cK8bsxQmZjka6pWKPNmoespYSTPkCxr4Fe58HV
         oaWFayBcFPbXfsPsmmAoK0JoDEcICmeuwt0BcImwTMb5usNY+lJd46sxMB+HWCee0q
         28wRkgqh4foqfZnXpjffvtaQHsxKp6GWtLxnTF+u9vkTI9ONgmFJsdlM8fxLEd+tVP
         zG8ruJMqHExQYxoyub1A34GC+MPrypnG6v26UnMGj+4bwz+WmIryDPL+UvTbE+4vDq
         Vi31EAk7HiJnz5mAgtGgpfMk1+zk1s6kxbspbZWw0wSH1MCba06eJRf2vUbMdNKL4S
         4JlyYPaFBex1g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/20 12:37 AM, Barry Song wrote:
> Without DEBUG_FS, all the code in gup_test becomes meaningless. For sure
> kernel provides debugfs stub while DEBUG_FS is disabled, but the point
> here is that GUP_TEST can do nothing without DEBUG_FS.
> 
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>   -v2:
>   add comment as a prompt to users as commented by John and Randy, thanks!
> 
>   mm/Kconfig | 4 ++++
>   1 file changed, 4 insertions(+)

Thanks for suffering through a lot of discussion about this!

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 01b0ae0cd9d3..a7ff0d31afd5 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -836,6 +836,7 @@ config PERCPU_STATS
>   
>   config GUP_TEST
>   	bool "Enable infrastructure for get_user_pages()-related unit tests"
> +	depends on DEBUG_FS
>   	help
>   	  Provides /sys/kernel/debug/gup_test, which in turn provides a way
>   	  to make ioctl calls that can launch kernel-based unit tests for
> @@ -853,6 +854,9 @@ config GUP_TEST
>   
>   	  See tools/testing/selftests/vm/gup_test.c
>   
> +comment "GUP_TEST needs to have DEBUG_FS enabled"
> +	depends on !GUP_TEST && !DEBUG_FS
> +
>   config GUP_GET_PTE_LOW_HIGH
>   	bool
>   
> 


