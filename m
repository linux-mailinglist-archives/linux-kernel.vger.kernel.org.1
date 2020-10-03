Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F0F28206F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 04:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgJCCM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 22:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgJCCM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 22:12:26 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EB4C0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 19:12:25 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l126so2659186pfd.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 19:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=wqgtfEXlK69O3zYlvUS0N2rx5d3DFBbOXqk2l3qB7HU=;
        b=XIxg1evKrFevIrvQhr+5Aqj7er8uo1//KQ7s3HsIxDzY8M2HtkvgKRTT7V/bJD3T7Y
         OpjJ3LR7c7x7oerT4nRF5mexVr4cc8QCxJIkTO5EiM2eUHz1IYALwHEibgaiRi33p/KV
         mYoAlKK5EzWQ9qAOsVNOp0fq4qgKPsl6l+Fw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=wqgtfEXlK69O3zYlvUS0N2rx5d3DFBbOXqk2l3qB7HU=;
        b=Q0nHpPEYe9uczrF/FHCKBcg63tiUOYcf+CbC7ynkxPIi/r7f534WXsxAyTING3WjOK
         mFT26k+jtpm8qw4TewmiZUVRr/Y0tSE3MWgCBChIMOcgF/4JBqznanI8N7cnbyChbKQ7
         diSBPrWfySW2bDsJ6lMPx1bHbHox+FIfr/dzFJ89R+IT24ekjbHeif3yMdEAYw3yqx3Q
         xw6gDkm6EeHonu+qvmpf//a/K6/vigeNBwey3ErdldZdGkUjvCW+QZ9H2zyMYi8XBvzT
         C0Da6VhE0peqVKEIr4oNvXq7OyaDUJxNAYCq/VAYMscJbJv+OsO2zACNVqWeJO8fsz6n
         FGSg==
X-Gm-Message-State: AOAM532TWGYmYruDUvJ4bSkpEI1rignBSe939aOhKqxgbs4ycCYglNa3
        1sdKNY8bQs16yGCoPII5BwXEfQ==
X-Google-Smtp-Source: ABdhPJzCGcXh/PpWofxiaZQnfeuTAnE6g8MPt67Opg9r0Sh3wV/qZ1llb4OZVm/VMVoIKcFZLG0gGg==
X-Received: by 2002:a62:1e07:0:b029:14e:d96c:9e04 with SMTP id e7-20020a621e070000b029014ed96c9e04mr5500869pfe.58.1601691145311;
        Fri, 02 Oct 2020 19:12:25 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id j12sm2950932pjd.36.2020.10.02.19.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 19:12:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201002220919.17245-1-khsieh@codeaurora.org>
References: <20201002220919.17245-1-khsieh@codeaurora.org>
Subject: Re: [PATCH] drm/msm/dp: fixes wrong connection state caused by failure of link train
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
To:     Kuogee Hsieh <khsieh@codeaurora.org>, robdclark@gmail.com,
        sean@poorly.run
Date:   Fri, 02 Oct 2020 19:12:23 -0700
Message-ID: <160169114309.310579.5033839844955785761@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2020-10-02 15:09:19)
> Connection state is set incorrectly happen at either failure of link train
> or cable plugged in while suspended. This patch fixes these problems.
> This patch also replace ST_SUSPEND_PENDING with ST_DISPLAY_OFF.
>=20
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>

Any Fixes: tag?

> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 52 ++++++++++++++---------------
>  drivers/gpu/drm/msm/dp/dp_panel.c   |  5 +++
>  2 files changed, 31 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 431dff9de797..898c6cc1643a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -340,8 +340,6 @@ static int dp_display_process_hpd_high(struct dp_disp=
lay_private *dp)
>         }
> =20
>         dp_add_event(dp, EV_USER_NOTIFICATION, true, 0);
> -
> -
>  end:
>         return rc;
>  }

Not sure we need this hunk

