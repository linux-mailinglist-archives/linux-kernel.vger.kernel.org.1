Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9E51CB6A5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 20:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgEHSFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 14:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726756AbgEHSFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:05:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C190C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=el9E5/pENx0u9FAEs3KmKFtgNwsJ96Jy19SzD82IMKw=; b=QcyxHiFX3Qvnnfy7yKCg9MarsW
        HnaAvV+RBs5aYeksWZFzRTfbVCngS/KVSk/Z2epq7u/ZncaW/D5EHvLWIbd4Upk8PsDZ1GqeISScF
        is6nTMQfiBdqkK2onRcwmEVABvhy702qcR0CR+r8xmgfNH8FDBrZj1524gpVEazDTOg1GRkXu3XGa
        xeiiJMQgMbstLgaRBrXfYb262lnovB3/8PTo5W/Tfx+BzivjoeEc+EQHpkW+afHHg+ka+BiWLa/dW
        GC/pkfAO2qM5kIEdGOFnZGQKEWxrixZiT+DIBIRqMUgtmEDVZ0a9OUp7YBAZQQB+8Tf15/lE8vyWY
        tzr0EJFA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX7NH-00018l-SF; Fri, 08 May 2020 18:05:27 +0000
Subject: Re: [PATCH 2/2] nouveau: fix dependencies for DEVICE_PRIVATE
To:     Arnd Bergmann <arnd@arndb.de>, Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20200508144017.3501418-1-arnd@arndb.de>
 <20200508144017.3501418-2-arnd@arndb.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a84bb114-c2c2-b15a-4e00-89e4abd01564@infradead.org>
Date:   Fri, 8 May 2020 11:05:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508144017.3501418-2-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/20 7:40 AM, Arnd Bergmann wrote:
> CONFIG_DEVICE_PRIVATE cannot be selected in configurations
> without ZONE_DEVICE:
> 
> WARNING: unmet direct dependencies detected for DEVICE_PRIVATE
>   Depends on [n]: ZONE_DEVICE [=n]
>   Selected by [y]:
>   - DRM_NOUVEAU_SVM [=y] && HAS_IOMEM [=y] && DRM_NOUVEAU [=y] && MMU [=y] && STAGING [=y]
> kernel/resource.c:1653:28: error: use of undeclared identifier 'PA_SECTION_SHIFT'
>         size = ALIGN(size, 1UL << PA_SECTION_SHIFT);
>                                   ^
> kernel/resource.c:1654:48: error: use of undeclared identifier 'MAX_PHYSMEM_BITS'
> 
> Add a dependency for Nouveau to avoid broken randconfig builds.
> 
> Fixes: d2c63df2242e ("mm/hmm: make CONFIG_DEVICE_PRIVATE into a select")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/gpu/drm/nouveau/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
> index af5793f3e7c2..996ec5475908 100644
> --- a/drivers/gpu/drm/nouveau/Kconfig
> +++ b/drivers/gpu/drm/nouveau/Kconfig
> @@ -87,6 +87,7 @@ config DRM_NOUVEAU_BACKLIGHT
>  config DRM_NOUVEAU_SVM
>  	bool "(EXPERIMENTAL) Enable SVM (Shared Virtual Memory) support"
>  	depends on DRM_NOUVEAU
> +	depends on ZONE_DEVICE
>  	depends on MMU
>  	depends on STAGING
>  	select DEVICE_PRIVATE
> 


-- 
~Randy

