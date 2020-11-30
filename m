Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0C52C90A3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgK3WIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729461AbgK3WIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:08:37 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5BAC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:07:51 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id z24so12896967oto.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rkYzGaKYtcgJzrd8rxQCICVltYGsIDYYTqDHFCgv/PE=;
        b=YaA8VRtUK+iIl6cBZe9uOR0+me09g6RYGUllwhAzQDLkqqpl5KL08khZ4MAYXhU6/E
         +kxdLVIEs0xGEw9yM8OKI+/11p22xgob+b7QPgLXcTvJYkoJo/SWwLBJRiT2zJgOqTTx
         LW6sQ67+Rucxk24VUNDUco20LAoTu55NMLVotn1zwPgKNWNOQPdMqZFCWq/Aksv4noUn
         KMBZfEWQDZx/Is2FljzzwadBdDJ+Xx5aehfTo9BRoRWH9bjsEHshzN1QJniFe3FMPfmL
         UgY+5Rt6Xk5bnRlcVg+KTet+dGuUrz6OaMApwyEshI78h9oKUUPCjk8JvgnZcHtokCf7
         fQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rkYzGaKYtcgJzrd8rxQCICVltYGsIDYYTqDHFCgv/PE=;
        b=GdDm5GeGJ8VUQsg4nzLuXOiNRNLPb0MIXUTPokC75AnUqbwnCaHf79EILMP0JPu/9G
         d7BIEIqdFuwTzNv26wTJnHPR1mPHLrpfG7LqOBzQuntQV/s3xqiLSp6m8B8/+C+MOS1H
         dCSh09HcmCHdOvV+EzvxBVgjXcjsSCDJr/kf7DsX6o6WtIUph4tG8kBU/q72EWKLnbqO
         DYfHurHIQPgqLI4CWhh0/Oe4QAy/o6iW99Jl0b7sZnDcJHZKfELWBM/Xv0tJBAFuEJCo
         N7YGr+d9XuZmUQbsRgEHQdl7dNiEBfgB5yoZdmUMNt5X6kx83gMeBn+4TbkCsPtWpoUA
         5JEQ==
X-Gm-Message-State: AOAM533oMquejm7wTnS2ffn0azY/zPtfJvMxpEvKXZL7HGvBsfdCy5Qe
        PNXrhLPUNULcMAkpy75VnsU5hxGiWqytNsNOpal2ktru
X-Google-Smtp-Source: ABdhPJz4qk7M7qbcN3RyX8GqU1TJ+GOMG5l8VivGV0OFD+K1aVBufZBR8oAnUQJ86amzXPJBV/ctHDCPMtf78AKwCIw=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr18699152otg.311.1606774070647;
 Mon, 30 Nov 2020 14:07:50 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org> <20201124193824.1118741-8-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-8-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 17:07:39 -0500
Message-ID: <CADnq5_PVL12Jp_vjTvxUd0VF=NbLoDQ0dOcHCP5PM1ngSKjo8A@mail.gmail.com>
Subject: Re: [PATCH 07/40] drm/amd/amdgpu/amdgpu_psp: Make local function
 'parse_ta_bin_descriptor' static
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 2:44 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:2576:5: warning: no previous pro=
totype for =E2=80=98parse_ta_bin_descriptor=E2=80=99 [-Wmissing-prototypes]
>
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 74cbaf2126982..910e89dc324b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2573,9 +2573,9 @@ int psp_init_sos_microcode(struct psp_context *psp,
>         return err;
>  }
>
> -int parse_ta_bin_descriptor(struct psp_context *psp,
> -                           const struct ta_fw_bin_desc *desc,
> -                           const struct ta_firmware_header_v2_0 *ta_hdr)
> +static int parse_ta_bin_descriptor(struct psp_context *psp,
> +                                  const struct ta_fw_bin_desc *desc,
> +                                  const struct ta_firmware_header_v2_0 *=
ta_hdr)
>  {
>         uint8_t *ucode_start_addr  =3D NULL;
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
