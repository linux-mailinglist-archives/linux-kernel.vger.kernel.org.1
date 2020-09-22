Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9E227459C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgIVPmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgIVPmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:42:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD70C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:42:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a17so17589393wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5zqe84Nk1UowCxWHEiI4DgdqPuTuGGYYmgeHmTBq0fk=;
        b=uHadmq3Kz2/+CUFAUGs/3cB8L1OaAkv/I+ZV8ZYzgFHRz2FsDq65zy5S8iqf3cN4jq
         8h9cAwvHa8idmrrH4ZpHw1qPEGpcxVIHNCr9NuY1vRhvhNLIJ9lNCMc5DviJQy8oqsEb
         NnR1rL3ma/9uNi9Hopsfs7oqbz7Grs20FVqgFW9MP9ofBiFG7xBQVGzLAVNu8oAXq9PM
         7jk9wJrr4275SyylH/FxyBzL9A6nhdiQ8VXpM8/xky2R8GqWrHPVZ1KjbxF5JEVsKROb
         VUJTVVwj1zfHyeWUk3mGkDKhWSQXET8j28VgkEsnu9DXm0ba1gLO0Y2z3t9fmfygxOHJ
         49TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5zqe84Nk1UowCxWHEiI4DgdqPuTuGGYYmgeHmTBq0fk=;
        b=YwnfrYaUf10bJ1EfYKWIm+Ei2SkCiCqeWrr7hT+HJ04Jc31XQiVVkLEvldGHnG3ZcY
         cKYw7d+2XQUGXLLGRceOyiVJ71xfuh7WkCUGpb7quPf5e0dtWDPZ5Z1TGFaleYqXd56y
         B49D6VyskJy2V1AM3O7N0pB4r9CkK1+WUvdNuheI8vvanzQ2SVd052zNFL5xehx2HJob
         +fAbP2Y9STvIJNBCS5XFKi7khX+ErWdt0FXGUifd13Fxg80+yeoqUIJ78QWDVoZKsHR9
         5aTNIwFpCJ42+OAeKu4LznXbbzbWdWTWVkLSk7pYtoT5xLWl0kdp5lJhP56xad5gvEXG
         Vu0A==
X-Gm-Message-State: AOAM5334hyBdMciiNnGOo1qsvxyYKAqma59n0UnL6mm0syjts+FwBWw0
        oXGPpvwIeOjNdoST+MddMfILZQpHmGuY33nS0rc=
X-Google-Smtp-Source: ABdhPJxF6Yvtfum2cD2X7jpiXkb4a9Vmy8ViEa3nivHp1A5xnwW3JO/PQV7tnrzLGN7mG0h8o9ULIacpXRoA7QLPSAg=
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr6081863wrr.111.1600789365196;
 Tue, 22 Sep 2020 08:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200922021106.24733-1-bernard@vivo.com>
In-Reply-To: <20200922021106.24733-1-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 22 Sep 2020 11:42:34 -0400
Message-ID: <CADnq5_OrnViA+RQkkrmTuBFkuK++yPY4Mhmp4grEuKzJiOmAEg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: optimize code runtime a bit
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
        Brandon Syu <Brandon.Syu@amd.com>,
        Michael Strauss <michael.strauss@amd.com>,
        abdoulaye berthe <abdoulaye.berthe@amd.com>,
        Martin Leung <martin.leung@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Tue, Sep 22, 2020 at 3:52 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> In the function dal_ddc_service_query_ddc_data,
> get rid of dal_ddc_i2c_payloads_destroy, call
> dal_vector_destruct() directly.
> This change is to make the code run a bit fast.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> Changes since V1:
> *get rid of dal_ddc_i2c_payloads_destroy, call
> dal_vector_destruct() directly.
>
> Link for V1:
> *https://lore.kernel.org/patchwork/patch/1309014/
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
> index b984eecca58b..dec12de37642 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
> @@ -148,14 +148,6 @@ static uint32_t dal_ddc_i2c_payloads_get_count(struct i2c_payloads *p)
>         return p->payloads.count;
>  }
>
> -static void dal_ddc_i2c_payloads_destroy(struct i2c_payloads *p)
> -{
> -       if (!p)
> -               return;
> -
> -       dal_vector_destruct(&p->payloads);
> -}
> -
>  #define DDC_MIN(a, b) (((a) < (b)) ? (a) : (b))
>
>  void dal_ddc_i2c_payloads_add(
> @@ -582,7 +574,7 @@ bool dal_ddc_service_query_ddc_data(
>                                 ddc->link,
>                                 &command);
>
> -               dal_ddc_i2c_payloads_destroy(&payloads);
> +               dal_vector_destruct(&payloads.payloads);
>         }
>
>         return success;
> --
> 2.28.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
