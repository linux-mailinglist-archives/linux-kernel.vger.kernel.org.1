Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A632B7851
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 09:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgKRIUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:20:02 -0500
Received: from mail-mw2nam10on2057.outbound.protection.outlook.com ([40.107.94.57]:3809
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725772AbgKRIUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:20:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZFmDGb3Syc95fXOHlliRiaXgwdXORCWQCwyYLN8YrWigRFS1qsKOzaw3cYdaIUr4crBeX5nEVoit4KgvnO9/XzMmvGVyRaQnDEQcufOwLlmvmbsSL6JjrvUpq0UzxwjbwOCkajwBc1jiRP31R5DDvn7/RzPl64XjgTkBMJxFqEU9W86W49+7WV81pPNB70JcKEhfmQk2s7vKANI2qndufWL5cDN0R/HBrM7WK5/XOXPYUTMw0VyGoAvdOADwmpLm5CL1JqVRcWyD5CCD8F0dpww6kGy3LcDO8o+NqIqMJ9ILC/SwQNX6SsFuh03MdD3Xnm15o7MctOyii9OvAHiZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuaFK2YwudltDL1ExHWPRfpD2+PB/ak9/xNlSSMaHJ4=;
 b=I7g+ZyT6JsRdWakEN4qrGFu53cEu5DA6MXxLlPbt3S+r1/VwZd7Q6Utwkg2l3Qc7UriN+r1fEZc6e5SRWYqOa9Z8/ssjQMAjyTzsRXeoSydedLNSdGhWekiKvcTg0h29VzcXka9aqDXKg0Okq4xHFDcHOR7xPKXCySU0eKOvpxQyf/NZQfjZI+onMzWumo8dmZB+P2f6VXrNDsWH/Yegre2fz4aH3AwCQVyCvI75SG5j4v11Qgd90E18VdS0Zj8mGF7VcZJzil3wblwXMoi8+Wpc/hNfb52+voe/ITAAct0c6P6JNAWproAO9kYa+5hvbLJ5RvGAzf8AdiB23p3LZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuaFK2YwudltDL1ExHWPRfpD2+PB/ak9/xNlSSMaHJ4=;
 b=s2w0amb1o3l3PcRWGL1rJQ8sJTuyvqEn1TYBjgpg5mDynpDbEfmhGmu7cq6S+ihPvIf9UlzTTwQ6JAt54/Io9kE27deUcaHdhaZMODTQcaq5cMnStBj9Dtivgi9ZvZ+VeVO62Qc5qdAIy17Mnj76w9yWNb7jAr4gDPwVdJvPFYg=
Authentication-Results: vivo.com; dkim=none (message not signed)
 header.d=none;vivo.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3966.namprd12.prod.outlook.com (2603:10b6:208:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Wed, 18 Nov
 2020 08:19:59 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31%7]) with mapi id 15.20.3564.028; Wed, 18 Nov 2020
 08:19:59 +0000
Subject: Re: [PATCH] amd/amdgpu: optimise CONFIG_X||CONFIG_X_MODULE to
 IS_ENABLED(X)
To:     Bernard Zhao <bernard@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Ye Bin <yebin10@huawei.com>,
        Evan Quan <evan.quan@amd.com>, Andriy Gapon <avg@FreeBSD.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20201118034306.103427-1-bernard@vivo.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e401f71f-4bfd-e4cb-c21d-addd6a2e90fe@amd.com>
