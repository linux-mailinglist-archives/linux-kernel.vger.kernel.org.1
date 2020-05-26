Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 616FF1A3BE1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 23:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgDIVYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 17:24:46 -0400
Received: from mail-eopbgr680059.outbound.protection.outlook.com ([40.107.68.59]:54247
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726964AbgDIVYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:24:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4lL+zNrN2DFaCaXpOgHFyiMt5OCP2WP7gPbF75OaLwqKVhKVqsiBPUYwgUx2zzxZCXnM804OGVapPIJEMg8mxYsO1O60RpwCqnw45N+nSEQ8F74q+gHAzbfSUacExX2AVR4R+vP7s7WKOjSurcsDCM0C/bk63NXSqpDDS0F/dkwVKcGoPD/DKFBouzRBJ1htFNg90jpWoXUI23f9WGP6pUYjCVkRuxaiPw5Hb/YH03GbWWx3Euy3sWfvIPECpIlbpkF6ogJ22s1/lU8z0Fcmc2nY3cd1F1Xg4U17iQvX/ti3a72HqfrQxJc2GJbYIW0zxEbHILENYvUeokU3W/6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGXLXZnZ+YSQczY6b7DJllJCuzsOUrQrrK+mivSWhHE=;
 b=OrIwbVKkMTtU3mZwT04fcbUHEA0wvmP+rm5ueJjllgF7YST2rDER7FWfOxIv51XXwbl+bjtwsyJ5j0of9ddLq8WPiKCm2OEuis9RUsXyBNuwszBIMucVpHgFCBhFP9cNsxyxruhVe+Xn12uCbj7c3RU0TYdZYunvVG/hPfCC148hH+g7G80c7pQlBEAJameJz+CX00rcmwpHT0y0DcbWdbie+R5kcZEYqSoP4utGDBZMrpR8VdznbD/FidpZBWNsGeurVjEZnL/5CNYCWrZh/9dpzzL6KBJq3kd5zflMH8+i0iFbQXqOCVNwyI1n7gDfvPqJBYsP8vajSCEzDC4nkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGXLXZnZ+YSQczY6b7DJllJCuzsOUrQrrK+mivSWhHE=;
 b=1FvJ7IUiExe3P3Dm09WxhG+q9Rxu6mY6BKNiUtvOp0TQ1T/v/wFqgyhxh97qNeTUoUASKOKqie3dTdvw32w7tY/kmLkQJBaW7E9p7YCpWxiX/UEoUHIA5/aOGkcIJq/UFl4SYsqAIGLaW1qw/0ZSQM3pxDCO51yYNmhF6UL7muM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB3097.namprd12.prod.outlook.com (2603:10b6:5:11d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 9 Apr
 2020 21:24:43 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733%7]) with mapi id 15.20.2878.022; Thu, 9 Apr 2020
 21:24:43 +0000
Subject: Re: [rfc v2 4/6] dma-direct: atomic allocations must come from atomic
 coherent pools
To:     David Rientjes <rientjes@google.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com>
 <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com>
 <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2004081420060.19661@chino.kir.corp.google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <26df6b35-af63-bf17-0c21-51684afa6f67@amd.com>
