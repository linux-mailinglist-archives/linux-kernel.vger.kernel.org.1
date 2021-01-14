Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC852F6711
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbhANRLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbhANRLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:11:33 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DB3C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:11:18 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id a109so5869178otc.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NfiPn9PLaQKtUN6T1QDFoz96DhnMF0UCTa6RtqwvtD8=;
        b=PGJ7IOgGNfDdVkNbift3flxymeO6Z2LGjXmEa0DHJKFbpQHW6fNXVZiOOe6FUhoyw7
         43wJNtuMpFcpqp6v+Rl7t6Z3SePMNN11KRLrpwZcWwwPwdfOfQgOMdoXp9j/uLC9qkCh
         pchZ6z0e0SvQNBGB6oSslbbPc2ZOk6Na1QCe+KCTWI2Px+yLgApMaUtLoc+JceSvwhnW
         ahDI3jEjDQVD7T5his3mMKxwu1Psx66XT3+ZNLzrxT6lzo8eMxumgl5rnDk/e2uRhvGf
         bS66Yt2sCdUKnSjT0gsG00sYQroUE+xzZEIPWwU48nD1cq3k1ORAGt6ohRaYKSTtQozh
         W4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NfiPn9PLaQKtUN6T1QDFoz96DhnMF0UCTa6RtqwvtD8=;
        b=bca/T86W/yb7M6MVjtlLsTQ4Mm+CfjqjPwYYog7C3cZxqfvqPmfnXUsiwc+SqHU74Z
         9XkV59T+BLAq8KH5mtF0BpNEyed/jcGjNKLKckA+ZYYtE8OyPY4aciIyNc39y9jCIcEE
         7T581kFN2AKlnYjjcpJH+BXkmQvEmez5ef8hln2SDCKfvIUPbo+hb3IJkbQ94WM064pe
         F7lKZMRaLZAoOIt2Z+72lH6CdRl8M5d1aA7FxWOnpIw3x7Z31XIRNm4lKlI9vLH1hdaW
         b38g801lcDcBIYlLvqv520FtL5qADHw7fB/7/InCTfK4q2SMzlEb70HQaAyMEYRgNY2I
         XrRA==
X-Gm-Message-State: AOAM530obc3pM4K91h2DfzDIYTi5bTqMltiUVq6Kn5qpGCOCV2TTEO77
        wJOWWsN1WvNRtR5IdJUu2OdHxTk52pi7Q6dNVjQ=
X-Google-Smtp-Source: ABdhPJzoUTQGcSw614Y41hTX+kKqaPEG+iqQ99MRM6XTrh1EXkI6DKDjcxehgC2LC+xMaoLB6U6s71UYy0zTaVLSNF4=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr5278877otl.311.1610644277946;
 Thu, 14 Jan 2021 09:11:17 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org> <20210113080752.1003793-11-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-11-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:11:06 -0500
Message-ID: <CADnq5_PR-huyKKLFm0Z74SE-CH51cJnDrhWywSJ=3bDicqbRqA@mail.gmail.com>
Subject: Re: [PATCH 10/30] drm/amd/display/dc/core/dc: Staticise local
 function 'apply_ctx_interdependent_lock'
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:806:6: warning: no pr=
evious prototype for =E2=80=98apply_ctx_interdependent_lock=E2=80=99 [-Wmis=
sing-prototypes]
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
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/a=
md/display/dc/core/dc.c
> index 8f1cadb823c71..0a07e608485ff 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -803,7 +803,8 @@ static void disable_all_writeback_pipes_for_stream(
>                 stream->writeback_info[i].wb_enabled =3D false;
>  }
>
> -void apply_ctx_interdependent_lock(struct dc *dc, struct dc_state *conte=
xt, struct dc_stream_state *stream, bool lock)
> +static void apply_ctx_interdependent_lock(struct dc *dc, struct dc_state=
 *context,
> +                                         struct dc_stream_state *stream,=
 bool lock)
>  {
>         int i =3D 0;
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
