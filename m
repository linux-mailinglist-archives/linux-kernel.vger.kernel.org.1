Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3972CEFB9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 15:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgLDObw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 09:31:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55421 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726312AbgLDObv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 09:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607092224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NYtWzmxXW6p6TC0ZIb/TrsYV07jgBGeTTEO3fKTwfek=;
        b=EtBGfvA+idc2kP3uwFxzUrEUDWtT4G0ijryIiw5iJ1bf1U5vjSgkROgLCdbzQg1HG7qD8V
        wJnwvzBGwOuyZBExd07wBoDFsPafq5syD9slfMpT8iY0fs7nTkj5w5eTTMoS9Tb4CHqJSt
        TvSXlvR5js8DjwJVZeyy2/5+HvUGDvk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-C8KL2PdxMsGRXvzKvQYXTg-1; Fri, 04 Dec 2020 09:30:21 -0500
X-MC-Unique: C8KL2PdxMsGRXvzKvQYXTg-1
Received: by mail-wm1-f71.google.com with SMTP id a205so1909847wme.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 06:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NYtWzmxXW6p6TC0ZIb/TrsYV07jgBGeTTEO3fKTwfek=;
        b=S2SypnF1bcOhlskj/5/IrQdWHZ/1ocPWGTFDUZPy+keBgl/tp4vp60NZ3LNnyEyp6f
         jrR7iOn1nGeiXe8Zz2uaKeD9ZQ6ZfSiIus7tZQ+HDCBhWlYABB26qSuI79RUoKOlFl4s
         Wh4vLn3fHpSLYqNk72bDeqALJLpXbnZG4h4HXCMxQIM/45f0tveQ9PdPT/omSEjWWa8G
         KDo1Ap46NnOUM14FgAMaTPARFUL51wBpSAj/pTNn+O7ggldhH5AsA62hpy+Ealic65U+
         hwRq2rmAIWW5vLrQ6kZoL6bR+ifcCgrEQyuW0/XIRgt3MUOgzH/j0uhPiOkjx9I9xYtz
         PMTg==
X-Gm-Message-State: AOAM531Xsk8novnBKhrGXqT7wCqeUO7IopWfySXgI14CKZRSOezKZspz
        m8CO+pPyaRsMHaPd8t0/wmr4S+/TgND5EeYmiT5a4poZLKBWK1rOKfIU0tOUV2iaPCjLnr+BVHu
        iP+1BM9PkqFx3QCjWyE8IKGzz
X-Received: by 2002:a5d:6751:: with SMTP id l17mr1652566wrw.73.1607092220008;
        Fri, 04 Dec 2020 06:30:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2IxOGe5/0uKbL3ffpg7oxTX+R4a0BhPUCp84b6RFm7CwcJDLyBWh2JM9Ikj/r9Hznj5g7yA==
X-Received: by 2002:a5d:6751:: with SMTP id l17mr1652539wrw.73.1607092219716;
        Fri, 04 Dec 2020 06:30:19 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id h204sm3563439wme.17.2020.12.04.06.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 06:30:19 -0800 (PST)
Date:   Fri, 4 Dec 2020 15:30:16 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com
Subject: Re: [PATCH V2 17/19] vdpa: set the virtqueue num during register
Message-ID: <20201204143016.xdjptprvtuthcebg@steredhat>
References: <20201204040353.21679-1-jasowang@redhat.com>
 <20201204040353.21679-18-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201204040353.21679-18-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 12:03:51PM +0800, Jason Wang wrote:
