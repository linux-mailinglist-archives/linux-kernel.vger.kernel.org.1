Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87C12F88CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 23:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbhAOWu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 17:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbhAOWu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:50:27 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21213C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:49:47 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id cq1so5889771pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=mHS+GmDucuVisO7/TEIKfi2038F5W5ODOHM5tYty678=;
        b=KIRkJcB62OI+2gSE6B0ufJiUa28Y6UKuq9fPy1UoCciO5jav0Ztuag0JxecnytAY2P
         l/lEtv0dVpCj1nqy3Cc4Wy3L8Q+U6WDmPCKkEKkCQCfa1mLlFQdgjJiwWXxoeOhqspWM
         +1OdvbdwZio/ryV8i4EjzY52whHAHY6NDvtmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=mHS+GmDucuVisO7/TEIKfi2038F5W5ODOHM5tYty678=;
        b=t3IsgwGzemabjT5QgS1PLaOhYiMqgLQHr8PhJ0HLpg0/NTY1bU5DOrbz3w5UICFUP/
         kgx9IklP30lTNGJVjWmxWUNP6UAVqxx5EfwZsFToVly5my0Y68bXSTumxF7CZ07kffYG
         OiezhfCfPT+o31uola6FB1xM+ix41dDUp9iFvNG1/BszzFoIos4fMVcCYz7PUmuXUXne
         8Lx8ErxiVTW4k3bN/4/QRAKMO85GXD7yWo1myf7oDfF7UNdYZ0Wk6OJRZP4AoO95h/f7
         T7Cx+rOC7husv70WL5EmR63UqWMFhiwEqX1pSClmeAAThT5YttWryzlVCjSxC3kDeJEp
         MzkA==
X-Gm-Message-State: AOAM532IJen8mB+99vsLggjIWS6I/fojdp8eP+sVUIYWAta0Pgld5JZJ
        CNzo1l0TErAzmbuWqafl00/5cg==
X-Google-Smtp-Source: ABdhPJyjJRm3oaf7/luMsSHFrTDffSjqmbq1kECJBjrdlfTUC4wembCp33zmhSKebJduSqkkL3K4KA==
X-Received: by 2002:a17:90a:df0d:: with SMTP id gp13mr12897807pjb.151.1610750986716;
        Fri, 15 Jan 2021 14:49:46 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id w20sm5428344pga.90.2021.01.15.14.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 14:49:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210115144345.v2.1.I33fcbd64ab409cfe4f9491bf449f51925a4d3281@changeid>
References: <20210115224420.1635017-1-dianders@chromium.org> <20210115144345.v2.1.I33fcbd64ab409cfe4f9491bf449f51925a4d3281@changeid>
Subject: Re: [PATCH v2 1/5] drm/panel-simple: Undo enable if HPD never asserts
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Date:   Fri, 15 Jan 2021 14:49:44 -0800
Message-ID: <161075098468.3661239.7555919770669361287@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-01-15 14:44:16)
> If the HPD signal never asserts in panel_simple_prepare() and we
> return an error, we should unset the enable GPIO and disable the
> regulator to make it consistent for the caller.
>=20
> At the moment I have some hardware where HPD sometimes doesn't assert.
> Obviously that needs to be debugged, but this patch makes it so that
> if I add a retry that I can make things work.
>=20
> Fixes: 48834e6084f1 ("drm/panel-simple: Support hpd-gpios for delaying pr=
epare()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Nice catch on the unprepared_time

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