Date:   Wed, 18 Nov 2020 09:19:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201118034306.103427-1-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM8P192CA0014.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::19) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM8P192CA0014.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21b::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Wed, 18 Nov 2020 08:19:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 55a4cbda-a872-47e1-0b5a-08d88b9abd2c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3966:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB39662BBA755AF6EE1E85122583E10@MN2PR12MB3966.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:323;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1JiwByY8rVNgogupy9cDdlAGBopWA8j44v8fz82rUkt9FDDJht3q67LiDOn09JftyS7CMy6WCaLNNIElpJlKUdkmEPf8FL1x6HLJftWRXgyeGAF3lsOVJKpDS/9Wkq8A9g2/U/sM6Qmc58shfayCcvFmwXrRo45A9Wwxxj0WtWMCcT1X2QQNaQhfNNtAZ7Z7mhP0uORkDDG21jHP4/7tvZG7D6ZiWY/krkKk7jDVbNSeUvaBYYNiED/MYk0kuPVQqiKYWozevHaRcy9Cd4it236Nu+vrKOD4GdlIYO398WTgnw9w0nq3y7SJihHyL4r0RdDaHgtUdEJLjgdaOBupZD0ELgGKynZQE1FEodd8oIh8dKJERZ2Srtn0S/hZ9YMZIEYmjKnOmMyMb4YgnVrc4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(66556008)(66476007)(6666004)(16526019)(86362001)(36756003)(6486002)(31686004)(2906002)(5660300002)(66946007)(4326008)(31696002)(8676002)(316002)(2616005)(186003)(478600001)(110136005)(8936002)(83380400001)(52116002)(921005)(66574015)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RlNsaExiTEVaZWF4R3E1YWwveUljYkpVRzZZdXI1aXRna3BYbXhvVXVuSzg3?=
 =?utf-8?B?cnBFZE5tbHdCb1FpZjcrK1lyRE4zUnk2OXg0QzlSN204R2NUVWh4L0hmaW9r?=
 =?utf-8?B?MUlTTG9OZTlLN0pRUjR0aGJXR3hmdVV1RVZsMFQ4Y2EwUEZ5dG15WkpmMXZp?=
 =?utf-8?B?OGh2ejhsK2RtMmovSGVSOUdJRTlaWmdyZ0VibURKWi9vNytTTDZKZmlud2Uy?=
 =?utf-8?B?cW9oSVNORGNHVjdCRm9mYVA3cGRqN2RmZWNhb2ljdE9tb3hnZjU4Vi9kNDY4?=
 =?utf-8?B?SDlDcjVnRk8vbUpsY25CTThXdzYwSVJkYTUzQTdwNEdmblZqbEl3NUQ2em5l?=
 =?utf-8?B?TVFwbDdpUzZ4WE1kZkZjei9HYUxEVmsva25zWGtwaEltdytIMndSRjhObWk4?=
 =?utf-8?B?STRVQ1hhaDhDOU4yaFZWRHUrZCtvZEswQWlhaGpmNjVyZkpMa01nUmo4UTFI?=
 =?utf-8?B?NUdNNkhjVFYzVGNub09JUnFscEFYZm5YUEwrQ3pEaFZpZy93MmxyVlI4L3ZX?=
 =?utf-8?B?Q0JyYmt6RGJGdGhvcCt5TGhhZnRGdldSZXJBT3FMR2dMNUZXWk1BZk1UTTRW?=
 =?utf-8?B?bTYxRXhDQWJUeDA1VzVzd1NSc1haeHp4QlZjSkNCU24yRjM2R09zWW5Ya1V6?=
 =?utf-8?B?SGlScXNSMG9oUVlqc1psRi9mNytqNHN1NzFDQ1VYcWxoOE1JMmx5aGp1dHRF?=
 =?utf-8?B?RnA4VTRTT3Q3NnpSWW1oQ2dRS2pQT2lheS9YdzF6SE5ZbENid3dMbjhQdVF5?=
 =?utf-8?B?cUNHcTBkQlFONEE4Q05zbFp0OFllWFNZekZYcUVFT2pzSkM2Mk4rb3JyTFl5?=
 =?utf-8?B?V3JiN092S1RnTDFYZENhMk04UGkxRklKaTRDa21yZ3huZUE5U09xRDZ5b3hE?=
 =?utf-8?B?WGpYaUswSW5tTDJyUWgwMHdQdkVkSVZYd1V3WGJEQkJ4VXVQZzJXeUF3Wndq?=
 =?utf-8?B?T0RGZkxCVXdmWEkwdWkxMi8rb1FCQUxtVy9OQnVXczBaVE1ERUkxQkNlY0ti?=
 =?utf-8?B?TjZMS0JWdVVTWC9GelRZcE5HMHJoOCtOSWNHdmxpZU9PUXZYalhMdTVRZUZU?=
 =?utf-8?B?MVhMRmFQMCtxbW0ycGY0ZngwSCswQ05ZYnordDB0alYvTWVyTXpsSzQ0RHVj?=
 =?utf-8?B?YjRVWkQwUi8yQ3pCbXJRVVk4Sy8zei8rRmp1OWZtdDdqU0RLSmszUFBGWlN5?=
 =?utf-8?B?YlVHS0tkYWtManZMc0hpcmxwby9HNS9POHBvZS9oMWlmSFlyQXIxVnpYa3V2?=
 =?utf-8?B?K05Xci9pbEpqSXlQc1NCQTJsN0QxUDBzM0JHb0ZFa3Z3dnUzQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a4cbda-a872-47e1-0b5a-08d88b9abd2c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 08:19:59.2897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7hxYEP3qinQ6O72KtQm58Y7XX6vr01N5s+PuYl453kmgYBvkMR9f6P/lcGz2swa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3966
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 18.11.20 um 04:43 schrieb Bernard Zhao:
> Optimise CONFIG_<X> || CONFIG_<X>_MODULE to IS_ENABLED(<X>).
> This change also fix check_patch.pl warning:
> WARNING: Prefer IS_ENABLED(<FOO>) to CONFIG_<FOO> ||
> CONFIG_<FOO>_MODULE
> +#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined
> (CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 165b02e267b0..f1980cd1f402 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -64,7 +64,7 @@ struct amdgpu_atif {
>   	struct amdgpu_atif_notifications notifications;
>   	struct amdgpu_atif_functions functions;
>   	struct amdgpu_atif_notification_cfg notification_cfg;
> -#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
> +#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
>   	struct backlight_device *bd;
>   #endif
>   	struct amdgpu_dm_backlight_caps backlight_caps;
> @@ -447,7 +447,7 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
>   		DRM_DEBUG_DRIVER("ATIF: %d pending SBIOS requests\n", count);
>   
>   		if (req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) {
> -#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
> +#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
>   			if (atif->bd) {
>   				DRM_DEBUG_DRIVER("Changing brightness to %d\n",
>   						 req.backlight_level);
> @@ -806,7 +806,7 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
>   	}
>   	adev->atif = atif;
>   
> -#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
> +#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
>   	if (atif->notifications.brightness_change) {
>   		if (amdgpu_device_has_dc_support(adev)) {
>   #if defined(CONFIG_DRM_AMD_DC)

