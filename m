Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4AC2732E5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgIUTdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgIUTdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:33:33 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A46DC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:33:33 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x23so610350wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tyqvRKFdtD8PMSb4v0LigIpVlIKZ32P+rPNhgG6iABo=;
        b=dTQiKQxbEPtUs+n52KETE43PkUq3kWFrLO2K1V7yfsGbLkbhi33Nye5NJcd55y9s1A
         PLJXb0CAjqa96NUyoZWQsPEE10VwZp5yypF+Xf6vj9/UpaHGw1sl9gwqVIirXEkML9S6
         lZcCbV/WEIlkz89V3iJoIMIUfAfUagbDJ5BqRkpk5/nbLEVvvHczBJ+h+lful/czbpGo
         dHLKeKsD0Mqp3Yy8ZqDR7l3a/fEC72RgaA4Qv0ugdP2g1L97jDJ1cjk1nc6s0oi5tJIo
         hVrlfA4JLKhhBSgn+4uQWkdsXUDBndi+CJTtwQN3ING5Wl9XdZeT1N8Z7WpbyZMmatCu
         d+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tyqvRKFdtD8PMSb4v0LigIpVlIKZ32P+rPNhgG6iABo=;
        b=lWGJnriw3RFWEk+4Sw4a27BDh61ksOKA4ssHl6H4BzBgpR4FEO22flSY6VNh2WvRDW
         Omt/JrfEjGmuzDYbYrWAYlaMCEJ8LkfuxZ8MlvARFvuCR25K7vpCkBRRceH10+ojcCEl
         N6R36hc77AyT8bZuQGMZfScRogWm6ep2fUjyv79OZRxgddSZ45wBrIYvrBOWggagniNj
         zgHBYNNqU28xXyLSYrrXlTlH+dVaPe4QcKBe6GUw4To7TLflqfLJVg5Axcmv0vPvK+nz
         hxGrV5ZNLOm2/9qhNx7SMGyFvz8VEIBjC+CSocdikZpDipUPIco28TgAvRQOeinZgDHv
         FXTw==
X-Gm-Message-State: AOAM532Pa6mFUsRO3u2z6He9e3AT5X+w0498wdbA70HKKUlBD5xsE1fF
        uFpjdi81DOuY15FQ8sGv1c6ud41MMq3Rrp6+mOU=
X-Google-Smtp-Source: ABdhPJz9ExPKuXj4QoQ/WsmFt1o/wLN8n6bfP18yT+wpV/WCvYVUcTDZXQdaVyPM7AYXRszBry3ZzoSD0AdJ9D+X3Ao=
X-Received: by 2002:a1c:a953:: with SMTP id s80mr885650wme.70.1600716811772;
 Mon, 21 Sep 2020 12:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200921114244.20506-1-bernard@vivo.com>
In-Reply-To: <20200921114244.20506-1-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 21 Sep 2020 15:33:20 -0400
Message-ID: <CADnq5_PJrpJpPjexVpN-r_9XZbKDS3NnQ=dBS5RdO1NYjw+8uA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: optimize code runtime a bit
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Jun Lei <Jun.Lei@amd.com>, Aric Cyr <aric.cyr@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        abdoulaye berthe <abdoulaye.berthe@amd.com>,
        Michael Strauss <michael.strauss@amd.com>,
        Brandon Syu <Brandon.Syu@amd.com>,
        Martin Leung <martin.leung@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 9:14 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> Static function dal_ddc_i2c_payloads_destroy is only called
> in dal_ddc_service_query_ddc_data, the parameter is &payloads
> , there is no point NULL risk, so no need to check.
> This change is to make the code run a bit fast.
>

How about just getting rid of dal_ddc_i2c_payloads_destroy() and just
call dal_vector_destruct() directly.

Alex


> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
> index b984eecca58b..6dcc666738fc 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
> @@ -150,9 +150,6 @@ static uint32_t dal_ddc_i2c_payloads_get_count(struct i2c_payloads *p)
>
>  static void dal_ddc_i2c_payloads_destroy(struct i2c_payloads *p)
>  {
> -       if (!p)
> -               return;
> -
>         dal_vector_destruct(&p->payloads);
>  }
>
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
