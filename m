Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D212C9387
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbgLAABk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgLAABk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:01:40 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDE1C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:00:59 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id o25so16261458oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vwAi3j5hKUR5I3v6aaEnj4yZwa+jhIFvRIVmx73mGr4=;
        b=OccpJsDXy6hPItda+235fnSn3RIRuNx9jcOkicT3aqwbLaSal8DSKc8M2vcptYVgCF
         LTFJv5PqxAH9vQDm094SUFW1SAXEYcKoW2Z3tm3KjcoBon8LFhGAUQEj/iH94aR87SkU
         irGBc0VvtBPN3DGph717/v2k3wX5I3qWlT7YOsFG5x0kv8xRYVmXuU7qn2P7chMDDr+w
         ER1dwbim9HiWDTd+F6KiLbsoKmdoRfg5e+i6Kuzekxm5q3SGigkz0Gkvm3r/YCMdFgI/
         gbwAyHrRcaYoPjDLW/8W9MydFstmDKcBez1zQXXbyYfv5Uo1x/bVxqP+V+rThVwYcjFY
         d+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vwAi3j5hKUR5I3v6aaEnj4yZwa+jhIFvRIVmx73mGr4=;
        b=oTE1bflYYjI2mtNRefZQwF4TqMUkF5NCVu0QRKfrmFAcYaTJV4y/7p2tQCsfTO+BD5
         LO67WyI1HG+yEVpmKyCHOoFyhuoofo50uPagRUHthMXAV+9xpXUXUeAPOwfGwmdvmlvM
         8zC6yrU2rmD0+kh3wgaYrodjxEvjcAIgCJfilxOKETvaLeeSGrfPmJM/S/ldWAbqN+k3
         PZTx9otV6SCMGRcgJTw0shO6XLu7KwXFUteklIPv66sABIUPCYHtmeCpXDTxqBiVvPZO
         2wbsLyh8+F/lGwsRECLdjZAYIqrLtvh4VgiI3VUV1WtjFd9EnSxxg9p5rf88uyjuUf23
         1FGQ==
X-Gm-Message-State: AOAM533hojCst09ShyDenDDHHS+H8dPdvDrM21/qHPUoYavhMg4vdD/Z
        Ap64VRwSavk3PnbrHeqqpY7HGX7qkuemrceNkNE=
X-Google-Smtp-Source: ABdhPJx5EW3BogA2TAlZ64hzqIRBxOKmP654oJ/bpQBGF7Yyxc8Qa/aoJ30NVr2vA++NbUaH/yizaWY2sbRPKMRxuHs=
X-Received: by 2002:a54:4608:: with SMTP id p8mr28704oip.5.1606780859215; Mon,
 30 Nov 2020 16:00:59 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-34-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-34-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 19:00:47 -0500
Message-ID: <CADnq5_OoA_mGiDmW=P4CW-KYNsR9W2Fu8uFwXzm_mQGBTJqkKQ@mail.gmail.com>
Subject: Re: [PATCH 33/40] drm/amd/display/dc/inc/hw/dpp: Mark
 'dpp_input_csc_matrix' as __maybe_unused
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

On Thu, Nov 26, 2020 at 8:43 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> 'dpp_input_csc_matrix' is used by some, but not all source files which
> include dpp.h.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/inc/hw/dpp.h:50:42: warning: =
=E2=80=98dpp_input_csc_matrix=E2=80=99 defined but not used [-Wunused-const=
-variable=3D]
>
> NB: Snipped lots of these for brevity
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
>  drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h b/drivers/gpu/dr=
m/amd/display/dc/inc/hw/dpp.h
> index 6751186f6f904..ddbe4bb52724a 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
> @@ -47,7 +47,7 @@ struct dpp_input_csc_matrix {
>         uint16_t regval[12];
>  };
>
> -static const struct dpp_input_csc_matrix dpp_input_csc_matrix[] =3D {
> +static const struct dpp_input_csc_matrix __maybe_unused dpp_input_csc_ma=
trix[] =3D {
>         {COLOR_SPACE_SRGB,
>                 {0x2000, 0, 0, 0, 0, 0x2000, 0, 0, 0, 0, 0x2000, 0} },
>         {COLOR_SPACE_SRGB_LIMITED,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
