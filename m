Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DDC2F2D5D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbhALLCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:02:38 -0500
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:9505
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728371AbhALLCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:02:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkOEgFurejsNIpDfhs75fVYd+otdaxzcM0BT12vx5e80ioLle8oDQp2KtNE56dTEzKryvIL5CxRa2XbMUXAgmXdHEzhJ3ZYNCtrjhg80ywiYm9lBMlNhZhoYUa/5f0CLo0EhFLmA6mlDecvBzswoyKAZT7VqkHmNr6WqW9S3U3bmsRh0l5wusGruEi3AcsLYoULLE90noGsvpdsK6XygQfNs6Wz+rpBpInDWd8M9Bf8M+4NvBLGsCYxwCwg/j7fdhFF3Q+PG0nG1dBb3tfe0iyHgQs1TV2yz7ppa2DBymBK8t6UMPWkxWFgtOms2dtClrCGGugYAiGBnCuqKWF/X8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCgRYxymNlcL3cQ5sNPhy2nWhoBGvU38LLobp8a/M7E=;
 b=OTiJGU/FebTSECnk7CDMWOrY+9QDQd0DHeW/zVt30ngDZfz5pseJmbEO9VOWGlO/TzBnsBC25gAAFikq0w3zm2Z5xdoBxb1dye8xacJvs4hfMwXXwInYsNhzQpD7V/g5krBeVycX/IyHTesWCoVK8GeC/EC9D9WkLP21Ee8IbPn2BIveNzS/HkXC0BNOKaEPp2LkAph5Xmv0AHINdUQ+Lo8fnFfJ89kSmvNEMIVsac8wiTQiH7cFK85/oHRGcioYsTb3gUbpymVDH0Gu6NWvArnCQtwl2d59tIgOO9Ze6tvD/LcuJcoiXZLRchO7OZTqb550FEqkxjAZfuI7XbMsbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCgRYxymNlcL3cQ5sNPhy2nWhoBGvU38LLobp8a/M7E=;
 b=Ny0t2nsztwbu3fyFlO0MEmkDWOrwEgGTxatxh9Cy/CR+zW16dZe4oJzIRZhyIwMYdT2KaX2D+3SqU0KGd9O9N5I+bZIb/y95zDbMkV5Nro8WzdaYkfuTG28YKdl/ssLDt8Z1ut57YZ5gyjeLuvcxIt5FxHYRgFUwE6Kwg3VoDEE=
