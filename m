Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993D729F0DB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgJ2QLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgJ2QLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:11:50 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E33C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:11:50 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id f4so1814377vsk.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MpdXRaHjhy22m2xPQ/mv08yTyf2gnU4AXsIatzMELM8=;
        b=YD5e3dH5w4KeVngaPn/rXDpipIyZ4twtKANlVvMnENs7daGWmLLAebfeBr4D+owVvo
         JmJN8bzwRSoSNY19EkWT7Gr+MLs6dMX+5hOfdBFihvOWtVjROHyoTNx8HfnP6UE20NBW
         CuPn2AeXXNaEUiMryrgndrtZ0UR4qAD5fHzek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MpdXRaHjhy22m2xPQ/mv08yTyf2gnU4AXsIatzMELM8=;
        b=FErjLPbSngPGtAuXUd3jO5wRaaZ4GOWiDhU+eASyCyFWqauHc+RIgS7KT9L0qZiJZR
         bnNuet/MrVWoGXTDSsYRF410cDRhd7wUDjVvZXF2bHlMO3/i6IxuHm8CcA6MEkU71uV/
         u31+qT8QC+cE6WBe02gg0vLLsDUKi347gB/7PnPwMsldHBbwAC4e8siXNmu/Uf5KdmcD
         zamrhnKjsTg8DDhS7ayStvPJqb/n+K2WIFli2y/b4X/G6r5PrM1UNCp8auKuKphajH4F
         WVcANevQZaGnG9vnFxqaOyUQzMj5Qkhi93eeacqF1kKtmIOdQ9ymdB5FbXjIqTkOS9TB
         Iubg==
X-Gm-Message-State: AOAM533lahXQ4t3KOQmu0xGX42iBEMyoyp472MpTJw93ZoSHhL6NeRCL
        cCTlpItZ40sUkoUioxs06Rj1TiKxG32bwQ==
X-Google-Smtp-Source: ABdhPJyWeaFm36Piu5RhVePN+ArD78KuWDjyYpKNfeKzsA4d9mow/D2o/la6bTw0YDMhzzCFDZ82cA==
X-Received: by 2002:a67:f7c2:: with SMTP id a2mr3987669vsp.24.1603987909428;
        Thu, 29 Oct 2020 09:11:49 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id l190sm375261vki.35.2020.10.29.09.11.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 09:11:48 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id d125so813783vkh.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:11:48 -0700 (PDT)
X-Received: by 2002:a1f:2ed2:: with SMTP id u201mr3808913vku.7.1603987908290;
 Thu, 29 Oct 2020 09:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201029011154.1515687-1-swboyd@chromium.org> <20201029011154.1515687-4-swboyd@chromium.org>
In-Reply-To: <20201029011154.1515687-4-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Oct 2020 09:11:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WScyFsu-QDWofXaAFd6-Qdvdb7WQMio2kQ9v6DvqKynA@mail.gmail.com>
Message-ID: <CAD=FV=WScyFsu-QDWofXaAFd6-Qdvdb7WQMio2kQ9v6DvqKynA@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/bridge: ti-sn65dsi86: Read EDID blob over DDC
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 28, 2020 at 6:12 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Use the DDC connection to read the EDID from the eDP panel instead of
> relying on the panel to tell us the modes.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> Cc: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Since we already did some early reviews off-list, it's not a surprise
that I have no comments.  ;-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
