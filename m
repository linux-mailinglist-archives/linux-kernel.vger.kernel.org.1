Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFDF2A0C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 18:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgJ3RCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 13:02:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60056 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726095AbgJ3RCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 13:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604077361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=heAoO8vJI0LuOEKNNcuQJaZtkMbQJQagUyG1mLKCrwU=;
        b=hO8JXnHOsm7zTWHv7L8y2TVfu9ECUOhPFkOszxl+yYZ20i5l2iFQuMIjPdYFcU6WEbTt5G
        QItCOjQqJEklPgl1w+z4M5k0aCfztcMHY2Qv+qkH5iz5lLIpnoMDu1tevp400vLOYY/Iui
        2YzKc01VaSHG/k7xhXr7nBJ8e35eAsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-qC1xMEi7OcS_LorT23wBGA-1; Fri, 30 Oct 2020 13:02:39 -0400
X-MC-Unique: qC1xMEi7OcS_LorT23wBGA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 437AE802EDA;
        Fri, 30 Oct 2020 17:02:37 +0000 (UTC)
Received: from w520.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D59719656;
        Fri, 30 Oct 2020 17:02:36 +0000 (UTC)
Date:   Fri, 30 Oct 2020 11:02:35 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>, Zeng Xin <xin.zeng@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v6 1/5] vfio/mdev: Register mdev bus earlier during boot
Message-ID: <20201030110235.0229654c@w520.home>
In-Reply-To: <20201030045809.957927-2-baolu.lu@linux.intel.com>
References: <20201030045809.957927-1-baolu.lu@linux.intel.com>
        <20201030045809.957927-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 12:58:05 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Move mdev bus registration earlier than IOMMU probe processing so that
> the IOMMU drivers could be able to set iommu_ops for the mdev bus. This
> only applies when vfio-mdev module is setected to be built-in.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---

Most kernels will build this as a module, so having different behavior
and apparently different IOMMU support for built-in vs module is
broken.  Thanks,

Alex

>  drivers/vfio/mdev/mdev_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index b558d4cfd082..6b9ab71f89e7 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -417,8 +417,12 @@ static void __exit mdev_exit(void)
>  	mdev_bus_unregister();
>  }
>  
> +#if IS_BUILTIN(CONFIG_VFIO_MDEV)
> +postcore_initcall(mdev_init)
> +#else
>  module_init(mdev_init)
>  module_exit(mdev_exit)
> +#endif /* IS_BUILTIN(CONFIG_VFIO_MDEV) */
>  
>  MODULE_VERSION(DRIVER_VERSION);
>  MODULE_LICENSE("GPL v2");