Date:   Thu, 9 Apr 2020 16:24:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <alpine.DEB.2.21.2004081420060.19661@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0011.namprd21.prod.outlook.com
 (2603:10b6:805:106::21) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN6PR2101CA0011.namprd21.prod.outlook.com (2603:10b6:805:106::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.6 via Frontend Transport; Thu, 9 Apr 2020 21:24:42 +0000
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff6c936e-96ad-4475-a839-08d7dccc6b56
X-MS-TrafficTypeDiagnostic: DM6PR12MB3097:|DM6PR12MB3097:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB309745FACE7A20CC468F4651ECC10@DM6PR12MB3097.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(54906003)(81156014)(16526019)(8936002)(81166007)(5660300002)(6486002)(4326008)(31696002)(66946007)(31686004)(86362001)(66556008)(478600001)(66476007)(186003)(110136005)(52116002)(53546011)(6506007)(26005)(2906002)(316002)(6512007)(2616005)(8676002)(956004)(36756003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xlPZ92xiPlcf/JMG9AANmtB9PJoqSzIkVIZywbyDexbpqyexUad4C9oU5x3pJRc1JizaoJfeXsBS+m6CIACoONORmn1r9157KlkZXMzU+WdymBRESj0YtkhEXerXOMzLG5l0Eboc1wy1eWqBxY0PoOGdh/no4pyB7Eubgi4XveF059Kti6pi3ybVCoZApRsHScV3cc/0JWvMwAIvJLrxEgOBebt7oiJ/7dWCIBPYRX8eYle4l2BrrXbekpYDqifhNA3tEXQmr28DIXRrY+lmA/SHe+f8ZLWYzBEaQGgTe0Tg+2yq5Gsd2Ewrji6zcPJqVQ1FDAUlsUeCebAEENc3J5IJznwJXPikIXuHJfNBP2wK12127TX84gEmyfI6a97OBjH/Poz9Y2eKEnc/GGFoxZIoKtptNrpfY/2FrT9tfIC+arTTBFgUq7CYk6tUZH8Q
X-MS-Exchange-AntiSpam-MessageData: SmSYeAK4ShsOIg7GQu1Rn6WIWoU+X0NT4It9M8LA4yOcZUiyShvI8KxPpJhj02mU/O7P7Pc5BBT7Bd8H8Z8zNOOyXEVHPXT8kW6DLZjIRQPTfhZw7MLpnCO7/+d8iNp81Fh0eze/DdSWVt8M6W19Wg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6c936e-96ad-4475-a839-08d7dccc6b56
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 21:24:42.9734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9WXkSJMZ61tVPbEjo6KnNPvfd38HhO5QUzuiHUzN32UfU8P7IcBE77YUQ20JDYFt+6I6Iw8MFMGCDG0ZbZLig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/20 4:21 PM, David Rientjes wrote:
> When a device required unencrypted memory and the context does not allow

required => requires

> blocking, memory must be returned from the atomic coherent pools.
> 
> This avoids the remap when CONFIG_DMA_DIRECT_REMAP is not enabled and the
> config only requires CONFIG_DMA_COHERENT_POOL.  This will be used for
> CONFIG_AMD_MEM_ENCRYPT in a subsequent patch.
> 
> Keep all memory in these pools unencrypted.
> 
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>   kernel/dma/direct.c | 16 ++++++++++++++++
>   kernel/dma/pool.c   | 15 +++++++++++++--
>   2 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 70800ca64f13..44165263c185 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -124,6 +124,18 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>   	struct page *page;
>   	void *ret;
>   
> +	/*
> +	 * Unencrypted memory must come directly from DMA atomic pools if
> +	 * blocking is not allowed.
> +	 */
> +	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
> +	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp)) {
> +		ret = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &page, gfp);
> +		if (!ret)
> +			return NULL;
> +		goto done;
> +	}
> +
>   	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
>   	    dma_alloc_need_uncached(dev, attrs) &&
>   	    !gfpflags_allow_blocking(gfp)) {
> @@ -203,6 +215,10 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
>   {
>   	unsigned int page_order = get_order(size);
>   
> +	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
> +	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
> +		return;
> +
>   	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
>   	    !force_dma_unencrypted(dev)) {
>   		/* cpu_addr is a struct page cookie, not a kernel address */
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index e14c5a2da734..6685ab89cfa7 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -9,6 +9,7 @@
>   #include <linux/dma-contiguous.h>
>   #include <linux/init.h>
>   #include <linux/genalloc.h>
> +#include <linux/set_memory.h>
>   #include <linux/slab.h>
>   #include <linux/vmalloc.h>
>   #include <linux/workqueue.h>
> @@ -55,12 +56,20 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>   
>   	arch_dma_prep_coherent(page, pool_size);
>   
> +#ifdef CONFIG_DMA_DIRECT_REMAP
>   	addr = dma_common_contiguous_remap(page, pool_size,
>   					   pgprot_dmacoherent(PAGE_KERNEL),
>   					   __builtin_return_address(0));
>   	if (!addr)
>   		goto free_page;
> -
> +#else
> +	addr = page_to_virt(page);
> +#endif
> +	/*
> +	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
> +	 * shrink so no re-encryption occurs in dma_direct_free_pages().
> +	 */
> +	set_memory_decrypted((unsigned long)page_to_virt(page), 1 << order);
>   	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
>   				pool_size, NUMA_NO_NODE);
>   	if (ret)
> @@ -69,8 +78,10 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>   	return 0;
>   
>   remove_mapping:
> +#ifdef CONFIG_DMA_DIRECT_REMAP
>   	dma_common_free_remap(addr, pool_size);

You're about to free the memory, but you've called set_memory_decrypted() 
against it, so you need to do a set_memory_encrypted() to bring it back to 
a state ready for allocation again.

Thanks,
Tom

> -free_page:
> +#endif
> +free_page: __maybe_unused
>   	if (!dma_release_from_contiguous(NULL, page, 1 << order))
>   		__free_pages(page, order);
>   out:
> 
