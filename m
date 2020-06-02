Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E861EB4E7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 07:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgFBFIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 01:08:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22922 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725793AbgFBFIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591074491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i21+6+jn+AssAfqfuTEOtmF/3IbU/JSkgC0yQOaoU/8=;
        b=imhzBF+h5EKWi+lJXJ+UUy4MdwVw8dLkRaM9Rri95X4F0w6R/uXoaPFqK5oWj9gA2M7PFR
        NmO7O1fs6wJqJNxBi3LGKRPqrclYFN72S+zwwuSVRZVXQ4n8QcLfqBAFDxmO2zG3OCzYWX
        G/9+PJFdKbMaLHICHRCFezx7odzrGSM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-x0oxw8UDPJOTFamOEM-hlQ-1; Tue, 02 Jun 2020 01:08:08 -0400
X-MC-Unique: x0oxw8UDPJOTFamOEM-hlQ-1
Received: by mail-wm1-f72.google.com with SMTP id p24so495946wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 22:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i21+6+jn+AssAfqfuTEOtmF/3IbU/JSkgC0yQOaoU/8=;
        b=hmrRrg2Pkd83RNsuam9bMT7UILi2ZxTF+nFkwDRSsYKDd6iT06Nv5sfKsE3vBMigRP
         +CIaOOo5WvVSZoQuqTOXSpohcoAd37rQnTBFxLlga6auLbEhjoTvxmtq8P6XXEV/mrn8
         QBLkoLhYpRCLM6Ibh4P8N7z5qclTvKusTVU1MKU81N/YecwjCg7C2ukLNCpjA4vhmWfg
         ORx9NVAVxRkFpYV/5JN1veGEFhA7fYcyQMqF2HlEbaGtXF/KXYZ8PETzoqQiGXMoQIMu
         SeJLlWHghKJWS3McJYkF8egv+XussvvMLfvBGpxH1FKgbFZFufOJEIK1ENkEIEg1D6Sm
         6e4A==
X-Gm-Message-State: AOAM531tZiK6kRoPM+35/q1wxkyqUK0+7bAddpHCpI4LJSKP5/CXsTky
        UhzmzvQLWlX4qr27hsVMl8yaXe69Bp22IyPo+8Yoay2patEMxqMjXe3hqz5jPEKHNLWqRYKCtgO
        M9NfEYyupJF16tDu3eCPE9zlq
X-Received: by 2002:a5d:4c81:: with SMTP id z1mr26712879wrs.371.1591074487434;
        Mon, 01 Jun 2020 22:08:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7ZFXMW684yAQznwucY1IA0VuesC1zA8zze+z7mJFUahZ6qoJQid59fnWEYmNevYhEMFGybw==
X-Received: by 2002:a5d:4c81:: with SMTP id z1mr26712868wrs.371.1591074487279;
        Mon, 01 Jun 2020 22:08:07 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id a126sm1761521wme.28.2020.06.01.22.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 22:08:06 -0700 (PDT)
Date:   Tue, 2 Jun 2020 01:08:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: Re: [PATCH 5/6] vdpa: introduce virtio pci driver
Message-ID: <20200602010332-mutt-send-email-mst@kernel.org>
References: <20200529080303.15449-1-jasowang@redhat.com>
 <20200529080303.15449-6-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529080303.15449-6-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 04:03:02PM +0800, Jason Wang wrote:
> +static void vp_vdpa_set_vq_ready(struct vdpa_device *vdpa,
> +				 u16 qid, bool ready)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +
> +	vp_iowrite16(qid, &vp_vdpa->common->queue_select);
> +	vp_iowrite16(ready, &vp_vdpa->common->queue_enable);
> +}
> +

Looks like this needs to check and just skip the write if
ready == 0, right? Of course vdpa core then insists on calling
vp_vdpa_get_vq_ready which will warn. Maybe just drop the
check from core, move it to drivers which need it?

...


> +static const struct pci_device_id vp_vdpa_id_table[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_ANY_ID) },
> +	{ 0 }
> +};

This looks like it'll create a mess with either virtio pci
or vdpa being loaded at random. Maybe just don't specify
any IDs for now. Down the road we could get a
distinct vendor ID or a range of device IDs for this.

> +MODULE_DEVICE_TABLE(pci, vp_vdpa_id_table);
> +
> +static struct pci_driver vp_vdpa_driver = {
> +	.name		= "vp-vdpa",
> +	.id_table	= vp_vdpa_id_table,
> +	.probe		= vp_vdpa_probe,
> +	.remove		= vp_vdpa_remove,
> +};
> +
> +module_pci_driver(vp_vdpa_driver);
> +
> +MODULE_AUTHOR("Jason Wang <jasowang@redhat.com>");
> +MODULE_DESCRIPTION("vp-vdpa");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION("1");
> -- 
> 2.20.1

