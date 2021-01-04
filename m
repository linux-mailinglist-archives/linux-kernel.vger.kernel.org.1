Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C136E2E8F94
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 04:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbhADD3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 22:29:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21273 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726333AbhADD3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 22:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609730900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GJJfwwJvIQfLkVSCQiPAwQXYX1m/CER5+zYYRij6ymg=;
        b=hLh+cqyad8loNSR6nMgFQPaoXKXvxzud1jZt4v+AqGAGiTHhKIBsUBxMe9NKHEUUECCh7q
        6vdQEXVx5baa1XmuMpKfjeazICibwMNO3gO5jbBJp4DoTndQWBdcVKVWaUZyjv3MxA1r0I
        T/6VVjwAtovUanV/Y2L1F5644UQ9PFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-F31XkmCWPxag_wRJA-zYGg-1; Sun, 03 Jan 2021 22:28:19 -0500
X-MC-Unique: F31XkmCWPxag_wRJA-zYGg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D7D2107ACE3;
        Mon,  4 Jan 2021 03:28:18 +0000 (UTC)
Received: from [10.72.13.221] (ovpn-13-221.pek2.redhat.com [10.72.13.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D24801346D;
        Mon,  4 Jan 2021 03:28:06 +0000 (UTC)
Subject: Re: [PATCH V2 19/19] vdpa: introduce virtio pci driver
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com
References: <20201204040353.21679-1-jasowang@redhat.com>
 <20201204040353.21679-20-jasowang@redhat.com>
 <20201204152043.ewqlwviaf33wwiyx@steredhat>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <a17bd160-eda2-af4f-e465-23d29ca0580a@redhat.com>
Date:   Mon, 4 Jan 2021 11:28:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201204152043.ewqlwviaf33wwiyx@steredhat>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/4 下午11:20, Stefano Garzarella wrote:
>> +#define VP_VDPA_QUEUE_MAX 256
>> +#define VP_VDPA_DRIVER_NAME "vp_vdpa"
>> +
>> +struct vp_vring {
>> +    void __iomem *notify;
>> +    char msix_name[256];
>
> Can we use a macro for the msix_name size, since we use 256 in 
> multiple places?


Yes, will switch to use a macro.


>
>> +    struct vdpa_callback cb;
>> +    int irq;
>> +};
>> +
>> +struct vp_vdpa {
>> +    struct vdpa_device vdpa;
>> +    struct virtio_pci_modern_device mdev;
>> +    struct vp_vring *vring;
>> +    struct vdpa_callback cb;
>                              ^
> It is not relevant, but 'config_cb' is maybe clearer to read.
>

Will change to config_cb.


> The rest looks good.


Thanks


>
> Thanks,
> Stefano 

