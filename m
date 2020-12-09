Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB402D40B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbgLILJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:09:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20103 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727221AbgLILJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607512071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NNP/s73hcs7iADiI2LbiH+U19DRgaYLN1YsBGHYmWOw=;
        b=cfjtGhq7NboOeM+7fNUdj/Q+MavCgVk3YSqENbCOBCppacCoEzpUe2S7aiTC4HFDnq14c2
        8acio4NWL8ywJ5Gz5dNUnBOf7sNkwfri63tfG/Zig3xkt0lfAeaq+tGkTh+3tsooFfDC0t
        5AalIM8U635J5clu790U27Rc+nIz7kA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-SscG9SZiNsSdx84HO6WV7Q-1; Wed, 09 Dec 2020 06:07:49 -0500
X-MC-Unique: SscG9SZiNsSdx84HO6WV7Q-1
Received: by mail-wr1-f71.google.com with SMTP id r11so511514wrs.23
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 03:07:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NNP/s73hcs7iADiI2LbiH+U19DRgaYLN1YsBGHYmWOw=;
        b=bxeNyRKc2oJDg9UdMMFlwGrHEJReRjIqke9cESP44kMaC4eL1ioSEsR2NN4W86Sr++
         d5R6G+gpGj5SIoyBrh94hGBw4Nrist9dmBrwHSbXHGRJdRoW22C/uaZvCXJGNuxXq7dS
         bDsZMB2OeNcPVAiVPgAwlWZ4YIhGllbHB2cFNG7zRXQlaaMn5tw9fJ3d7zgwtT4OBDYr
         k/bKMTRGk4nZbKG2bPRgqQFQROQjeeKNInO0XuKcVnBslGEvmN2Z1Ad8AOw/h1RmDWHQ
         f9QxnIqS/nGZwttMSeuri4sKgzVTmfHvJdKLI6KegnHF8gHqYmXtUu1FNO76jmtB+3qm
         4e8g==
X-Gm-Message-State: AOAM533XqtXrOc3vkLhe8jY8JenErau2f+b4oGARYjL4i1PzDlApebbu
        6Vho2wX9OqIDx8JsqyC9RaHrp3glHCsk5UC6Sy7UuJwKstcV547Hiq1dQq7m2k5fPQymGrSTGZ1
        1BMmJ9Zv94CfW7USoqWA1s2oY
X-Received: by 2002:a5d:4c8d:: with SMTP id z13mr2162501wrs.248.1607512068690;
        Wed, 09 Dec 2020 03:07:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLJjrGYKJa9GuB+sZae7CCE+GVRzbLSWplYg80HvLuf0DS5zxtBPkAXu0cvRnclJxHYP+ZcA==
X-Received: by 2002:a5d:4c8d:: with SMTP id z13mr2162481wrs.248.1607512068518;
        Wed, 09 Dec 2020 03:07:48 -0800 (PST)
Received: from steredhat (host-79-24-227-66.retail.telecomitalia.it. [79.24.227.66])
        by smtp.gmail.com with ESMTPSA id z140sm2839639wmc.30.2020.12.09.03.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 03:07:47 -0800 (PST)
Date:   Wed, 9 Dec 2020 12:07:45 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Oren Duer <oren@nvidia.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v3 13/19] vdpa_sim: add get_config callback in
 vdpasim_dev_attr
Message-ID: <20201209110745.p4ybybanzip2lav3@steredhat>
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-14-sgarzare@redhat.com>
 <829a5026-a68c-6d02-49ef-f237dcae2460@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <829a5026-a68c-6d02-49ef-f237dcae2460@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 01:29:17PM +0800, Jason Wang wrote:
