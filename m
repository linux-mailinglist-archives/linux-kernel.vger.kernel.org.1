Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DAE2F7060
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 03:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbhAOCKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 21:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbhAOCKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 21:10:25 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B44C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 18:09:44 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id i7so5036867pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 18:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=dannooC+A5LWkd3Ac8LXRquK9ciYe/oflIGuwcSGfTA=;
        b=obhcRYWu1TQQF/rfqb1MHAvpWn0lWgr5DV/FVMgO4R3PA6AqHp2JDcWe+z4aqaw8fG
         /z8NKxNFYn8UgxEbuiYJic06U6Tu8UtcaGGEA6+AY2Qwl59QA1dAk0S5OOrOHS1GKtAj
         fizvuhKMBbE7LzFBCtiT/HpDf/7ImkRfbEuD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=dannooC+A5LWkd3Ac8LXRquK9ciYe/oflIGuwcSGfTA=;
        b=undW0B9dCrvs0b1yPNmiVjGmMvoleUfNuAbEpCB5O5JNmwxc/0fJOWMVhhZaOJl/A/
         3IRP9DkV74NoKb4o3XI4w4GK1kitcG0urfIbs8Qf1VnpaPVUazuzZEspt/npMbG2kWge
         CtxtQqlLciGZQHZ48DY5uzN8fUiytFzYJDT8RGsbHEg8H9vqxgNbZvgraHZpIk2BdSud
         ye2rzwpzHZ/8PS21TNyf1w9WIn1Fn72vV/9YsZb8PTW9ypmZ5fqoV7JYHJ6LqjdufbC1
         l+z5R9Shv1uksnfC2sQSdb1+Hp04s4uAqSs+BGemq7qIOBG81LJEgWIewNKdL3OIXVkZ
         aqsA==
X-Gm-Message-State: AOAM532RMVCuHvh5mhqKcJ1DX98NkFRC9XcO7tZKd0O5hAAQaSyHwc/3
        k1U1pD0l3i7xrSkPBakSH9J0og==
X-Google-Smtp-Source: ABdhPJyWGZRCJiQNQl64uo7yCE8fHw8Vw4JwrWpDJL+EJJpEiGsGhi5X4/dekyMOyA8SjfJJ153MMw==
X-Received: by 2002:a63:da4f:: with SMTP id l15mr10386961pgj.22.1610676584423;
        Thu, 14 Jan 2021 18:09:44 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id w11sm6721197pge.28.2021.01.14.18.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 18:09:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210114172254.1.I33fcbd64ab409cfe4f9491bf449f51925a4d3281@changeid>
References: <20210114172254.1.I33fcbd64ab409cfe4f9491bf449f51925a4d3281@changeid>
Subject: Re: [PATCH] drm/panel-simple: Undo enable if HPD never asserts
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
Date:   Thu, 14 Jan 2021 18:09:42 -0800
Message-ID: <161067658243.3661239.4774914368205323276@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-01-14 17:22:59)
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

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
