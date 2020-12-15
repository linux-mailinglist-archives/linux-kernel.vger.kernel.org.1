Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF782DAFD7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbgLOPMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:12:44 -0500
Received: from mail-bn8nam11on2070.outbound.protection.outlook.com ([40.107.236.70]:47840
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729739AbgLOPMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:12:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WU3N4WkBWzx16KgYxb0EZeRljm89C+oOcE+8cYNKTOaom6OIejImxx+HEi7XEk+UyujDc7QIT9ZTjQfhA4eMjibubbI7kQVqtmfsr3vMn4M27lAkvuhLaKKnJygjz0kyxiGBi1sutaAOQs2uk69KAGnV+/fddJ0cS4HS/LfLEbjw2LsFB4rA2NBTHoyW50ptdfBcfIqLv7mxZHqVN5OckGIFSApcMF0pSHnuya7Kmmacq/D7637k2jsQ8YgM/ZZJN6XKYjQKMAVa78vHzKynUFmvviT8VuO7fHIYmE0c2OpmEDYriASj4xTN0QYP2AL+/kB3RuZGVzmxlWK1aPJNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbhKKOw0Vy9hCUCLKaJoRqDU/t3rR5Gyzwh6zO8WJhw=;
 b=l+atYbNhuYIciFxFTgck1UP10saBR9O2+wM4GbRngv33QlL5QXUKntf9hG82UFLZIh51Ll8JFAsVnjEfiLC6hkuL9G0hZHdeT740aN925a1q6HMvl481syisOg5TBIdpASD7WKNl6kj6suh+0O1Ue+QXSRWc98lRli76ZJRAoiP8LKBIqV1y2T/E45mztdohcdknkUblQVfKu/U91PUBdY6YFkgdTybAQkSV6UhcsCRHcjRJ5BJjMV1fD0TmOqj7ilTqg5IrqucgUcLi2eT9cCSHHCeLedrF12JvObNdh1auIPrmuzQz+azuuVWxldse2evzbrH/QAhThVDnyg8Zew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbhKKOw0Vy9hCUCLKaJoRqDU/t3rR5Gyzwh6zO8WJhw=;
 b=QzdlffRrEEGIwpnH1q9tmvva9ScrmcoaDLEQhW+hbt145+GIXKbfN8ipOifkdUq0c0Rw86CKafSMZ5mJE/t0qKsS0JlvzNAB9L9T9kWpSiIJSONOw9Puzs0X4OsM8NG/wZHv1bs1ERdB25VE7LN9asDuFz7Zb7uJ7ezvIINZNNk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Tue, 15 Dec
 2020 15:11:49 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 15:11:49 +0000
Subject: Re: [PATCH] drm/amdgpu: remove h from printk format specifier
To:     Tom Rix <trix@redhat.com>, alexander.deucher@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, lee.jones@linaro.org,
        Felix.Kuehling@amd.com, nirmoy.das@amd.com, sonny.jiang@amd.com,
        xinhui.pan@amd.com, colin.king@canonical.com, James.Zhu@amd.com,
        leo.liu@amd.com, thong.thai@amd.com, vegopala@amd.com,
        boyuan.zhang@amd.com, Monk.Liu@amd.com, mh12gx2825@gmail.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20201215143835.1874487-1-trix@redhat.com>
 <e71eb9ef-d5f9-0829-670f-d5c2c644a493@amd.com>
 <a741836e-7f33-dcbb-d2bd-603091b9a2ad@redhat.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6be8d340-248d-3853-8799-4327b76c63ab@amd.com>
Date:   Tue, 15 Dec 2020 16:11:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <a741836e-7f33-dcbb-d2bd-603091b9a2ad@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM4PR0101CA0051.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::19) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR0101CA0051.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 15:11:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 67b8adbb-208c-48b1-b91c-08d8a10bbf3a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4095:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4095DBF8A25AB3D45792259183C60@MN2PR12MB4095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kIToJY5rlSOy76Jdi4yC7+xZTKkQ5VF94Btl7GutWWhFw3Y6g/+J+oNTI0sq8sIogAyGWHVXGuBC6LbFqBcPZb3HQxBpLSP9WnhmffwysZwdp5mFFarlOqsPqCBcaMQtduTLcBX+zpuL3wt2BCm4spt7uq5BoT3YotgwSXrQ8BzZZfCkiLBcPx8nPzdSUdneFTV5Ktx5V7poAlMdkhEuvvXqV2sNed6OPZtEiaXOfKiGSH+IRkIfA29w37EmDtNgmBt+c+UbG1dKWSg0zGbUZvn7zaxZFCTUyICoJ8S2Qg/HS15RYrLj8cSzGbUAAB1u88NGYTdzG8lOmRDtEi26ItoCJ/PSJ/+buZBKrR8v/Uwir3J8x2Lp7nHUE8icb/HWnqqg0/G74s195Rsc+MhU3CeDb1HJHV2Ve6QczpEvmGqP3q+MvIyMOzH4ZP9+0g0Blzwh3R6iINgQ+M+oFZqHXn47uLZ9/Cq5Dckycx3ThYpaG962H8eE6xoaJnlpgFDS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(966005)(8676002)(8936002)(6666004)(6486002)(5660300002)(34490700003)(31696002)(52116002)(86362001)(508600001)(2616005)(186003)(45080400002)(31686004)(66556008)(66476007)(921005)(53546011)(16526019)(2906002)(4326008)(83380400001)(36756003)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K3ZXa3hKNG5BNEU2MWZtOU1BeTUvN0ZMZkIyanVvWUl4UXVidWFNRUZzM0F0?=
 =?utf-8?B?MFlmZlJMRU0ySXBadmZLTzVqYUZkdWwwWCszdjFhNVdlTXpXRkZPQjVLalNa?=
 =?utf-8?B?azZUUkJqa05ZYy9LUEgrem1ReUp5NGttcVBpN0JQejZVeE1JemlBb05jaFZR?=
 =?utf-8?B?ZjQ2SnVMQWRaNVhJNzMyUnZEU3NDWHVCblB0V09ka2dseWZRcTNrYWpGT1E3?=
 =?utf-8?B?MUxHbHlkTVB4NnNiWFVPZFhsMy9mb0xFaUdHc1NwcGZsUW1Zdmg4V3hJUTZB?=
 =?utf-8?B?Rm5iYTg0amhMUEtyeHNtN1hScWlyVDFGRkVybEZSb0FUU29oZTZVYVpOVWJO?=
 =?utf-8?B?L1FPNFB0UXJxNmpqaERCWlNxUmhodTdtMGZ5K29VWnpMZVdjcjh2Nk00d1JY?=
 =?utf-8?B?UlpTcXd2S3lYM0twbHJBT0FDRXVSSFp6azFycGthTFRTQ1hlZURFTklpS1dp?=
 =?utf-8?B?LzhzZ3F5VHo1b0VTU1E4WmwwNWxYQU45OG5TWUlKOVhCd0RkQ3FORWJrNHBU?=
 =?utf-8?B?YjlJd25DNjM1REV3NCtWYlZZaW1qenhDY2YxZVkzSkRTMXFuS0IraUV0ejk2?=
 =?utf-8?B?LzhNbGJxZUlPcFUwMFI5am40ZVRPYXZYWGUvL2hPRUFBV2JaY2lFNWc4QnlK?=
 =?utf-8?B?SklDZ3crUkFiLzFCY2JpYVRLRGFwcWluQytXVTdja21iLy83NjNlYmh3YVAr?=
 =?utf-8?B?bWVtRFZkZTMrNSsyaUIyNnR4QjhBNXBRN1J1d0pzVW1MMzlqclpFeHVVdjlr?=
 =?utf-8?B?b09FU1hvaXlQeTRqczlKdXN4S3ROVEQ1SVIzdFNhZ2kxci9QajU0aVZpYXp1?=
 =?utf-8?B?b3lrVlVkOHJBUkdxcnZyVzQrMjliaUFXVUFqT0pMZDJtaDJ6bGkxQlBkeWhi?=
 =?utf-8?B?MzU2V21YUC9KYjl1REorSnJNVWFoc2cwSDFxYkNxWGp4UGxHZ0RUNW5RQTFy?=
 =?utf-8?B?VTk5cUZrUUNDclRNYTRDYnIyamlOTEZ4WUZvRHI5TW5pVlg1VFBMUnN4YUlS?=
 =?utf-8?B?dks0ajRBWDR0MSswdVVqQU1hdGRlelhsOUJ2MlF5cHlZZFZvSEhoRGd4eFpi?=
 =?utf-8?B?MlViMWxhSXRCZWtOTU9yRmRxWi96azJqRm1DSDRsUEY5ZE5zT1M0eWErdzQx?=
 =?utf-8?B?UldkWmoxcWdyQ0dOS1JEZm9MUUZmOEI3OXp0WHFNS3ZQaGhxblJWTTBkWklh?=
 =?utf-8?B?QlQrSjNBelpWSEVTK0hZVEl4b09QRVFsQkpERllaNnVXRnhBVzNSZ3JCQmRG?=
 =?utf-8?B?Z0sreTFpUGJKZ3B2K1REcjVPUGowWXp2UEhpUU51aDY0Y2J4cFBxTjdLa0dS?=
 =?utf-8?B?azFQbWhKRWpuK3lQL0VuekN6OXV5NE1RYnpxNWdvUm9UWVgvcjJIVGlSbWVy?=
 =?utf-8?B?QWJ5YTVvRzExN3J4L2kvQy9BNk9vc3dFZUtWcC9ocnJLYjMxM2hpRnp4QWtJ?=
 =?utf-8?Q?U2qHSwAx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 15:11:49.6315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b8adbb-208c-48b1-b91c-08d8a10bbf3a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhX0/Jx5jWC5a5j93QL4nn0I9unqKhlkyiuElj0lFivj1UOxmHuO+/pqh6e08cNf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 15.12.20 um 16:06 schrieb Tom Rix:
