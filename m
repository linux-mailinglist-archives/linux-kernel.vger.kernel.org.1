Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AD31FACA0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 11:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgFPJgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 05:36:13 -0400
Received: from mail-co1nam11on2076.outbound.protection.outlook.com ([40.107.220.76]:26656
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbgFPJgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 05:36:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G97VSFmKu2KiCPI4XOk1oBmO6T+xqBLF123gL7562/ycrGvCsjoNOw5L3Jkwj8stPmTXRSwyxUS9JBOvxwNruFdDUHcTInGthGvrxSJd70NbqgmoqfrpAAQNK4Ll/sb8UsBO5z3yNiTppebpTMBGU6mzQriv18lhPtHkGCwnMt5jlohcsIvWaQl06Ezm9MNVyGET580EVFueNhnUHFgrHNK6brlnvjAF/OrUU/dtN7SX+SkgM6mOHQ5HDs91K3KwKrMtJNIZeNZZE0UfoOnl7cZg/91Jw2RQ4fcCjtAPAXWyjql8REm2DdIf59VGLqf2g+V0Yecw0GvSNP4wdp2C9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cU+sgOXakDtGYijQ64gZND2Wf5aBlSsbn5bzbIMzBY=;
 b=fsK0aCdXENpCROcRsmGHlExqHcH32wMvjWqNOWMh/QSlupb2eNN/VIL18WLMMcCPCiUc4Dmc1b7/GAru/Ku3KLzPeXs4uaec/GjTvHia6nwDh3+GsujayazvqoXnWesejw77vZP0FPkm5XgdKiXJf4NTR/La4xl61h+zYQn1Zzq7BxqditR4T89aWBglxUMPQ2FnVGNI9ZmNhrAgACrt68ZfRXJgGS9lo+DRr0TbPya6PK1ZVbMtdLaOlSgKm2LFdIcau8ii6krezfrP5jvkyIMU9swn8LcuIVZc3kJ7gNuAy8xR76IW6+2RBkD8gJ0oXmPIxXjHPzpi3JJe6PEVnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cU+sgOXakDtGYijQ64gZND2Wf5aBlSsbn5bzbIMzBY=;
 b=pUykOiAurO4DwJ1WqM/h1AmTzap6LxPFPW6fRDPJFDKjsSsovwNWB526hxi33qU+xRHcElG9NaFzzTVP8V4iUKbpG4ovPATldKVvm+O+G3bsDtUMZAw2QbHnjKS3Qtd6PttUZrMkMXo5XqgQ+hPAZLi4CK08Gyof1H5FOYC5WW8=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:10::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21; Tue, 16 Jun 2020 09:36:00 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::c1bc:8ef9:9ba3:99bf]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::c1bc:8ef9:9ba3:99bf%10]) with mapi id 15.20.3088.029; Tue, 16 Jun
 2020 09:35:59 +0000
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
References: <20200529200738.1923-1-amonakov@ispras.ru>
 <56761139-f794-39b1-4dfa-dfc05fbe5f60@amd.com>
 <alpine.LNX.2.20.13.2006011132530.16067@monopod.intra.ispras.ru>
 <dba1e37a-1ed7-ef7f-7252-2ebd1d6bde8c@amd.com>
 <alpine.LNX.2.20.13.2006152346320.21123@monopod.intra.ispras.ru>
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <b01994db-da9b-d8e6-e0c1-1af35dd62191@amd.com>
Date:   Tue, 16 Jun 2020 16:35:48 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <alpine.LNX.2.20.13.2006152346320.21123@monopod.intra.ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (159.192.253.167) by SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend Transport; Tue, 16 Jun 2020 09:35:56 +0000
X-Originating-IP: [159.192.253.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0bd570d1-b7ef-4733-43fb-08d811d8ad52
X-MS-TrafficTypeDiagnostic: DM5PR12MB1449:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1449A962748243910033A3EDF39D0@DM5PR12MB1449.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Trh1rX62RVI2kI2bPDanGQGpAPGz6n5wOMChvBlciEQlM4z4JC7f3/aNuMccFzqvqb6y8KvUKKKAtSZ4Jja8bySJfPHMfzOCc59nsdwIvewmMC2y85irHEgktyCay02i41Mv7SzFYdUcybP2QiG4hbwDv/UWh49VM2OEXQ/hU6Sc+JUApzho6F5F7a6gEon9KfAn7kEMcSz1tvaflvjv0hQV/zyjn3EaT49JMhpu0he6gYXHh3bQ1rUVX77KK9kG3sR0DKBLqvjwL7RAIUcfw4poiUuiD/jVkPLKOfVpdKOi8A3EPFvd3IRk1G1/BU0h483+gqFB/SoqIUjFIfy0yNqvGjMcKQ8lVYQoD4DSZsv3vFx0rA3YdB07agVCTvU8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(44832011)(66476007)(6666004)(66946007)(5660300002)(31696002)(31686004)(66556008)(956004)(86362001)(8676002)(2616005)(52116002)(6916009)(6512007)(36756003)(186003)(16526019)(2906002)(6486002)(4326008)(53546011)(6506007)(26005)(83380400001)(8936002)(316002)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ppfQxRbr/KpTBZoyrg3b4f2CFXg+awkDVmvJK/uyp+4rvpKl+anfLsVvZpgrlGckGDUlPbJPEukHeLCGri9E3DCVxBzC7yCakqWYNYEyYKKEvZXClsHzGdPBg5bRRKgrcc6Ne98WR7ggkPyfMceNTqOaRo4VgwAR9NmrtGl5A1vf89H+218R5DSE/dEUXia9S/SqKD6XWhdn9T+kHKMXLfHQSso34oiOcba/Bx2zMAi+mA8nmLAalGDkUFzq4/Qd6D4ZE1XYAA066NiUQ2NgfQbu5seMs1mEQnQxylhvdPseiiZocNLzFjkq7JwPGEN+J/hiGt5Cf0NjUpiy5OG2xvVyIjJXpcTK2FWkF0v5RapHJ40idoJ5S/2YYgegEOxavAQWF/ka/NL+o4TtKYD0PqJ3qo/iZvDJE3VtBlm9Nd5k3mkq5Z5dz+dXIL5/koVLIMj1+23VUNI0B5kFrhebcrxEnYUzsRb2u5AMhfYOqjlXGZrM6uxnl4RmlfR8oy+i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd570d1-b7ef-4733-43fb-08d811d8ad52
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 09:35:59.8220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3sU3NJiEFAbPsKW0gjJt8ub6sGc5f0qbNnv1G9GJUumX8axlBWPzk7VJ4z6I/V0HCTpov4IbHB4QhtzN0WDCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/20 3:48 AM, Alexander Monakov wrote:
>> Alexander
>>
>> On 6/1/20 4:01 PM, Alexander Monakov wrote:
>>> On Mon, 1 Jun 2020, Suravee Suthikulpanit wrote:
>>>
>>>>> Moving init_iommu_perf_ctr just after iommu_flush_all_caches resolves
>>>>> the issue. This is the earliest point in amd_iommu_init_pci where the
>>>>> call succeeds on my laptop.
>>>> According to your description, it should just need to be anywhere after
>>>> the
>>>> pci_enable_device() is called for the IOMMU device, isn't it? So, on your
>>>> system, what if we just move the init_iommu_perf_ctr() here:
>>> No, this doesn't work, as I already said in the paragraph you are responding
>>> to. See my last sentence in the quoted part.
>>>
>>> So the implication is init_device_table_dma together with subsequent cache
>>> flush is also setting up something that is necessary for counters to be
>>> writable.
>>>
>>> Alexander
>>>
>> Instead of blindly moving the code around to a spot that would just work,
>> I am trying to understand what might be required here. In this case,
>> the init_device_table_dma()should not be needed. I suspect it's the IOMMU
>> invalidate all command that's also needed here.
>>
>> I'm also checking with the HW and BIOS team. Meanwhile, could you please give
>> the following change a try:
> Hello. Can you give any update please?
> 
> Alexander
> 

Sorry for late reply. I have a reproducer and working with the HW team to understand the issue.
I should be able to provide update with solution by the end of this week.

Suravee
