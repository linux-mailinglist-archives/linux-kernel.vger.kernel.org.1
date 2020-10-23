Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4899829753E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbgJWQv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:51:28 -0400
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com ([40.107.93.84]:35520
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752807AbgJWQvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:51:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3D29VhJHRMLemEI0Q/FHe3ZtV0oEO/9n4yI4X67oT7r2HFVLChpry0MVfoj77BOlvwdVT6dZq2YEuhmK6nrAcV+Kxkhxs8bkeIpMw+thuXJjUkDt/MfJ5F/HOPI1FmPqAB24yQUZl/4KiVD7jehFZt2y0nEgVeqaftgzcgSusPGFYvOb7kRxXfI24ck0OxbvYcnhebXd7POxRpnmIeqW6ulbBVG/C2uWUm41mqXD0RfMLIVoBRSvU0FNu8rpFVrjY6f21Sg/0vEqlisZ4a8Qcj1zchKK+LF0VemIbl8olIP3GBg0jcXBZL54SdjFZLQMEA1gyPeEKJZYWEt9qRwNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb6xlH+YsIQLQra1S6TBPMNI9X0yX0l13txSZtFBGYk=;
 b=WTJHLhle0H6qOQ2srWU3A1tmT5vb1OmHLq9NDtSI8KevbeMrRnLIYSCb6A/tPHkc4PejHDFpgltmQYPIEXCoDiiQ0c9VDRJnctHDfgjWbOYzlLbw/mjC6lptJum/Motk5UawXilKfLHLKToBc5Zdo02TSRJ17zKoT50IMbt6SerI+5d9J+I/i4oLUqyXP013RQOYtKH6mLwtKI2n7SipsqQAP9CBKj+HeHikbkLvjx5yg8IVkuKkLuHT0NVgLOVixl1ZlzMFX6UuRxCrPbMMZEoLIRNSrmoml7oazbTL2CYSy/HUjvvt82Zi/ucOzA3dT9HVoUYLShVkcV7P7k4brw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb6xlH+YsIQLQra1S6TBPMNI9X0yX0l13txSZtFBGYk=;
 b=AGUbVTGo9ov97LluCKr1swnUHrzAZnCtG96/IqvY9YudlZkxk2P1ekmCjH1s4tw/R576uSQOoX9EM/aMdOuczAGegQoe/u3imiSL5H7u+dxbvrokMMAX9Ij9lah5EBslO0nKUCYMWU6ZrKYBoyUerikAQ5EGqli7yFcnAXDGQBU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2417.namprd12.prod.outlook.com (2603:10b6:207:45::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 23 Oct
 2020 16:51:00 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 16:51:00 +0000
Subject: Re: [PATCH v3 11/56] drm/amdgpu: fix some kernel-doc markups
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Bernard Zhao <bernard@vivo.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jacob He <jacob.he@amd.com>,
        Jonathan Kim <jonathan.kim@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        xinhui pan <xinhui.pan@amd.com>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <ffc1f2d59fd5005f365eb5d178a2d890112bb6bb.1603469755.git.mchehab+huawei@kernel.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5e7a3500-a84a-1dfb-0841-bb624eba30c8@amd.com>
Date:   Fri, 23 Oct 2020 18:50:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <ffc1f2d59fd5005f365eb5d178a2d890112bb6bb.1603469755.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM4PR0701CA0027.eurprd07.prod.outlook.com
 (2603:10a6:200:42::37) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR0701CA0027.eurprd07.prod.outlook.com (2603:10a6:200:42::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.7 via Frontend Transport; Fri, 23 Oct 2020 16:50:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eae4bd9c-256f-4b08-8bda-08d87773d1a0
X-MS-TrafficTypeDiagnostic: BL0PR12MB2417:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2417977C14AE775EA4961216831A0@BL0PR12MB2417.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8scQpRbzcT2TTnlvPEXmz8V++e2H+hT0LohqzgNjkPkS/A0KCvWsnGNAQ3ZsUTi8hHKE0aDQXCT0DD+DWrE8wEOLy45N+bmo39TA9b2un/LdxLE4/bqVBSFW/vl2G4TJ3kIaBbIvBnMrgK7qYjIZmSaOiSrdquP4N1fTXd/N6fYi1a5S2nGYYXZGibLuoDZ3nuY2KYw7e2GhqGwl2ymmFFkpqUWRmpb9FijdcVjlx0tzZBNL5t2b2ZaIhUe24RdKcwW7hGjoOp6b+VgQGA3S7JA20zybmLK7QUyXKI8CgL3onEm01A8kSuJqlcwsCJt5gMctSBOYwsTXopNvN8XJdVvVyCdlY0XBb9R9Uo6Mxcuf8Soli3BBN2akQ1cgbPS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(86362001)(2906002)(478600001)(54906003)(83380400001)(66574015)(316002)(6486002)(8676002)(31686004)(186003)(2616005)(16526019)(8936002)(66556008)(66946007)(52116002)(4326008)(31696002)(110136005)(5660300002)(66476007)(7416002)(6666004)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tRk54PN/KWpnXgbWV+uUTlP4+b9JbqCBaTZL4ilWcG83MA9koGhT2E8lRFAaXrO8/ZH5o6N3wg11pQG48hEAIgzZE0EUh1IOQ1fnffWb1+ooRQWsRwtTtv1QCHvep/fzk5TXVVbZFQWVEegHYQ9k4pjfcXBKyIF3c5XwWlCcH9Wgmjr2jga5Yomu/gi3jpmkFoB+O9pu6+eLpaZkuMsPU4uamBGzygkljKnTfzdZIlntdpOwa0T1n+MHvJUmlFeEEnp3yjlwcWDkbYXVRtjtGS6RiaaJNOgs88lJO4I6uHSrDV+mdIJOjl17z4NQ3CzsvCxjd9XiDsNMGBsfDLV9TUL3OxYFtG+hlpVQ5BQ0XMauBAWo9P/bH5AFzMo9GGf+KdRhIykESYpccteRkSYax4AFOTCxUExI6YPSEZ6TeArYF5O0DuuDV4h5xI3EsnxnvG7xO6A+D1qlYOHUCNKou2TuU/9wsfX8fwKAdKconcKHXUcXyufQZtiicGR/iqAx39TPqeM5xG+0yyKoNvQ7zo21Ok+R6Yd9V8NglH9wsGMAV3fYoNi04kCzJizYFgitaC3BF4uJq9turwtoBtBy3nOyfx+aHkHTSAh5PkFqB9knTmokzb7EJH1t4PKSs0ZKjY/H+iptYQ6jxNpHqgAyThSFLRAHl2X6UzcKwnfzO0WeqTQ/1/GUFYV2xZ9OPiBaTrfecYOnNiegT7xKmii+Zw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae4bd9c-256f-4b08-8bda-08d87773d1a0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 16:50:59.8277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10tc9HHyD1mlCQ02XT8VEVaiJaC7ZF0PF0FSVrdmYcBmQkLLZmvChBvfaR8+tulP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2417
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23.10.20 um 18:32 schrieb Mauro Carvalho Chehab:
> Some functions have different names between their prototypes
> and the kernel-doc markup.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c       | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>   include/uapi/drm/amdgpu_drm.h                | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index df110afa97bf..a5f73a267fe5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2166,7 +2166,7 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
>   
>   
>   /**
> - * amdgpu_vm_bo_insert_mapping - insert a new mapping
> + * amdgpu_vm_bo_insert_map - insert a new mapping
>    *
>    * @adev: amdgpu_device pointer
>    * @bo_va: bo_va to store the address
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 0c6b7c5ecfec..795bad307497 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -528,7 +528,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>   }
>   
>   /**
> - * amdgpu_vram_mgr_alloc_sgt - allocate and fill a sg table
> + * amdgpu_vram_mgr_free_sgt - allocate and fill a sg table
>    *
>    * @adev: amdgpu device pointer
>    * @sgt: sg table to free
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index c5ff2b275fcd..791a1d597d2a 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -667,7 +667,7 @@ struct drm_amdgpu_cs_chunk_data {
>   	};
>   };
>   
> -/**
> +/*
>    *  Query h/w info: Flag that this is integrated (a.h.a. fusion) GPU
>    *
>    */