>
>On 2020/12/4 上午1:05, Stefano Garzarella wrote:
>>The get_config callback can be used by the device to fill the
>>config structure.
>>The callback will be invoked in vdpasim_get_config() before copying
>>bytes into caller buffer.
>>
>>Move vDPA-net config updates from vdpasim_set_features() in the
>>new vdpasim_net_get_config() callback.
>>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>v3:
>>- checked if get_config callback is set before call it
>>---
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 35 +++++++++++++++++++-------------
>>  1 file changed, 21 insertions(+), 14 deletions(-)
>>
>>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>index fe71ed7890e1..f935ade0806b 100644
>>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>@@ -60,6 +60,8 @@ struct vdpasim_virtqueue {
>>  #define VDPASIM_NET_FEATURES	(VDPASIM_FEATURES | \
>>  				 (1ULL << VIRTIO_NET_F_MAC))
>>+struct vdpasim;
>>+
>>  struct vdpasim_dev_attr {
>>  	u64 supported_features;
>>  	size_t config_size;
>>@@ -67,6 +69,7 @@ struct vdpasim_dev_attr {
>>  	u32 id;
>>  	work_func_t work_fn;
>>+	void (*get_config)(struct vdpasim *vdpasim, void *config);
>>  };
>>  /* State of each vdpasim device */
>>@@ -522,8 +525,6 @@ static u64 vdpasim_get_features(struct vdpa_device *vdpa)
>>  static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
>>  {
>>  	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>>-	struct virtio_net_config *config =
>>-		(struct virtio_net_config *)vdpasim->config;
>>  	/* DMA mapping must be done by driver */
>>  	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
>>@@ -531,16 +532,6 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
>>  	vdpasim->features = features & vdpasim->dev_attr.supported_features;
>>-	/* We generally only know whether guest is using the legacy interface
>>-	 * here, so generally that's the earliest we can set config fields.
>>-	 * Note: We actually require VIRTIO_F_ACCESS_PLATFORM above which
>>-	 * implies VIRTIO_F_VERSION_1, but let's not try to be clever here.
>>-	 */
>>-
>>-	config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
>>-	config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
>>-	memcpy(config->mac, macaddr_buf, ETH_ALEN);
>
>
>Patch looks good to me.
>
>But we need Michael to confirm whether doing moving like this is safe. 
>I guess what has been done were trying to make sure get_config() fail 
>before set_features(), but it's not clear to me whether it's useful.

IIUC, also looking the QEMU code, the set_features() should be called 
every time before get_config(), but to be sure, in get_config(), I can 
check for example if 'vdpasim->features' is not zero (we require 
VIRTIO_F_ACCESS_PLATFORM set).

@Michael any suggestion?

Thanks,
Stefano

>
>Thanks
>
>
>>-
>>  	return 0;
>>  }
>>@@ -595,8 +586,13 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
>>  {
>>  	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>>-	if (offset + len < vdpasim->dev_attr.config_size)
>>-		memcpy(buf, vdpasim->config + offset, len);
>>+	if (offset + len > vdpasim->dev_attr.config_size)
>>+		return;
>>+
>>+	if (vdpasim->dev_attr.get_config)
>>+		vdpasim->dev_attr.get_config(vdpasim, vdpasim->config);
>>+
>>+	memcpy(buf, vdpasim->config + offset, len);
>>  }
>>  static void vdpasim_set_config(struct vdpa_device *vdpa, unsigned int offset,
>>@@ -739,6 +735,16 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
>>  	.free                   = vdpasim_free,
>>  };
>>+static void vdpasim_net_get_config(struct vdpasim *vdpasim, void *config)
>>+{
>>+	struct virtio_net_config *net_config =
>>+		(struct virtio_net_config *)config;
>>+
>>+	net_config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
>>+	net_config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
>>+	memcpy(net_config->mac, macaddr_buf, ETH_ALEN);
>>+}
>>+
>>  static int __init vdpasim_dev_init(void)
>>  {
>>  	struct vdpasim_dev_attr dev_attr = {};
>>@@ -747,6 +753,7 @@ static int __init vdpasim_dev_init(void)
>>  	dev_attr.supported_features = VDPASIM_NET_FEATURES;
>>  	dev_attr.nvqs = VDPASIM_VQ_NUM;
>>  	dev_attr.config_size = sizeof(struct virtio_net_config);
>>+	dev_attr.get_config = vdpasim_net_get_config;
>>  	dev_attr.work_fn = vdpasim_net_work;
>>  	vdpasim_dev = vdpasim_create(&dev_attr);
>

