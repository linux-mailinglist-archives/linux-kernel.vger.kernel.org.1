Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9150E2EA632
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 08:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbhAEHxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 02:53:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726993AbhAEHxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 02:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609833136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=igdDX6nTf4cbA39W1H+W8RdNCNfFYs684pcl8DlTBJY=;
        b=LASJhgSlmwIG9iwoIkzL06R/hMZu3anQBIFyTQTnvhEnfz7LsoEsaTr48sz9XEtemYRqf9
        CIRKytR3YiaaS0nwNaZ+VuWtZHxikuzDfWClXyfFEQWbBSfR525eKrH8WIpEC/Er5sROA3
        eRgtdmA+iwzRvbgtztQ8H5v5VqGLz0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-uovIrgZqNJWO4xmv1igrsg-1; Tue, 05 Jan 2021 02:52:12 -0500
X-MC-Unique: uovIrgZqNJWO4xmv1igrsg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4A9015720;
        Tue,  5 Jan 2021 07:52:11 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-214.pek2.redhat.com [10.72.12.214])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FF7971CA1;
        Tue,  5 Jan 2021 07:52:08 +0000 (UTC)
Subject: Re: [PATCH] iommu: check for the deferred attach when attaching a
 device
From:   lijiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux-foundation.org,
        jroedel@suse.de, jsnitsel@redhat.com,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>
References: <20201226053959.4222-1-lijiang@redhat.com>
 <33b6f925-71e6-5d9e-74c3-3e1eaf13398e@redhat.com>
Message-ID: <b385db3b-4506-6d75-49e1-e11064e65d6a@redhat.com>
Date:   Tue, 5 Jan 2021 15:52:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <33b6f925-71e6-5d9e-74c3-3e1eaf13398e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021年01月05日 11:55, lijiang 写道:
> Hi,
> 
> Also add Joerg to cc list.
> 

Also add more people to cc list, Jerry Snitselaar and Tom Lendacky.

Thanks.

> Thanks.
> Lianbo
> 在 2020年12月26日 13:39, Lianbo Jiang 写道:
>> Currently, because domain attach allows to be deferred from iommu
>> driver to device driver, and when iommu initializes, the devices
>> on the bus will be scanned and the default groups will be allocated.
>>
>> Due to the above changes, some devices could be added to the same
>> group as below:
>>
>> [    3.859417] pci 0000:01:00.0: Adding to iommu group 16
>> [    3.864572] pci 0000:01:00.1: Adding to iommu group 16
>> [    3.869738] pci 0000:02:00.0: Adding to iommu group 17
>> [    3.874892] pci 0000:02:00.1: Adding to iommu group 17
>>
>> But when attaching these devices, it doesn't allow that a group has
>> more than one device, otherwise it will return an error. This conflicts
>> with the deferred attaching. Unfortunately, it has two devices in the
>> same group for my side, for example:
>>
>> [    9.627014] iommu_group_device_count(): device name[0]:0000:01:00.0
>> [    9.633545] iommu_group_device_count(): device name[1]:0000:01:00.1
>> ...
>> [   10.255609] iommu_group_device_count(): device name[0]:0000:02:00.0
>> [   10.262144] iommu_group_device_count(): device name[1]:0000:02:00.1
>>
>> Finally, which caused the failure of tg3 driver when tg3 driver calls
>> the dma_alloc_coherent() to allocate coherent memory in the tg3_test_dma().
>>
>> [    9.660310] tg3 0000:01:00.0: DMA engine test failed, aborting
>> [    9.754085] tg3: probe of 0000:01:00.0 failed with error -12
>> [    9.997512] tg3 0000:01:00.1: DMA engine test failed, aborting
>> [   10.043053] tg3: probe of 0000:01:00.1 failed with error -12
>> [   10.288905] tg3 0000:02:00.0: DMA engine test failed, aborting
>> [   10.334070] tg3: probe of 0000:02:00.0 failed with error -12
>> [   10.578303] tg3 0000:02:00.1: DMA engine test failed, aborting
>> [   10.622629] tg3: probe of 0000:02:00.1 failed with error -12
>>
>> In addition, the similar situations also occur in other drivers such
>> as the bnxt_en driver. That can be reproduced easily in kdump kernel
>> when SME is active.
>>
>> Add a check for the deferred attach in the iommu_attach_device() and
>> allow to attach the deferred device regardless of how many devices
>> are in a group.
>>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> ---
>>  drivers/iommu/iommu.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index ffeebda8d6de..dccab7b133fb 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1967,8 +1967,11 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
>>  	 */
>>  	mutex_lock(&group->mutex);
>>  	ret = -EINVAL;
>> -	if (iommu_group_device_count(group) != 1)
>> +	if (!iommu_is_attach_deferred(domain, dev) &&
>> +	    iommu_group_device_count(group) != 1) {
>> +		dev_err_ratelimited(dev, "Group has more than one device\n");
>>  		goto out_unlock;
>> +	}
>>  
>>  	ret = __iommu_attach_group(domain, group);
>>  
>>

