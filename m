Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6222EF9F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbhAHVJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbhAHVJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:09:06 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799A6C061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 13:08:26 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id j12so11008549ota.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 13:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nRS0L7fvUGqSA/e/lDofkKYEIWrtPa7uYouhHiULOy0=;
        b=E4PhqOjB/Thrk2iqgGRHz9qHCn2oXuwy8TbZ5/imW5zcS/BMBgSl9UDlO/ZxiYzSZo
         YPeLgu+Moamgjx8J9MJaIQ15X3sLBYVizDb0QS68VJJWSDXlET5dDtRSSaaNQRWFCDjE
         A0f6FEiQ1MKb/eg18K2FISo0LwzbPNxz32xZGFnUP+zGDwCt1xMqppXyGmK8RjhhD4id
         H2vJ40Jdm8ate031crwnaSE9j2/SNjZlHGymwyHUoJDiq2QZFVmVWH8E+LAIM4wRhvNx
         L0hKU8dUjfWYZ0mHTYfiWi7lLT/sVMM7w4WOPGMoS+WvdnxRV9mlGj/wOCVdjYK/XPFs
         E4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nRS0L7fvUGqSA/e/lDofkKYEIWrtPa7uYouhHiULOy0=;
        b=PdLjfhl/fO+wCLs+CGkFKQYzBu8qu8OHcrp0N5YhtNyrPoobZC7fuB1qLpo1EhrPja
         rGlJlchXO+iVx/6/G8Wd4ePZAAPI+ICqf75kC/Er3WhCOfdT6BeoRUdGoEmNnaoLMP6o
         0tcAEbuP3XYLTEpF7GA1EHfSeYXyz1jnIWQiUfbQhQsME497SIPFWJvLM1EMEFD/3jVS
         uMUFFbeKy1ZHteYeguXwhcMEyVGuP6S6CB/OYL7YF2Bc9Fvgmc+I4k0TWrs3jnFOtAZD
         aJ3cpMCaZp5ar6hgtsVEqc4fjFBbT+IGCVwGxViefZtBH7FB/jgdlwLkjE8z61p3kIOY
         3oXQ==
X-Gm-Message-State: AOAM533WF6ha3WdzlPSKuHsoo41ppsRFltbes9HiEcRsyI9OfL86mLOa
        ilNq0X+6k1UdN2I4NvYwtCZg/XRMTx3wjcmjcwI=
X-Google-Smtp-Source: ABdhPJwUKn189k6jz2ID6ROoxv+heGK+T09fzz48QxLhws12Sthaohe17iu9PHOzfBs+E9feRpimhMnvhtp18nRVzCk=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr4067082ote.132.1610140105945;
 Fri, 08 Jan 2021 13:08:25 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-23-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-23-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 16:08:15 -0500
Message-ID: <CADnq5_Odj55sMJ3FD-PmRx=1if-DnjC4EtNNPdVgSktBN=2C9Q@mail.gmail.com>
Subject: Re: [PATCH 22/40] drm/amd/display/dc/bios/bios_parser2: Fix some
 formatting issues and missing parameter docs
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 3:15 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:501: warnin=
g: Function parameter or member 'dcb' not described in 'bios_parser_get_gpi=
o_pin_info'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:501: warnin=
g: Function parameter or member 'gpio_id' not described in 'bios_parser_get=
_gpio_pin_info'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:501: warnin=
g: Function parameter or member 'info' not described in 'bios_parser_get_gp=
io_pin_info'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:815: warnin=
g: Function parameter or member 'dcb' not described in 'bios_parser_get_spr=
ead_spectrum_info'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:815: warnin=
g: Function parameter or member 'signal' not described in 'bios_parser_get_=
spread_spectrum_info'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:815: warnin=
g: Function parameter or member 'index' not described in 'bios_parser_get_s=
pread_spectrum_info'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:815: warnin=
g: Function parameter or member 'ss_info' not described in 'bios_parser_get=
_spread_spectrum_info'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:1210: warni=
ng: Function parameter or member 'dcb' not described in 'bios_parser_set_sc=
ratch_critical_state'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:1210: warni=
ng: Function parameter or member 'state' not described in 'bios_parser_set_=
scratch_critical_state'
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
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
>  .../drm/amd/display/dc/bios/bios_parser2.c    | 29 +++++++++----------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers=
/gpu/drm/amd/display/dc/bios/bios_parser2.c
> index 670c265838178..9f9fda3118d1f 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> @@ -485,10 +485,11 @@ static struct atom_hpd_int_record *get_hpd_record(
>   * bios_parser_get_gpio_pin_info
>   * Get GpioPin information of input gpio id
>   *
> - * @param gpio_id, GPIO ID
> - * @param info, GpioPin information structure
> - * @return Bios parser result code
> - * @note
> + * @dcb:     pointer to the DC BIOS
> + * @gpio_id: GPIO ID
> + * @info:    GpioPin information structure
> + * return: Bios parser result code
> + * note:
>   *  to get the GPIO PIN INFO, we need:
>   *  1. get the GPIO_ID from other object table, see GetHPDInfo()
>   *  2. in DATA_TABLE.GPIO_Pin_LUT, search all records,
> @@ -801,11 +802,11 @@ static enum bp_result get_ss_info_v4_2(
>   * ver 3.1,
>   * there is only one entry for each signal /ss id.  However, there is
>   * no planning of supporting multiple spread Sprectum entry for EverGree=
n
> - * @param [in] this
> - * @param [in] signal, ASSignalType to be converted to info index
> - * @param [in] index, number of entries that match the converted info in=
dex
> - * @param [out] ss_info, sprectrum information structure,
> - * @return Bios parser result code
> + * @dcb:     pointer to the DC BIOS
> + * @signal:  ASSignalType to be converted to info index
> + * @index:   number of entries that match the converted info index
> + * @ss_info: sprectrum information structure,
> + * return: Bios parser result code
>   */
>  static enum bp_result bios_parser_get_spread_spectrum_info(
>         struct dc_bios *dcb,
> @@ -1196,13 +1197,11 @@ static bool bios_parser_is_accelerated_mode(
>  }
>
>  /**
> - * bios_parser_set_scratch_critical_state
> + * bios_parser_set_scratch_critical_state - update critical state bit
> + *                                          in VBIOS scratch register
>   *
> - * @brief
> - *  update critical state bit in VBIOS scratch register
> - *
> - * @param
> - *  bool - to set or reset state
> + * @dcb:   pointer to the DC BIO
> + * @state: set or reset state
>   */
>  static void bios_parser_set_scratch_critical_state(
>         struct dc_bios *dcb,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
