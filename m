Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6925C2EF991
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbhAHUmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbhAHUmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:42:42 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0B5C061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:42:01 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 11so10928634oty.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4Y4X+Mb/A+zp2kjLTrCh286RdSf9uxhVlmUD1nGxQxQ=;
        b=cBluTZw/Bpzu/e/8hq+wcL5hP+tnaQyKhptLN89M8vAqH6G0n3Jlz0Z5lzIi13ooUF
         A82XdXMviUPcqllyAAKbY8uaoyUNv0r5MQNbjMdnmyFRd4v/2PeOn9TQPZJdgVQYlP6+
         wgiVHbskEdHZkYkeJJW/cycv/nZp0z3U5mqEpwIf1rCBIXuZgUdzSj05I2FFbxrxHd0P
         2q1EsFq4JSuhHtRw9HcEjqtVLQhTu9Pugy545ueYGWkRmPhOBmh0hnRsD+YH/bre2Tqd
         kp3XC0abOo+t58sJO+Bw9c1FWf47qqRm1eBtTERorD2v9MnxfN2+sO5bMvRXf+uiQ94X
         UANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4Y4X+Mb/A+zp2kjLTrCh286RdSf9uxhVlmUD1nGxQxQ=;
        b=FZaoSgFQ5Y3N+vjAmEfS8n6e7KZYv7kyh63vg/F6wY1RODoxDcfGM/tfWBH7WWiiLh
         V9JopWtN6FEJLJBGfhrupIELJzRykIdyUnBWLDRIB78iG1D6BbmDoRlmhdSAYdY8otaq
         OYrzPAaMWixmqgKIDaNSCRU5QRrDa0uRvGDfirf3/AlHOE9hjWCr4kTWEJCfVYsY/ShO
         GbalqASWu2yxVHyglpBBMOO4JbXzdHEHh4rqQWBdxrnrYvR7/BjndR/pjeTqZv//3/dE
         mKi+9GrMhC1AVgfEtVTtHzlwHnRXSR0317M7/zHEumteES6ooAo3rzU82Xc95wyZ4aQQ
         dXnw==
X-Gm-Message-State: AOAM530I/5C5CKkmYkH7SfJuSfBed57q31z2aOYiUYdN6g8cFDJdQ34i
        xb9KeXCuY2qD6PMW0aMY7i60eO6+GfbqQJ3RGpTjT9Gf
X-Google-Smtp-Source: ABdhPJyyURcwWbsGz6v4kikax/QZCdPMNW86PTtSeH3DM23kqcOhXdnY1RC04LQcdlcMtSa3mwua7YoxMtjuzTRUOhg=
X-Received: by 2002:a05:6830:1d66:: with SMTP id l6mr3806493oti.23.1610138520972;
 Fri, 08 Jan 2021 12:42:00 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-19-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-19-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 15:41:49 -0500
Message-ID: <CADnq5_MJf26AqyONCLbovDSxGX0bDUkY9FMyVByFXomLLGmE4w@mail.gmail.com>
Subject: Re: [PATCH 18/40] drm/amd/display/dc/bios/bios_parser: Fix a whole
 bunch of legacy doc formatting
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

Applied.  Thanks!

Alex

