Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAB42B6834
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgKQPFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:05:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729509AbgKQPFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605625530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C/nOqhucfZUlsIYVt0sm+AbfGVI1whVk4z8pbvaxmKA=;
        b=TCGYHLoN9sy/OeRcSOnWwNvpeYT5qUQNzni5dervMl/yUQVBVWgj3z3pq8jsUzHOm+fiaK
        4jW/hiuyGLkIkC8gfEh9ekZRmROXI/KHiqNHdehOPi/cEyeNEPJN7c6fvcyL1d8lLf0VYd
        NcuGnvMHm6O9jfvoqhwFEGaCPBmg7vE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-53UJA0tDPqmmqHnDD0IIOw-1; Tue, 17 Nov 2020 10:05:28 -0500
X-MC-Unique: 53UJA0tDPqmmqHnDD0IIOw-1
Received: by mail-wr1-f70.google.com with SMTP id f4so13147107wru.21
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 07:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C/nOqhucfZUlsIYVt0sm+AbfGVI1whVk4z8pbvaxmKA=;
        b=LBVx2Gh18jc5wLOTPG+PteRfZhzHdGyycSYsTRDmolYdOoDKIAZgm0MNs4pYTRnBS2
         xF6o8du2Wu06T06ZquWDR2uYMKXCpaXM6bHjHYCadTRa6CiB187P57YV9ICRvjhwgXPO
         WfErc+QiURaqSpMXll14QvS1mRQNSxmJrPr4pvheGi1QXNQ7mFeEXYYm7SOeFk4OAmf6
         O1V2hs+V2Q9JXFu9PCRIufkR89+3SbIPBXAmiFXKHljJz5GbD2KT9EDGv34sm4kjPtPp
         A3PNbZ5wgwrU0KK1yvMI7+N5zuxNSYgOEY3MtR9E+m9g7rroHpauHL4bn69bA2Y1lJrz
         HKhQ==
X-Gm-Message-State: AOAM5330NEHyzNpsauJ8Vbm8+h408nUVk7zQ7G8truzhaiSIQy6FkgUR
        upAhi6vzkWz6cZwHnu0c1U2rIxObNhWw340TleCJf3A2kCRJEBu0uwRds/GbGXOFLAtMil/hFEy
        KuQfGtA4YogTixQIpXAppO85o
X-Received: by 2002:adf:e284:: with SMTP id v4mr27243148wri.271.1605625526852;
        Tue, 17 Nov 2020 07:05:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXFMUC7GbvK+tcAatXhQQBJ4QIJaiqBrH3tZKm9AnxaGW5zb1KUr9XSbvepq2Td91tZd0S0w==
X-Received: by 2002:adf:e284:: with SMTP id v4mr27243126wri.271.1605625526652;
        Tue, 17 Nov 2020 07:05:26 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id g23sm4050490wmh.21.2020.11.17.07.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 07:05:26 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:05:23 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC 01/12] vhost-vdpa: add support for vDPA blk devices
Message-ID: <20201117150523.berhqwtgqjov3i63@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-2-sgarzare@redhat.com>
 <20201117105709.GC131917@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201117105709.GC131917@stefanha-x1.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 10:57:09AM +0000, Stefan Hajnoczi wrote:
>On Fri, Nov 13, 2020 at 02:47:01PM +0100, Stefano Garzarella wrote:
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index 2754f3069738..fb0411594963 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/nospec.h>
>>  #include <linux/vhost.h>
>>  #include <linux/virtio_net.h>
>> +#include <linux/virtio_blk.h>
>>
>>  #include "vhost.h"
>>
>> @@ -194,6 +195,9 @@ static int vhost_vdpa_config_validate(struct vhost_vdpa *v,
>>  	case VIRTIO_ID_NET:
>>  		size = sizeof(struct virtio_net_config);
>>  		break;
>> +	case VIRTIO_ID_BLOCK:
>> +		size = sizeof(struct virtio_blk_config);
>> +		break;
>>  	}
>>
>>  	if (c->len == 0)
>
>Can vdpa_config_ops->get/set_config() handle the size check instead of
>hardcoding device-specific knowledge into drivers/vhost/vdpa.c?

I agree that this should be better. For example we already check if the 
buffer is large enough in the simulator callbacks, we only need to 
return an error in case it is not true.

@Jason, do you think it's okay to add a return value to 
vdpa_config_ops->get/set_config() to handle the size check?

Thanks,
Stefano