> On 12/15/20 6:47 AM, Christian König wrote:
>> Am 15.12.20 um 15:38 schrieb trix@redhat.com:
>>> From: Tom Rix <trix@redhat.com>
>>>
>>> See Documentation/core-api/printk-formats.rst.
>>> h should no longer be used in the format specifier for printk.
>> In general looks valid to me, but my question is how does that work?
>>
>> I mean we specify h here because it is a short int. Are ints always 32bit on the stack?
> The type of the argument is promoted to int.  This was discussed earlier here
>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2Fa68114afb134b8633905f5a25ae7c4e6799ce8f1.camel%40perches.com%2F&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C0dd6fe7c17304d4ea72a08d8a10af765%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637436415772411133%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ta8M5iN%2Bj2J6tio%2FMuUi2lG%2BiyEhkdsFfpXcEjGKNwE%3D&amp;reserved=0

Thanks, I expected this but just wanted to double check.

In this case this patch as well as the radeon one are Reviewed-by: 
Christian König <christian.koenig@amd.com>.

Regards,
Christian.

>
> Tom
>
>> Thanks,
>> Christian.
>>
>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 4 ++--
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 4 ++--
>>>    3 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>> index 7c5b60e53482..8b989670ed66 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>> @@ -240,7 +240,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>>>              version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
>>>            version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
>>> -        DRM_INFO("Found UVD firmware Version: %hu.%hu Family ID: %hu\n",
>>> +        DRM_INFO("Found UVD firmware Version: %u.%u Family ID: %u\n",
>>>                version_major, version_minor, family_id);
>>>              /*
>>> @@ -267,7 +267,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>>>            dec_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
>>>            enc_minor = (le32_to_cpu(hdr->ucode_version) >> 24) & 0x3f;
>>>            enc_major = (le32_to_cpu(hdr->ucode_version) >> 30) & 0x3;
>>> -        DRM_INFO("Found UVD firmware ENC: %hu.%hu DEC: .%hu Family ID: %hu\n",
>>> +        DRM_INFO("Found UVD firmware ENC: %u.%u DEC: .%u Family ID: %u\n",
>>>                enc_major, enc_minor, dec_minor, family_id);
>>>              adev->uvd.max_handles = AMDGPU_MAX_UVD_HANDLES;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>> index 4861f8ddc1b5..ea6a62f67e38 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>> @@ -179,7 +179,7 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
>>>        version_major = (ucode_version >> 20) & 0xfff;
>>>        version_minor = (ucode_version >> 8) & 0xfff;
>>>        binary_id = ucode_version & 0xff;
>>> -    DRM_INFO("Found VCE firmware Version: %hhd.%hhd Binary ID: %hhd\n",
>>> +    DRM_INFO("Found VCE firmware Version: %d.%d Binary ID: %d\n",
>>>            version_major, version_minor, binary_id);
>>>        adev->vce.fw_version = ((version_major << 24) | (version_minor << 16) |
>>>                    (binary_id << 8));
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> index 1e756186e3f8..99b82f3c2617 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> @@ -181,7 +181,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>>>            enc_major = fw_check;
>>>            dec_ver = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xf;
>>>            vep = (le32_to_cpu(hdr->ucode_version) >> 28) & 0xf;
>>> -        DRM_INFO("Found VCN firmware Version ENC: %hu.%hu DEC: %hu VEP: %hu Revision: %hu\n",
>>> +        DRM_INFO("Found VCN firmware Version ENC: %u.%u DEC: %u VEP: %u Revision: %u\n",
>>>                enc_major, enc_minor, dec_ver, vep, fw_rev);
>>>        } else {
>>>            unsigned int version_major, version_minor, family_id;
>>> @@ -189,7 +189,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>>>            family_id = le32_to_cpu(hdr->ucode_version) & 0xff;
>>>            version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
>>>            version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
>>> -        DRM_INFO("Found VCN firmware Version: %hu.%hu Family ID: %hu\n",
>>> +        DRM_INFO("Found VCN firmware Version: %u.%u Family ID: %u\n",
>>>                version_major, version_minor, family_id);
>>>        }
>>>    