On Fri, Jan 8, 2021 at 3:15 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:2588:16: war=
ning: no previous prototype for =E2=80=98update_slot_layout_info=E2=80=99 [=
-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:2692:16: war=
ning: no previous prototype for =E2=80=98get_bracket_layout_record=E2=80=99=
 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:925: warning=
: Function parameter or member 'dcb' not described in 'bios_parser_get_spre=
ad_spectrum_info'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:925: warning=
: Function parameter or member 'signal' not described in 'bios_parser_get_s=
pread_spectrum_info'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:925: warning=
: Function parameter or member 'index' not described in 'bios_parser_get_sp=
read_spectrum_info'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:925: warning=
: Function parameter or member 'ss_info' not described in 'bios_parser_get_=
spread_spectrum_info'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:997: warning=
: Function parameter or member 'bp' not described in 'get_ss_info_from_tbl'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:997: warning=
: Function parameter or member 'id' not described in 'get_ss_info_from_tbl'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:997: warning=
: Function parameter or member 'ss_info' not described in 'get_ss_info_from=
_tbl'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1022: warnin=
g: Function parameter or member 'bp' not described in 'get_ss_info_from_int=
ernal_ss_info_tbl_V2_1'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1022: warnin=
g: Function parameter or member 'id' not described in 'get_ss_info_from_int=
ernal_ss_info_tbl_V2_1'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1022: warnin=
g: Function parameter or member 'info' not described in 'get_ss_info_from_i=
nternal_ss_info_tbl_V2_1'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1087: warnin=
g: Function parameter or member 'bp' not described in 'get_ss_info_from_ss_=
info_table'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1087: warnin=
g: Function parameter or member 'id' not described in 'get_ss_info_from_ss_=
info_table'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1087: warnin=
g: Function parameter or member 'ss_info' not described in 'get_ss_info_fro=
m_ss_info_table'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1469: warnin=
g: Function parameter or member 'dcb' not described in 'bios_parser_get_enc=
oder_cap_info'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1469: warnin=
g: Function parameter or member 'object_id' not described in 'bios_parser_g=
et_encoder_cap_info'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1469: warnin=
g: Function parameter or member 'info' not described in 'bios_parser_get_en=
coder_cap_info'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1508: warnin=
g: Function parameter or member 'bp' not described in 'get_encoder_cap_reco=
rd'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1508: warnin=
g: Function parameter or member 'object' not described in 'get_encoder_cap_=
record'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1566: warnin=
g: Function parameter or member 'dcb' not described in 'bios_parser_get_ss_=
entry_number'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1566: warnin=
g: Function parameter or member 'signal' not described in 'bios_parser_get_=
ss_entry_number'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1619: warnin=
g: Function parameter or member 'bp' not described in 'get_ss_entry_number_=
from_ss_info_tbl'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1619: warnin=
g: Function parameter or member 'id' not described in 'get_ss_entry_number_=
from_ss_info_tbl'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1686: warnin=
g: Function parameter or member 'bp' not described in 'get_ss_entry_number'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1686: warnin=
g: Function parameter or member 'id' not described in 'get_ss_entry_number'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1705: warnin=
g: Function parameter or member 'bp' not described in 'get_ss_entry_number_=
from_internal_ss_info_tbl_v2_1'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1705: warnin=
g: Function parameter or member 'id' not described in 'get_ss_entry_number_=
from_internal_ss_info_tbl_v2_1'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1740: warnin=
g: Function parameter or member 'bp' not described in 'get_ss_entry_number_=
from_internal_ss_info_tbl_V3_1'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1740: warnin=
g: Function parameter or member 'id' not described in 'get_ss_entry_number_=
from_internal_ss_info_tbl_V3_1'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1783: warnin=
g: Function parameter or member 'dcb' not described in 'bios_parser_get_gpi=
o_pin_info'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1783: warnin=
g: Function parameter or member 'gpio_id' not described in 'bios_parser_get=
_gpio_pin_info'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1783: warnin=
g: Function parameter or member 'info' not described in 'bios_parser_get_gp=
io_pin_info'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:2211: warnin=
g: Function parameter or member 'dcb' not described in 'bios_parser_set_scr=
atch_critical_state'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:2211: warnin=
g: Function parameter or member 'state' not described in 'bios_parser_set_s=
cratch_critical_state'
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  .../gpu/drm/amd/display/dc/bios/bios_parser.c | 115 +++++++++---------
>  1 file changed, 56 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/=
gpu/drm/amd/display/dc/bios/bios_parser.c
> index f054c5872c619..d2654c50b0b20 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> @@ -911,11 +911,11 @@ static enum bp_result get_ss_info_from_tbl(
>   * ver 2.1 can co-exist with SS_Info table. Expect ASIC_InternalSS_Info =
ver 3.1,
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
> + * return:   Bios parser result code
>   */
>  static enum bp_result bios_parser_get_spread_spectrum_info(
>         struct dc_bios *dcb,
> @@ -985,10 +985,10 @@ static enum bp_result get_ss_info_from_internal_ss_=
info_tbl_V2_1(
>   * There can not be more than 1 entry for  ASIC_InternalSS_Info Ver 2.1 =
or
>   * SS_Info.
>   *
> - * @param this
> - * @param id, spread sprectrum info index
> - * @param pSSinfo, sprectrum information structure,
> - * @return Bios parser result code
> + * @bp:      pointer to the BIOS parser
> + * @id:      spread sprectrum info index
> + * @ssinfo:  sprectrum information structure,
> + * return::  BIOS parser result code
>   */
>  static enum bp_result get_ss_info_from_tbl(
>         struct bios_parser *bp,
> @@ -1011,9 +1011,10 @@ static enum bp_result get_ss_info_from_tbl(
>   * from the VBIOS
>   * There will not be multiple entry for Ver 2.1
>   *
> - * @param id, spread sprectrum info index
> - * @param pSSinfo, sprectrum information structure,
> - * @return Bios parser result code
> + * @bp:    pointer to the Bios parser
> + * @id:    spread sprectrum info index
> + * @info:  sprectrum information structure,
> + * return: Bios parser result code
>   */
>  static enum bp_result get_ss_info_from_internal_ss_info_tbl_V2_1(
>         struct bios_parser *bp,
> @@ -1076,9 +1077,10 @@ static enum bp_result get_ss_info_from_internal_ss=
_info_tbl_V2_1(
>   * of entries that matches the id
>   * for, the SS_Info table, there should not be more than 1 entry match.
>   *
> - * @param [in] id, spread sprectrum id
> - * @param [out] pSSinfo, sprectrum information structure,
> - * @return Bios parser result code
> + * @bp:      pointer to the Bios parser
> + * @id:      spread sprectrum id
> + * @ss_info: sprectrum information structure,
> + * return:   Bios parser result code
>   */
>  static enum bp_result get_ss_info_from_ss_info_table(
>         struct bios_parser *bp,
> @@ -1451,16 +1453,14 @@ static enum bp_result get_embedded_panel_info_v1_=
3(
>  }
>
>  /**
> - * bios_parser_get_encoder_cap_info
> + * bios_parser_get_encoder_cap_info - get encoder capability
> + *                                    information of input object id
>   *
> - * @brief
> - *  Get encoder capability information of input object id
> - *
> - * @param object_id, Object id
> - * @param object_id, encoder cap information structure
> - *
> - * @return Bios parser result code
> + * @dcb:       pointer to the DC BIOS
> + * @object_id: object id
> + * @info:      encoder cap information structure
>   *
> + * return: Bios parser result code
>   */
>  static enum bp_result bios_parser_get_encoder_cap_info(
>         struct dc_bios *dcb,
> @@ -1490,17 +1490,12 @@ static enum bp_result bios_parser_get_encoder_cap=
_info(
>  }
>
>  /**
> - * get_encoder_cap_record
> - *
> - * @brief
> - *  Get encoder cap record for the object
> - *
> - * @param object, ATOM object
> + * get_encoder_cap_record - Get encoder cap record for the object
>   *
> - * @return atom encoder cap record
> - *
> - * @note
> - *  search all records to find the ATOM_ENCODER_CAP_RECORD_V2 record
> + * @bp:      pointer to the BIOS parser
> + * @object:  ATOM object
> + * return:   atom encoder cap record
> + * note:     search all records to find the ATOM_ENCODER_CAP_RECORD_V2 r=
ecord
>   */
>  static ATOM_ENCODER_CAP_RECORD_V2 *get_encoder_cap_record(
>         struct bios_parser *bp,
> @@ -1557,8 +1552,9 @@ static uint32_t get_ss_entry_number_from_ss_info_tb=
l(
>   * Get Number of SpreadSpectrum Entry from the ASIC_InternalSS_Info tabl=
e from
>   * the VBIOS that match the SSid (to be converted from signal)
>   *
> - * @param[in] signal, ASSignalType to be converted to SSid
> - * @return number of SS Entry that match the signal
> + * @dcb:    pointer to the DC BIOS
> + * @signal: ASSignalType to be converted to SSid
> + * return: number of SS Entry that match the signal
>   */
>  static uint32_t bios_parser_get_ss_entry_number(
>         struct dc_bios *dcb,
> @@ -1608,10 +1604,10 @@ static uint32_t bios_parser_get_ss_entry_number(
>   * get_ss_entry_number_from_ss_info_tbl
>   * Get Number of spread spectrum entry from the SS_Info table from the V=
BIOS.
>   *
> - * @note There can only be one entry for each id for SS_Info Table
> - *
> - * @param [in] id, spread spectrum id
> - * @return number of SS Entry that match the id
> + * @bp:  pointer to the BIOS parser
> + * @id:  spread spectrum id
> + * return: number of SS Entry that match the id
> + * note: There can only be one entry for each id for SS_Info Table
>   */
>  static uint32_t get_ss_entry_number_from_ss_info_tbl(
>         struct bios_parser *bp,
> @@ -1679,8 +1675,9 @@ static uint32_t get_ss_entry_number_from_ss_info_tb=
l(
>   * There can not be more than 1 entry for  ASIC_InternalSS_Info Ver 2.1 =
or
>   * SS_Info.
>   *
> - * @param id, spread sprectrum info index
> - * @return Bios parser result code
> + * @bp:    pointer to the BIOS parser
> + * @id:    spread sprectrum info index
> + * return: Bios parser result code
>   */
>  static uint32_t get_ss_entry_number(struct bios_parser *bp, uint32_t id)
>  {
> @@ -1696,8 +1693,9 @@ static uint32_t get_ss_entry_number(struct bios_par=
ser *bp, uint32_t id)
>   * Ver 2.1 from the VBIOS
>   * There will not be multiple entry for Ver 2.1
>   *
> - * @param id, spread sprectrum info index
> - * @return number of SS Entry that match the id
> + * @bp:    pointer to the BIOS parser
> + * @id:    spread sprectrum info index
> + * return: number of SS Entry that match the id
>   */
>  static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_v2_1(
>         struct bios_parser *bp,
> @@ -1731,8 +1729,9 @@ static uint32_t get_ss_entry_number_from_internal_s=
s_info_tbl_v2_1(
>   * Get Number of SpreadSpectrum Entry from the ASIC_InternalSS_Info tabl=
e of
>   * the VBIOS that matches id
>   *
> - * @param[in]  id, spread sprectrum id
> - * @return number of SS Entry that match the id
> + * @bp:    pointer to the BIOS parser
> + * @id:    spread sprectrum id
> + * return: number of SS Entry that match the id
>   */
>  static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_V3_1(
>         struct bios_parser *bp,
> @@ -1767,10 +1766,11 @@ static uint32_t get_ss_entry_number_from_internal=
_ss_info_tbl_V3_1(
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
> + * return:   Bios parser result code
> + * note:
>   *  to get the GPIO PIN INFO, we need:
>   *  1. get the GPIO_ID from other object table, see GetHPDInfo()
>   *  2. in DATA_TABLE.GPIO_Pin_LUT, search all records, to get the regist=
erA
> @@ -2197,13 +2197,10 @@ static uint32_t get_support_mask_for_device_id(st=
ruct device_id device_id)
>  }
>
>  /**
> - * bios_parser_set_scratch_critical_state
> - *
> - * @brief
> - *  update critical state bit in VBIOS scratch register
> - *
> - * @param
> - *  bool - to set or reset state
> + * bios_parser_set_scratch_critical_state - update critical state
> + *                                          bit in VBIOS scratch registe=
r
> + * @dcb:    pointer to the DC BIOS
> + * @state:  set or reset state
>   */
>  static void bios_parser_set_scratch_critical_state(
>         struct dc_bios *dcb,
> @@ -2222,7 +2219,7 @@ static void bios_parser_set_scratch_critical_state(
>   * bios_parser *bp - [in]BIOS parser handler to get master data table
>   * integrated_info *info - [out] store and output integrated info
>   *
> - * @return
> + * return:
>   * enum bp_result - BP_RESULT_OK if information is available,
>   *                  BP_RESULT_BADBIOSTABLE otherwise.
>   */
> @@ -2372,7 +2369,7 @@ static enum bp_result get_integrated_info_v8(
>   * bios_parser *bp - [in]BIOS parser handler to get master data table
>   * integrated_info *info - [out] store and output integrated info
>   *
> - * @return
> + * return:
>   * enum bp_result - BP_RESULT_OK if information is available,
>   *                  BP_RESULT_BADBIOSTABLE otherwise.
>   */
> @@ -2509,7 +2506,7 @@ static enum bp_result get_integrated_info_v9(
>   * bios_parser *bp - [in]BIOS parser handler to get master data table
>   * integrated_info *info - [out] store and output integrated info
>   *
> - * @return
> + * return:
>   * enum bp_result - BP_RESULT_OK if information is available,
>   *                  BP_RESULT_BADBIOSTABLE otherwise.
>   */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
