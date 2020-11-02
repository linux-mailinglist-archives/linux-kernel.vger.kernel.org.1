Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017122A3101
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgKBRLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:11:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727144AbgKBRLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604337070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qe9HtNbCEgI8DjOjklRgoiEgF3X7IiclvAtTrYaenm8=;
        b=KpQVNPULCeqVZoLH2C+1Fqe84QqeQbhR2AHNYpT10tbErNnxVvTm67qSF+/1zg6STvBLBT
        yCa+ACU8Jn3sczyHj9BKN8uzAt70ItlYEd3wj7g4IAQ9R+oIRtvfFN4oGlW7yqW1ZvOf67
        selpa/sfr+QxBVfWwwWV2IXzaP9G1UM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-wZgNZfKpO8OMgg7w5BLoVA-1; Mon, 02 Nov 2020 12:11:09 -0500
X-MC-Unique: wZgNZfKpO8OMgg7w5BLoVA-1
Received: by mail-wm1-f70.google.com with SMTP id c204so3577033wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 09:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qe9HtNbCEgI8DjOjklRgoiEgF3X7IiclvAtTrYaenm8=;
        b=hzzRyhCzy5fipqVEJe/aSplbfjbe9y1S+asUe3W1iXrIgAm2CM+7AUDytqD8G0ft3a
         J1mUPBt4rQ25NEuXpFPbRzxsZu/DH9GNOFQ0gySS/x8RqLNjuvyhi3eNICPZt9zFQ+iu
         WNStuN7SdMfsKj9wYKDeQTBuZXn3g6rOXB0jw2rXILhBu3KoHruxxqUaDzlb8NU+66Oc
         NGiJWDqTtg007XO83p19z4lE5YG1MkovKnmpWYAoTT+uOAKF6EY35LZvhdVinENjjXtb
         yhQI01lXcRYJcL+WHvupUneHbQDQkOc015/QlGTaV2R+I6HKwt/AFnYIrD6RoQEflx+U
         KcNw==
X-Gm-Message-State: AOAM531SXrtWXhOdRCZi7hFSTc2xlfHHyXk+cq5XbxHjjrT/K97mVWnj
        52/norFaBHhMUgiEWxQj0HfOimRSpkEL6VRXDEFQu9MEan0yu13b3Zb1s04uV6QbIFzKd92Z9IE
        bNQcziqvEXK5YlUbCMe5cRA8I
X-Received: by 2002:a1c:2441:: with SMTP id k62mr19529354wmk.10.1604337068049;
        Mon, 02 Nov 2020 09:11:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxftVuRDvqXD+CO65Xi6YzLd9A4FBJz+cftSjYhfrG9NB/4h4AS+WlFGmto5fs0nWE6W+uFJQ==
X-Received: by 2002:a1c:2441:: with SMTP id k62mr19529323wmk.10.1604337067797;
        Mon, 02 Nov 2020 09:11:07 -0800 (PST)
Received: from steredhat (host-79-22-200-33.retail.telecomitalia.it. [79.22.200.33])
        by smtp.gmail.com with ESMTPSA id c9sm9435227wrp.65.2020.11.02.09.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:11:06 -0800 (PST)
Date:   Mon, 2 Nov 2020 18:11:04 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, netdev@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: add IOTLB API support
Message-ID: <20201102171104.eiovmkj23fle5ioj@steredhat>
References: <20201029174351.134173-1-sgarzare@redhat.com>
 <751cc074-ae68-72c8-71de-a42458058761@redhat.com>
 <20201030105422.ju2aj2bmwsckdufh@steredhat>
 <278f4732-e561-2b4f-03ee-b26455760b01@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <278f4732-e561-2b4f-03ee-b26455760b01@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 07:44:43PM +0800, Jason Wang wrote:
>
>On 2020/10/30 下午6:54, Stefano Garzarella wrote:
>>On Fri, Oct 30, 2020 at 06:02:18PM +0800, Jason Wang wrote:
>>>
>>>On 2020/10/30 上午1:43, Stefano Garzarella wrote:
>>>>This patch enables the IOTLB API support for vhost-vsock devices,
>>>>allowing the userspace to emulate an IOMMU for the guest.
>>>>
>>>>These changes were made following vhost-net, in details this patch:
>>>>- exposes VIRTIO_F_ACCESS_PLATFORM feature and inits the iotlb
>>>>  device if the feature is acked
>>>>- implements VHOST_GET_BACKEND_FEATURES and
>>>>  VHOST_SET_BACKEND_FEATURES ioctls
>>>>- calls vq_meta_prefetch() before vq processing to prefetch vq
>>>>  metadata address in IOTLB
>>>>- provides .read_iter, .write_iter, and .poll callbacks for the
>>>>  chardev; they are used by the userspace to exchange IOTLB messages
>>>>
>>>>This patch was tested with QEMU and a patch applied [1] to fix a
>>>>simple issue:
>>>>    $ qemu -M q35,accel=kvm,kernel-irqchip=split \
>>>>           -drive file=fedora.qcow2,format=qcow2,if=virtio \
>>>>           -device intel-iommu,intremap=on \
>>>>           -device vhost-vsock-pci,guest-cid=3,iommu_platform=on
>>>
>>>
>>>Patch looks good, but a question:
>>>
>>>It looks to me you don't enable ATS which means vhost won't get 
>>>any invalidation request or did I miss anything?
>>>
>>
>>You're right, I didn't see invalidation requests, only miss and updates.
>>Now I have tried to enable 'ats' and 'device-iotlb' but I still 
>>don't see any invalidation.
>>
>>How can I test it? (Sorry but I don't have much experience yet with 
>>vIOMMU)
>
>
>I guess it's because the batched unmap. Maybe you can try to use 
>"intel_iommu=strict" in guest kernel command line to see if it works.
>
>Btw, make sure the qemu contains the patch [1]. Otherwise ATS won't be 
>enabled for recent Linux Kernel in the guest.

The problem was my kernel, it was built with a tiny configuration.
Using fedora stock kernel I can see the 'invalidate' requests, but I 
also had the following issues.

Do they make you ring any bells?

$ ./qemu -m 4G -smp 4 -M q35,accel=kvm,kernel-irqchip=split \
     -drive file=fedora.qcow2,format=qcow2,if=virtio \
     -device intel-iommu,intremap=on,device-iotlb=on \
     -device vhost-vsock-pci,guest-cid=6,iommu_platform=on,ats=on,id=v1

     qemu-system-x86_64: vtd_iova_to_slpte: detected IOVA overflow 
     (iova=0x1d40000030c0)
     qemu-system-x86_64: vtd_iommu_translate: detected translation 
     failure (dev=00:03:00, iova=0x1d40000030c0)
     qemu-system-x86_64: New fault is not recorded due to compression of 
     faults

Guest kernel messages:
     [   44.940872] DMAR: DRHD: handling fault status reg 2
     [   44.941989] DMAR: [DMA Read] Request device [00:03.0] PASID 
     ffffffff fault addr ffff88W
     [   49.785884] DMAR: DRHD: handling fault status reg 2
     [   49.788874] DMAR: [DMA Read] Request device [00:03.0] PASID 
     ffffffff fault addr ffff88W


QEMU: b149dea55c Merge remote-tracking branch 
'remotes/cschoenebeck/tags/pull-9p-20201102' into staging

Linux guest: 5.8.16-200.fc32.x86_64


Thanks,
Stefano

