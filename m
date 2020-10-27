Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428F129A69E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894930AbgJ0Icw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:32:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34578 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894921AbgJ0Icu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:32:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id y16so801758ljk.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 01:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X82VobCub5wdmETS8bjf+vsdYdzdCr0PUmctvSLcEXs=;
        b=KhZ5AD7Jw9jBSL5FbMoztfPKGbPuygHGVL/xEfq2XjOAML/HDO8WCDbzSkhKyibuAU
         EdS7G74Z4xdzPbTaGFJM60aGA7elIq0mM1xpSG+76kNXuXg6Zy8JHG5XHUqOGhpK34S2
         GBXe4XxWKlqFmjAjWTSutGi7pdAEaHPAGR/I6Ugdxfahk/n85pfH7WdokpQ4nweP/5aU
         vnGoTK/26xRIqlW1NPVseaIbS5jZF3f1FigFuawXl+oSZfctnBZn0uvRAMMYelFfoK8V
         oRGzJyg+Yn7kqncPCe2KU5YcVp2fuIKuT5nFQCCis7SYNgPo0hG5Xb9SkGKPfW0vnSPc
         d6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X82VobCub5wdmETS8bjf+vsdYdzdCr0PUmctvSLcEXs=;
        b=RRIziHdsQGCYtLu83YuQNJBERKB+hnpDBk5ZBCy2Fd56Dd+gMOhtFrjeGKoY5OIQ8h
         eBdNriGeUuTe7Wdkw1N14T2YABx720I9uDm35nNFh+N1DYCuYiuivyc6wEyQvQev4gFJ
         BWo6Ek4zB/kfWf7lWNvL+GjaH8C6jonaO7Rp6lc1sOOEZX0CRUQIt9q8qlckwAfKSPjM
         THx7HdCCBtTpm0/9ChejwPwYloZZV1qbNn0fmtn2nF/S/qK32lCSHpyfhnf6DgXW7RZq
         B2voWcODG+cn1EHomDmlDHyfD9Wm6SH5gpFY5VBXi+6qUNFYrK5g2J3h/1l8wyYFHczJ
         C5PA==
X-Gm-Message-State: AOAM530/3fmHzvAYfkSbt06isZirE2rFlefO/F2/OEyO8kiw7Qkhyc7d
        ECKzQsnTEzFmGxo3RS/4HlQOfg==
X-Google-Smtp-Source: ABdhPJz1bsKo5yTgSnDzbbvP5V2jQw+5aQqoUkmOwX1eV8OBkkpGpm8QyCzEOzVMO02QIpg+mOjbYQ==
X-Received: by 2002:a2e:874c:: with SMTP id q12mr579587ljj.148.1603787565936;
        Tue, 27 Oct 2020 01:32:45 -0700 (PDT)
Received: from [192.168.1.211] ([188.162.64.248])
        by smtp.gmail.com with ESMTPSA id c4sm67675lfr.14.2020.10.27.01.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 01:32:45 -0700 (PDT)
Subject: Re: [PATCH 3/3] drm/msm/dpu: add support for clk and bw scaling for
 display
To:     Rob Clark <robdclark@gmail.com>,
        Kalyan Thota <kalyan_t@codeaurora.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Raviteja Tamatam <travitej@codeaurora.org>,
        nganji@codeaurora.org
References: <1594899334-19772-1-git-send-email-kalyan_t@codeaurora.org>
 <1594899334-19772-3-git-send-email-kalyan_t@codeaurora.org>
 <CAF6AEGsYmxwmG2OWdX3Q-5tio+kU-AwhiL_0EyLTVb0=gWgwgw@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <1faa4d88-7acf-1895-f93b-59fd20d6de06@linaro.org>
