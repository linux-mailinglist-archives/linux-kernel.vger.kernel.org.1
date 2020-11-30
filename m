Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280962C92E9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgK3Xny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgK3Xny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:43:54 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2508C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:43:13 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id f48so4605828otf.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qEeGuqqjWiFOlcF7HqrOoE3sQeUDyOLuQtQ6gdmnGEk=;
        b=DH5ZY8N62ugXcBCo6m4LqwZVZTFNK5MzqChC5rkT6BlVWdcWf4VwnuImzq2S7N9LQU
         ZaqCzWPBlo11MhPWtoaWxJIA4HdSn9ZEatemlFt1PUpkE+POlEOvDNn2+HF/dYKmwbTp
         RDRwuUYkBcY4WTkHJqQbVN9a5veXj+GfCW0BbiV+LiPlbFj0EoELJ5ZLeT8kOfoIKfQ0
         jWLQii7h5BEvhJcxRiERgwCHGp/uEd/mj/w/3UFO+liIwFcbrUEtlsRM/PuPp7JCJjn4
         q1Jg2gIr66mEV2SKaR6Jp73mmXn1pyPufIkkqsIV1aOmlS/H3tqA7cFQeogXFXreBntG
         33KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qEeGuqqjWiFOlcF7HqrOoE3sQeUDyOLuQtQ6gdmnGEk=;
        b=k9Cgv1B4wbsY7i71t5IQ3HMAgkKCPwuZB9qByR/Iy6WA+fWv3ZlojFxz7+MVmRFXLD
         FdOioykSK24gRk3GX6pogPhHQqiHU6NC3HIG0TGm+X98sMOc2kuL+yKBSez8FOyFms+k
         M14lJcoUEjxNW+v/12HRPWmX246GXIbUe2wXG5mwZQ8tOocYbpUIbjFpnm1dl0ugxsNe
         hXYh5cYtyuHCyApc+oXKWRnaJ+Ce7jxh8ntleNJyxoaucUZb86NfEJoDYhSGQXK8aXIH
         nHoSsw3gz2mzT9it9nqMoDlCHWDp3bYBc+endYu3bDNXGPrbZ/bWpSGYmG7F8LtLJoEA
         FOjw==
X-Gm-Message-State: AOAM53233oY3FtQg9VKUqXNV3IZEAAHr6+hRjW0WC+Y4PeCDK9+yTnma
        29XPoIR7bhSrvAgnd7BTEcOhK7SX4rEdN7uX0QE=
X-Google-Smtp-Source: ABdhPJwcnocbSek7AcniapY3FPp22icMM1ur2r6jf4tOfWAiMTh4VBn0IsZSyKcK0kCOUtJurCBwDl5YpDhP+/MQ8r4=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr18986753otg.311.1606779793216;
 Mon, 30 Nov 2020 15:43:13 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-20-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-20-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:43:01 -0500
