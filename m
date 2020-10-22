Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F9C295817
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 07:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508047AbgJVFrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 01:47:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54329 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2508040AbgJVFrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 01:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603345659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g4B//qnaxTvyagU4Ta4XmHD0G1WDTvcCQn1ISIno4ag=;
        b=Kc5O2xUjpMbgtyLygBwmqGXIYejZDoWjy8uQWLfUVnn22URh5zE7JB7RNmeum1/ewFa7/t
        zui+KRLiqqrEQIkCowTx3HT0vciq5iARY6teVfaudiq/ZndceSgsfWmXWaNmBYzfS9tuNh
        TvtcHj+nMaaC1NEXgGo5nHVLw9mGyO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-24ki4_b3MOywOgsTgU-wwA-1; Thu, 22 Oct 2020 01:47:37 -0400
X-MC-Unique: 24ki4_b3MOywOgsTgU-wwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A3F98797F6;
        Thu, 22 Oct 2020 05:47:34 +0000 (UTC)
Received: from [10.72.13.119] (ovpn-13-119.pek2.redhat.com [10.72.13.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA8CD5C1C7;
        Thu, 22 Oct 2020 05:47:25 +0000 (UTC)
Subject: Re: [PATCH 0/4] vDPA: API for reporting IOVA range
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20201021104508-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <09525e8b-2c7a-de5d-128a-79b5b0725224@redhat.com>
Date:   Thu, 22 Oct 2020 13:47:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201021104508-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/10/21 下午10:45, Michael S. Tsirkin wrote:
> On Wed, Jun 17, 2020 at 11:29:43AM +0800, Jason Wang wrote:
>> Hi All:
>>
>> This series introduces API for reporing IOVA range. This is a must for
>> userspace to work correclty:
>>
>> - for the process that uses vhost-vDPA directly to properly allocate
>>    IOVA
>> - for VM(qemu), when vIOMMU is not enabled, fail early if GPA is out
>>    of range
>> - for VM(qemu), when vIOMMU is enabled, determine a valid guest
>>    address width
>>
>> Please review.
>>
>> Thanks
> OK so what is the plan here? Change begin-end->first-last and repost?


I've posted V2 with this change, but it get some warning for buildbot.

Will post a V3.

Thanks


>
>> Jason Wang (4):
>>    vdpa: introduce config op to get valid iova range
>>    vdpa_sim: implement get_iova_range bus operation
>>    vdpa: get_iova_range() is mandatory for device specific DMA
>>      translation
>>    vhost: vdpa: report iova range
>>
>>   drivers/vdpa/vdpa.c              |  4 ++++
>>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 11 +++++++++++
>>   drivers/vhost/vdpa.c             | 27 +++++++++++++++++++++++++++
>>   include/linux/vdpa.h             | 14 ++++++++++++++
>>   include/uapi/linux/vhost.h       |  4 ++++
>>   include/uapi/linux/vhost_types.h |  5 +++++
>>   6 files changed, 65 insertions(+)
>>
>> -- 
>> 2.20.1

