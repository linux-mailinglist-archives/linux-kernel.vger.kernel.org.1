Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F86E2B6737
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgKQOQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:16:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgKQOQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605622587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CzMT1+oVbQ9dwG/lsdpdD0JPtzFvgGD2Po3JeM77ORU=;
        b=BiCbd4erfloJRjYmqj5iO1xiQ8fcFTPyCAm2hpMOBbVN+qtIVwJ832wFcM7dLMYEojw0Pk
        lKETl2DwTy6ibsoZSzEpStIQf/a+JxlFS5bSeByUCbn00rnSYnxZ5kbnYWkXqYuWLaspX0
        /MWJK4R6yhoesYDpXHQTG1TSHXn2/ZY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-VVnynI-TOW2QgWnnPBGh_A-1; Tue, 17 Nov 2020 09:16:25 -0500
X-MC-Unique: VVnynI-TOW2QgWnnPBGh_A-1
Received: by mail-wm1-f71.google.com with SMTP id e15so1602776wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 06:16:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CzMT1+oVbQ9dwG/lsdpdD0JPtzFvgGD2Po3JeM77ORU=;
        b=napJeJ9gnqaL+1UMHrDosm5sHpXZwBZ87JB/3WFBEbGzAIk6KVf8JRuRZwuYX3DoVu
         SRn2mh5CAff0QRF+fPOHkhZsWcYJ0cR+CbI/+lA1O5MIkWGddh6xzQF3V/yw1dZ1LUba
         wi2jnykyx5ZR2jMzrObi+PXs7IaN9Trs+OfHsNwdkqZWOSknCVXcMbA352QwEDKsOK6D
         rufatIqxNGbFYPbsuEMTn1JV3BqhwcCa9jPoUXSXr0uXesV5tVwGXITd/2wG9DpWGOko
         Ci41aVXeEvvCf7HPDQMBJlQjLIZ9fsFxRpsvW/E8vubmCrpLNQ0dkRtymfnoBJMG6t9x
         Or9Q==
X-Gm-Message-State: AOAM533bYGerhlXfn+FFNDNfrqPC7jdVkdm1ETbH0b5F/5DRxmD+yf0T
        iCiYhwrce0anlCIRs4rrvQ4V2mM1FbsVbMawqnQP5UgN5J0TVfcCfOGldsPF0O89D7TdD4kCVHG
        krqAkc68yk2+hDL0Y34GVqV34
X-Received: by 2002:a7b:c195:: with SMTP id y21mr4676405wmi.138.1605622584205;
        Tue, 17 Nov 2020 06:16:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBkIRbW/E0QpPWzxXv/oO7j1HcflxKjnPt/yFzKIM9ogMSgtbRK19mcoLGa0kZoD3/i5gmAg==
X-Received: by 2002:a7b:c195:: with SMTP id y21mr4676379wmi.138.1605622583987;
        Tue, 17 Nov 2020 06:16:23 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id d3sm29797039wrg.16.2020.11.17.06.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 06:16:23 -0800 (PST)
Date:   Tue, 17 Nov 2020 15:16:20 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC 04/12] vdpa: add vdpa simulator for block device
Message-ID: <20201117141620.ytium7r6xpxi4and@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-5-sgarzare@redhat.com>
 <20201117111121.GD131917@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201117111121.GD131917@stefanha-x1.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:11:21AM +0000, Stefan Hajnoczi wrote:
>On Fri, Nov 13, 2020 at 02:47:04PM +0100, Stefano Garzarella wrote:
>> +static void vdpasim_blk_work(struct work_struct *work)
>> +{
>> +	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
>> +	u8 status = VIRTIO_BLK_S_OK;
>> +	int i;
>> +
>> +	spin_lock(&vdpasim->lock);
>> +
>> +	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
>> +		goto out;
>> +
>> +	for (i = 0; i < VDPASIM_BLK_VQ_NUM; i++) {
>> +		struct vdpasim_virtqueue *vq = &vdpasim->vqs[i];
>> +
>> +		if (!vq->ready)
>> +			continue;
>> +
>> +		while (vringh_getdesc_iotlb(&vq->vring, &vq->iov, &vq->iov,
>> +					    &vq->head, GFP_ATOMIC) > 0) {
>> +
>> +			int write;
>> +
>> +			vq->iov.i = vq->iov.used - 1;
>> +			write = vringh_iov_push_iotlb(&vq->vring, &vq->iov, &status, 1);
>> +			if (write <= 0)
>> +				break;
>
>We're lucky the guest driver doesn't crash after VIRTIO_BLK_T_GET_ID? :)

The crash could happen if the simulator doesn't put the string 
terminator, but in virtio_blk.c, the serial_show() initialize the buffer 
putting the string terminator in the VIRTIO_BLK_ID_BYTES element:

     buf[VIRTIO_BLK_ID_BYTES] = '\0';
     err = virtblk_get_id(disk, buf);

This should prevent the issue, right?

However in the last patch of this series I implemented 
VIRTIO_BLK_T_GET_ID support :-)

Thanks,
Stefano

