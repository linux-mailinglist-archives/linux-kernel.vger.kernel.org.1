Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4F62CAB3D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbgLATAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:00:19 -0500
Received: from mail-bn8nam12on2057.outbound.protection.outlook.com ([40.107.237.57]:18834
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727006AbgLATAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:00:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2xzAiHnK/Y7RP10n2pd5TZC0FOQmaCdMzxW3gBBVQDGdXF2E9K/aDYQbdDQ1jNtDYUu9MT+jaid/h6IiiDfVR2kc717G2O4w5yA7A6a3cFDzovq5ocCxuKl2KqhDd8HdPjs7864wgScmNWbD0Cd/i0az8CaV/gGDqiUC1ezgRch/8n6Kg9qEd07Q7XLFxBQwbAIlJTczNepPF6M5w4/VKJSSJq9yYyZEMEf3RsctCf5rPN03rzMZcTBNXAXuSi6YD8xs4tE4dEtlYBUx88N4OTiKOFDOkwo7lMOLFKiPVMCSpTmg7Sh2xVyTc0mcuNk2RrKB++u+XW1c2S6bLbvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAjhx+2q31NurzMqe0SCva3xZYBRRm+VllP4k9fo/tA=;
 b=LXrQs/LUNBHdjS5gmihEjpR8qRHfLXV0+9I/dE6iiseER1PEGAT25nWIIkIFrjaUPP6Cl4XWcIn8t7v5hUkNNRu3DBcogPBOTCdxyE9EZNOIbJaSMiRy/KB0zKHdShC0JUWa9HII4Dtdoy67cHH1nIsrSufXvLj2vdaGakcWQWpNgENOsBBdl+DH1b9wbyGzr0wGrKwKiABQP1gq+11lBVhknK5KbgF15gORiBWGcvMt+MdOrcUQVHCM9P1AXIICoEggACi7hGvBxYJZO4EUeHKz3I8NP7fEgQU8Ft+7vwtYDrgIQxCF3U+b55O0mqxrPQBcXO7og6xRV2uyZWTaVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAjhx+2q31NurzMqe0SCva3xZYBRRm+VllP4k9fo/tA=;
 b=xsb3Er3OvaaOA0vGLB5Q0aIeSY26k1iRXY/6Eewp4eMm3Rm397CmsTJPCX+mlg9WgJqJ5UMBg6K3E8yRJ8YTywrjhqovMlXyoH2FhcCZSdfcQzOXKu9lABsfK4blbr2btCVTk8jA1IyGW3IlkBx5fc5smDIe7stW8+/oW6C6zhM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4867.namprd12.prod.outlook.com (2603:10b6:208:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 1 Dec
 2020 18:59:25 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31%7]) with mapi id 15.20.3611.025; Tue, 1 Dec 2020
 18:59:25 +0000
Subject: Re: [PATCH 34/40] drm/amd/display/amdgpu_dm/amdgpu_dm_helpers: Use
 'gnu_printf' format notation
To:     Alex Deucher <alexdeucher@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
 <20201126134240.3214176-35-lee.jones@linaro.org>
 <CADnq5_On90z1w=_usmjA7kHFVig3uHg4VJRecDraYZv8cmRAUQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b5050f44-9542-2ae3-c019-c9821f978cc8@amd.com>
