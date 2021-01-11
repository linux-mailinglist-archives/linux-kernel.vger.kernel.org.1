Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2102F1AC5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388829AbhAKQTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbhAKQTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:19:03 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232D1C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 08:18:23 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id c7so15052907qke.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 08:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xhOQxNsV2il5IcGG2+Pj+mgc5E5N2v3HzSDbkiCiFrg=;
        b=KMn8a/l2uWt00jFzBeo+h32jG1PlJ+l6d2C+46a7JdaMn0O9w2kIh3Vnq84V3CCiYP
         FzQoblPAzRiCDHBIQES204zMoXppyb9Cz+W0kiN31qx+i0G1ir9pyyY0Zbmx9odzIp6v
         9fTRujY4s/JEgS9ppFtmnzkDfA7y2BuQddLlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xhOQxNsV2il5IcGG2+Pj+mgc5E5N2v3HzSDbkiCiFrg=;
        b=UQfKb8IR8bsqh5ht/94O6ZX0uhThbIwIA8hAGyI+H4cMi9QQipYhUwWErBEjG4aKj8
         i0krU9ILotW+03KBrDwmwceNwEDH382OhMlhPmk7Fqd9mOxEERD4Z4Tcm3EYkMToLkpE
         ebRI+qS94RL+9agD0rAj4HxHj2D4avAi085EXNVxLVXLCP8EB50jb/BwaEz5yGyVeOUd
         PZ83RSrmYLKOH2FpHc+4NuzRteuwQRLcvGHlez1kB+1ZsmDUEdLycbKQ7wpHWSBbEqcw
         fyW5ra2P/kZ5zuAkT53VgrYjd91hDXNNTX5FkZTzOX9yZo5dDlClSI0VJ/p52jOuEKMU
         zJXg==
X-Gm-Message-State: AOAM5327f82/B17f11ahQ7o03kc85UCOPhHRiJAHiH+dmTr3/Hs/rZHY
        88Rre+OwnpklPU6F7bDdUxsuPeS5oDBKgg==
X-Google-Smtp-Source: ABdhPJyIQQdhca7nKmUbppI02t+cVZYgDO+OndhMmpK46xRgMzafBQQcDZmafPPV7yoqgJiLVrYrHg==
X-Received: by 2002:a37:544:: with SMTP id 65mr73101qkf.204.1610381901846;
        Mon, 11 Jan 2021 08:18:21 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id e11sm2643qtg.46.2021.01.11.08.18.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 08:18:20 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id k78so302268ybf.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 08:18:20 -0800 (PST)
X-Received: by 2002:a25:d3c8:: with SMTP id e191mr751769ybf.234.1610381899962;
 Mon, 11 Jan 2021 08:18:19 -0800 (PST)
MIME-Version: 1.0
References: <20210109130951.3448435-1-heiko@sntech.de>
In-Reply-To: <20210109130951.3448435-1-heiko@sntech.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Jan 2021 08:18:07 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W461Qh8zDYL8aHKfcLp-1uZzgZRJ9HgpJ2Opmckf2mjA@mail.gmail.com>
Message-ID: <CAD=FV=W461Qh8zDYL8aHKfcLp-1uZzgZRJ9HgpJ2Opmckf2mjA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: panel-simple: add bus-format and
 connector-type to Innolux n116bge
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jan 9, 2021 at 5:10 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
>
> The Innolux n116bge panel has an eDP connector and 3*6 bits bus format.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 2 ++
>  1 file changed, 2 insertions(+)

This looks right to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
