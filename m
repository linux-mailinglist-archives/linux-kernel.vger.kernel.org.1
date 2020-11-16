Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392AB2B416E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgKPKmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:42:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58108 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728873AbgKPKmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:42:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605523327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AbJT48MzAcRyOQMKLElNni6bzOKtWGki16HjKF748o0=;
        b=TBYfDeiWEJNxLjoYk+cTwE5RXYtOpaqDacf/T0txz+9X+QqGpzybIq6po9uJW4p9rcwH3w
        NWmxG+WTs6SuUT4lPg8WuP7NYkpAty1uqUdvlXHxAQ73sWb1ppfqLqUJz0bTcy6TqmjhS+
        C65EjZA+RY3vavzBFwJnU/I2dAgxa6c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-ok_QltbwPoKocKa9hpo5tA-1; Mon, 16 Nov 2020 05:42:06 -0500
X-MC-Unique: ok_QltbwPoKocKa9hpo5tA-1
Received: by mail-wm1-f70.google.com with SMTP id u9so8607431wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AbJT48MzAcRyOQMKLElNni6bzOKtWGki16HjKF748o0=;
        b=IsHUS/d00fp8Fw6r4eXfPjBLFhIkF+EabaQdRdSUBSY55CagXFQvmlAxvxzpOJBJ2/
         tw9ajPVmVrrH92UTjUCGlbJQytnrmQGmbqTj1+Q28BKpC3w/xVJIULWjXxU/oAkhlBON
         OinCtgg6ZSnErQ2Ptk1IpCJAwbJRmr5pFyNv5hRyO6fNCUahybMThCDIaeT7HHEV/CsK
         FdkDZfZk63E3pzKyW2kqGbpU1Xv0yugwRUukDLKoTVUkwiVPkcaYVOUE/P+ADbbSP3nt
         Vf4VwIOAswVcAs+w6tL/37PCUMbZ3gd7rSM5d5awFV7OQw3ivfZvLc5+9h11tRvFiQNR
         HzLQ==
X-Gm-Message-State: AOAM533MDI80PX8dSBDEASNCUdaK40VikKUZug8O9yTQPsU/PIl55dQz
        ag63EUea2KCVjEwNF3M6KIzE4kOFx6jQRNzrmPj2CBuPzKAkzDeFoXXHK2Q2xtgeMLHDCBxa7jg
        rRiBWmF806sHz63oCFCW94Pqb
X-Received: by 2002:a1c:2c2:: with SMTP id 185mr14994213wmc.103.1605523324617;
        Mon, 16 Nov 2020 02:42:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZ+tAGKjI2Y8SDbunQ0GnxRaaDm6BtohQWSlWu94euTDYVt5oYegQKt0OOTTBieWNDm6idXg==
X-Received: by 2002:a1c:2c2:: with SMTP id 185mr14994197wmc.103.1605523324385;
        Mon, 16 Nov 2020 02:42:04 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id o184sm19037484wmo.37.2020.11.16.02.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:42:03 -0800 (PST)
Date:   Mon, 16 Nov 2020 11:42:01 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC 07/12] vdpa_sim: move config management outside of
 the core
Message-ID: <20201116104201.futmxydbpq542luk@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-8-sgarzare@redhat.com>
 <6ee3e73b-257a-3c02-db32-e890cfacae64@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ee3e73b-257a-3c02-db32-e890cfacae64@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 12:18:19PM +0800, Jason Wang wrote:
>
>On 2020/11/13 下午9:47, Stefano Garzarella wrote:
>>In order to simplify the code of the vdpa_sim core, we move the
>>config management in each device simulator.
>>
>>The device must provide the size of config structure and a callback
>>to update this structure called during the vdpasim_set_features().
>
>
>Similarly, I suggest to do this before patch 2, then there's no need 
>for the conversion of blk device.
>

I'll do.

>
>>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>  drivers/vdpa/vdpa_sim/vdpa_sim.h     |  5 +++--
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c     | 29 +++++-----------------------
>>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 27 ++++++++++++++++----------
>>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 12 ++++++++++++
>>  4 files changed, 37 insertions(+), 36 deletions(-)
>>
>>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>>index 76e642042eb0..f7e1fe0a88d3 100644
>>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
>>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>>@@ -10,8 +10,6 @@
>>  #include <linux/vdpa.h>
>>  #include <linux/vhost_iotlb.h>
>>  #include <uapi/linux/virtio_config.h>
>>-#include <uapi/linux/virtio_net.h>
>>-#include <uapi/linux/virtio_blk.h>
>>  #define DRV_VERSION  "0.1"
>>  #define DRV_AUTHOR   "Jason Wang <jasowang@redhat.com>"
>>@@ -42,8 +40,11 @@ struct vdpasim_virtqueue {
>>  struct vdpasim_device {
>>  	u64 supported_features;
>>+	size_t config_size;
>>  	u32 id;
>>  	int nvqs;
>>+
>>+	void (*update_config)(struct vdpasim *vdpasim);
>
>
>Let's use set_config/get_config to align with virtio/vhost.

Yes, it's better,

>
>Other looks good.

Thanks,
Stefano

