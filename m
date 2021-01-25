Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1526A3033D2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbhAZFFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:05:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29136 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726361AbhAYJ32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611566881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DgLn7mRLyLa5hY4Q/SNI7yc80bmJUoLZ6qDWh4ZcMp4=;
        b=a8T8iq3wT3IGB2i4bfNY+SrUcQjj/1DSklNPOdJhH95n/Y7cgS+HJIKNMXpx5qnCCk2QE4
        YPTYDdZSGpEXhd8CLm/2vBxkTRs3LMA1OZNMxKtTgaGFORp0tlCXOFIAGVm/JTvE6ubTv9
        oxSVtxVhMazLKCYK5IlBe3D1LddsXpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-eg28SkrbPv-pCQq-Pyxj2w-1; Mon, 25 Jan 2021 03:43:27 -0500
X-MC-Unique: eg28SkrbPv-pCQq-Pyxj2w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9047959;
        Mon, 25 Jan 2021 08:43:25 +0000 (UTC)
Received: from [10.36.113.217] (ovpn-113-217.ams2.redhat.com [10.36.113.217])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D143676E16;
        Mon, 25 Jan 2021 08:43:14 +0000 (UTC)
Subject: Re: [PATCH RFC v1 00/15] iommu/virtio: Nested stage support with Arm
To:     Vivek Kumar Gautam <vivek.gautam@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org
Cc:     jean-philippe@linaro.org, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, mst@redhat.com, joro@8bytes.org,
        will.deacon@arm.com, shameerali.kolothum.thodi@huawei.com,
        alex.williamson@redhat.com, yi.l.liu@intel.com,
        lorenzo.pieralisi@arm.com, robin.murphy@arm.com
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <a8fd0176-3888-44cf-d659-2e2213a59969@redhat.com>
 <ba4c30b9-1f31-f6b2-e69a-7bb71ce74d57@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <7ccaa834-0a50-43cc-3da9-7ee13a0c52d2@redhat.com>
Date:   Mon, 25 Jan 2021 09:43:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ba4c30b9-1f31-f6b2-e69a-7bb71ce74d57@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On 1/21/21 6:34 PM, Vivek Kumar Gautam wrote:
> Hi Eric,
> 
> 
> On 1/19/21 2:33 PM, Auger Eric wrote:
>> Hi Vivek,
>>
>> On 1/15/21 1:13 PM, Vivek Gautam wrote:
>>> This patch-series aims at enabling Nested stage translation in guests
>>> using virtio-iommu as the paravirtualized iommu. The backend is
>>> supported
>>> with Arm SMMU-v3 that provides nested stage-1 and stage-2 translation.
>>>
>>> This series derives its purpose from various efforts happening to add
>>> support for Shared Virtual Addressing (SVA) in host and guest. On Arm,
>>> most of the support for SVA has already landed. The support for nested
>>> stage translation and fault reporting to guest has been proposed [1].
>>> The related changes required in VFIO [2] framework have also been put
>>> forward.
>>>
>>> This series proposes changes in virtio-iommu to program PASID tables
>>> and related stage-1 page tables. A simple iommu-pasid-table library
>>> is added for this purpose that interacts with vendor drivers to
>>> allocate and populate PASID tables.
>>> In Arm SMMUv3 we propose to pull the Context Descriptor (CD) management
>>> code out of the arm-smmu-v3 driver and add that as a glue vendor layer
>>> to support allocating CD tables, and populating them with right values.
>>> These CD tables are essentially the PASID tables and contain stage-1
>>> page table configurations too.
>>> A request to setup these CD tables come from virtio-iommu driver using
>>> the iommu-pasid-table library when running on Arm. The virtio-iommu
>>> then pass these PASID tables to the host using the right virtio backend
>>> and support in VMM.
>>>
>>> For testing we have added necessary support in kvmtool. The changes in
>>> kvmtool are based on virtio-iommu development branch by Jean-Philippe
>>> Brucker [3].
>>>
>>> The tested kernel branch contains following in the order bottom to top
>>> on the git hash -
>>> a) v5.11-rc3
>>> b) arm-smmu-v3 [1] and vfio [2] changes from Eric to add nested page
>>>     table support for Arm.
>>> c) Smmu test engine patches from Jean-Philippe's branch [4]
>>> d) This series
>>> e) Domain nesting info patches [5][6][7].
>>> f) Changes to add arm-smmu-v3 specific nesting info (to be sent to
>>>     the list).
>>>
>>> This kernel is tested on Neoverse reference software stack with
>>> Fixed virtual platform. Public version of the software stack and
>>> FVP is available here[8][9].
>>>
>>> A big thanks to Jean-Philippe for his contributions towards this work
>>> and for his valuable guidance.
>>>
>>> [1]
>>> https://lore.kernel.org/linux-iommu/20201118112151.25412-1-eric.auger@redhat.com/T/
>>>
>>> [2]
>>> https://lore.kernel.org/kvmarm/20201116110030.32335-12-eric.auger@redhat.com/T/
>>>
>>> [3] https://jpbrucker.net/git/kvmtool/log/?h=virtio-iommu/devel
>>> [4] https://jpbrucker.net/git/linux/log/?h=sva/smmute
>>> [5]
>>> https://lore.kernel.org/kvm/1599734733-6431-2-git-send-email-yi.l.liu@intel.com/
>>>
>>> [6]
>>> https://lore.kernel.org/kvm/1599734733-6431-3-git-send-email-yi.l.liu@intel.com/
>>>
>>> [7]
>>> https://lore.kernel.org/kvm/1599734733-6431-4-git-send-email-yi.l.liu@intel.com/
>>>
>>> [8]
>>> https://developer.arm.com/tools-and-software/open-source-software/arm-platforms-software/arm-ecosystem-fvps
>>>
>>> [9]
>>> https://git.linaro.org/landing-teams/working/arm/arm-reference-platforms.git/about/docs/rdn1edge/user-guide.rst
>>>
>>
>> Could you share a public branch where we could find all the kernel
>> pieces.
>>
>> Thank you in advance
> 
> Apologies for the delay. It took a bit of time to sort things out for a
> public branch.
> The branch is available in my github now. Please have a look.
> 
> https://github.com/vivek-arm/linux/tree/5.11-rc3-nested-pgtbl-arm-smmuv3-virtio-iommu