>This patch delay the queue number setting to vDPA device
>registering. This allows us to probe the virtqueue numbers between
>device allocation and registering.
>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vdpa/ifcvf/ifcvf_main.c   | 5 ++---
> drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 ++---
> drivers/vdpa/vdpa.c               | 8 ++++----
> drivers/vdpa/vdpa_sim/vdpa_sim.c  | 4 ++--
> include/linux/vdpa.h              | 7 +++----
> 5 files changed, 13 insertions(+), 16 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
>index 8b4028556cb6..d65f3221d8ed 100644
>--- a/drivers/vdpa/ifcvf/ifcvf_main.c
>+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>@@ -438,8 +438,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 	}
>
> 	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
>-				    dev, &ifc_vdpa_ops,
>-				    IFCVF_MAX_QUEUE_PAIRS * 2);
>+				    dev, &ifc_vdpa_ops);
> 	if (adapter == NULL) {
> 		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
> 		return -ENOMEM;
>@@ -463,7 +462,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 	for (i = 0; i < IFCVF_MAX_QUEUE_PAIRS * 2; i++)
> 		vf->vring[i].irq = -EINVAL;
>
>-	ret = vdpa_register_device(&adapter->vdpa);
>+	ret = vdpa_register_device(&adapter->vdpa, IFCVF_MAX_QUEUE_PAIRS * 2);
> 	if (ret) {
> 		IFCVF_ERR(pdev, "Failed to register ifcvf to vdpa bus");
> 		goto err;
>diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>index 1fa6fcac8299..3c3eb2a02f76 100644
>--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>@@ -1940,8 +1940,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
> 	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
> 	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
>
>-	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
>-				 2 * mlx5_vdpa_max_qps(max_vqs));
>+	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops);
> 	if (IS_ERR(ndev))
> 		return ndev;
>
>@@ -1968,7 +1967,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
> 	if (err)
> 		goto err_res;
>
>-	err = vdpa_register_device(&mvdev->vdev);
>+	err = vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs));
> 	if (err)
> 		goto err_reg;
>
>diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>index a69ffc991e13..ba89238f9898 100644
>--- a/drivers/vdpa/vdpa.c
>+++ b/drivers/vdpa/vdpa.c
>@@ -61,7 +61,6 @@ static void vdpa_release_dev(struct device *d)
>  * initialized but before registered.
>  * @parent: the parent device
>  * @config: the bus operations that is supported by this device
>- * @nvqs: number of virtqueues supported by this device
>  * @size: size of the parent structure that contains private data
>  *
>  * Driver should use vdpa_alloc_device() wrapper macro instead of
>@@ -72,7 +71,6 @@ static void vdpa_release_dev(struct device *d)
>  */
> struct vdpa_device *__vdpa_alloc_device(struct device *parent,
> 					const struct vdpa_config_ops *config,
>-					int nvqs,
> 					size_t size)
> {
> 	struct vdpa_device *vdev;
>@@ -99,7 +97,6 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
> 	vdev->index = err;
> 	vdev->config = config;
> 	vdev->features_valid = false;
>-	vdev->nvqs = nvqs;
>
> 	err = dev_set_name(&vdev->dev, "vdpa%u", vdev->index);
> 	if (err)
>@@ -122,11 +119,14 @@ EXPORT_SYMBOL_GPL(__vdpa_alloc_device);
>  * vdpa_register_device - register a vDPA device
>  * Callers must have a succeed call of vdpa_alloc_device() before.
>  * @vdev: the vdpa device to be registered to vDPA bus
>+ * @nvqs: number of virtqueues supported by this device
>  *
>  * Returns an error when fail to add to vDPA bus
>  */
>-int vdpa_register_device(struct vdpa_device *vdev)
>+int vdpa_register_device(struct vdpa_device *vdev, int nvqs)
> {
>+	vdev->nvqs = nvqs;
>+
> 	return device_add(&vdev->dev);
> }
> EXPORT_SYMBOL_GPL(vdpa_register_device);
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index 6a90fdb9cbfc..b129cb4dd013 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -357,7 +357,7 @@ static struct vdpasim *vdpasim_create(void)
> 	else
> 		ops = &vdpasim_net_config_ops;
>
>-	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops, VDPASIM_VQ_NUM);
>+	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops);
> 	if (!vdpasim)
> 		goto err_alloc;
>
>@@ -393,7 +393,7 @@ static struct vdpasim *vdpasim_create(void)
> 	vringh_set_iotlb(&vdpasim->vqs[1].vring, vdpasim->iommu);
>
> 	vdpasim->vdpa.dma_dev = dev;
>-	ret = vdpa_register_device(&vdpasim->vdpa);
>+	ret = vdpa_register_device(&vdpasim->vdpa, VDPASIM_VQ_NUM);
> 	if (ret)
> 		goto err_iommu;
>
>diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>index 30bc7a7223bb..d9e9d17b9083 100644
>--- a/include/linux/vdpa.h
>+++ b/include/linux/vdpa.h
>@@ -244,18 +244,17 @@ struct vdpa_config_ops {
>
> struct vdpa_device *__vdpa_alloc_device(struct device *parent,
> 					const struct vdpa_config_ops *config,
>-					int nvqs,
> 					size_t size);
>
>-#define vdpa_alloc_device(dev_struct, member, parent, config, nvqs)   \
>+#define vdpa_alloc_device(dev_struct, member, parent, config)   \
> 			  container_of(__vdpa_alloc_device( \
>-				       parent, config, nvqs, \
>+				       parent, config, \
> 				       sizeof(dev_struct) + \
> 				       BUILD_BUG_ON_ZERO(offsetof( \
> 				       dev_struct, member))), \
> 				       dev_struct, member)
>
>-int vdpa_register_device(struct vdpa_device *vdev);
>+int vdpa_register_device(struct vdpa_device *vdev, int nvqs);
> void vdpa_unregister_device(struct vdpa_device *vdev);
>
> /**
>-- 
>2.25.1
>
>_______________________________________________
>Virtualization mailing list
>Virtualization@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

