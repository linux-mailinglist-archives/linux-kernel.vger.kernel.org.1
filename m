Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB9B2AA4E9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 13:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgKGMMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 07:12:21 -0500
Received: from mail-bn8nam11on2068.outbound.protection.outlook.com ([40.107.236.68]:61888
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727298AbgKGMMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 07:12:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhK00RDpTcnzR8IX4y/OWITEZcVhDxHTe6IB4Oo/qEyx48oMMg5plObd2cpQLafpVtQ/1mPGnIuL43IiKmx03gg/5ozaku8qKilgc8qeb9ppmchJGPr+5j5XeVE2xrBJAm/F935VEZFT9FvlsgElMlqFBnLng5Yu5c4Z5gUoV39fME2KhId4nMcyWeN+Vwg++Vlk0s+4Skg4dR6ZAErgqfS0fmbDxhEmYTk0D50PDJdnfWQoOqTcXu8LankTgHhkbY3cJBdRZmAlZjMKqJ3/oaxSwsNv3pDLbgo9Z8OpgXtWs3zGXIeYtFFeoDW0YId7Na+PXtn3SQIL22a/nSHNtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/t7npU7A8P4jtcgq02VAPiswkxIr93rIBgCZBNrZYNg=;
 b=Qa2aoolpHkXdc8f/ZEAONOsW14H1DxsXeQkdSdxQT87DUjBOlCMeHilXNqBIQtwus+Nm6Z0oUx3xfCdYzHx3QRe3C7u4sgxlQ418KO8oghgxXEVX64lEW49a2qSCWpDj3ZeLpugTP0YW5Ik1TArD3yT/XnuebOtk4SlsdPp9x6/x7cgDlDKjkDryg0XlhfKbW5EgRy02AeVUPdrHISzEJ6GCXnoBF8LSh/IELf+6w2vZVtyoT7q8b7hnD7vzl3iTtfvXMputxw+9Das2senNNGh3FLbfk7ZOyWzgc1/n2ZVvcrcM4sdIIw9jUp3+myW7ZwWxUP3V1yBoBl7PvOWfiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/t7npU7A8P4jtcgq02VAPiswkxIr93rIBgCZBNrZYNg=;
 b=HGeF/SLFGoaITKg0dTZ7TBGySRblipaUYYFqCB9xtNb1+aUOrX8/Nc/fyveIwhoH/SZ6OBzlSGg7Wd9Jb20yaJqibfF0LwOL/HwVsT+18ZCSi4FNnKAT5/Mp3eteESH2lbC1Ufu1rBf/UzNxcKyYvDfu08J1jvxRIg+78YuXZ9I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2545.namprd12.prod.outlook.com (2603:10b6:207:4e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Sat, 7 Nov
 2020 12:12:15 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31%7]) with mapi id 15.20.3499.032; Sat, 7 Nov 2020
 12:12:15 +0000
Subject: Re: [PATCH 01/19] drm/ttm/ttm_range_manager: Demote non-conformant
 kernel-doc header
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
References: <20201106214949.2042120-1-lee.jones@linaro.org>
 <20201106214949.2042120-2-lee.jones@linaro.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <72945d8b-e1fe-8d4a-5c16-a40776e01007@amd.com>
Date:   Sat, 7 Nov 2020 13:12:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201106214949.2042120-2-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM8P189CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::12) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM8P189CA0007.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Sat, 7 Nov 2020 12:12:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 89d6618a-266b-4afa-6f1a-08d883165d44
X-MS-TrafficTypeDiagnostic: BL0PR12MB2545:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2545215173EC9E48B96D9C0383EC0@BL0PR12MB2545.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANpYD9OT/rIHvtvc0XuHBuPJibPpIrTIJm2wwJzwr+kIMFO8/w2dCsXlZeGMy+Tbz6RRpExEMcWzvsr7t/uMkGTSecZj9xRERAbqP6jzQOWJq0GAe7akyoBRzafEBxY2//fjCalMicNBdguJi34PizDOxMRBsDNmQro0mtk4tcyuPvj63gnMcsEX7AczAOe45LcjWuWV1agkQBeGIGE783Wd53oSjPSfp05sL1wIZKnmZpXfw33+O0hamiBVDky7cGNrFSm8eeYwXAqCxWDcJWKFjtTwr9D4Cw22Gmo2vKR9NHWBUPMmRn8jxI+r/EA+mLjmdnn3fKI2IBhJ7993IMH8cNR1oT3KdIxcFjdXlKN8UnxUHxOVFhTkPvDzPFg7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(4326008)(66574015)(83380400001)(6916009)(52116002)(8936002)(8676002)(478600001)(6486002)(31696002)(54906003)(16526019)(186003)(2906002)(36756003)(2616005)(66556008)(66476007)(86362001)(66946007)(6666004)(31686004)(316002)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: iDMmOsK74JWAV9hkPAuwoU0SRLCswaHGwROHu50bBendrvLoGmjB3CUkim9NBSFADS1jMUO7rp9FXOcNJdKQ6yWYDSUC5zHCKovD2vWeCE7qB/l/yJB2kWYWWJxw1fLzwsQ2yb3hqQzBZgy01PeFNJjsythHXKKhdBLOe0GVEql7Pay0on6JupXAGDuAtswI/gvjnxehQYFkewfZ+cJSoohr1526f74Ym1AUIREgbko5yy+Vi/IGQvcdORj908s5WnyYIFz/HDvZLOmXvlyghpLmwaHUiawP/Eo3fQP4v5ArhFX2tCkjir438+aLvcMxGUSgLsFSKP4J4OFxkOhpKknkJISEp1SHBk/wOfZgASzFI1eDFH7xzQQAP+Lv9wcznAAPvpm2nTLOvCynvD7rd+I/j7ETHQH/+vwHzcCZpnbM8FwM1K8404jao1d2b5F8tjG8VCaKshRKheRNXux5qUmhYGWrwsCKHdPM/zMipVKVNrmmT/YxVEyh4mpUHjxXfyohergcO3GIltFBjkQlyYOesirDf6RgDMMTsTjGilhSfL7XDQ7FI08iIpx9O4ooNCi/26juQbb2/GrspJpnuoFL3Fv1sQmaMug6ibKvr5jSCJYcykgqSofJ6vRAKrSNYlOhyns6/4RgWO2p0KwRr0l7ZdnD5DVU4e1smm1VDGytbzdeEQFuqHpcHse7/p0fnMEwWPNd7ZETX7WcuI+OPg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d6618a-266b-4afa-6f1a-08d883165d44
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2020 12:12:15.5607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmzoGkX/6HvZv7h8dQZIU9P7Gpb8FysWzj2x6GEJRcZPJIgczE1fwGDCzUQz90Aw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2545
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.11.20 um 22:49 schrieb Lee Jones:
> Fixes the following W=1 kernel build warning(s):
>
>   drivers/gpu/drm/ttm/ttm_range_manager.c:46: warning: cannot understand function prototype: 'struct ttm_range_manager '
>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/ttm/ttm_range_manager.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_range_manager.c b/drivers/gpu/drm/ttm/ttm_range_manager.c
> index ea77919569a2e..e0952444cea93 100644
> --- a/drivers/gpu/drm/ttm/ttm_range_manager.c
> +++ b/drivers/gpu/drm/ttm/ttm_range_manager.c
> @@ -37,7 +37,7 @@
>   #include <linux/spinlock.h>
>   #include <linux/module.h>
>   
> -/**
> +/*
>    * Currently we use a spinlock for the lock, but a mutex *may* be
>    * more appropriate to reduce scheduling latency if the range manager
>    * ends up with very fragmented allocation patterns.

