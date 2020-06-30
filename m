Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A229B20F4E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 14:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbgF3MnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 08:43:02 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1396 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgF3MnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:43:01 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efb33240000>; Tue, 30 Jun 2020 05:42:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 05:43:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 30 Jun 2020 05:43:01 -0700
Received: from [10.26.75.203] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 12:42:54 +0000
Subject: Re: [PATCH v8 3/3] iommu/arm-smmu: Add global/context fault
 implementation hooks
To:     Robin Murphy <robin.murphy@arm.com>,
        Krishna Reddy <vdumpa@nvidia.com>
CC:     <snikam@nvidia.com>, <nicoleotsuka@gmail.com>,
        <mperttunen@nvidia.com>, <bhuntsman@nvidia.com>, <will@kernel.org>,
        <linux-kernel@vger.kernel.org>, <praithatha@nvidia.com>,
        <talho@nvidia.com>, <iommu@lists.linux-foundation.org>,
        <nicolinc@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <yhsu@nvidia.com>, <treding@nvidia.com>,
        <linux-arm-kernel@lists.infradead.org>, <bbiswas@nvidia.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-4-vdumpa@nvidia.com>
 <4b4b20af-7baa-0987-e40d-af74235153f6@nvidia.com>
 <6c2ce909-c71b-351f-79f5-b1a4b4c0e4ac@arm.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <fd1f1102-ab05-002a-a86a-d3c6cef21e01@nvidia.com>
Date:   Tue, 30 Jun 2020 13:42:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <6c2ce909-c71b-351f-79f5-b1a4b4c0e4ac@arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593520932; bh=hK3xWsoaF4cxDik6Mhq5qaTx82gKOLvVl8GbV1br+EM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=puWqgxQA8yIruffJjHDVkJAi+UFOYN1pn9OAiXwGvywkKRxjWFtBhUaip1YoThldr
         i6NHZ/dtKAjI+ln4Q1pE/KqNNlnUyluMJWqRyzuo/t91r1WMqbicqPfWCCQfx+fvuQ
         9NXOzVNUNZWMkxYN5++mPnQCMwjlfc9ZOiifR0/dSrwRbbHDHUpyGt6S6pI2K1RXDB
         xuE3VAKgS4D2NXdlBAtGsx9f6aNRLRdRZV1Cq3f/maRdn2uW4ti2PRd18RZPpqrg4e
         LqvR5JhOSxqw0tbBOpNj9MgYkrYITBUBAcsKIlpbugPsPSgP09fFVixBvKQSSvPNMp
         STDwB7x62E+0g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/06/2020 13:13, Robin Murphy wrote:
> On 2020-06-30 09:37, Jon Hunter wrote:
>>
>> On 30/06/2020 01:10, Krishna Reddy wrote:
>>> Add global/context fault hooks to allow NVIDIA SMMU implementation
>>> handle faults across multiple SMMUs.
>>
>> Nit ... this is not just for NVIDIA, but this allows anyone to add
>> custom global/context and fault hooks. So I think that the changelog
>> should be clear that this change permits custom fault hooks and that
>> custom fault hooks are needed for the Tegra194 SMMU. You may also want
>> to say why.
>>
>>>
>>> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
>>> ---
>>> =C2=A0 drivers/iommu/arm-smmu-nvidia.c | 98 +++++++++++++++++++++++++++=
++++++
>>> =C2=A0 drivers/iommu/arm-smmu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 17 +++++-
>>> =C2=A0 drivers/iommu/arm-smmu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 3 +
>>> =C2=A0 3 files changed, 116 insertions(+), 2 deletions(-)

...

>>> @@ -835,7 +836,13 @@ static int arm_smmu_init_domain_context(struct
>>> iommu_domain *domain,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * handler seeing a half-initialise=
d domain state.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq =3D smmu->irqs[smmu->num_global_irqs=
 + cfg->irptndx];
>>> -=C2=A0=C2=A0=C2=A0 ret =3D devm_request_irq(smmu->dev, irq, arm_smmu_c=
ontext_fault,
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (smmu->impl && smmu->impl->context_fault)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 context_fault =3D smmu->imp=
l->context_fault;
>>> +=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 context_fault =3D arm_smmu_=
context_fault;
>>
>> Why not see the default smmu->impl->context_fault to
>> arm_smmu_context_fault in arm_smmu_impl_init() and then allow the
>> various implementations to override as necessary? Then you can get rid
>> of this context_fault variable here and just use
>> smmu->impl->context_fault below.
>=20
> Because the default smmu->impl is NULL. And as I've said before, NAK to
> forcing the common case to allocate a set of "quirks" purely to override
> the default IRQ handler with the default IRQ handler ;)


Ah OK, makes sense. Sorry I am a bit late to the review :-)

Jon

--=20
nvpublic