Date:   Tue, 27 Oct 2020 11:32:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <CAF6AEGsYmxwmG2OWdX3Q-5tio+kU-AwhiL_0EyLTVb0=gWgwgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 04/08/2020 18:40, Rob Clark wrote:
> On Thu, Jul 16, 2020 at 4:36 AM Kalyan Thota <kalyan_t@codeaurora.org> wrote:
>>
>> This change adds support to scale src clk and bandwidth as
>> per composition requirements.
>>
>> Interconnect registration for bw has been moved to mdp
>> device node from mdss to facilitate the scaling.
>>
>> Changes in v1:
>>   - Address armv7 compilation issues with the patch (Rob)
>>
>> Signed-off-by: Kalyan Thota <kalyan_t@codeaurora.org>

Kalyan, back in July you promised to provide a followup patchset, 
removing code duplication. It's close to November now. Are there any 
plans for the followup or is a forgotten topic?

> 
> Reviewed-by: Rob Clark <robdclark@chromium.org>
> 
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c  | 109 +++++++++++++++++++++----
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c |   5 +-
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h |   4 +
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c        |  37 ++++++++-
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h        |   4 +
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c       |   9 +-
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c      |  84 +++++++++++++++++++
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h      |   4 +
>>   8 files changed, 233 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
>> index 7c230f7..e52bc44 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
>> @@ -29,6 +29,74 @@ enum dpu_perf_mode {
>>          DPU_PERF_MODE_MAX
>>   };
>>
>> +/**
>> + * @_dpu_core_perf_calc_bw() - to calculate BW per crtc
>> + * @kms -  pointer to the dpu_kms
>> + * @crtc - pointer to a crtc
>> + * Return: returns aggregated BW for all planes in crtc.
>> + */
>> +static u64 _dpu_core_perf_calc_bw(struct dpu_kms *kms,
>> +               struct drm_crtc *crtc)
>> +{
>> +       struct drm_plane *plane;
>> +       struct dpu_plane_state *pstate;
>> +       u64 crtc_plane_bw = 0;
>> +       u32 bw_factor;
>> +
>> +       drm_atomic_crtc_for_each_plane(plane, crtc) {
>> +               pstate = to_dpu_plane_state(plane->state);
>> +               if (!pstate)
>> +                       continue;
>> +
>> +               crtc_plane_bw += pstate->plane_fetch_bw;
>> +       }
>> +
>> +       bw_factor = kms->catalog->perf.bw_inefficiency_factor;
>> +       if (bw_factor) {
>> +               crtc_plane_bw *= bw_factor;
>> +               do_div(crtc_plane_bw, 100);
>> +       }
>> +
>> +       return crtc_plane_bw;
>> +}
>> +
>> +/**
>> + * _dpu_core_perf_calc_clk() - to calculate clock per crtc
>> + * @kms -  pointer to the dpu_kms
>> + * @crtc - pointer to a crtc
>> + * @state - pointer to a crtc state
>> + * Return: returns max clk for all planes in crtc.
>> + */
>> +static u64 _dpu_core_perf_calc_clk(struct dpu_kms *kms,
>> +               struct drm_crtc *crtc, struct drm_crtc_state *state)
>> +{
>> +       struct drm_plane *plane;
>> +       struct dpu_plane_state *pstate;
>> +       struct drm_display_mode *mode;
>> +       u64 crtc_clk;
>> +       u32 clk_factor;
>> +
>> +       mode = &state->adjusted_mode;
>> +
>> +       crtc_clk = mode->vtotal * mode->hdisplay * drm_mode_vrefresh(mode);
>> +
>> +       drm_atomic_crtc_for_each_plane(plane, crtc) {
>> +               pstate = to_dpu_plane_state(plane->state);
>> +               if (!pstate)
>> +                       continue;
>> +
>> +               crtc_clk = max(pstate->plane_clk, crtc_clk);
>> +       }
>> +
>> +       clk_factor = kms->catalog->perf.clk_inefficiency_factor;
>> +       if (clk_factor) {
>> +               crtc_clk *= clk_factor;
>> +               do_div(crtc_clk, 100);
>> +       }
>> +
>> +       return crtc_clk;
>> +}
>> +
>>   static struct dpu_kms *_dpu_crtc_get_kms(struct drm_crtc *crtc)
>>   {
>>          struct msm_drm_private *priv;
>> @@ -51,12 +119,7 @@ static void _dpu_core_perf_calc_crtc(struct dpu_kms *kms,
>>          dpu_cstate = to_dpu_crtc_state(state);
>>          memset(perf, 0, sizeof(struct dpu_core_perf_params));
>>
>> -       if (!dpu_cstate->bw_control) {
>> -               perf->bw_ctl = kms->catalog->perf.max_bw_high *
>> -                                       1000ULL;
>> -               perf->max_per_pipe_ib = perf->bw_ctl;
>> -               perf->core_clk_rate = kms->perf.max_core_clk_rate;
>> -       } else if (kms->perf.perf_tune.mode == DPU_PERF_MODE_MINIMUM) {
>> +       if (kms->perf.perf_tune.mode == DPU_PERF_MODE_MINIMUM) {
>>                  perf->bw_ctl = 0;
>>                  perf->max_per_pipe_ib = 0;
>>                  perf->core_clk_rate = 0;

Now bw_control is unused and can be removed alltogether.

>> @@ -64,6 +127,10 @@ static void _dpu_core_perf_calc_crtc(struct dpu_kms *kms,
>>                  perf->bw_ctl = kms->perf.fix_core_ab_vote;
>>                  perf->max_per_pipe_ib = kms->perf.fix_core_ib_vote;
>>                  perf->core_clk_rate = kms->perf.fix_core_clk_rate;
>> +       } else {
>> +               perf->bw_ctl = _dpu_core_perf_calc_bw(kms, crtc);
>> +               perf->max_per_pipe_ib = kms->catalog->perf.min_dram_ib;
>> +               perf->core_clk_rate = _dpu_core_perf_calc_clk(kms, crtc, state);
>>          }
>>
>>          DPU_DEBUG(
>> @@ -115,11 +182,7 @@ int dpu_core_perf_crtc_check(struct drm_crtc *crtc,
>>                          DPU_DEBUG("crtc:%d bw:%llu ctrl:%d\n",
>>                                  tmp_crtc->base.id, tmp_cstate->new_perf.bw_ctl,
>>                                  tmp_cstate->bw_control);
>> -                       /*
>> -                        * For bw check only use the bw if the
>> -                        * atomic property has been already set
>> -                        */
>> -                       if (tmp_cstate->bw_control)
>> +
>>                                  bw_sum_of_intfs += tmp_cstate->new_perf.bw_ctl;

Just a nitpick: indent is wrong.

>>                  }
>>
>> @@ -131,9 +194,7 @@ int dpu_core_perf_crtc_check(struct drm_crtc *crtc,
>>
>>                  DPU_DEBUG("final threshold bw limit = %d\n", threshold);
>>
>> -               if (!dpu_cstate->bw_control) {
>> -                       DPU_DEBUG("bypass bandwidth check\n");
>> -               } else if (!threshold) {
>> +               if (!threshold) {
>>                          DPU_ERROR("no bandwidth limits specified\n");
>>                          return -E2BIG;
>>                  } else if (bw > threshold) {
>> @@ -154,7 +215,11 @@ static int _dpu_core_perf_crtc_update_bus(struct dpu_kms *kms,
>>                                          = dpu_crtc_get_client_type(crtc);
>>          struct drm_crtc *tmp_crtc;
>>          struct dpu_crtc_state *dpu_cstate;
>> -       int ret = 0;
>> +       int i, ret = 0;
>> +       u64 avg_bw;
>> +
>> +       if (!kms->num_paths)
>> +               return -EINVAL;

This broke bandwidth setting for everybody except sc7180, since 
_dpu_core_perf_crtc_update_bus will be still called for them, and 
returning -EINVAL here prevents dpu_core_perf_crtc_update() from setting 
clock rate. Returning 0 here fixes the issue.


>>
>>          drm_for_each_crtc(tmp_crtc, crtc->dev) {
>>                  if (tmp_crtc->enabled &&
>> @@ -165,10 +230,20 @@ static int _dpu_core_perf_crtc_update_bus(struct dpu_kms *kms,


-- 
With best wishes
Dmitry
