Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCAC32423ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 04:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHLCCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 22:02:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23767 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726235AbgHLCCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 22:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597197760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HoZ/EBZIxsgZT3jW1Je1ueNMDaBxzDlPbn95xarnJ6M=;
        b=I9UocYj1MQRM+pi23K0PWpoYyoiarzHYOEbp2/MFbkDGl0ig0dzPqpX53j85jSbZ78kIF8
        4wIgHltOS8ieXJvX3B4UN/OcTLZmc5EPykQed0aaKikQAiRVB+XAKkCBNmE26Q+A7PUt8G
        sk2td0E3xt0JdMLWziU4J2y799y/L/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-odOuMVZWOCqDs1ztjQP2JA-1; Tue, 11 Aug 2020 22:02:38 -0400
X-MC-Unique: odOuMVZWOCqDs1ztjQP2JA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6AC5E921;
        Wed, 12 Aug 2020 02:02:36 +0000 (UTC)
Received: from [10.72.12.118] (ovpn-12-118.pek2.redhat.com [10.72.12.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 983C61A7CF;
        Wed, 12 Aug 2020 02:02:27 +0000 (UTC)
Subject: Re: [PATCH 1/4] vdpa: introduce config op to get valid iova range
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Eli Cohen <eli@mellanox.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-2-jasowang@redhat.com>
 <20200805085035-mutt-send-email-mst@kernel.org>
 <20200806120354.GA171218@mtl-vdi-166.wap.labs.mlnx>
 <20200806082727-mutt-send-email-mst@kernel.org>
 <20200806124354.GA172661@mtl-vdi-166.wap.labs.mlnx>
 <20200810080410-mutt-send-email-mst@kernel.org>
 <2d1e6278-e57e-c340-399e-40ff102c74a3@redhat.com>
 <20200811042733-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9effa14f-e305-2fa0-5aa6-83b146b969e0@redhat.com>
Date:   Wed, 12 Aug 2020 10:02:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811042733-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/11 下午4:29, Michael S. Tsirkin wrote:
> On Tue, Aug 11, 2020 at 10:53:09AM +0800, Jason Wang wrote:
>> On 2020/8/10 下午8:05, Michael S. Tsirkin wrote:
>>> On Thu, Aug 06, 2020 at 03:43:54PM +0300, Eli Cohen wrote:
>>>> On Thu, Aug 06, 2020 at 08:29:22AM -0400, Michael S. Tsirkin wrote:
>>>>> On Thu, Aug 06, 2020 at 03:03:55PM +0300, Eli Cohen wrote:
>>>>>> On Wed, Aug 05, 2020 at 08:51:56AM -0400, Michael S. Tsirkin wrote:
>>>>>>> On Wed, Jun 17, 2020 at 11:29:44AM +0800, Jason Wang wrote:
>>>>>>>> This patch introduce a config op to get valid iova range from the vDPA
>>>>>>>> device.
>>>>>>>>
>>>>>>>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>>>>>>>> ---
>>>>>>>>    include/linux/vdpa.h | 14 ++++++++++++++
>>>>>>>>    1 file changed, 14 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>>>>>>>> index 239db794357c..b7633ed2500c 100644
>>>>>>>> --- a/include/linux/vdpa.h
>>>>>>>> +++ b/include/linux/vdpa.h
>>>>>>>> @@ -41,6 +41,16 @@ struct vdpa_device {
>>>>>>>>    	unsigned int index;
>>>>>>>>    };
>>>>>>>> +/**
>>>>>>>> + * vDPA IOVA range - the IOVA range support by the device
>>>>>>>> + * @start: start of the IOVA range
>>>>>>>> + * @end: end of the IOVA range
>>>>>>>> + */
>>>>>>>> +struct vdpa_iova_range {
>>>>>>>> +	u64 start;
>>>>>>>> +	u64 end;
>>>>>>>> +};
>>>>>>>> +
>>>>>>> This is ambiguous. Is end in the range or just behind it?
>>>>>>> How about first/last?
>>>>>> It is customary in the kernel to use start-end where end corresponds to
>>>>>> the byte following the last in the range. See struct vm_area_struct
>>>>>> vm_start and vm_end fields
>>>>> Exactly my point:
>>>>>
>>>>> include/linux/mm_types.h:       unsigned long vm_end;           /* The first byte after our end address
>>>>>
>>>>> in this case Jason wants it to be the last byte, not one behind.
>>>>>
>>>>>
>>>> Maybe start, size? Not ambiguous, and you don't need to do annoying
>>>> calculations like size = last - start + 1
>>> Size has a bunch of issues: can overlap, can not cover the entire 64 bit
>>> range. The requisite checks are arguably easier to get wrong than
>>> getting the size if you need it.
>> Yes, so do you still prefer first/last or just begin/end which is consistent
>> with iommu_domain_geometry?
>>
>> Thanks
> I prefer first/last I think, these are unambiguous.
> E.g.
>
>          dma_addr_t aperture_start; /* First address that can be mapped    */
>          dma_addr_t aperture_end;   /* Last address that can be mapped     */
>
> instead of addressing ambiguity with a comment, let's just name the field well.


Ok, will do.

Thanks



>
>
>

