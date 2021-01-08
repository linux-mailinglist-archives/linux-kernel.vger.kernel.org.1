Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0062EFA0A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbhAHVNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbhAHVNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:13:31 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43481C061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 13:12:51 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id j12so11020858ota.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 13:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JJ7FtiwBdYxXEh8WTGbXJJZhJ5AF6r7OSPZfRoUJmbA=;
        b=LV850xJ1SGbsWlLhv8SIykiIbw9fs5VaMD9pKjRweE8Eti1DFJv2/pk8tcISWTigx8
         MPAV5GXtXuwPzojP3r96HnS2qqufjcMoO+vhcC2T8rP6IFqhacZKP0ieAzAxsT3VALtG
         KrPnaNQAk9Qifjv0mXajdpUq7t8eywv+W6CxHg2wfk3IKD/67Fwm82YSrlcJe1DS7dZ6
         EZU8HZbJ91JNYwsecSSDy/Lfj6TsP/amSBMKbrmXPV1USYh1051n9tc5yvW9ee7Mn73j
         ohrKl34VSC9m4ehA9cI+Ai8ZFoKtA+TKOBNaPA7bp890zfyPVOdjLpi3UWGm0tNb8A8a
         +ZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JJ7FtiwBdYxXEh8WTGbXJJZhJ5AF6r7OSPZfRoUJmbA=;
        b=kfXv3KEF/cbtDBBozPY1Fy14T+u7heEbMJLaB1VxP38+RSq6rYIypVz599F4yye/pH
         P8bpDL37tqrGCE/TnN4Z9amV094AJLLZZGsPOZJ+PSo6PX+dx+kO/34WpzWaoDS8rbJe
         nbcmJiEb9bI658A9YbF6mUnGL+PbLTe8xzKH/EaQQW3B7GrzSeDuF+1E8MD2Jr1aXSvY
         zQZv4rL4bJ1I64QLreXWXYxk2SdTLW7qHLASgC75LXmq+iLeQf2CRCtri6SNrCroYqx3
         9IGBHh4ZoZJ288swZX1Js3jpk1kMAb1Oawr2sTcUC8PQTCdhkdL8yef21iEO9JtOuSUi
         K7qg==
X-Gm-Message-State: AOAM532d/VqPwqHW1eA3TE+I1SGe4ryzDTSedJRxWx5WYwvdy3EfVNSI
        leyBbgRnR4k3xQVamORfBIgJ0t5MI0dBWlvyGEw=
X-Google-Smtp-Source: ABdhPJzrBa4Bvb1LKElVzhupUsk6Q/8zoZrXDIzXdCWtWEIJ1Yta2gOeFScrPIl0sOQKAISGtTXXGlnj+i16KlyBjds=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr4077667ote.132.1610140370752;
 Fri, 08 Jan 2021 13:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-25-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-25-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 16:12:39 -0500
Message-ID: <CADnq5_NMmop3fFb3vy1QS_wEjNCmwkzjn+aTMd0S45GkKpiCpw@mail.gmail.com>
Subject: Re: [PATCH 24/40] drm/amd/display/dc/dce/dce_stream_encoder: Remove
 unused variable 'regval'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Eric Bernstein <eric.bernstein@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        George Shen <george.shen@amd.com>,
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.c: In fu=
nction =E2=80=98dce110_update_generic_info_packet=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.c:70:11:=
 warning: variable =E2=80=98regval=E2=80=99 set but not used [-Wunused-but-=
set-variable]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: George Shen <george.shen@amd.com>
> Cc: Eric Bernstein <eric.bernstein@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/dr=
ivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> index ada57f745fd76..265eaef30a519 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> @@ -67,7 +67,6 @@ static void dce110_update_generic_info_packet(
>         uint32_t packet_index,
>         const struct dc_info_packet *info_packet)
>  {
> -       uint32_t regval;
>         /* TODOFPGA Figure out a proper number for max_retries polling fo=
r lock
>          * use 50 for now.
>          */
> @@ -99,7 +98,7 @@ static void dce110_update_generic_info_packet(
>         }
>         /* choose which generic packet to use */
>         {
> -               regval =3D REG_READ(AFMT_VBI_PACKET_CONTROL);
> +               REG_READ(AFMT_VBI_PACKET_CONTROL);
>                 REG_UPDATE(AFMT_VBI_PACKET_CONTROL,
>                                 AFMT_GENERIC_INDEX, packet_index);
>         }
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
