Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3462E767B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 07:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgL3GYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 01:24:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726161AbgL3GYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 01:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609309397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zMOHRQRlmmzuXmXJwYwsntjIgSSrZq/XW9h6GVg/eWI=;
        b=bNxiez54pDzDEXZtFvmDlrL8+SijXP5Oi89Xw/IbrsnbBsASwV3DE3X+7NEp8awblFtUYX
        72nd1aZG1FXCcyIYrf0x5BnmRYQxN291Kbt4P2altPAZrX78Rgl5T3q/2xmpAOETq3XS17
        Nq3cn5pFZrCqFFQCNl8wrIounRXEfUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-EQtmwsDoOMSTdZvFTvX8SQ-1; Wed, 30 Dec 2020 01:23:15 -0500
X-MC-Unique: EQtmwsDoOMSTdZvFTvX8SQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CF0015720;
        Wed, 30 Dec 2020 06:23:14 +0000 (UTC)
Received: from [10.72.13.30] (ovpn-13-30.pek2.redhat.com [10.72.13.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 50A6271C8B;
        Wed, 30 Dec 2020 06:23:03 +0000 (UTC)
Subject: Re: [PATCH 11/21] vhost-vdpa: introduce asid based IOTLB
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lulu@redhat.com, eli@mellanox.com,
        lingshan.zhu@intel.com, rob.miller@broadcom.com,
        stefanha@redhat.com, sgarzare@redhat.com
References: <20201216064818.48239-1-jasowang@redhat.com>
 <20201216064818.48239-12-jasowang@redhat.com>
 <20201229114110.GC195479@mtl-vdi-166.wap.labs.mlnx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <02c7a7ea-3765-3ff8-0742-0520d6cc4ca5@redhat.com>
Date:   Wed, 30 Dec 2020 14:23:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201229114110.GC195479@mtl-vdi-166.wap.labs.mlnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/29 下午7:41, Eli Cohen wrote:
> On Wed, Dec 16, 2020 at 02:48:08PM +0800, Jason Wang wrote:
>> This patch converts the vhost-vDPA device to support multiple IOTLBs
>> tagged via ASID via hlist. This will be used for supporting multiple
>> address spaces in the following patches.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/vhost/vdpa.c | 106 ++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 80 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index feb6a58df22d..060d5b5b7e64 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -33,13 +33,21 @@ enum {
>>   
>>   #define VHOST_VDPA_DEV_MAX (1U << MINORBITS)
>>   
>> +#define VHOST_VDPA_IOTLB_BUCKETS 16
>> +
>> +struct vhost_vdpa_as {
>> +	struct hlist_node hash_link;
>> +	struct vhost_iotlb iotlb;
>> +	u32 id;
>> +};
>> +
>>   struct vhost_vdpa {
>>   	struct vhost_dev vdev;
>>   	struct iommu_domain *domain;
>>   	struct vhost_virtqueue *vqs;
>>   	struct completion completion;
>>   	struct vdpa_device *vdpa;
>> -	struct vhost_iotlb *iotlb;
>> +	struct hlist_head as[VHOST_VDPA_IOTLB_BUCKETS];
>>   	struct device dev;
>>   	struct cdev cdev;
>>   	atomic_t opened;
>> @@ -49,12 +57,64 @@ struct vhost_vdpa {
>>   	struct eventfd_ctx *config_ctx;
>>   	int in_batch;
>>   	struct vdpa_iova_range range;
>> +	int used_as;
> This is not really used. Not in this patch and later removed.


Right, will remove this.

Thanks


