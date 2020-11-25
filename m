Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1132C4218
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 15:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgKYOTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 09:19:46 -0500
Received: from mail-bn8nam12on2044.outbound.protection.outlook.com ([40.107.237.44]:51152
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726908AbgKYOTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:19:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qp1S1/lJRGEBowfDlfw66DOpmucCGRkg8S5WFo9a9aIgWZZT0zxgli8hXUfmCI573QcBr7AQwfTkJQWsWeuvX4qADznXlASoof/P8duzq/mzCEMxv+dOyzCu1AAZ6V96jd26rOBHcAfbjA/JBkcSR949B5vKCdIKFFA7V+uczPPBlYTZ7kvUSFnMNkl2Gw5qTWdFBj9GEnX8zvPtCHERZscCDjhUlnleKf6gLrO7FwhGrhjX/ePHftuMCZWdxMBUyqk+CiUAp4OfjYH+WFZTreVqbf9FsuZ1zyytywrSVb4GH7w92DcoJ8+VrBHUtMKRT2y2eQi5fmbKxwTzemxaEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc0vHeqEzy/nNNXLLwo56pQeOjt6MrgxV5bmDrLH/c0=;
 b=n+VnrjuZYxDkF+c4q38AE4polJ1GwzWpAv6a3rd8pIrP+rzBP0F7H6XOtfr/tfUt+lr9nsRwJmK9SW4yv2AetIr8dOZdHjvfYvTS003tOG5SmM7FI1V7BfKf8ljQ/7UkLH17u4CmsoSze8VrxhQm+8mB93T7n3fnYVIGLIBDRDY6uJ5v5fqs1d/s5E6AJ2dxCPuolHw31IdY4rucnvZVjO6o7s26l22lGu/+5J9CliWMDo43097CGdvv9zkWFJ1NDPM4r8CeqVQtnZkImcvsehL0WY0Apya6QwmG40kSKC4Zk7iiYkX/VzA5fUY7n7UDFeQhm2Ys694eE85DDExvTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc0vHeqEzy/nNNXLLwo56pQeOjt6MrgxV5bmDrLH/c0=;
 b=3lbZ2lvXyS95raj/bFOLe4Z6M0WpqUS8E7d85+YBsaWoQ1Z3UZ8B1zKu1e+W2XLwpHAbiDVVyDN1iiI0M3JtemdLyw2Q60kFOr+YkKFCc2QU8Gw0uRcSHd8UYdZ03RroEgJpPCGqgniVhSDZTfChUXpptjyTNh58OjBOwsAfiUs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Wed, 25 Nov
 2020 14:19:41 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31%7]) with mapi id 15.20.3589.022; Wed, 25 Nov 2020
 14:19:41 +0000
Subject: Re: [PATCH][next] drm/amdgpu: Fix sizeof() mismatch in bps_bo
 kmalloc_array creation
