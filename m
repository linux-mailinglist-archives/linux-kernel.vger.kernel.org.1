Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C80282433
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 15:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgJCNIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 09:08:46 -0400
Received: from mail-bn8nam12on2062.outbound.protection.outlook.com ([40.107.237.62]:15137
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725710AbgJCNIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 09:08:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LH5GxOe2D29a5Q3TFUF05Xf6+awGvfCwaFii+hjfPWutwEhne66wffiRTzq/EEXhhTXe8MYyTqI2yM2+gfbL0ii8KHVbHDUcQ9t+9shuDMV3xoCemzV5h6S4x6GsEgp+Bq6PlbEonlLZ5NKbn5go2XhmR93OIcwL2wRl5ehewu6hXZrtZtbfoFXtuyGlOnCwdTiJ4/3EAz9TsZU02GFIqq181hDG0IqeM32ixI32GRQnee73sPIflYqYqWrYQxCx9mnYqpXP/pT/oJZPqddN8fmxv/cs4TJF9Jd31R5em7F3KL1q3d0W9yKa2Dd+sjj4Wz3gb7Us33PQR49ykPBLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNZMzsr8vnKyLNGGI0uH/b6LWbBp4Hvg0imdwsNYVOU=;
 b=Rg0zthqWYbvEsy9TCZIxwWmtv6GA0e9qvAzDOS9fpeBmcmBe2BTOaINljy3c1NbmFLiPXsZcWfli+L7Fptf19Sfo/1HPczNzhma8Ox+elc+3Z1HX2JQ+LmPC41IrqEtogAZDlnDMMWWAGl8bej4kilrIuSJNqDZRxuryn2YlKOE970rqx1Owv3XOvwXhYWUPHjqFT7XbD5mno/Tvoutp4lkTTjHLWXfQjcRtsbXN3spTXDFnKu1E101koTHmzcP+TyTg9ZyMX9B2UagHaezGeZm/5r/GUQEmSAjW8hUgQqkbe9qdkm8ozMDWVfK9E8Ys8EW/tfycj2X75+wmcpJGEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNZMzsr8vnKyLNGGI0uH/b6LWbBp4Hvg0imdwsNYVOU=;
 b=D+JF8qp3EjggAwtoAGvPdijpJHuBBGEaS69AOQ82UsvlneZURGIcKByOOCp51T8N6z5B9Z3xoNPV9mFIUmdHLsbXS0SJCIzPGnZ8ahyo6mNC2Rlq1RPImIIXX7t4/0O6KqppDqd2Jv0Y6Wf0TYDsfTcmWtXkJxdlHLwipmEM2sA=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB2827.namprd12.prod.outlook.com (2603:10b6:5:7f::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.38; Sat, 3 Oct 2020 13:08:40 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.039; Sat, 3 Oct 2020
 13:08:40 +0000
Subject: Re: [PATCH v2 00/13] iommu/amd: Add Generic IO Page Table Framework
 Support
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robin.murphy@arm.com
References: <20201002122830.4051-1-suravee.suthikulpanit@amd.com>
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <835c0d46-ed96-9fbe-856a-777dcffac967@amd.com>
Date:   Sat, 3 Oct 2020 20:08:32 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <20201002122830.4051-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [61.90.26.46]
X-ClientProxiedBy: SG2PR01CA0165.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::21) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (61.90.26.46) by SG2PR01CA0165.apcprd01.prod.exchangelabs.com (2603:1096:4:28::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Sat, 3 Oct 2020 13:08:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f89d9647-f187-43d8-135b-08d8679d7264
X-MS-TrafficTypeDiagnostic: DM6PR12MB2827:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2827C3C46BAEA726EA0AA8FCF30E0@DM6PR12MB2827.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DRecu6wGgjc3Hj5wIBavLEhJ8JW2hLFQcXqNafiXl55jEHtuFI7tOcH+RXlvBNFcDD53cA1pIa9swh1Q9bMfZt86aknWy/J56O0J11837pJr+EcRob8vMw2W8ybETplNnNvGHRQfQPFAMi2wO58uJ/mRdmTaaGAMr5CQbRqRxuTGsxwM/Sdv4fotAbeI8olxyLSl99sCmS97p++EmCc5ocZZM8eBjdnIGcZYXGJ0s1S+hVLEW4oUgDKtuJTHcXQVSuUDGVMtFv9yrYHIVe/7ysGCdgYWFokhCw3IWPzKGzAuB2tma5pbf0s99RqEBZi+ByWiWn0uAuPJcvaYi+P1Ivu71VWH8dxHwmp88MAJl9wEcCmh4Y1YiUm7t7tpVnzUI6VxBwJWj8MvqW1fZxgN0fTXz9KLwpUyNuwoz0vH0J5IpDk6R5W0+oGo4p4NpOymCPcus1rqyn0kD4uef5P5Yayvzg8iHZL4xmwDNIKv4Gk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(26005)(83080400001)(4326008)(6506007)(83380400001)(6512007)(16526019)(186003)(316002)(53546011)(2906002)(8936002)(52116002)(66556008)(66476007)(2616005)(6666004)(5660300002)(956004)(31696002)(8676002)(66946007)(44832011)(86362001)(6486002)(31686004)(36756003)(478600001)(41533002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fUv7fn25TWszg1er8gyYw/2SboIRY+0DPYGI0p9YCvgxQD/vYk1feGanlzGf/uzKBwM9BAdjiawiLNRZsT/iovLzLtRb1yGql2nXpWc9m6cMCFpu65D3PyOabd9jcVRWIWJNV/24kMr/u99nRlxDLNLNGObrZEYcHwYbv/7rue70EAUIBh+mKwSensX6+taw2dT3lMTm6DZSG4QjCaRDI/JFahpCEEareLnp2AQJY60nRJwlmxRdpdDlDBmbcQtj1czTapw1GPpBfV/xvjonu3fXn73FDXfevs0pixswXKLRErEmu+3j8Ti6R0DOLUThmLNYajKA1SzG0225f6GgKaJYfN+oDRt3jeB354C4lgRbXXWA160XoMqaUWmC6uAB5JDJN8pRJwJL/4DtGaynm28ApofLuBV5JnRqC+/CCuZ/vIhO17NWB1T11liZXWquv1bu2sktSLU3VzrPliQdQQmcoa9SPWoFOflYYeTP4PqA9vVgHpZ19jynnezp4rrW/8MPNwYbzGxAfzqgSj5BYinubcs57BJx03lmEQiqDA4QQ/C28BBDUd9Io+S7iqjfdljtZdP0nj/A7Y3TKtgDTMiTHbq37C1E6YrSZ6dtyy9Exz+djv/lfW7L8lPRHWMgZ0uOrTfi3pBJisNOZZKG4w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89d9647-f187-43d8-135b-08d8679d7264
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2020 13:08:40.3561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78ruS7AEWpFOjxok/1+V6yV1gnKNDNLXMuZCSjmIaswOG0WStYa++6A5ru2elhqj1naZV+Fz/kh11QZUwhFNTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2827
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found an issue w/ this series. Please ignore. I'll send out V3.

Regards,
Suravee

On 10/2/20 7:28 PM, Suravee Suthikulpanit wrote:
> The framework allows callable implementation of IO page table.
> This allows AMD IOMMU driver to switch between different types
> of AMD IOMMU page tables (e.g. v1 vs. v2).
> 
> This series refactors the current implementation of AMD IOMMU v1 page table
> to adopt the framework. There should be no functional change.
> Subsequent series will introduce support for the AMD IOMMU v2 page table.
> 
> Thanks,
> Suravee
> 
> Change from V1 (https://lkml.org/lkml/2020/9/23/251)
>    - Do not specify struct io_pgtable_cfg.coherent_walk, since it is
>      not currently used. (per Robin)
>    - Remove unused struct iommu_flush_ops.  (patch 2/13)
>    - Move amd_iommu_setup_io_pgtable_ops to iommu.c instead of io_pgtable.c
>      patch 13/13)
> 
> Suravee Suthikulpanit (13):
>    iommu/amd: Re-define amd_iommu_domain_encode_pgtable as inline
>    iommu/amd: Prepare for generic IO page table framework
>    iommu/amd: Move pt_root to to struct amd_io_pgtable
>    iommu/amd: Convert to using amd_io_pgtable
>    iommu/amd: Declare functions as extern
>    iommu/amd: Move IO page table related functions
>    iommu/amd: Restructure code for freeing page table
>    iommu/amd: Remove amd_iommu_domain_get_pgtable
>    iommu/amd: Rename variables to be consistent with struct
>      io_pgtable_ops
>    iommu/amd: Refactor fetch_pte to use struct amd_io_pgtable
>    iommu/amd: Introduce iommu_v1_iova_to_phys
>    iommu/amd: Introduce iommu_v1_map_page and iommu_v1_unmap_page
>    iommu/amd: Adopt IO page table framework
> 
>   drivers/iommu/amd/Kconfig           |   1 +
>   drivers/iommu/amd/Makefile          |   2 +-
>   drivers/iommu/amd/amd_iommu.h       |  22 +
>   drivers/iommu/amd/amd_iommu_types.h |  40 +-
>   drivers/iommu/amd/io_pgtable.c      | 534 +++++++++++++++++++++++
>   drivers/iommu/amd/iommu.c           | 644 +++-------------------------
>   drivers/iommu/io-pgtable.c          |   3 +
>   include/linux/io-pgtable.h          |   2 +
>   8 files changed, 656 insertions(+), 592 deletions(-)
>   create mode 100644 drivers/iommu/amd/io_pgtable.c
> 
