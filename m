Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCD429F0D6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgJ2QLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgJ2QLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:11:23 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A345C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:11:23 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id b4so1827331vsd.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0lmuE6RR3dhx0tK+loCxehAgyFNZWus4zKcvrq/a24=;
        b=c4n8wyrP3vlNQPilsWu9vKqsJGfZS8wahksMfrJ7rGMn9SebslvVzpHL1QvVP8Kkk0
         r15i5okYMIBlkgnrGCzn5fGybIoXW/2YDlB/3KynBPOYl7OxIWX67hWjnL+Rwr0Ngo2D
         3iMpMaHecSvq/RZDhhk4HqXoxDDD/X+SWxDnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0lmuE6RR3dhx0tK+loCxehAgyFNZWus4zKcvrq/a24=;
        b=GrJbADit2eOnCJGG4tSpZe1Yl4zWk5Q1REzC1sCGGpW4JtNICWCutz3jAmiAq4zahb
         xN5rQ8YT51c3vguexPK8TMqFQPMZuNvYk7Ek/0MMEE3hWa6OSDUPFBZ02KmOgbisuW65
         GK4KFT76Kuic1X254GmV8QhedVppr+X5YExAS3SB2pU9CM2lAT+UoJWKJ/mV073MufTL
         pqWulsEREXwdekqEBhvdZxSa4xn4CDqLJ7pjZONuPrlWAeaxom2nf8fK4QE0GKkNnNP8
         ogynlvkmjXAafjuu9vN5BWF4f563NI3t9udtwvcp3F6g49ip1hM5mGL112sZRFoJwZqc
         TtQQ==
X-Gm-Message-State: AOAM533TMvWk3LLbLQk+U+kqeseH0vP4kkkt7JdHBuXIt2iR/yvIE3t9
        tD/PaIyl6h3G7PR6t5yxNXOAgobUGPoMUg==
X-Google-Smtp-Source: ABdhPJyZfHGpS34kb8SOr2cGiVZ4aDP79rJ5shKwfo5zwzzqUNFrwf6BahYqn5amgt3GmcsyIHUcZQ==
X-Received: by 2002:a67:c90b:: with SMTP id w11mr3813137vsk.25.1603987882309;
        Thu, 29 Oct 2020 09:11:22 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id b15sm414581vsq.4.2020.10.29.09.11.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 09:11:21 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id t67so813908vkb.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:11:21 -0700 (PDT)
X-Received: by 2002:a1f:8d91:: with SMTP id p139mr3942003vkd.9.1603987880886;
 Thu, 29 Oct 2020 09:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201029011154.1515687-1-swboyd@chromium.org> <20201029011154.1515687-3-swboyd@chromium.org>
In-Reply-To: <20201029011154.1515687-3-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Oct 2020 09:11:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WWT=Pp4cyBvLfHSoNbR=aX_O5zaiErY--t0C9Fg-pNgg@mail.gmail.com>
Message-ID: <CAD=FV=WWT=Pp4cyBvLfHSoNbR=aX_O5zaiErY--t0C9Fg-pNgg@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/bridge: ti-sn65dsi86: Make polling a busy loop
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sean Paul <seanpaul@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 28, 2020 at 6:12 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> There's no reason we need to wait here to poll a register over i2c. The
> i2c bus is inherently slow and delays are practically part of the
> protocol because we have to wait for the device to respond to any
> request for a register. Let's rely on the sleeping of the i2c controller
> instead of adding any sort of delay here in the bridge driver.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> Cc: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Since we already did some early reviews off-list, it's not a surprise
that I have no comments.  ;-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