Date:   Tue, 1 Dec 2020 19:59:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CADnq5_On90z1w=_usmjA7kHFVig3uHg4VJRecDraYZv8cmRAUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: FR2P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::16) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by FR2P281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.16 via Frontend Transport; Tue, 1 Dec 2020 18:59:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7b8fe07f-4558-47e4-b7b7-08d8962b38a1
X-MS-TrafficTypeDiagnostic: BL0PR12MB4867:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4867C8FB10C08A493BFFE10283F40@BL0PR12MB4867.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:28;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g8pcbjvreavuGwJG/+1GrdKgNUfaHx/DsnB5G2O+97+/7Iuuz4nx6kFcCK8tcIebjOcKR1wnNyy7vQ7mapd5q6oxXPFb+ObBStEA9omEG5LIAQleUuacN0xb0TvheNMSovu2/l8LJiMC5mZyudMFXfngOJJrYJGfaPs5ThYdKm2VHxNiBMaQYTBKvef8yHf2kg8Qc5LJIZrvduktmBFIKlGrOiTLdt49tXqYdy2Gtx3YCtufygVafhW4wcCgKL8MN6qg5uAC1OGIrlizztBqm5JXC44KKFsAlxhmbTg4Ldqjkcm3lSLNPNZQyXwLl52Puy3Dof+R3PITaP7FzJ3qDgWCnV9E7wrNQTjwMzSrTJDa7YnoV59a41/Hg9g5qMR78TdaXluKKkp3KQlLBSXblgPwxreDmtodLfLmlZMqnbk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(186003)(66556008)(66476007)(66946007)(31686004)(16526019)(498600001)(966005)(54906003)(4326008)(110136005)(45080400002)(83380400001)(2906002)(53546011)(6486002)(36756003)(5660300002)(8676002)(2616005)(31696002)(6666004)(86362001)(66574015)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VzEwZk0zUkZENnZGeVRFTVNFMGF4RDd4b1VKdjFtRW9POTJPRDBzSHhpNG1P?=
 =?utf-8?B?ZW1NTVRmdis3NzROeFhsNnowenVPTDV5OURYWUNjbEI1WWdLQlNPTWM2T2w0?=
 =?utf-8?B?cHZKaEp2RGc4TlI1VnVZRzNnSkoxNWFTSWRmSU1INnJGdis1aHZlWnlWait6?=
 =?utf-8?B?VHFPeVZ2S0o5Z25DKzdxdXZhSE5yaDJqKzZDVG1iS3FnRi83TWppZktOdjZy?=
 =?utf-8?B?RzJ4NklMV2Q3YWM3a29QV0lwWUdMU3FjOCtzdHlxMUtwQThSMWxmMjZ4V2l4?=
 =?utf-8?B?VlN0SUZodlBJbHVLQWdHdS9RS2lHc3RjY2U4OHhPRXk0bG9TM3oxcG1aazh0?=
 =?utf-8?B?MVMreURza0RmejF6S1ZKNjIvZkpKU1NrZHNhZ2NBdnN2dzk1MEtRYm9vamRB?=
 =?utf-8?B?SVQ1clUzMGkrbHd6aUNndFFFSHFXTWhmd0JwWWZwS2NGcEgxcGdLdWlIMFJl?=
 =?utf-8?B?WlYrNThqWWF1c081ZW1zSThrYzVLcFY3QU1XZXUwNXJ3Y1NCVjBleHZMbUZa?=
 =?utf-8?B?M0U2TFdRTFppU2NRRDh5T1ZxRm5lL29xd1A0Wlg4a1FQMTBSelhBMEUzL3hZ?=
 =?utf-8?B?VjU4aWRtQnVINmVFS3FobXB4L0xqQ0xRMnZORkwvYWdIbFZsd2NtWjlaamto?=
 =?utf-8?B?ekx2YWZzcS9DUnB1MU1TcFpwRyt4WGJrS0tTVm53aW55RVIyZGJBT1FBSFkv?=
 =?utf-8?B?cDdQSzJPNUpTZ3pmOGRGOGdra0Zub1RIa1ZNM0FEdE9ydmFnRU9mZklwM2R0?=
 =?utf-8?B?RzdkNTZFMXRnYW1OYkdhZlFkUDM0M2x4MUo3QmU2Z2pqVkVLOUQ1S1VJZnN3?=
 =?utf-8?B?eDBtNlBpc2tKc2ZRS2h5WkVxb0g3Y3pvbnlJbUZMNGc4ZnZETk94UDRxQnhx?=
 =?utf-8?B?bDdTRHJoVFNJRlppMnIrTjRLZ3NkMTBFb1gxMUtmT1psdnlGWk0ydGRaa00y?=
 =?utf-8?B?UzhBYjVyMzV0V3BqQlRJTlBuaWI0QmFYNm1ydFY2UTdJRDV3ZHFQVFhObG5v?=
 =?utf-8?B?MTU4aHFEUW1rU0VsMmwyMkJvWVRlRVFJRXgxNHREWWFoc1JLWjV4eFVLUjBt?=
 =?utf-8?B?RGVHOXFkQXR0QXdPSTFUWTdZL2VrZDIrNkwwTFMvdW5tZHdSK0h5TThCaWJs?=
 =?utf-8?B?MmdnWFE0ekJ1RUZSQUhNMUdhU1lYOWNoMkFjZTR3alFqUEdBL0J4cVNoQzBo?=
 =?utf-8?B?K082NHI1RXViZkExS05Wa0dGRkhLWnMzdTU0enFaYVZpem9ad2V4RGlhZ0Zv?=
 =?utf-8?B?MmJZYTJXYlFMUVdIMzRrTFd1eHYzOHBidFFOVHhoNlJRN1FXUk1iTSt0ajhQ?=
 =?utf-8?B?ZzN5M09IUWRCVDhIZVNETUVsRGVzMUtwWnV2NlE2ZHNldmJ4azlIN1hhVDJu?=
 =?utf-8?B?eDZtYXdvVVNOczdFNnFnUDVxQU9ZR0ltQU9mVnZGWElFK3FJTzJHb2l1Uzd5?=
 =?utf-8?Q?gaRoZqDW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8fe07f-4558-47e4-b7b7-08d8962b38a1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 18:59:25.2536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JE1RmYeNLLcNsCR6qJpQOovQURaRStJLRZyEe6C8r6S6u8V85DKrzPQAqANjwJl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4867
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 01.12.20 um 19:42 schrieb Alex Deucher:
> On Thu, Nov 26, 2020 at 8:44 AM Lee Jones <lee.jones@linaro.org> wrote:
>> Fixes the following W=1 kernel build warning(s):
>>
>>   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c: In function ‘dm_dtn_log_append_v’:
>>   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:345:2: warning: function ‘dm_dtn_log_append_v’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
>>   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:375:3: warning: function ‘dm_dtn_log_append_v’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
>>
>> Cc: Harry Wentland <harry.wentland@amd.com>
>> Cc: Leo Li <sunpeng.li@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: "Christian König" <christian.koenig@amd.com>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Cc: amd-gfx@lists.freedesktop.org
>> Cc: dri-devel@lists.freedesktop.org
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> index b7d7ec3ba00d7..24a81642baa26 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> @@ -318,6 +318,7 @@ void dm_dtn_log_begin(struct dc_context *ctx,
>>          dm_dtn_log_append_v(ctx, log_ctx, "%s", msg);
>>   }
>>
>> +__printf(3, 4)
> Can you expand a bit on what this does?

Been a while since I looked into something like this, but IIRC this 
means that parameter 3 (msg) is considered a printf format string and 
the types of parameter 4 and following checked against that.

Looks correct to me.

Christian.

>
> Alex
>
>>   void dm_dtn_log_append_v(struct dc_context *ctx,
>>          struct dc_log_buffer_ctx *log_ctx,
>>          const char *msg, ...)
>> --
>> 2.25.1
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C50bdbd2fb7a5400e91c008d89628d11c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C1%7C637424450053181783%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=afzSSu%2Fba0%2FQiwOameJRO5Sgs5joRPondWQx%2ByQZZlU%3D&amp;reserved=0

