Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245E72DA335
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408480AbgLNWRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440519AbgLNWRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:17:05 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090F2C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:16:25 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id p126so21018994oif.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WM4JTaOWR+p/2SnX/T6Ubb1JtGVXnGdSAPZvQi9TwAs=;
        b=E33Wwcn2VZlheQPh/e2AI0PBVpVWKwQ9BHgyfc49y+9i8ENejnto2+VLazx1l9KNkA
         R2jvpc5ltga6Xtd+ZECTQA4Cdqq1Jor7hp13MCT+wIHGXGFOwDSgetSUpoJ+vJcfnF7P
         BIXfHbL1md+r+1mI+evD4waGAtfXeHJe+LTCz9mpD9SsWD1oLu91JXEAA5F3R8cZ0qtU
         gPq/R5S0ct/5EdaZLj/EpVm6TbujpIzWMMWMgnknQj0OEBgXVFAnpDdnWcrek5ldN4G0
         +BTV3Kaj8EXJxpqbkjcMgCzm/q9OH9+Z7wOrXXcBdtAJLobnkyVeHI0QJ3G7ivr/e+2L
         eWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WM4JTaOWR+p/2SnX/T6Ubb1JtGVXnGdSAPZvQi9TwAs=;
        b=jBRCNZnKK0Eu4cQ8zQsfCDGuxKpG8Pk5ZR2EPEFDi1xBSt3xDwm7N4RERAskTVOh+w
         ADCj1AMKrFWxwW2gfjZwCv1BOBZwBNeDju0zdlGLpGuRI3czxcbpJSkGZFqZ58nR4TMS
         WhZwHxtCFh0TnQ+54M55O2taHlJEoNWzRYEBi4Tv/UKp52rcdkXjPZEciarAC4Dkogg/
         cMZKLNrlRW+GpgHdpng92g8lCYhQcyc9iQyIiWYqNY9PiwU9cDQv9pZi8SoOQJKXYygw
         TGQpBIYh/Me9r/eXFpBQigAjDmaQq3i0j37tgtbJldT1ngMzfZlAeu0pI9GVKNsmp5Ca
         aFIQ==
X-Gm-Message-State: AOAM530NUAkgQbhFQi5WuPXDna/xJgHL+/oI4kz32uEQqK3MHSvuOrqu
        fQuP+8ZDFPgknLeR1cX2ipNLO+haaS1ZeXaHG4k=
X-Google-Smtp-Source: ABdhPJwDhRQBEWCxbUkc4j66mNxq6TvusqyXVQtfSF5vOjZHgnrozxpuBaTXPock8HQDKiWwRZYCgIhpyTaEg9YV1Wo=
X-Received: by 2002:a54:4608:: with SMTP id p8mr19033063oip.5.1607984184497;
 Mon, 14 Dec 2020 14:16:24 -0800 (PST)
MIME-Version: 1.0
References: <1607784984-4542-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1607784984-4542-1-git-send-email-jrdr.linux@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 14 Dec 2020 17:16:13 -0500
Message-ID: <CADnq5_M4XT40efcLO=b2MKJumyu4e01+CPaUN5DwgrNvNAnD1g@mail.gmail.com>
Subject: Re: [PATCH linux-next] drm/amd/display: Adding prototype for dccg21_update_dpp_dto()
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Yongqiang Sun <yongqiang.sun@amd.com>, bindu.r@amd.com,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Dec 14, 2020 at 3:18 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Kernel test robot throws below warning ->
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_dccg.c:46:6:
> warning: no previous prototype for 'dccg21_update_dpp_dto'
> [-Wmissing-prototypes]
>
> Adding prototype for dccg21_update_dpp_dto().
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h
> index b7efa77..e44a374 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h
> @@ -32,5 +32,6 @@ struct dccg *dccg21_create(
>         const struct dccg_shift *dccg_shift,
>         const struct dccg_mask *dccg_mask);
>
> +void dccg21_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk);
>
>  #endif /* __DCN21_DCCG_H__ */
> --
> 1.9.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