To:     Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Tao Zhou <tao.zhou1@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201125141806.1881036-1-colin.king@canonical.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <88005778-a759-a3c8-a86d-070a51f04dc2@amd.com>
Date:   Wed, 25 Nov 2020 15:19:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201125141806.1881036-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR04CA0097.eurprd04.prod.outlook.com
 (2603:10a6:208:be::38) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR04CA0097.eurprd04.prod.outlook.com (2603:10a6:208:be::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Wed, 25 Nov 2020 14:19:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7e4792ee-ed7b-40c9-9221-08d8914d262c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4303:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB430348DD98423365D70C06B483FA0@MN2PR12MB4303.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXH469PuZXsNYEwDZ2emcrP+KB3FQkTf2bmxXawDy2CDpLEDupIAVxxmESbp19IfM1YAj8JLWMt0Ss7EcRfXpxQUYh1wqVKeG82Fvqih/8+ZZncnFial3++UNwPZgOl9Z/qK0fPenMznB5T5Ice7lNr8v2DKa7Pan/js8ceL7viRfjMSTvrWAVcTJdf5nuoBItrlVkNaxVjcdCEhXUqA54tXOQ+YBh8gCyTr/yjOp3IZskIagwQ667Yw/K4/IX4J1Kaqw9e4GGM0vFARIDLJwwnffp6uChOIqFnd5JiMJ3Bjk/y8u3/M7gwo315sWQZOXOF2ehSwT6EnQOUdd7rvjhy+mhlGFb8Pp2+hEM+A/PmpHoXs8fVCX+/vZBnlBiRr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(86362001)(110136005)(31686004)(31696002)(83380400001)(6486002)(66574015)(316002)(36756003)(8936002)(5660300002)(4326008)(8676002)(16526019)(66946007)(66556008)(2616005)(66476007)(2906002)(6666004)(186003)(478600001)(52116002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y3pKdmt3RFBNT241Njk0WFdjdDkxaEtQMEJscmw0aDlHbzZ3aldJOWQyNHZy?=
 =?utf-8?B?NUhIZW5EN1R6VWh4NXBVUkIxMmJReUpkT1kzYnlYRkhRL0dtSWphYWNlVnh0?=
 =?utf-8?B?eUJRQ2ZRR0tBd1JWb0JuVDVEVzB2UHk4MUtPbk5nZlVURUtvNjB4Z3F4aklQ?=
 =?utf-8?B?TDlHMVk2WmlReUovZ1o2OXJtY1dCNnp6SURTNVhBTUU0YlRmSUljUnhjTC9V?=
 =?utf-8?B?bkFObGR5blMxWWlxZVk0TENkWDhkcnM0WUVWZGVMaU0rYTB3ckdCV0x0MHJa?=
 =?utf-8?B?cjQySWphQWpSRjcvRHcxVkI0YVNHM1JwNHZleDE1T2UyczFmTWpaaXRaVGMx?=
 =?utf-8?B?Qjk4Y3pQSmpjWVFlYkdIM21YZFhyU2VGY3IvRG4xVGJvTlF0OC9lamlhMVVr?=
 =?utf-8?B?R2k1TnZUcU1lSmt2OUhwM1R2VVY4UGFLNFBPZDI2UnpmcXB5dGVlamJpUmUv?=
 =?utf-8?B?QmYxeEFoTEowMGlrWXNaK3VaZkpCOTM3aVFhVTZVTlJOZk9ZNXJweEY4RnYy?=
 =?utf-8?B?UTJiQnFvZ0tKMlRsYXBhdjAzM0RlaDczRW5kWTIyRmZHWWE5YklwVWFiUnV0?=
 =?utf-8?B?YXJUTWNVZjBxYzRkRGVrLzVVaEdhYlMrSTNheEMxaTJqbU5wTlBGZzh0U29E?=
 =?utf-8?B?K3pNc3ZoR1RGK3ZUVEZZQ3EvaW9qZzdJb3Rnc05BamhoVCswbC93TU1BZkI0?=
 =?utf-8?B?WmxLSzNZVXd1WWpKNnQwY3ltV25QdGhLSkxRVTFzcTkvWkMvSWE5ZEI0QUtI?=
 =?utf-8?B?eTY0bzU4ODYyNjhLanljZGFnbU52M1FKS1JtUEhOeUFKZ1EvQTQ2T3VWT0RH?=
 =?utf-8?B?RVlVTUp1K0F2dldKYWZ3Q0dQYjBPaGFleUhjbDNrY3l6alI1UHlURFZzVUhn?=
 =?utf-8?B?UVg0bGtVYlFYVDBpSytiSmIyVEppa0tEaEFnVUdFS0tMVkdadlBSL3FuemN6?=
 =?utf-8?B?ZGNEcFlkZHdFclJ1MmJhaXBZZFR5RkVWMnVaM3FmWlRnVjJLTEluNzFMcE1T?=
 =?utf-8?B?UCtnNTl5bHhSS1ZxbFZsSnprMkxlRVdTZE9RSFBIaHZ2YWRJZjBzMU5rWUlG?=
 =?utf-8?B?WnJsTHBhckVWL1lPRXIyVTAzQ1FWVkFmRlNxMTF3d1V4Q1pTeWJYZkFJRnZH?=
 =?utf-8?B?ZFFpL2V2U05LaThaUE8rT2pnVmx1T2lNc2VvMGRjdExsQndkZjhBcDFlYVBQ?=
 =?utf-8?B?bkpmbFFyVEF5RWJIUGp4ZmpWY2YvTDg4NjRYK0FiM2o1U2c2aTJKaXRJa1E0?=
 =?utf-8?B?N3ZFUXdOdXNobk0wMjJ5blFZL3E3RkJWY2taZW1xTUlXS2J6VEJuMWNJQklF?=
 =?utf-8?B?SG05MDRUZEE0MTZFd3hVbmNXTGswNVJLZEFmeXZNNG16ZVgrWFFSa1k2Umd4?=
 =?utf-8?B?RGdIYVBrMk1sRXEvKzFxSERIdmJsaTdMaGg0ZlJiL2dhK3gvY3IxempVVUxi?=
 =?utf-8?Q?A57hANZH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4792ee-ed7b-40c9-9221-08d8914d262c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 14:19:41.4658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w56mRr66oSTcdE01IccUCkXFrDYCrsSf9Rh+J4OqjwGymoJydjve8psiZB4n9tDX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.11.20 um 15:18 schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
>
> An incorrect sizeof() is being used, sizeof((*data)->bps_bo) is not
> correct, it should be sizeof(*(*data)->bps_bo).  It just so happens
> to work because the sizes are the same.  Fix it.
>
> Addresses-Coverity: ("Sizeof not portable (SIZEOF_MISMATCH)")
> Fixes: 5278a159cf35 ("drm/amdgpu: support reserve bad page for virt (v3)")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 2d51b7694d1f..df15d33e3c5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -283,7 +283,7 @@ static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
>   		return -ENOMEM;
>   
>   	bps = kmalloc_array(align_space, sizeof((*data)->bps), GFP_KERNEL);
> -	bps_bo = kmalloc_array(align_space, sizeof((*data)->bps_bo), GFP_KERNEL);
> +	bps_bo = kmalloc_array(align_space, sizeof(*(*data)->bps_bo), GFP_KERNEL);
>   
>   	if (!bps || !bps_bo) {
>   		kfree(bps);

