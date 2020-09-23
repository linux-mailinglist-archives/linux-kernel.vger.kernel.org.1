Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D25F275184
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 08:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgIWGcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 02:32:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36674 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbgIWGcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 02:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600842774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KNYXvNzELYq54wu7W3RCN3nmnlEFmyGx388a6Bc/HMA=;
        b=ZCQbjFVvQLI5Rjr75v+L+cJbGMNprnFc6Kmv9o9n1NYwxPe+Kp39tuXEJCp1cRJFiCR4jf
        6Bm6gPmhnzXH5j7fvYhk8cOzDCugTSyjAaHchLJlMlCwUXYTMPeUUG+gm7UTUFdJ4iMzYU
        vQbBr1hk2qSyIu+S4DowishcqvaZtMg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-OsAsDADyNyWgWEaMZInWBA-1; Wed, 23 Sep 2020 02:32:49 -0400
X-MC-Unique: OsAsDADyNyWgWEaMZInWBA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD408807100;
        Wed, 23 Sep 2020 06:32:47 +0000 (UTC)
Received: from [10.36.112.29] (ovpn-112-29.ams2.redhat.com [10.36.112.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4694B78822;
        Wed, 23 Sep 2020 06:32:45 +0000 (UTC)
Subject: Re: [PATCH v2] iommu/arm: Add module parameter to set msi iova
 address
To:     Will Deacon <will@kernel.org>,
        Vennila Megavannan <vemegava@linux.microsoft.com>
Cc:     jean-philippe@linaro.org, joro@8bytes.org,
        linux-kernel@vger.kernel.org, shameerali.kolothum.thodi@huawei.com,
        iommu@lists.linux-foundation.org, tyhicks@linux.microsoft.com,
        srinath.mannam@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
References: <20200914181307.117792-1-vemegava@linux.microsoft.com>
 <20200921204545.GA3811@willie-the-truck>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <85f7d1ae-71a9-4e95-8a30-03cc699d4794@redhat.com>
Date:   Wed, 23 Sep 2020 08:32:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200921204545.GA3811@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 9/21/20 10:45 PM, Will Deacon wrote:
> On Mon, Sep 14, 2020 at 11:13:07AM -0700, Vennila Megavannan wrote:
>> From: Srinath Mannam <srinath.mannam@broadcom.com>
>>
>> Add provision to change default value of MSI IOVA base to platform's
>> suitable IOVA using module parameter. The present hardcoded MSI IOVA base
>> may not be the accessible IOVA ranges of platform.
>>
>> If any platform has the limitaion to access default MSI IOVA, then it can
>> be changed using "arm-smmu.msi_iova_base=0xa0000000" command line argument.
>>
>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>> Co-developed-by: Vennila Megavannan <vemegava@linux.microsoft.com>
>> Signed-off-by: Vennila Megavannan <vemegava@linux.microsoft.com>
>> ---
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 ++++-
>>  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 5 ++++-
>>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> This feels pretty fragile. Wouldn't it be better to realise that there's
> a region conflict with iommu_dma_get_resv_regions() and move the MSI window
> accordingly at runtime?

Since cd2c9fcf5c66 ("iommu/dma: Move PCI window region reservation back
into dma specific path"), the PCI host bridge windows are not exposed by
iommu_dma_get_resv_regions() anymore. If I understood correctly, what is
attempted here is to avoid the collision between such PCI host bridge
window and the MSI IOVA range.

Thanks

Eric
> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

