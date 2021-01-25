Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951A2302C8B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbhAYUbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732290AbhAYU3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 15:29:35 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EBBC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:28:42 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id m6so9092345pfk.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=YsfVmxDu5i68FdHZXdW8/k9FA/2TTh363mxFr7C7TK0=;
        b=ZGu20RKhKxE4PexNqACzZtv1RksHxEWqBczX5GDLh1PsMLN8NX5SDS6WThQcgrZIqT
         53IidItS5fYcc50usgIPbbtvQzp84SNPJutEKlWFKTpXb30RL/LLBJjm7iUYvT5PlBf+
         MJVTiBTlBWzrzK6IBfiPgD+cerHIO0rxpdVhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=YsfVmxDu5i68FdHZXdW8/k9FA/2TTh363mxFr7C7TK0=;
        b=mQnlwQrwQwG8fqbQUMl/+qTq3AeyehWCdERTLEdeKADeRdvQSJZMO6w46PtZiJ+nl8
         lqaLMgxXEwvDyn1CwYua58M2zZqM/vc1MpvCplVrTbwtR6y2gOK3figlmVejRpd1KH/n
         4I+w9BxxuB67wFlUkoofTkaAvPsN3SnXeuc8pP6h3Bc/ysOLPYb36K7Es2xtuCQ+QsV4
         AEtZNtYq8aTC/ioiW2RjaJ47Ll5cD41ZuKkwFGG+BzgUhYqoS/NywU3e9DnZcmqkNBNw
         iOIxFHHy2pm8CyE58AW1cpF8LDi4g8fwJ4wtghyhSeaiDBAOY9mA6Wj/2rXaGDaZWSXG
         GxKg==
X-Gm-Message-State: AOAM530kJdmpTAnJqYfFm9WNLsuAwRjZOXLiL2SW0cRpPS0K2KjdSmVL
        F+ycT8n+kf4tRNcZppr0wgatkg==
X-Google-Smtp-Source: ABdhPJyIhPoV2HHtfOFLPgRgtaa/aJaGbkRA7/2bGmeo8ltPc0Py+x0xMd4shudIUsH4tPOQ5j1KJg==
X-Received: by 2002:a62:1c97:0:b029:1ae:6d94:75c6 with SMTP id c145-20020a621c970000b02901ae6d9475c6mr1940373pfc.34.1611606522222;
        Mon, 25 Jan 2021 12:28:42 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:1066:b437:97cd:2278])
        by smtp.gmail.com with ESMTPSA id w20sm19101934pga.90.2021.01.25.12.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 12:28:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210115144345.v2.3.I6916959daa7c5c915e889442268d23338de17923@changeid>
References: <20210115224420.1635017-1-dianders@chromium.org> <20210115144345.v2.3.I6916959daa7c5c915e889442268d23338de17923@changeid>
Subject: Re: [PATCH v2 3/5] drm/panel-simple: Retry if we timeout waiting for HPD
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Date:   Mon, 25 Jan 2021 12:28:39 -0800
Message-ID: <161160651990.76967.1833069919954122114@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-01-15 14:44:18)
> On an Innolux N116BCA panel that I have in front of me, sometimes HPD
> simply doesn't assert no matter how long you wait for it. As per the
> very wise advice of The IT Crowd ("Have you tried turning it off and
> on again?") it appears that power cycling is enough to kick this panel
> back into a sane state.
>=20
> From tests on this panel, it appears that leaving it powered off for a
> while stimulates the problem. Adding a 6 second sleep at the start of
> panel_simple_prepare_once() makes it happen fairly reliably and, with
> this delay, I saw up to 3 retries needed sometimes. Without the 6
> second sleep, however, the panel came up much more reliably the first
> time or after only 1 retry.
>=20
> While it's unknown what the problems are with this panel (and probably
> the hardware should be debugged), adding a few retries to the power on
> routine doesn't seem insane. Even if this panel's problems are
> attributed to the fact that it's pre-production and/or can be fixed,
> retries clearly can help in some cases and really don't hurt.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> @@ -440,6 +441,31 @@ static int panel_simple_prepare(struct drm_panel *pa=
nel)
>         return err;
>  }
> =20
> +/*
> + * Some panels simply don't always come up and need to be power cycled to
> + * work properly.  We'll allow for a handful of retries.
> + */
> +#define MAX_PANEL_PREPARE_TRIES                5

Is this define used anywhere else? Feels like it would be better to
inline the constant and move the comment above the loop, but I guess
this is OK too.

> +
> +static int panel_simple_prepare(struct drm_panel *panel)
> +{
> +       int ret;
> +       int try;
> +
> +       for (try =3D 0; try < MAX_PANEL_PREPARE_TRIES; try++) {
> +               ret =3D panel_simple_prepare_once(panel);
> +               if (ret !=3D -ETIMEDOUT)
> +                       break;
> +       }
> +
> +       if (ret =3D=3D -ETIMEDOUT)
> +               dev_err(panel->dev, "Prepare timeout after %d tries\n", t=
ry);
> +       else if (try)
> +               dev_warn(panel->dev, "Prepare needed %d retries\n", try);
> +
