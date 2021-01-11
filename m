Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3696E2F19DD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 16:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbhAKPku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 10:40:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727180AbhAKPkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610379562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V6s22bNSoq1L+NIFn/JvX6d51nE1mLRjnfTwZ0WeTw4=;
        b=UGpgWj79HBcdJnkBtUIGCZqpsA1rgF0hz/DFMjZHuYug6vpA4KOagjokW6GGCDOnPOXy/I
        WtpLn9zvsSG9Hpw/8bhHHCQj8qrP2yO52FgTgzx5VDrtOQJQhchCugxLHDn7ImNudFdUQN
        bo0YbxhPoItwWo1XdJeas/XaIGt23fQ=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-JFgxkQL4NNWcvie_BtvaBA-1; Mon, 11 Jan 2021 10:39:21 -0500
X-MC-Unique: JFgxkQL4NNWcvie_BtvaBA-1
Received: by mail-io1-f71.google.com with SMTP id l5so12800794ioj.17
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 07:39:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V6s22bNSoq1L+NIFn/JvX6d51nE1mLRjnfTwZ0WeTw4=;
        b=gauq6b0ipw2A2JSmE83BytXxwToyX7Kc4B52hF50ZBPCOSpPX+MI5ftYsGkuDfZCYP
         dRNQzc+LrsSEKTJytMZ7vBbvAi6OLAQvLApc06JL5xRrnWqUw3NyzMG4n35d0wgahe/i
         UTZQQs+hwZsp7H8zj80ecGVkuDckQjtiaxoz20hyPk0x/gk07t1TX3Zi+BlAm9t5N7qu
         J+CpE1KUZtUruTot/IHgEKtX3SGCMvCeMRQUmOMRo2UTtn4c7ARWtEL0LSJOR+PBfYwc
         8Hm5+5bPKp4plgrtUx0Lr1y2rfB/GWaHw37IO0YQPI6/sxWckrYj4tmTtBob2iotZnLH
         M+/Q==
X-Gm-Message-State: AOAM531eKY9D6Eihg2Y1JuaXrzqKUeK50WlI4DISrFkxQNbD1Rv4fUux
        0LKuOG+rY9blyNuA0fNnvZNWkAvdx/2zS7wvO09XHowyIuGA4bXKX+tcoWJMKMqDWBgoslItHzG
        Wh0xvS+Ty6j+G/7WHs1A/S7yL
X-Received: by 2002:a92:cf44:: with SMTP id c4mr15547582ilr.207.1610379560551;
        Mon, 11 Jan 2021 07:39:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzlggvM+nwzezd73mKCuiQILg/y8Tnj4twPqnA644Y3DXvue24trNEi0s1w98pXs6fxCdnvw==
X-Received: by 2002:a92:cf44:: with SMTP id c4mr15547567ilr.207.1610379560359;
        Mon, 11 Jan 2021 07:39:20 -0800 (PST)
Received: from xps13 ([2605:a601:a63a:4d01:c3c1:7008:ba35:96])
        by smtp.gmail.com with ESMTPSA id t2sm16862182ili.31.2021.01.11.07.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 07:39:19 -0800 (PST)
Date:   Mon, 11 Jan 2021 10:39:17 -0500
From:   Jeremy Cline <jcline@redhat.com>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH] amdgpu: Avoid sleeping during FPU critical sections
Message-ID: <20210111153917.GA22594@xps13>
References: <20210108215838.470637-1-jcline@redhat.com>
 <3c94f9d6-501d-271c-ca83-1cf4229cb3ab@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c94f9d6-501d-271c-ca83-1cf4229cb3ab@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 11, 2021 at 09:53:56AM +0100, Christian König wrote:
> Am 08.01.21 um 22:58 schrieb Jeremy Cline:
> > dcn20_resource_construct() includes a number of kzalloc(GFP_KERNEL)
> > calls which can sleep, but kernel_fpu_begin() disables preemption and
> > sleeping in this context is invalid.
> > 
> > The only places the FPU appears to be required is in the
> > init_soc_bounding_box() function and when calculating the
> > {min,max}_fill_clk_mhz. Narrow the scope to just these two parts to
> > avoid sleeping while using the FPU.
> > 
> > Fixes: 7a8a3430be15 ("amdgpu: Wrap FPU dependent functions in dc20")
> > Cc: Timothy Pearson <tpearson@raptorengineering.com>
> > Signed-off-by: Jeremy Cline <jcline@redhat.com>
> 
> Good catch, but I would rather replace the kzalloc(GFP_KERNEL) with a
> kzalloc(GFP_ATOMIC) for now.
> 
> We have tons of problems with this DC_FP_START()/DC_FP_END() annotations and
> are even in the process of moving them out of the file because the compiles
> tend to clutter FP registers even outside of the annotated ranges on some
> architectures.
> 

Thanks for the review. Is it acceptable to move the DC_FP_END()
annotation up to the last usage? Keeping it where it is is probably
do-able, but covers things like calls to resource_construct() which
makes use of struct resource_create_funcs. I'm guessing only a sub-set
of the implementations are called via this function, but having an
interface which can't sleep sometimes doesn't sound appealing.

Happy to do it, but before I go down that road I just wanted to make
sure that's what you had in mind.

Thanks,
Jeremy

> > ---
> >   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > index e04ecf0fc0db..a4fa5bf016c1 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > @@ -3622,6 +3622,7 @@ static bool init_soc_bounding_box(struct dc *dc,
> >   	if (bb && ASICREV_IS_NAVI12_P(dc->ctx->asic_id.hw_internal_rev)) {
> >   		int i;
> > +		DC_FP_START();
> >   		dcn2_0_nv12_soc.sr_exit_time_us =
> >   				fixed16_to_double_to_cpu(bb->sr_exit_time_us);
> >   		dcn2_0_nv12_soc.sr_enter_plus_exit_time_us =
> > @@ -3721,6 +3722,7 @@ static bool init_soc_bounding_box(struct dc *dc,
> >   			dcn2_0_nv12_soc.clock_limits[i].dram_speed_mts =
> >   					fixed16_to_double_to_cpu(bb->clock_limits[i].dram_speed_mts);
> >   		}
> > +		DC_FP_END();
> >   	}
> >   	if (pool->base.pp_smu) {
> > @@ -3777,8 +3779,6 @@ static bool dcn20_resource_construct(
> >   	enum dml_project dml_project_version =
> >   			get_dml_project_version(ctx->asic_id.hw_internal_rev);
> > -	DC_FP_START();
> > -
> >   	ctx->dc_bios->regs = &bios_regs;
> >   	pool->base.funcs = &dcn20_res_pool_funcs;
> > @@ -3959,8 +3959,10 @@ static bool dcn20_resource_construct(
> >   				ranges.reader_wm_sets[i].wm_inst = i;
> >   				ranges.reader_wm_sets[i].min_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MIN;
> >   				ranges.reader_wm_sets[i].max_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
> > +				DC_FP_START();
> >   				ranges.reader_wm_sets[i].min_fill_clk_mhz = (i > 0) ? (loaded_bb->clock_limits[i - 1].dram_speed_mts / 16) + 1 : 0;
> >   				ranges.reader_wm_sets[i].max_fill_clk_mhz = loaded_bb->clock_limits[i].dram_speed_mts / 16;
> > +				DC_FP_END();
> >   				ranges.num_reader_wm_sets = i + 1;
> >   			}
> > @@ -4125,12 +4127,10 @@ static bool dcn20_resource_construct(
> >   		pool->base.oem_device = NULL;
> >   	}
> > -	DC_FP_END();
> >   	return true;
> >   create_fail:
> > -	DC_FP_END();
> >   	dcn20_resource_destruct(pool);
> >   	return false;
> 