Message-ID: <CADnq5_OH4D_0YQFEx_62uVP1gpEj0r9=_bt3Wj5io5mWB=bCog@mail.gmail.com>
Subject: Re: [PATCH 19/40] drm/amd/pm/powerplay/hwmgr/ppatomctrl: Fix a myriad
 of kernel-doc issues
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 8:43 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:104: warni=
ng: Function parameter or member 'reg_block' not described in 'atomctrl_set=
_mc_reg_address_table'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:104: warni=
ng: Function parameter or member 'table' not described in 'atomctrl_set_mc_=
reg_address_table'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:213: warni=
ng: Function parameter or member 'hwmgr' not described in 'atomctrl_set_eng=
ine_dram_timings_rv770'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:213: warni=
ng: Function parameter or member 'engine_clock' not described in 'atomctrl_=
set_engine_dram_timings_rv770'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:213: warni=
ng: Function parameter or member 'memory_clock' not described in 'atomctrl_=
set_engine_dram_timings_rv770'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:239: warni=
ng: Function parameter or member 'device' not described in 'get_voltage_inf=
o_table'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:519: warni=
ng: Function parameter or member 'hwmgr' not described in 'atomctrl_get_ref=
erence_clock'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:548: warni=
ng: Function parameter or member 'hwmgr' not described in 'atomctrl_is_volt=
age_controlled_by_gpio_v3'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:548: warni=
ng: Function parameter or member 'voltage_type' not described in 'atomctrl_=
is_voltage_controlled_by_gpio_v3'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:548: warni=
ng: Function parameter or member 'voltage_mode' not described in 'atomctrl_=
is_voltage_controlled_by_gpio_v3'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:640: warni=
ng: Function parameter or member 'device' not described in 'get_gpio_lookup=
_table'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:663: warni=
ng: Function parameter or member 'hwmgr' not described in 'atomctrl_get_pp_=
assign_pin'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:663: warni=
ng: Function parameter or member 'pinId' not described in 'atomctrl_get_pp_=
assign_pin'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:663: warni=
ng: Function parameter or member 'gpio_pin_assignment' not described in 'at=
omctrl_get_pp_assign_pin'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1152: warn=
ing: Function parameter or member 'hwmgr' not described in 'atomctrl_get_vo=
ltage_evv'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1152: warn=
ing: Function parameter or member 'virtual_voltage_id' not described in 'at=
omctrl_get_voltage_evv'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1152: warn=
ing: Function parameter or member 'voltage' not described in 'atomctrl_get_=
voltage_evv'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1194: warn=
ing: Function parameter or member 'hwmgr' not described in 'atomctrl_get_mp=
ll_reference_clock'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1227: warn=
ing: Function parameter or member 'device' not described in 'asic_internal_=
ss_get_ss_table'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1258: warn=
ing: Function parameter or member 'hwmgr' not described in 'asic_internal_s=
s_get_ss_asignment'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1258: warn=
ing: Function parameter or member 'clockSource' not described in 'asic_inte=
rnal_ss_get_ss_asignment'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1258: warn=
ing: Function parameter or member 'clockSpeed' not described in 'asic_inter=
nal_ss_get_ss_asignment'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1258: warn=
ing: Function parameter or member 'ssEntry' not described in 'asic_internal=
_ss_get_ss_asignment'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1321: warn=
ing: Function parameter or member 'hwmgr' not described in 'atomctrl_get_me=
mory_clock_spread_spectrum'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1321: warn=
ing: Function parameter or member 'memory_clock' not described in 'atomctrl=
_get_memory_clock_spread_spectrum'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1321: warn=
ing: Function parameter or member 'ssInfo' not described in 'atomctrl_get_m=
emory_clock_spread_spectrum'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1332: warn=
ing: Function parameter or member 'hwmgr' not described in 'atomctrl_get_en=
gine_clock_spread_spectrum'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1332: warn=
ing: Function parameter or member 'engine_clock' not described in 'atomctrl=
_get_engine_clock_spread_spectrum'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1332: warn=
ing: Function parameter or member 'ssInfo' not described in 'atomctrl_get_e=
ngine_clock_spread_spectrum'
>
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  .../drm/amd/pm/powerplay/hwmgr/ppatomctrl.c   | 74 ++++++++++---------
>  1 file changed, 39 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> index 2cb913ab77f26..83a6504e093cb 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> @@ -92,11 +92,11 @@ static int atomctrl_retrieve_ac_timing(
>  }
>
>  /**
> - * Get memory clock AC timing registers index from VBIOS table
> + * atomctrl_set_mc_reg_address_table - Get memory clock AC timing regist=
ers index from VBIOS table
>   * VBIOS set end of memory clock AC timing registers by ucPreRegDataLeng=
th bit6 =3D 1
> - * @param    reg_block the address ATOM_INIT_REG_BLOCK
> - * @param    table the address of MCRegTable
> - * @return   0
> + * @reg_block: the address ATOM_INIT_REG_BLOCK
> + * @table: the address of MCRegTable
> + * Return:   0
>   */
>  static int atomctrl_set_mc_reg_address_table(
>                 ATOM_INIT_REG_BLOCK *reg_block,
> @@ -203,7 +203,7 @@ int atomctrl_initialize_mc_reg_table_v2_2(
>         return result;
>  }
>
> -/**
> +/*
>   * Set DRAM timings based on engine clock and memory clock.
>   */
>  int atomctrl_set_engine_dram_timings_rv770(
> @@ -229,7 +229,7 @@ int atomctrl_set_engine_dram_timings_rv770(
>                         (uint32_t *)&engine_clock_parameters);
>  }
>
> -/**
> +/*
>   * Private Function to get the PowerPlay Table Address.
>   * WARNING: The tabled returned by this function is in
>   * dynamically allocated memory.
> @@ -274,12 +274,13 @@ static const ATOM_VOLTAGE_OBJECT_V3 *atomctrl_looku=
p_voltage_type_v3(
>         return NULL;
>  }
>
> -/** atomctrl_get_memory_pll_dividers_si().
> +/**
> + * atomctrl_get_memory_pll_dividers_si().
>   *
> - * @param hwmgr                 input parameter: pointer to HwMgr
> - * @param clock_value             input parameter: memory clock
> - * @param dividers                 output parameter: memory PLL dividers
> - * @param strobe_mode            input parameter: 1 for strobe mode,  0 =
for performance mode
> + * @hwmgr:           input parameter: pointer to HwMgr
> + * @clock_value:     input parameter: memory clock
> + * @dividers:        output parameter: memory PLL dividers
> + * @strobe_mode:     input parameter: 1 for strobe mode,  0 for performa=
nce mode
>   */
>  int atomctrl_get_memory_pll_dividers_si(
>                 struct pp_hwmgr *hwmgr,
> @@ -326,11 +327,12 @@ int atomctrl_get_memory_pll_dividers_si(
>         return result;
>  }
>
> -/** atomctrl_get_memory_pll_dividers_vi().
> +/**
> + * atomctrl_get_memory_pll_dividers_vi().
>   *
> - * @param hwmgr                 input parameter: pointer to HwMgr
> - * @param clock_value             input parameter: memory clock
> - * @param dividers               output parameter: memory PLL dividers
> + * @hwmgr:                 input parameter: pointer to HwMgr
> + * @clock_value:           input parameter: memory clock
> + * @dividers:              output parameter: memory PLL dividers
>   */
>  int atomctrl_get_memory_pll_dividers_vi(struct pp_hwmgr *hwmgr,
>                 uint32_t clock_value, pp_atomctrl_memory_clock_param *mpl=
l_param)
> @@ -512,7 +514,7 @@ int atomctrl_get_dfs_pll_dividers_vi(
>         return result;
>  }
>
> -/**
> +/*
>   * Get the reference clock in 10KHz
>   */
>  uint32_t atomctrl_get_reference_clock(struct pp_hwmgr *hwmgr)
> @@ -535,7 +537,7 @@ uint32_t atomctrl_get_reference_clock(struct pp_hwmgr=
 *hwmgr)
>         return clock;
>  }
>
> -/**
> +/*
>   * Returns true if the given voltage type is controlled by GPIO pins.
>   * voltage_type is one of SET_VOLTAGE_TYPE_ASIC_VDDC,
>   * SET_VOLTAGE_TYPE_ASIC_MVDDC, SET_VOLTAGE_TYPE_ASIC_MVDDQ.
> @@ -630,7 +632,7 @@ static bool atomctrl_lookup_gpio_pin(
>         return false;
>  }
>
> -/**
> +/*
>   * Private Function to get the PowerPlay Table Address.
>   * WARNING: The tabled returned by this function is in
>   * dynamically allocated memory.
> @@ -653,7 +655,7 @@ static ATOM_GPIO_PIN_LUT *get_gpio_lookup_table(void =
*device)
>         return (ATOM_GPIO_PIN_LUT *)table_address;
>  }
>
> -/**
> +/*
>   * Returns 1 if the given pin id find in lookup table.
>   */
>  bool atomctrl_get_pp_assign_pin(
> @@ -1101,14 +1103,15 @@ int atomctrl_calculate_voltage_evv_on_sclk(
>         return result;
>  }
>
> -/** atomctrl_get_voltage_evv_on_sclk gets voltage via call to ATOM COMMA=
ND table.
> - * @param hwmgr        input: pointer to hwManager
> - * @param voltage_type            input: type of EVV voltage VDDC or VDD=
GFX
> - * @param sclk                        input: in 10Khz unit. DPM state SC=
LK frequency
> - *             which is define in PPTable SCLK/VDDC dependence
> - *                             table associated with this virtual_voltag=
e_Id
> - * @param virtual_voltage_Id      input: voltage id which match per volt=
age DPM state: 0xff01, 0xff02.. 0xff08
> - * @param voltage                     output: real voltage level in unit=
 of mv
> +/**
> + * atomctrl_get_voltage_evv_on_sclk gets voltage via call to ATOM COMMAN=
D table.
> + * @hwmgr:              input: pointer to hwManager
> + * @voltage_type:       input: type of EVV voltage VDDC or VDDGFX
> + * @sclk:               input: in 10Khz unit. DPM state SCLK frequency
> + *                      which is define in PPTable SCLK/VDDC dependence
> + *                      table associated with this virtual_voltage_Id
> + * @virtual_voltage_Id: input: voltage id which match per voltage DPM st=
ate: 0xff01, 0xff02.. 0xff08
> + * @voltage:           output: real voltage level in unit of mv
>   */
>  int atomctrl_get_voltage_evv_on_sclk(
>                 struct pp_hwmgr *hwmgr,
> @@ -1142,9 +1145,9 @@ int atomctrl_get_voltage_evv_on_sclk(
>
>  /**
>   * atomctrl_get_voltage_evv gets voltage via call to ATOM COMMAND table.
> - * @param hwmgr        input: pointer to hwManager
> - * @param virtual_voltage_id      input: voltage id which match per volt=
age DPM state: 0xff01, 0xff02.. 0xff08
> - * @param voltage                     output: real voltage level in unit=
 of mv
> + * @hwmgr:              input: pointer to hwManager
> + * @virtual_voltage_id: input: voltage id which match per voltage DPM st=
ate: 0xff01, 0xff02.. 0xff08
> + * @voltage:          output: real voltage level in unit of mv
>   */
>  int atomctrl_get_voltage_evv(struct pp_hwmgr *hwmgr,
>                              uint16_t virtual_voltage_id,
> @@ -1187,7 +1190,7 @@ int atomctrl_get_voltage_evv(struct pp_hwmgr *hwmgr=
,
>         return result;
>  }
>
> -/**
> +/*
>   * Get the mpll reference clock in 10KHz
>   */
>  uint32_t atomctrl_get_mpll_reference_clock(struct pp_hwmgr *hwmgr)
> @@ -1220,7 +1223,7 @@ uint32_t atomctrl_get_mpll_reference_clock(struct p=
p_hwmgr *hwmgr)
>         return clock;
>  }
>
> -/**
> +/*
>   * Get the asic internal spread spectrum table
>   */
>  static ATOM_ASIC_INTERNAL_SS_INFO *asic_internal_ss_get_ss_table(void *d=
evice)
> @@ -1248,7 +1251,7 @@ bool atomctrl_is_asic_internal_ss_supported(struct =
pp_hwmgr *hwmgr)
>                 return false;
>  }
>
> -/**
> +/*
>   * Get the asic internal spread spectrum assignment
>   */
>  static int asic_internal_ss_get_ss_asignment(struct pp_hwmgr *hwmgr,
> @@ -1311,7 +1314,7 @@ static int asic_internal_ss_get_ss_asignment(struct=
 pp_hwmgr *hwmgr,
>         return entry_found ? 0 : 1;
>  }
>
> -/**
> +/*
>   * Get the memory clock spread spectrum info
>   */
>  int atomctrl_get_memory_clock_spread_spectrum(
> @@ -1322,7 +1325,8 @@ int atomctrl_get_memory_clock_spread_spectrum(
>         return asic_internal_ss_get_ss_asignment(hwmgr,
>                         ASIC_INTERNAL_MEMORY_SS, memory_clock, ssInfo);
>  }
> -/**
> +
> +/*
>   * Get the engine clock spread spectrum info
>   */
>  int atomctrl_get_engine_clock_spread_spectrum(
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
