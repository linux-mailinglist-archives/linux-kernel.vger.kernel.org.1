Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31484274C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 00:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgIVWhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 18:37:10 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60682 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgIVWhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 18:37:09 -0400
Received: from [192.168.1.171] (50-39-235-197.bvtn.or.frontiernet.net [50.39.235.197])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1508920B7179;
        Tue, 22 Sep 2020 15:37:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1508920B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600814229;
        bh=ClwMIaEy1QkOug3GZQC9xiEgNvcZxX8uczkxLFHFqh8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LZItGfNojTl6mkytfVVoC0bv8uWfNuAm4O+yL0CV3M1p16sUodwOl7UeKSdCC3Jjp
         jDiDKmyPNrCyl41pbnvRZlnSU0S4/EDIHlVoJeBNGZp5hyVL218Z6QDyqjHYrIus+A
         d94Y64Yk3ZocNDV8HOZqm7ZAlTv8QChWSIONOCIo=
Subject: Re: [PATCH v2] iommu/arm: Add module parameter to set msi iova
 address
To:     Will Deacon <will@kernel.org>
Cc:     robin.murphy@arm.com, joro@8bytes.org, srinath.mannam@broadcom.com,
        jean-philippe@linaro.org, eric.auger@redhat.com,
        shameerali.kolothum.thodi@huawei.com, tyhicks@linux.microsoft.com,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <20200914181307.117792-1-vemegava@linux.microsoft.com>
 <20200921204545.GA3811@willie-the-truck>
From:   Vennila Megavannan <vemegava@linux.microsoft.com>
Message-ID: <f2de12f9-b53b-abcd-4133-7bcb90341f0c@linux.microsoft.com>
Date:   Tue, 22 Sep 2020 15:37:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921204545.GA3811@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure, that's a great suggestion, I'll rework on the patch and post again.

Vennila

On 9/21/2020 1:45 PM, Will Deacon wrote:
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
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 ++++-
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c       | 5 ++++-
>>   2 files changed, 8 insertions(+), 2 deletions(-)
> This feels pretty fragile. Wouldn't it be better to realise that there's
> a region conflict with iommu_dma_get_resv_regions() and move the MSI window
> accordingly at runtime?
>
> Will
