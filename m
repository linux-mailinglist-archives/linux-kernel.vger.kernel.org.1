Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FF82F2022
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391207AbhAKT4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391163AbhAKT4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:56:01 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58281C061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:55:21 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y8so56833plp.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=x1kEK/qhNdROptR6SyV1mmKseA6+oUbWg4LW5g3LzE0=;
        b=hRnDQcZQXrF7xHbgGwWWWW+3sdndqXrcQ+SW4lu0ULqzpK81pHZW3zcA4U8UxHDh/r
         QPL4v1rIH6LCKv55YiBpMJxl8YhCuB6MSZjjS/p8D0VZ4SNnck2ldoIo26/q1LxeqOlx
         64kowb2YDUHl2pAU/Wiz70Ddg5B8xFYlA5Rcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=x1kEK/qhNdROptR6SyV1mmKseA6+oUbWg4LW5g3LzE0=;
        b=ehjvdFbY2+vRR70sZmNi9bkq03zSUm6LWoKDM1M26SSyjLFNmI3EzJL0PSXVIOExvJ
         p7cYgVcGPoNC0KEQH+73XcwxyTgJqN/YcrDGiYc7R1tA6CDKGIgj4Lw55P2KMB0ChYys
         Nk3PyemycUXDRRLNOwrfl4fMYDreOBUjwu89zcwqcoCYbbsycxsyzUu9CVUGRrZAldg4
         zAiQ/UDbWLbqchBdjZTPrQQd5TcMFv/ThZT7WT5BWVEBYFVzNr2f6+juQMmMnbfYi0hT
         aoTD1b0NdfGbdA9e0VWaE7FAPoTFmfZPxDmPXCpaApDUVBZyIAvaABzbNFI/eoP8RHdd
         7Zcw==
X-Gm-Message-State: AOAM531wLDXx1NFB2hkV/+OgUqf1humxcKsdn7M4nFOxy/KwPz+ZPNGa
        sXewf9vShVAX7eQYtHZr//FYNA==
X-Google-Smtp-Source: ABdhPJzc4P554z1bLWeSmnfZa/mKVXF6a1Yj65oFD7L91wgvOd94GvhF8PnuSgnP7DhqQAen3NX7IQ==
X-Received: by 2002:a17:902:7001:b029:da:bbb6:c7e2 with SMTP id y1-20020a1709027001b02900dabbb6c7e2mr932791plk.50.1610394920963;
        Mon, 11 Jan 2021 11:55:20 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z15sm443642pfn.34.2021.01.11.11.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:55:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1610051425-20632-2-git-send-email-khsieh@codeaurora.org>
References: <y> <1610051425-20632-1-git-send-email-khsieh@codeaurora.org> <1610051425-20632-2-git-send-email-khsieh@codeaurora.org>
Subject: Re: [PATCH 1/2] drm/msm/dp: postpone irq_hpd event during connection pending state
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Kuogee Hsieh <khsieh@codeaurora.org>, tanmay@codeaurora.org,
        abhinavk@codeaurora.org, aravindh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Kuogee Hsieh <khsieh@codeaurora.org>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run
Date:   Mon, 11 Jan 2021 11:55:18 -0800
Message-ID: <161039491877.3661239.1387205899512360969@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-01-07 12:30:24)
> irq_hpd event can only be executed at connected state. Therefore
> irq_hpd event should be postponed if it happened at connection
> pending state. This patch also make sure both link rate and lane

Why does it happen at connection pending state?

> are valid before start link training.

Can this part about link rate and lane being valid be split off into
another patch?

>=20
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Any fixes tag?

>  drivers/gpu/drm/msm/dp/dp_display.c |  7 +++++++
>  drivers/gpu/drm/msm/dp/dp_panel.c   | 12 +++++++++---
>  2 files changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 6e971d5..3bc7ed2 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -693,6 +693,13 @@ static int dp_irq_hpd_handle(struct dp_display_priva=
te *dp, u32 data)
>                 return 0;
>         }
> =20
> +       if (state =3D=3D ST_CONNECT_PENDING) {
> +               /* wait until ST_CONNECTED */
> +               dp_add_event(dp, EV_IRQ_HPD_INT, 0, 1); /* delay =3D 1 */
> +               mutex_unlock(&dp->event_mutex);
> +               return 0;
> +       }
> +
>         ret =3D dp_display_usbpd_attention_cb(&dp->pdev->dev);
>         if (ret =3D=3D -ECONNRESET) { /* cable unplugged */
>                 dp->core_initialized =3D false;
