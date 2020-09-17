Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C3F26E5DF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgIQT5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:57:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45754 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgIQT5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 15:57:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HFibjQ039739;
        Thu, 17 Sep 2020 16:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Kl+4zTu2R7thxnNUNJ9t6757FiAB7t1BqPhVJLcoaz0=;
 b=FJwd5NAfO4ZJxqML6dmt90W2qDtF2SGZBdxX8aTaUXdda5yYwSFt6uF68TK4GPA8ceWu
 POYI8blmcSt/wLnLQwqyQyzWm9G0gNdBfr4roBzh6hary7T76R1bVr71zKEIVlW16PdP
 qrq6fw0BVzBlzEy5HVExBqJDfqcNIpsVTWmXATkZ5w9Sq6sdrzr6k4eKyITWbi2lIsWy
 MYKqhIEYoYo+GO2F4qby6DNg2L6bfMAwOJ6mk5SVwfOKfXliIbgAaOQzF+v4l7haCklR
 4XASxd8N3lq/CFhWmKTaXG+ufdAclYYFPbVFMQtA29xPvZRcx6RbAtEC+ed0gGYs/xYy XQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33j91duw32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 16:04:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HFjnTC048520;
        Thu, 17 Sep 2020 16:04:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33h88brwkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 16:04:02 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08HG3rBG001943;
        Thu, 17 Sep 2020 16:03:53 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Sep 2020 16:03:52 +0000
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id E82FB6A013C; Thu, 17 Sep 2020 12:05:17 -0400 (EDT)
Date:   Thu, 17 Sep 2020 12:05:17 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Thomas Tai <thomas.tai@oracle.com>
Cc:     m.szyprowski@samsung.com, hch@lst.de, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] dma-direct: Fix potential NULL pointer dereference
Message-ID: <20200917160517.GB10122@char.us.oracle.com>
References: <1600289466-23805-1-git-send-email-thomas.tai@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600289466-23805-1-git-send-email-thomas.tai@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009170120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 02:51:06PM -0600, Thomas Tai wrote:
> When booting the kernel v5.9-rc4 on a VM, the kernel would panic when
> printing a warning message in swiotlb_map(). The dev->dma_mask must not
> be a NULL pointer when calling the dma mapping layer. A NULL pointer check
> can potentially avoid the panic.
> 
> [drm] Initialized virtio_gpu 0.1.0 0 for virtio0 on minor 0
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: 0000 [#1] SMP PTI
>  CPU: 1 PID: 331 Comm: systemd-udevd Not tainted 5.9.0-rc4 #1
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
>  BIOS 1.13.0-1ubuntu1 04/01/2014
>  RIP: 0010:swiotlb_map+0x1ac/0x200
>  Code: e8 d9 fc ff ff 80 3d 92 ee 4c 01 00 75 51 49 8b 84 24 48 02 00 00
>  4d 8b 6c 24 50 c6 05 7c ee 4c 01 01 4d 8b bc 24 58 02 00 00 <4c> 8b 30
>  4d 85 ed 75 04 4d 8b 2c 24 4c 89 e7 e8 10 6b 4f 00 4d 89
>  RSP: 0018:ffff9f96801af6f8 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000080
>  RDX: 000000000000007f RSI: 0000000000000202 RDI: 0000000000000202
>  RBP: ffff9f96801af748 R08: ffffffffffffffff R09: 0000000000000020
>  R10: 0000000000000000 R11: ffff8fabfffa3000 R12: ffff8faad02c7810
>  R13: 0000000000000000 R14: 0000000000000020 R15: 0000000000000000
>  FS:  00007fabc63588c0(0000) GS:ffff8fabf7c80000(0000)
>  knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000000 CR3: 0000000151496005 CR4: 0000000000370ee0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   dma_direct_map_sg+0x124/0x210
>   dma_map_sg_attrs+0x32/0x50
>   drm_gem_shmem_get_pages_sgt+0x6a/0x90 [drm]
>   virtio_gpu_object_create+0x140/0x2f0 [virtio_gpu]
>   ? ww_mutex_unlock+0x26/0x30
>   virtio_gpu_mode_dumb_create+0xab/0x160 [virtio_gpu]
>   drm_mode_create_dumb+0x82/0x90 [drm]
>   drm_client_framebuffer_create+0xaa/0x200 [drm]
>   drm_fb_helper_generic_probe+0x59/0x150 [drm_kms_helper]
>   drm_fb_helper_single_fb_probe+0x29e/0x3e0 [drm_kms_helper]
>   __drm_fb_helper_initial_config_and_unlock+0x41/0xd0 [drm_kms_helper]
>   drm_fbdev_client_hotplug+0xe6/0x1a0 [drm_kms_helper]
>   drm_fbdev_generic_setup+0xaf/0x170 [drm_kms_helper]
>   virtio_gpu_probe+0xea/0x100 [virtio_gpu]
>   virtio_dev_probe+0x14b/0x1e0 [virtio]
>   really_probe+0x1db/0x440
>   driver_probe_device+0xe9/0x160
>   device_driver_attach+0x5d/0x70
>   __driver_attach+0x8f/0x150
>   ? device_driver_attach+0x70/0x70
>   bus_for_each_dev+0x7e/0xc0
>   driver_attach+0x1e/0x20
>   bus_add_driver+0x152/0x1f0
>   driver_register+0x74/0xd0
>   ? 0xffffffffc0529000
>   register_virtio_driver+0x20/0x30 [virtio]
>   virtio_gpu_driver_init+0x15/0x1000 [virtio_gpu]
>   do_one_initcall+0x4a/0x1fa
>   ? _cond_resched+0x19/0x30
>   ? kmem_cache_alloc_trace+0x16b/0x2e0
>   do_init_module+0x62/0x240
>   load_module+0xe0e/0x1100
>   ? security_kernel_post_read_file+0x5c/0x70
>   __do_sys_finit_module+0xbe/0x120
>   ? __do_sys_finit_module+0xbe/0x120
>   __x64_sys_finit_module+0x1a/0x20
>   do_syscall_64+0x38/0x50
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Thomas Tai <thomas.tai@oracle.com>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> ---
>  include/linux/dma-direct.h |  3 ---
>  kernel/dma/mapping.c       | 11 +++++++++++
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index 6e87225..0648708 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -62,9 +62,6 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
>  {
>  	dma_addr_t end = addr + size - 1;
>  
> -	if (!dev->dma_mask)
> -		return false;
> -
>  	if (is_ram && !IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
>  	    min(addr, end) < phys_to_dma(dev, PFN_PHYS(min_low_pfn)))
>  		return false;
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 0d12942..7133d5c 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -144,6 +144,10 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
>  	dma_addr_t addr;
>  
>  	BUG_ON(!valid_dma_direction(dir));
> +
> +	if (WARN_ON_ONCE(!dev->dma_mask))
> +		return DMA_MAPPING_ERROR;
> +
>  	if (dma_map_direct(dev, ops))
>  		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
>  	else
> @@ -179,6 +183,10 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>  	int ents;
>  
>  	BUG_ON(!valid_dma_direction(dir));
> +
> +	if (WARN_ON_ONCE(!dev->dma_mask))
> +		return 0;
> +
>  	if (dma_map_direct(dev, ops))
>  		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
>  	else
> @@ -213,6 +221,9 @@ dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
>  
>  	BUG_ON(!valid_dma_direction(dir));
>  
> +	if (WARN_ON_ONCE(!dev->dma_mask))
> +		return DMA_MAPPING_ERROR;
> +
>  	/* Don't allow RAM to be mapped */
>  	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
>  		return DMA_MAPPING_ERROR;
> -- 
> 1.8.3.1
> 