no problem. Thank you for the link.

Best Regards

Eric
> 
> 
> 
> Thanks and regards
> Vivek
> 
>>
>> Best Regards
>>
>> Eric
>>>
>>> Jean-Philippe Brucker (6):
>>>    iommu/virtio: Add headers for table format probing
>>>    iommu/virtio: Add table format probing
>>>    iommu/virtio: Add headers for binding pasid table in iommu
>>>    iommu/virtio: Add support for INVALIDATE request
>>>    iommu/virtio: Attach Arm PASID tables when available
>>>    iommu/virtio: Add support for Arm LPAE page table format
>>>
>>> Vivek Gautam (9):
>>>    iommu/arm-smmu-v3: Create a Context Descriptor library
>>>    iommu: Add a simple PASID table library
>>>    iommu/arm-smmu-v3: Update drivers to work with iommu-pasid-table
>>>    iommu/arm-smmu-v3: Update CD base address info for user-space
>>>    iommu/arm-smmu-v3: Set sync op from consumer driver of cd-lib
>>>    iommu: Add asid_bits to arm smmu-v3 stage1 table info
>>>    iommu/virtio: Update table format probing header
>>>    iommu/virtio: Prepare to add attach pasid table infrastructure
>>>    iommu/virtio: Update fault type and reason info for viommu fault
>>>
>>>   drivers/iommu/arm/arm-smmu-v3/Makefile        |   2 +-
>>>   .../arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c      | 283 +++++++
>>>   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  16 +-
>>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 268 +------
>>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   4 +-
>>>   drivers/iommu/iommu-pasid-table.h             | 140 ++++
>>>   drivers/iommu/virtio-iommu.c                  | 692 +++++++++++++++++-
>>>   include/uapi/linux/iommu.h                    |   2 +-
>>>   include/uapi/linux/virtio_iommu.h             | 158 +++-
>>>   9 files changed, 1303 insertions(+), 262 deletions(-)
>>>   create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
>>>   create mode 100644 drivers/iommu/iommu-pasid-table.h
>>>
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

