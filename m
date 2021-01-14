Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3012F66CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbhANRHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbhANRHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:07:39 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B7AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:06:59 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id i6so5836075otr.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qh27w4Qu6OhsphukRi2VdyAK1mOAim2h716oUAliA58=;
        b=HHEJA648X5qusc4i+aD87hdFQH45LsBeTjJRRQel8OpeXFcsPqj63FFLti3Wt/cfoS
         SG9cViNZc9/XAFMRVqvOV9x2n9FikFlY3jugjFlgu0bkuy0KWWgatg7H3F64u3bI4Val
         bYK0Cem7CmuJeOCH8OLaH1l/jNd1QxZwUIxNNKbcUgkiwhqZJ2BJVDX8Ml+AR0JsELE6
         Ik1i4fIpKmFaD0ZI9bxeKJrkEI2TsLTpa78YUD8DyA2+jHbwsey8RS78jOFGL8Eq1gck
         it7SoEQJX7tc3XLybD5gcudk88BmZIS7mtKBRCINcD1QypnNQ0NgP47AwEo2PXhzcKsx
         kj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qh27w4Qu6OhsphukRi2VdyAK1mOAim2h716oUAliA58=;
        b=E8f/p5leIjk16EgYmIbV1ssEI4n/p49VfQO+CsbMES1Pq5PX7DSRodo4x53SP3KdAu
         dhAwjZVF47JMfA3I0qM/1JZCy52zR41INVWuHNBhuMipmqMXr/uZ6g1AlLIoROWsJ7Yx
         IpwPl+93vQPHkb48U4GBxTmP9tTRUuWw+StEohsHYGYc+Roay1x7BgPLl0MbZNG63zLn
         PrWYFeG3VYvjKqcKsCiu6DTU7AwIL1UQcU5puspyq8zgTeQfKpvecEuuysmkSv6pqCAu
         eJ2CiyxAzYOFjhrdMekEHk0EI+bj5cXPbcWQqugrdCS50C3ozGuTOvTTC8jDSbDQ8Ewx
         kFBA==
X-Gm-Message-State: AOAM532wVGbSrywvQIwf0M8mapGqaO0ULghOJEQ8gdq6TsejpTi/G+3X
        qMzwbwj0KDZAI42gjTzDFrFrNlpTjBi01dV+6Fs=
X-Google-Smtp-Source: ABdhPJwfwGMzERsPUfhKr73XbkTkP6/KnfFYpoFUS487anDPL56vBHJfWjFCM/j4aRke1Jsr1NrW+DT7LLtEbXALi9w=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr5260854otl.311.1610644019008;
 Thu, 14 Jan 2021 09:06:59 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org> <20210113080752.1003793-6-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-6-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:06:47 -0500
Message-ID: <CADnq5_NQ5dnb5B6_4TooYWrL6FU1ML_AiF6+h42=FM4atv=tZg@mail.gmail.com>
Subject: Re: [PATCH 05/30] drm/amd/display/modules/info_packet/info_packet:
 Correct kernel-doc formatting
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

On Wed, Jan 13, 2021 at 3:08 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/modules/info_packet/info_packet.c:=
412: warning: Cannot understand  ******************************************=
***********************************
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
>  .../amd/display/modules/info_packet/info_packet.c   | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.=
c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> index 0fdf7a3e96dea..57f198de5e2cb 100644
> --- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> +++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> @@ -409,16 +409,11 @@ void mod_build_vsc_infopacket(const struct dc_strea=
m_state *stream,
>  }
>
>  /**
> - ***********************************************************************=
******
> - *  Function: mod_build_hf_vsif_infopacket
> + *  mod_build_hf_vsif_infopacket - Prepare HDMI Vendor Specific info fra=
me.
> + *                                 Follows HDMI Spec to build up Vendor =
Specific info frame
>   *
> - *  @brief
> - *     Prepare HDMI Vendor Specific info frame.
> - *     Follows HDMI Spec to build up Vendor Specific info frame
> - *
> - *  @param [in] stream: contains data we may need to construct VSIF (i.e=
. timing_3d_format, etc.)
> - *  @param [out] info_packet:   output structure where to store VSIF
> - ***********************************************************************=
******
> + *  @stream:      contains data we may need to construct VSIF (i.e. timi=
ng_3d_format, etc.)
> + *  @info_packet: output structure where to store VSIF
>   */
>  void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
>                 struct dc_info_packet *info_packet)
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
