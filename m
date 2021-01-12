Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0E32F2D4F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbhALK7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 05:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbhALK7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:59:39 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E03C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 02:58:58 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id dk8so1824260edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 02:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/ZB0N9vFqdWQk9aTiwyMQta6u5tE3PztKaAxQ3G3b7s=;
        b=Migt3eVdKoQRMPNcP/HVGQscVh1Of3rgq6FI2xoTY8xVimL2tg/COK23Uc5gVcotsc
         plWkeXRcWL+4jEbpcvBqA27ji7zxMA51p7sqyvURfnh7MVgosE4gPX3UGSft7HfN8bvQ
         RyX1UQ2Fy/gsrzU9PkTD7An6cS7bRRcgPsk5RIKH3bub1Emv6fp+cyi4766J9IlvDqev
         XIcpyRPUARS+G3vdr2AEoaER1KPFb4tNPGPQiy4Fvh49HZ8MBdLAK2rH95Ior7k7Ra4i
         fs82z3FGW5LHMVg6LMYd3l6Cb9e8Li77uyp0M26eZdgNdEbeIi2if21+2Qzk4h7MNBjX
         NeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/ZB0N9vFqdWQk9aTiwyMQta6u5tE3PztKaAxQ3G3b7s=;
        b=co4WJeQEs+OtNP0HB/bRIVdtNvq8jLQvXH3DibOa87s8bUplZcdXtoncIkaW/AX6w7
         laa4NjQBBlDeFTIat1yZyc4K0PfN1xlgRZQQT//opCN3As1LTUWndWAePDL6sIU32nuc
         jtVKREg6uLSoJF56TSVftUE9SfmQD7gcEZ11sW6N1D7U+VWGIvQGHAJg9BjyFtyeqX2p
         MyGuFZsZ6RolN+lioNK233jGLg5v/8Kl5cf2qPupGzmxDoDpcKkSjouE2bE/+cAEXN/u
         SYiIo1oqjLRMAvaRAnU8+RBSR4Kza1U/ZyWRkObb9D7tJhXyrc+QIYls/FRNvkFIiPYI
         A1ww==
X-Gm-Message-State: AOAM533caPto/Shat8WI9gvcjw4zOj/scQupQKxaVu9o/0MwiC/rM/LD
        NJUKkeQdmS5Ofnq0kyGJaxE=
X-Google-Smtp-Source: ABdhPJxPFNY4h1wbZrWA9dit0lXCRTetVi1fePu5eJBo/v9B0oVZh49ovIz7q+QeQubyuxfaZAFT7Q==
X-Received: by 2002:aa7:cb12:: with SMTP id s18mr2911166edt.125.1610449137170;
        Tue, 12 Jan 2021 02:58:57 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id d22sm1041266eja.72.2021.01.12.02.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 02:58:56 -0800 (PST)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] amdgpu: Avoid sleeping during FPU critical sections
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jeremy Cline <jcline@redhat.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Timothy Pearson <tpearson@raptorengineering.com>
References: <20210108215838.470637-1-jcline@redhat.com>
 <3c94f9d6-501d-271c-ca83-1cf4229cb3ab@amd.com>
 <X/x9ojzg8XcCG+ZT@phenom.ffwll.local>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <410b2ed4-2760-f851-55ff-7065217b633b@gmail.com>
Date:   Tue, 12 Jan 2021 11:58:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X/x9ojzg8XcCG+ZT@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 11.01.21 um 17:32 schrieb Daniel Vetter:
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
> Out of curiosity, what's the plan? Soft-fp implementation for DC so you
> can keep the algorithms all unchanged, or redoing them as some fixed point
> with careful review and retesting everything? Something else?

My last status is that we want to move all FP related functions into a 
separate C file.

Then compile only that file with FP enabled and all callers of those 
functions must protected the function calls with FP enable/disable.

That's the only way we can guarantee that no FP state is corrupted.

Regards,
Christian.

> -Daniel
>
>> Regards,
>> Christian.
>>
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

