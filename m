Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9A2294504
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 00:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438997AbgJTWP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 18:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438967AbgJTWP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 18:15:58 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9393C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 15:15:58 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w11so120104pll.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 15:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Byl068bSjplKbL4+PGKJ1dC619S+qOz8jD1tUz0XwHk=;
        b=KE+PETcp6MXxJp2h7R+7wX6TA7o0bnwOzHNuKMnSSWmLWLDVi3exXozEpC2/oJlQN8
         +KRIahNRWZR0vRBqf05eo1Ca/0Copjo/AjJwsptmk2Bqoyw0eP6VNszY2u4x5ZaFVSkZ
         BbyHVYsoDxQI619GGH5gKMoNNbSkLn0vaviZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Byl068bSjplKbL4+PGKJ1dC619S+qOz8jD1tUz0XwHk=;
        b=aVLfziGspTsMootoiGPTiaBYvHglkSHEjpor1UIBvJDPjtbF8UVvVLs2Om1q7WfyHd
         k5ZuLPImMQStczjeVOGCeB4gatyXTGaUZ5DzIstXMwVVusSfdadJVPVLCBsRNN20eKFd
         9Dq/HYDlcTa9Lb/vUavDYOrwxtUi/2zvTO5mlsoJ8FEF0Nd/5/fdHJxzUqUAATuInF1M
         DQuKpHk8jwymSmKM10/1jtxI+EUgouxDX6U21+CYzDUxUduBCEO87SnUHfE4UBhwzHlc
         6JbFJh14hpHt1bozNNoUjVoIklRovefx5tI6Fjlbi+Nc/WrzaoLMZr7lsIsUaOXSkYtK
         /Z0g==
X-Gm-Message-State: AOAM532M7KaPfyW5GYO39wuEBu6k3owqEz2azXWOsztx4DWhzTmRUKx7
        kr2Neo7/Bu0AfrsfpOBmlElOkw==
X-Google-Smtp-Source: ABdhPJyhGqquEURVzCUWjkxaXE1f4ZbyUwHjKWuvLzMw7wyKxAe9p8Ze3hRndsQEWKczhrZO5Thjvw==
X-Received: by 2002:a17:902:b7c3:b029:d4:bc6e:8aae with SMTP id v3-20020a170902b7c3b02900d4bc6e8aaemr269153plz.12.1603232158094;
        Tue, 20 Oct 2020 15:15:58 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id e196sm50988pfh.128.2020.10.20.15.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 15:15:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201020165959.7441-1-khsieh@codeaurora.org>
References: <20201020165959.7441-1-khsieh@codeaurora.org>
Subject: Re: [PATCH] drm/msm/dp: skip checking LINK_STATUS_UPDATED bit
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
To:     Kuogee Hsieh <khsieh@codeaurora.org>, robdclark@gmail.com,
        sean@poorly.run
Date:   Tue, 20 Oct 2020 15:15:55 -0700
Message-ID: <160323215566.884498.14018580767640192186@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2020-10-20 09:59:59)
> No need to check LINK_STATuS_UPDATED bit before

LINK_STATUS_UPDATED?

> return 6 bytes of link status during link training.

Why?

> This patch also fix phy compliance test link rate
> conversion error.

How?

>=20
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Any Fixes: tag?

>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 20 ++++++--------------
>  drivers/gpu/drm/msm/dp/dp_link.c | 24 +++++++++++-------------
>  2 files changed, 17 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 6bdaec778c4c..76e891c91c6e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1061,23 +1061,15 @@ static bool dp_ctrl_train_pattern_set(struct dp_c=
trl_private *ctrl,
>  static int dp_ctrl_read_link_status(struct dp_ctrl_private *ctrl,
>                                     u8 *link_status)
>  {
> -       int len =3D 0;
> -       u32 const offset =3D DP_LANE_ALIGN_STATUS_UPDATED - DP_LANE0_1_ST=
ATUS;
> -       u32 link_status_read_max_retries =3D 100;
> -
> -       while (--link_status_read_max_retries) {
> -               len =3D drm_dp_dpcd_read_link_status(ctrl->aux,
> -                       link_status);
> -               if (len !=3D DP_LINK_STATUS_SIZE) {
> -                       DRM_ERROR("DP link status read failed, err: %d\n"=
, len);
> -                       return len;
> -               }
> +       int ret =3D 0, len;
> =20
> -               if (!(link_status[offset] & DP_LINK_STATUS_UPDATED))
> -                       return 0;
> +       len =3D drm_dp_dpcd_read_link_status(ctrl->aux, link_status);
> +       if (len !=3D DP_LINK_STATUS_SIZE) {
> +               DRM_ERROR("DP link status read failed, err: %d\n", len);
> +               ret =3D len;

Could this be positive if the len is greater than 0 but not
DP_LINK_STATUS_SIZE? Maybe the check should be len < 0? We certainly
don't want to return some smaller size from this function, right?

>         }
> =20
> -       return -ETIMEDOUT;
> +       return ret;
>  }
> =20
>  static int dp_ctrl_link_train_1(struct dp_ctrl_private *ctrl,
> diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp=
_link.c
> index c811da515fb3..58d65daae3b3 100644
> --- a/drivers/gpu/drm/msm/dp/dp_link.c
> +++ b/drivers/gpu/drm/msm/dp/dp_link.c
> @@ -773,7 +773,8 @@ static int dp_link_process_link_training_request(stru=
ct dp_link_private *link)
>                         link->request.test_lane_count);
> =20
>         link->dp_link.link_params.num_lanes =3D link->request.test_lane_c=
ount;
> -       link->dp_link.link_params.rate =3D link->request.test_link_rate;
> +       link->dp_link.link_params.rate =3D
> +               drm_dp_bw_code_to_link_rate(link->request.test_link_rate);

Why are we storing bw_code in test_link_rate? This looks very confusing.

> =20
>         return 0;
>  }