> @@ -1186,19 +1180,19 @@ static int dp_pm_resume(struct device *dev)
> =20
>         dp =3D container_of(dp_display, struct dp_display_private, dp_dis=
play);
> =20
> +       /* start from dis connection state */

disconnection? Or disconnected state?

> +       atomic_set(&dp->hpd_state, ST_DISCONNECTED);
> +
>         dp_display_host_init(dp);
> =20
>         dp_catalog_ctrl_hpd_config(dp->catalog);
> =20
>         status =3D dp_catalog_hpd_get_state_status(dp->catalog);
> =20
> -       if (status) {
> +       if (status)
>                 dp->dp_display.is_connected =3D true;
> -       } else {
> +       else
>                 dp->dp_display.is_connected =3D false;
> -               /* make sure next resume host_init be called */
> -               dp->core_initialized =3D false;
> -       }
> =20
>         return 0;
>  }
> @@ -1214,6 +1208,9 @@ static int dp_pm_suspend(struct device *dev)
>         if (dp_display->power_on =3D=3D true)
>                 dp_display_disable(dp, 0);
> =20
> +       /* host_init will be called at pm_resume */
> +       dp->core_initialized =3D false;
> +
>         atomic_set(&dp->hpd_state, ST_SUSPENDED);
> =20
>         return 0;
> @@ -1343,6 +1340,9 @@ int msm_dp_display_enable(struct msm_dp *dp, struct=
 drm_encoder *encoder)
> =20
>         mutex_lock(&dp_display->event_mutex);
> =20
> +       /* delete sentinel checking */

Stop sentinel checking?

> +       dp_del_event(dp_display, EV_CONNECT_PENDING_TIMEOUT);
> +
>         rc =3D dp_display_set_mode(dp, &dp_display->dp_mode);
>         if (rc) {
>                 DRM_ERROR("Failed to perform a mode set, rc=3D%d\n", rc);
> @@ -1368,9 +1368,8 @@ int msm_dp_display_enable(struct msm_dp *dp, struct=
 drm_encoder *encoder)
>                 dp_display_unprepare(dp);
>         }
> =20
> -       dp_del_event(dp_display, EV_CONNECT_PENDING_TIMEOUT);
> -
> -       if (state =3D=3D ST_SUSPEND_PENDING)
> +       /* manual kick off plug event to train link */
> +       if (state =3D=3D ST_DISPLAY_OFF)
>                 dp_add_event(dp_display, EV_IRQ_HPD_INT, 0, 0);
> =20
>         /* completed connection */
> @@ -1402,20 +1401,21 @@ int msm_dp_display_disable(struct msm_dp *dp, str=
uct drm_encoder *encoder)
> =20
>         mutex_lock(&dp_display->event_mutex);
> =20
> +       /* delete sentinel checking */

Stop sentinel checking?

> +       dp_del_event(dp_display, EV_DISCONNECT_PENDING_TIMEOUT);
> +
>         dp_display_disable(dp_display, 0);
> =20
>         rc =3D dp_display_unprepare(dp);
>         if (rc)
>                 DRM_ERROR("DP display unprepare failed, rc=3D%d\n", rc);
> =20
> -       dp_del_event(dp_display, EV_DISCONNECT_PENDING_TIMEOUT);
> -
>         state =3D  atomic_read(&dp_display->hpd_state);
>         if (state =3D=3D ST_DISCONNECT_PENDING) {

I don't understand the atomic nature of this hpd_state variable. Why is
it an atomic variable? Is taking a spinlock bad? What is to prevent the
atomic read here to not be interrupted and then this if condition check
be invalid because the variable has been updated somewhere else?

>                 /* completed disconnection */
>                 atomic_set(&dp_display->hpd_state, ST_DISCONNECTED);
>         } else {
> -               atomic_set(&dp_display->hpd_state, ST_SUSPEND_PENDING);
> +               atomic_set(&dp_display->hpd_state, ST_DISPLAY_OFF);