Authentication-Results: raptorengineering.com; dkim=none (message not signed)
 header.d=none;raptorengineering.com; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3725.namprd12.prod.outlook.com (2603:10b6:208:162::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Tue, 12 Jan
 2021 11:01:42 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 11:01:42 +0000
Subject: Re: [PATCH] amdgpu: Avoid sleeping during FPU critical sections
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Timothy Pearson <tpearson@raptorengineering.com>
References: <20210108215838.470637-1-jcline@redhat.com>
 <3c94f9d6-501d-271c-ca83-1cf4229cb3ab@amd.com> <20210111153917.GA22594@xps13>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <817d44ea-0f1e-b13a-86d4-3da6a47752bd@amd.com>
Date:   Tue, 12 Jan 2021 12:01:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210111153917.GA22594@xps13>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM4PR0302CA0012.eurprd03.prod.outlook.com
 (2603:10a6:205:2::25) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR0302CA0012.eurprd03.prod.outlook.com (2603:10a6:205:2::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Tue, 12 Jan 2021 11:01:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13c5860f-314b-4345-acc6-08d8b6e97183
X-MS-TrafficTypeDiagnostic: MN2PR12MB3725:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3725FA66BE65AAD59E7E087D83AA0@MN2PR12MB3725.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i55sH9jy8wWqN09SEYYzE5SL+NE0e0kyjH06IrQ1fP7y+PYEZmEMZQNZIUddExqsDYSbupexDbCMNeKJPBoeuHLjGTmOF06z0f5/HNhk+pycnE4AOD399mdAZDKtmSa0qvOXuV9P5drBMSCsoPp7UmXRzeP9+rp6N2NwMNu/oKGjCoojs9gAgWnnt2UCh0D6m1sZ4hd0896rpeEL+37RVQEo256Ro6zRxlKKt0VS47fzheuXZhcT6Kg2Pi0jB+39Fwf95kWkV3VvweE/KHv6eBXC4YMqBVa5kV4yTRQ5poobIFGj4qVzP6gjQoWI3jG/GPvVS1FXAjdTcA3d0Nog1ImAXafzuagRzcXXcTeWAqd5b/xb3wj2+HkA+FitQw2Sqke+F996nRb4vESrm6SjoKPMF2EtRAzAI2X9TqRurmiyPyKyLqk8X4hnTk5rAQViPXnUFDBEMPxxiQ+SxVckSmSU7LZYuyQ8I8dwNle28Eg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(478600001)(8676002)(2906002)(316002)(83380400001)(31696002)(66476007)(54906003)(36756003)(31686004)(52116002)(6666004)(4326008)(186003)(6916009)(6486002)(2616005)(86362001)(66946007)(8936002)(66556008)(16526019)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TEtqeWt3QkQrc05aejRwVGVJdWh4emhVSExwellSQjlYSmtZVENxS2lBUFNu?=
 =?utf-8?B?dzV6RC9INUJZVU1tb0lyS3EyTUppbkVSQUc4bFZ3c3lNZW04VDdjOFhKTWRE?=
 =?utf-8?B?bUhKT0M2SHkrS0s1Zy9Sb3BtNmY4Z2NNVHN2V3BuaTJ3SlgzNmU4TUpOTWl4?=
 =?utf-8?B?bSt1cUhJNDgvWm9wMVdwNmxRYVNOWklSUUsyWldweWNPUk42bVh0R0hqa1dR?=
 =?utf-8?B?MXI4QVAxSzlyeEhjSkV1VGxmMWo2anp3aGhmMzBNU0E3RHNYSHFBME5neVpy?=
 =?utf-8?B?cjAxdGdsZVl6NjJlNHlTQVIzSzFpcXA0UXl4dUpZUmFpeHhSekFGejdjK1or?=
 =?utf-8?B?alVMUHNjRXJBRHQyeWcxQzZFeDV1bDFPOThXSkZmT2xpRWRSTWhTdTFyci8w?=
 =?utf-8?B?SEVMZUE5aW9pUFB2UTFYWTZQeFg4bHRUdktXV3dVOGR4aEF4dDB1eURYanIx?=
 =?utf-8?B?UU12UTkxRVcrWmlLRnNUd1AxMkg4Wmg1NkdZZlh1dDJtcFU4Q29FR1NSM0ow?=
 =?utf-8?B?Z1ZSZVVqbFBaWmhPYlFxaU1HalptN1k1M0M2aUZjMkw3bUVRUXVhQ1VBUkJ1?=
 =?utf-8?B?N3crUVhVaTlRdHlmZnpmUjlGTnhOaVFNVzVlUXdTZnRRWUJoWUxLeVR1QWs4?=
 =?utf-8?B?TGtIQWVEdDdIK2p1ZDZCVUFicjRzOTJ4NXRoYW54c0xtcHBtWEpiMUdJZysx?=
 =?utf-8?B?a1ZtTzJjeEZ2NnNDdUMwNFVCWjlVSzRjZXZIREhpcFlnbGJybmRoWDUydGlm?=
 =?utf-8?B?SUxFSDFBZHJla3VOVHFZNzZJaWpJSVZzU0hwT04zK0Q1MnAza1Y0b080d0JG?=
 =?utf-8?B?WHdrTkZEaXQ1YllEYWZKeDliMmRkajZvMmp5blh0dTdlMFV0QU8wbXR0OUxq?=
 =?utf-8?B?WUNnUnNwYUl4VVdLQ21EL1dEMElKYU94cFR6WFZtZW5rb1c4bVppRVozVkQy?=
 =?utf-8?B?blZHM3p1d1FnK3FybzNCclJxbHdyQXhBVWdRZ0d3aGlIaUFORFZ6ZjRzWXky?=
 =?utf-8?B?ZWFtS0NuakZoWHpCVVZPb01obCtjQkc1TGxoNVVwUnV0MytjcVN3ZGZhTzA2?=
 =?utf-8?B?QmxiQkFWbVlkZm42T0NvOWExTnFMK0dPcTVLcjRqdmdLMzBlL2RuSmEzdUF0?=
 =?utf-8?B?K1EyTWtnek9rK29sbXBreU0zemF4SHYyMzBVODB5TEJDOHBwR3pWb2FGWFNX?=
 =?utf-8?B?YVhoUGhmMDQrZFhGeVlla3JwcmpjY3BWaFBzUm5zSE1nM3U4bDNFM3p0OENS?=
 =?utf-8?B?Wkgza2VTYVJqZ21BU1NyVmIyTE5mckNxb2krcWZzVmkxOFNkbWNEbHU3M2w0?=
 =?utf-8?B?VzhiRDB0cDZ2bTJaVmp2QWV5aFBMK1A3YjQxbG5LNDRYZHFQUk5WdEpXTSt3?=
 =?utf-8?B?cmd6aWtwdWpzRFRCRDhRTDNkTjNrTnlxaWdVdzUwZEFaN2s0RVViT0pPMUFm?=
 =?utf-8?Q?yA7/q/ku?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2021 11:01:41.9586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c5860f-314b-4345-acc6-08d8b6e97183
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0pBfPJFSKkyy0gbbfrNzGHQ4u7nwPAcwKFwi+ZIoK/83gvyKHBJ4N2Wjg+wIYwc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3725
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 11.01.21 um 16:39 schrieb Jeremy Cline:
> Hi,
>
> On Mon, Jan 11, 2021 at 09:53:56AM +0100, Christian König wrote:
>> Am 08.01.21 um 22:58 schrieb Jeremy Cline:
>>> dcn20_resource_construct() includes a number of kzalloc(GFP_KERNEL)
>>> calls which can sleep, but kernel_fpu_begin() disables preemption and
>>> sleeping in this context is invalid.
>>>
>>> The only places the FPU appears to be required is in the
>>> init_soc_bounding_box() function and when calculating the
>>> {min,max}_fill_clk_mhz. Narrow the scope to just these two parts to
>>> avoid sleeping while using the FPU.
>>>
>>> Fixes: 7a8a3430be15 ("amdgpu: Wrap FPU dependent functions in dc20")
>>> Cc: Timothy Pearson <tpearson@raptorengineering.com>
>>> Signed-off-by: Jeremy Cline <jcline@redhat.com>
>> Good catch, but I would rather replace the kzalloc(GFP_KERNEL) with a
>> kzalloc(GFP_ATOMIC) for now.
>>
>> We have tons of problems with this DC_FP_START()/DC_FP_END() annotations and
>> are even in the process of moving them out of the file because the compiles
>> tend to clutter FP registers even outside of the annotated ranges on some
>> architectures.
>>
> Thanks for the review. Is it acceptable to move the DC_FP_END()
> annotation up to the last usage? Keeping it where it is is probably
> do-able, but covers things like calls to resource_construct() which
> makes use of struct resource_create_funcs. I'm guessing only a sub-set
> of the implementations are called via this function, but having an
> interface which can't sleep sometimes doesn't sound appealing.
>
> Happy to do it, but before I go down that road I just wanted to make
> sure that's what you had in mind.

I can't fully judge that either. Harry and the rest of our DC team needs 
to decide that.

Thanks,
Christian.

>
> Thanks,
> Jeremy
>
>>> ---
>>>    drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
>>> index e04ecf0fc0db..a4fa5bf016c1 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
>>> @@ -3622,6 +3622,7 @@ static bool init_soc_bounding_box(struct dc *dc,
>>>    	if (bb && ASICREV_IS_NAVI12_P(dc->ctx->asic_id.hw_internal_rev)) {
>>>    		int i;
>>> +		DC_FP_START();
>>>    		dcn2_0_nv12_soc.sr_exit_time_us =
>>>    				fixed16_to_double_to_cpu(bb->sr_exit_time_us);
>>>    		dcn2_0_nv12_soc.sr_enter_plus_exit_time_us =
>>> @@ -3721,6 +3722,7 @@ static bool init_soc_bounding_box(struct dc *dc,
>>>    			dcn2_0_nv12_soc.clock_limits[i].dram_speed_mts =
>>>    					fixed16_to_double_to_cpu(bb->clock_limits[i].dram_speed_mts);
>>>    		}
>>> +		DC_FP_END();
>>>    	}
>>>    	if (pool->base.pp_smu) {
>>> @@ -3777,8 +3779,6 @@ static bool dcn20_resource_construct(
>>>    	enum dml_project dml_project_version =
>>>    			get_dml_project_version(ctx->asic_id.hw_internal_rev);
>>> -	DC_FP_START();
>>> -
>>>    	ctx->dc_bios->regs = &bios_regs;
>>>    	pool->base.funcs = &dcn20_res_pool_funcs;
>>> @@ -3959,8 +3959,10 @@ static bool dcn20_resource_construct(
>>>    				ranges.reader_wm_sets[i].wm_inst = i;
>>>    				ranges.reader_wm_sets[i].min_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MIN;
>>>    				ranges.reader_wm_sets[i].max_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
>>> +				DC_FP_START();
>>>    				ranges.reader_wm_sets[i].min_fill_clk_mhz = (i > 0) ? (loaded_bb->clock_limits[i - 1].dram_speed_mts / 16) + 1 : 0;
>>>    				ranges.reader_wm_sets[i].max_fill_clk_mhz = loaded_bb->clock_limits[i].dram_speed_mts / 16;
>>> +				DC_FP_END();
>>>    				ranges.num_reader_wm_sets = i + 1;
>>>    			}
>>> @@ -4125,12 +4127,10 @@ static bool dcn20_resource_construct(
>>>    		pool->base.oem_device = NULL;
>>>    	}
>>> -	DC_FP_END();
>>>    	return true;
>>>    create_fail:
>>> -	DC_FP_END();
>>>    	dcn20_resource_destruct(pool);
>>>    	return false;

