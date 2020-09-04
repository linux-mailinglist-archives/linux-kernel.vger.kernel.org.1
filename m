Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E379B25E17E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 20:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIDSaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 14:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgIDSaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 14:30:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A79C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 11:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=u57HCbbo/U9xGCFmuh/B7qrQY5Pwi48i+mgDDmKW8zQ=; b=Ow3E4S2mrJf2o3M7SDusR2C/5n
        QidmcA3Z5NX64nyw+VwvdNALNBq4XCRYXaFftHI9RNCNllJTbvoTrCn5ahZ0fJiPmJLhdodygOBRP
        4TSYF+CAoM2z7mOE9Hlp4DcQ6Am8rR8LNncbuj1ZaVgN6adwMMAnKBkA5ejIX8O5K7hV8oLAfdsus
        xodBKk10VfxDZ3khBzOu26sqE9RXGGBmEL0lQHWTMiVn6eC5CLqvVX4O5/nOGTlGuaH1lLbK+rGFt
        sCwbLDqexttRgR4Bu44Wt5hrbKQDomLdIgdASz2fD+8Ry3Zcd59UMQQqSCBhEDe+zZeZKW0KcNMz+
        EXB9PCcQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEGTI-0006d8-Bt; Fri, 04 Sep 2020 18:30:00 +0000
Subject: Re: [PATCH] drm: xlnx: fix build warning & errors when DMADEVICES is
 not set
From:   Randy Dunlap <rdunlap@infradead.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     kernel test robot <lkp@intel.com>
References: <1f7bdabb-e28b-2cc1-5fbd-92c381299ba9@infradead.org>
Message-ID: <58bb811e-7ca5-10e9-fcab-39fd5bdc857d@infradead.org>
Date:   Fri, 4 Sep 2020 11:29:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1f7bdabb-e28b-2cc1-5fbd-92c381299ba9@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/20 9:41 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kconfig warnings & build errors caused by DRM_ZYNQMP_DPSUB.
> 
> Any driver that selects DMA_ENGINE should make sure that
> DMADEVICES is already enabled.
> As is, this causes build errors in many other drivers.
> 
> See https://lore.kernel.org/lkml/202009020239.oUPh82Xc%25lkp@intel.com/
> for the numerous build errors.
> 
> WARNING: unmet direct dependencies detected for DMA_ENGINE
>   Depends on [n]: DMADEVICES [=n]
>   Selected by [y]:
>   - DRM_ZYNQMP_DPSUB [=y] && HAS_IOMEM [=y] && (ARCH_ZYNQMP || COMPILE_TEST [=y]) && COMMON_CLK [=y] && DRM [=y] && OF [=y]
> 

Sorry, this is a duplicate of a patch that Laurent has already posted
so my patch isn't needed.

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Hyun Kwon <hyun.kwon@xilinx.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/xlnx/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20200903.orig/drivers/gpu/drm/xlnx/Kconfig
> +++ linux-next-20200903/drivers/gpu/drm/xlnx/Kconfig
> @@ -2,6 +2,7 @@ config DRM_ZYNQMP_DPSUB
>  	tristate "ZynqMP DisplayPort Controller Driver"
>  	depends on ARCH_ZYNQMP || COMPILE_TEST
>  	depends on COMMON_CLK && DRM && OF
> +	depends on DMADEVICES
>  	select DMA_ENGINE
>  	select DRM_GEM_CMA_HELPER
>  	select DRM_KMS_CMA_HELPER
> 


-- 
~Randy

