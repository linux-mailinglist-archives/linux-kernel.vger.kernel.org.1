Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16172756D1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 13:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgIWLEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 07:04:24 -0400
Received: from mail-bn8nam11on2066.outbound.protection.outlook.com ([40.107.236.66]:12000
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726466AbgIWLEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 07:04:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNShelGkxtNjAolvfEtv6nAyzspOMQtKRViRsVAw2OddttXqSKVTY1OMSaLtOuhA6pwq1bEwj+jU2+RWgtTwJTv25QVKVG/zJQumKOVSMz3Jkk1sWmcuRkyNsY3tLNzQPHBCXr99/Njk2IhlYoQOYd9PshIpA1P7PjfRjgGvNiydNrc9dRfzxZdQkLMoAgYmdV9BosUCgx2JsoYqfzUUvCWgfX/7vgEk/5IDbKikPHvcKR+Bjwdc6A7rxZlxu2FI+CnHLfvh++C6pvW/5MxGK4EOXVdGzKDmy+z6O1b+HRU/pmefb0l2OBW/P6rzCNiI+6H5TewmHjNl7x2W0gpneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hblxid5BQCezAaZc71o/wIE+KdOFw8mHfk40JcdCFNk=;
 b=m8nfEiwsRqXOexRtnq3e7vD4f1S5IED4s1ITqV+ULs0/bD87I/75m74WrzFTs5dioA4l5/z9NFPCtbk+J6iLUqaqK0Ck5F7YHw/chBt9U71AL2imCIfnpr61KF3E+HG3kihnOctLAvXKuPvSZwf49LD1DxOvX/c53OMNS3zW19vx5IHhKIsG6vZXF5dbVc3JUE0e0UuWky0FqXPeHm+K0KZa63DpjuctHVn2mHYliz++HWXbzvzwcIZ1IiRaOJaXzpRQCOaVx2UgC7hVqlJtz3rElOcjfaT99ShENAIEUIsoFgaiXMeg+NOBS2k9bWvh06KwcG/mbRYlHBfHceVMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hblxid5BQCezAaZc71o/wIE+KdOFw8mHfk40JcdCFNk=;
 b=hy5UVEv2T3b4MCWeq9uxtokyIbln76KgdSPch8aix0OekQ3REOg1e8ANDlGJ8F3iKcwPImSEDVZroEhGFdv/mswhda54LHnyzL6v/MeuH3QBWoJhkxt92GQXpx5GIb1ZRx0Kc5bhivq8hU5PNtAC4U2bSeX+DLTmvcjehs1ESGg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR1201MB0025.namprd12.prod.outlook.com (2603:10b6:4:53::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14; Wed, 23 Sep 2020 11:04:17 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.022; Wed, 23 Sep 2020
 11:04:17 +0000
Subject: Re: [PATCH 2/3] iommu: amd: Add support for RMP_PAGE_FAULT and
 RMP_HW_ERR
To:     Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Jon.Grimm@amd.com, brijesh.singh@amd.com
References: <20200916135549.146468-1-suravee.suthikulpanit@amd.com>
 <20200916135549.146468-3-suravee.suthikulpanit@amd.com>
 <20200918093117.GO31590@8bytes.org>
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <64ffa498-990d-2086-eff3-bac70f674e88@amd.com>
Date:   Wed, 23 Sep 2020 18:04:07 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <20200918093117.GO31590@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.80.7]
X-ClientProxiedBy: KL1PR0401CA0006.apcprd04.prod.outlook.com
 (2603:1096:820:f::11) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (165.204.80.7) by KL1PR0401CA0006.apcprd04.prod.outlook.com (2603:1096:820:f::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend Transport; Wed, 23 Sep 2020 11:04:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 106a152d-32d1-4de6-b59e-08d85fb069f7
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0025:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB002573FA0F3EFBCD934D31A9F3380@DM5PR1201MB0025.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3xcxO/6b2bZGGn6xQgUz7JiJE6Lnm9MWh0etNgStgnOuR3kL5aKmMLQz0o+0n8sW4inl75g+KazKzhsTqdpNq/7XRO6PYKCr59rPB+7pF7dy7ANcGYKXZKM3V1rNMzcRqw0rFUeLnaXLRGdUGOliPfqCLicu7gE/dZ2oAXnPJUO/Ywtr+osEoTJxq+j+zu824y8OHeh4KalAm56Fn50H62H5CqlNOdk9UKuCnX+RSGSnvTHTmx1QjY9PVmvDpd+eVQzGDndeJzaINFIZMmN4b43ORwXR9RGabUTxue0luUM2yDWR7GE2US1AS7LxXkbirT/iEHlYega8vW67NFQ4BsLM/qMABlMu8ALIjDZ4F3WEi6EGAaHbmiSna93KO9jq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(2906002)(6916009)(8936002)(4326008)(6486002)(66476007)(6512007)(66556008)(5660300002)(36756003)(66946007)(8676002)(31686004)(31696002)(44832011)(53546011)(478600001)(86362001)(2616005)(26005)(186003)(16526019)(6506007)(956004)(83380400001)(52116002)(6666004)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ELstsUj8W5EgZ3uv29vBGfn7J+1CN247BfpWqMLS+wTedNbRf+309qCLtVvgM+Y77YTICeNki/yuwB6XG+dQ78hE7u7O4WWj9ne1scxtplaoIn/ruv43IkCmCLZxVIVjIUBYzdSrtHlfEA9DCo8TIgPbRdRlUJ606RFDGSrgoMsRdEYdUgm3az4NwvuhqXBszxrihd5DEsnOy1ozEDfU6cyH4WKfD5u5lJiCtupLI6QLhnwvy1lJbj9Kgh2ZrjVaUV5Y17p97HA3EVWs//7yHJC0VP6KrOJqltWyGjesrWz9pBy7g4VxVMcTqDLYRHY5yab/MaQmtVYOlj2s7bT4FN+aF5PU60INXgnAs/VSA9Xh+lUqh9d768NrSdX0ZZgVG8p6bxQ89Soc//gSkJUvL3cGRDbYlHFI9us6rvmRAqZlNL3pmiGvKd9mLgn9Y0QfHEf7K0yIbkhYA4do041E9HwXp3S+ah456OgFR5ddZFeIIeuNENsafu46FXl0iJfWmAW6PklBFvzcHca1BdO129JSGFNGl9aKrXYcPn7PuihmJnlCi3kd20r5GIg/fOPmfWphBKhTjL0JBlKo8jMuWeubh3AuB8CjzoD5kAznrzAxXmn4A02LTBwId86nvqVKXOUvQncx/7mtPZOU9YhGSw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106a152d-32d1-4de6-b59e-08d85fb069f7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 11:04:17.2858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXCN5ip1mKdWklphf80jW7UmKq1ICU2Ygwv+WOChWXPnpHVhV/Gj8+CxG6Vny51haxpIHjshDHUfy4KZ49PNmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/20 4:31 PM, Joerg Roedel wrote:
> Hi Suravee,
> 
> On Wed, Sep 16, 2020 at 01:55:48PM +0000, Suravee Suthikulpanit wrote:
>> +static void amd_iommu_report_rmp_hw_error(volatile u32 *event)
>> +{
>> +	struct pci_dev *pdev;
>> +	struct iommu_dev_data *dev_data = NULL;
>> +	int devid     = (event[0] >> EVENT_DEVID_SHIFT) & EVENT_DEVID_MASK;
>> +	int vmg_tag   = (event[1]) & 0xFFFF;
>> +	int flags     = (event[1] >> EVENT_FLAGS_SHIFT) & EVENT_FLAGS_MASK;
>> +	u64 spa       = ((u64)event[3] << 32) | (event[2] & 0xFFFFFFF8);
> 
> Please write this as:
> 
> 	struct iommu_dev_data *dev_data = NULL;
> 	int devid, vmg_tag, flags;
> 	struct pci_dev *pdev;
> 	u64 spa;
> 
> 	devid   = (event[0] >> EVENT_DEVID_SHIFT) & EVENT_DEVID_MASK;
> 	vmg_tag = (event[1]) & 0xFFFF;
> 	flags   = (event[1] >> EVENT_FLAGS_SHIFT) & EVENT_FLAGS_MASK;
> 	spa     = ((u64)event[3] << 32) | (event[2] & 0xFFFFFFF8);
> 
> Same applied the the next function.
> 
>> +
>> +	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
>> +					   devid & 0xff);
>> +	if (pdev)
>> +		dev_data = dev_iommu_priv_get(&pdev->dev);
>> +
>> +	if (dev_data && __ratelimit(&dev_data->rs)) {
>> +		pci_err(pdev, "Event logged [RMP_HW_ERROR devid=0x%04x, vmg_tag=0x%04x, spa=0x%llx, flags=0x%04x]\n",
>> +			devid, vmg_tag, spa, flags);
> 
> Printing the devid is not really needed here, no? Same issue in the next
> function.

I'll update the patch and will send out V2.

Thanks,
Suravee
