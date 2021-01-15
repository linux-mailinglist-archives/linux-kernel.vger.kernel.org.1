Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD4D2F7E27
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 15:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbhAOO1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 09:27:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43767 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbhAOO1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 09:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610720784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EJkFmkS/n37npwrUJg3yWLMp+NjfQlhtrOX5VX4sPOk=;
        b=FuqLEsXz5dj6rDswfIlcfueDLMaq53qvqa2C5ocIXCMVMWqN0MFPjtMPi84NxIROQDzLP5
        nlhZdICLTOefn+2IjQLn4HGtnQhxGr7oYPP5bkq4IwpGS6hveo7I0gJxkq6Al5EoIKol2F
        d+1w470nyMumBjhTnFe7LsP+Hoke9Gs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-Nxv7TyYxOB-WiEuPgTUt5g-1; Fri, 15 Jan 2021 09:26:16 -0500
X-MC-Unique: Nxv7TyYxOB-WiEuPgTUt5g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA6E480DDED;
        Fri, 15 Jan 2021 14:26:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-117.pek2.redhat.com [10.72.12.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B87A5C3E9;
        Fri, 15 Jan 2021 14:26:11 +0000 (UTC)
Subject: Re: [PATCH] iommu: check for the deferred attach when attaching a
 device
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>, jroedel@suse.de,
        iommu@lists.linux-foundation.org, will@kernel.org
References: <20201226053959.4222-1-lijiang@redhat.com>
 <33b6f925-71e6-5d9e-74c3-3e1eaf13398e@redhat.com>
 <b385db3b-4506-6d75-49e1-e11064e65d6a@redhat.com>
 <8273ce28-5ba6-2a39-5073-ec0f2b12dd2f@arm.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <e42b426e-00c1-1144-4f1f-630d52f91215@redhat.com>
Date:   Fri, 15 Jan 2021 22:26:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8273ce28-5ba6-2a39-5073-ec0f2b12dd2f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Robin

Thank you for the comment.

在 2021年01月13日 01:29, Robin Murphy 写道:
> On 2021-01-05 07:52, lijiang wrote:
>> 在 2021年01月05日 11:55, lijiang 写道:
>>> Hi,
>>>
>>> Also add Joerg to cc list.
>>>
>>
>> Also add more people to cc list, Jerry Snitselaar and Tom Lendacky.
>>
>> Thanks.
>>
>>> Thanks.
>>> Lianbo
>>> 在 2020年12月26日 13:39, Lianbo Jiang 写道:
>>>> Currently, because domain attach allows to be deferred from iommu
>>>> driver to device driver, and when iommu initializes, the devices
>>>> on the bus will be scanned and the default groups will be allocated.
>>>>
>>>> Due to the above changes, some devices could be added to the same
>>>> group as below:
>>>>
>>>> [    3.859417] pci 0000:01:00.0: Adding to iommu group 16
>>>> [    3.864572] pci 0000:01:00.1: Adding to iommu group 16
>>>> [    3.869738] pci 0000:02:00.0: Adding to iommu group 17
>>>> [    3.874892] pci 0000:02:00.1: Adding to iommu group 17
>>>>
>>>> But when attaching these devices, it doesn't allow that a group has
>>>> more than one device, otherwise it will return an error. This conflicts
>>>> with the deferred attaching. Unfortunately, it has two devices in the
>>>> same group for my side, for example:
>>>>
>>>> [    9.627014] iommu_group_device_count(): device name[0]:0000:01:00.0
>>>> [    9.633545] iommu_group_device_count(): device name[1]:0000:01:00.1
>>>> ...
>>>> [   10.255609] iommu_group_device_count(): device name[0]:0000:02:00.0
>>>> [   10.262144] iommu_group_device_count(): device name[1]:0000:02:00.1
>>>>
>>>> Finally, which caused the failure of tg3 driver when tg3 driver calls
>>>> the dma_alloc_coherent() to allocate coherent memory in the tg3_test_dma().
>>>>
>>>> [    9.660310] tg3 0000:01:00.0: DMA engine test failed, aborting
>>>> [    9.754085] tg3: probe of 0000:01:00.0 failed with error -12
>>>> [    9.997512] tg3 0000:01:00.1: DMA engine test failed, aborting
>>>> [   10.043053] tg3: probe of 0000:01:00.1 failed with error -12
>>>> [   10.288905] tg3 0000:02:00.0: DMA engine test failed, aborting
>>>> [   10.334070] tg3: probe of 0000:02:00.0 failed with error -12
>>>> [   10.578303] tg3 0000:02:00.1: DMA engine test failed, aborting
>>>> [   10.622629] tg3: probe of 0000:02:00.1 failed with error -12
>>>>
>>>> In addition, the similar situations also occur in other drivers such
>>>> as the bnxt_en driver. That can be reproduced easily in kdump kernel
>>>> when SME is active.
>>>>
>>>> Add a check for the deferred attach in the iommu_attach_device() and
>>>> allow to attach the deferred device regardless of how many devices
>>>> are in a group.
> 
> Is this iommu_attach_device() call is coming from iommu-dma? (if not, then whoever's calling it probably shouldn't be)
> 

Yes, you are right, the iommu_attach_device call is coming from iommu-dma.
 
> Assuming so, then probably what should happen is to move the handling currently in iommu_dma_deferred_attach() into the core so that it can call __iommu_attach_device() directly - the intent is just to replay that exact call skipped in iommu_group_add_device(), so the legacy external iommu_attach_device() interface isn't really the right tool for the job 

Sounds good. I will check if this can work in various cases. If it's OK, I will post again.

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f0305e6aac1b..5e7da902ac36 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -23,7 +23,6 @@
 #include <linux/swiotlb.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
-#include <linux/crash_dump.h>
 #include <linux/dma-direct.h>
 
 struct iommu_dma_msi_page {
@@ -378,21 +377,6 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	return iova_reserve_iommu_regions(dev, domain);
 }
 
-static int iommu_dma_deferred_attach(struct device *dev,
-		struct iommu_domain *domain)
-{
-	const struct iommu_ops *ops = domain->ops;
-
-	if (!is_kdump_kernel())
-		return 0;
-
-	if (unlikely(ops->is_attach_deferred &&
-			ops->is_attach_deferred(domain, dev)))
-		return iommu_attach_device(domain, dev);
-
-	return 0;
-}
-
 /**
  * dma_info_to_prot - Translate DMA API directions and attributes to IOMMU API
  *                    page flags.
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ffeebda8d6de..4fed1567b498 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -23,6 +23,7 @@
 #include <linux/property.h>
 #include <linux/fsl/mc.h>
 #include <linux/module.h>
+#include <linux/crash_dump.h>
 #include <trace/events/iommu.h>
 
 static struct kset *iommu_group_kset;
@@ -1952,6 +1953,21 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 	return ret;
 }
 
+int iommu_dma_deferred_attach(struct device *dev,
+                struct iommu_domain *domain)
+{
+        const struct iommu_ops *ops = domain->ops;
+
+        if (!is_kdump_kernel())
+                return 0;
+
+        if (unlikely(ops->is_attach_deferred &&
+                        ops->is_attach_deferred(domain, dev)))
+                return __iommu_attach_device(domain, dev);
+
+        return 0;
+}
+
 int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 {
 	struct iommu_group *group;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b3f0e2018c62..8e0ee96ca456 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -424,6 +424,8 @@ extern struct iommu_group *iommu_group_get_by_id(int id);
 extern void iommu_domain_free(struct iommu_domain *domain);
 extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
+extern int iommu_dma_deferred_attach(struct device *dev,
+                struct iommu_domain *domain);
 extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
 extern int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
@@ -680,6 +682,12 @@ static inline int iommu_attach_device(struct iommu_domain *domain,
 	return -ENODEV;
 }
 
+static inline int iommu_dma_deferred_attach(struct device *dev,
+					    struct iommu_domain *domain)
+{
+	return -ENODEV;
+}
+
 static inline void iommu_detach_device(struct iommu_domain *domain,
 				       struct device *dev)
 {


> Alternatively I suppose it *could* just call ops->attach_dev directly, but then we miss out on the tracepoint, and deferred attach is arguably one of the cases where that's most useful :/
> 
Seems good, I could debug it and provide feedback.

Thanks.
Lianbo

> Robin.
> 
>>>>
>>>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>>>> ---
>>>>   drivers/iommu/iommu.c | 5 ++++-
>>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index ffeebda8d6de..dccab7b133fb 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -1967,8 +1967,11 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
>>>>        */
>>>>       mutex_lock(&group->mutex);
>>>>       ret = -EINVAL;
>>>> -    if (iommu_group_device_count(group) != 1)
>>>> +    if (!iommu_is_attach_deferred(domain, dev) &&
>>>> +        iommu_group_device_count(group) != 1) {
>>>> +        dev_err_ratelimited(dev, "Group has more than one device\n");
>>>>           goto out_unlock;
>>>> +    }
>>>>         ret = __iommu_attach_group(domain, group);
>>>>  
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>
> 

