Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBE52F1D98
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390263AbhAKSIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389750AbhAKSIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:08:52 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9433DC06179F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:08:11 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id m13so159175ljo.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+B+6pMaa6Q7xKO+4h5rdcoXhhu4oZDjwR1J7UMT4Rk=;
        b=LlsxNoI4BImJb0lMWb1dLUOtq/B1wjQunMIZM7LAuw1JNemQ4vJXNku5ntxD2DJOw+
         lhYNetlVczBfhaQAmH86zJDVJNjZfJ06ZOs716T0hmQ4gUTnfVCa/tE/MZYRpInSxN8w
         yZCtu3+KZkg926Kow9Ofugn48c/v2xKoGKB8bjWzqvqgkZ6Khr87f6VyyWDQqrO5GRXT
         L5mlJr6WLiDJYLUvNvEfloqrEbdz/VAUon1BdmuY/xgyZ0spFe0ndX1AidRXt/wXQ5Cn
         yiIzisza6KGnBSdTGF1e430tHXgtZkxgtpq9QdEH0b/pTf1atBg/DnYoZJNHLhy/6RZS
         8qDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+B+6pMaa6Q7xKO+4h5rdcoXhhu4oZDjwR1J7UMT4Rk=;
        b=lzFhTaj4+ndnKV3fVm7IzdSaSWVaAj2jPEjc8a9a5CJ2g3c1oKXm9gcx6hQlLcJQ0y
         OUYhz5Ztl/tOUkzrCxotxgV26OucbXmdynY3PnruLzgAmZ9+fxXw60uXCSiRDEH4VEBI
         bse7CnQcf96muxxOx8za/zNSH3P9f88kru7Z8OWBR5uLq5HdlbRJ7GGBXZp11AGvv2Oq
         RMGtPadyoQE/tp+xxTLYdhr0xVhPBL+keUbEbuZymHbqZV1pcSCgiYPDXUiCyAwhx/G3
         OrukujI2viktETYKInsDHPi7jPAcLR+JBrbJLPXschifZlZLMS0fUr4Mb4q8f5Yk1UFl
         Pe0A==
X-Gm-Message-State: AOAM5317Lt8uSKwIH8E9nwJU6ND8rIJRJiEJ03YUM3DfSYI37W1aJnWN
        FRfxolALKPPTK6sw7d3PSDC5Er4cABPi5P8+AYo=
X-Google-Smtp-Source: ABdhPJxQSnjahHHc+CEoLPrh1phEmZlVoro9RXebrNI+oYsadieuy+YiDRNGo/oxMiaj+jv6nvhkbJsb5wrTd8mhed8=
X-Received: by 2002:a2e:b4b3:: with SMTP id q19mr273826ljm.121.1610388488972;
 Mon, 11 Jan 2021 10:08:08 -0800 (PST)
MIME-Version: 1.0
References: <20210111125702.360745-1-geert+renesas@glider.be>
In-Reply-To: <20210111125702.360745-1-geert+renesas@glider.be>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 11 Jan 2021 15:07:57 -0300
Message-ID: <CAOMZO5ADSvcNvWx5vYui1v=jdUQ=K+HfETAm7xr5zg73DhqcFw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: nwl-dsi: Avoid potential multiplication
 overflow on 32-bit
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Mon, Jan 11, 2021 at 10:02 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> As nwl_dsi.lanes is u32, and NSEC_PER_SEC is 1000000000L, the second
> multiplication in
>
>     dsi->lanes * 8 * NSEC_PER_SEC
>
> will overflow on a 32-bit platform.  Fix this by making the constant
> unsigned long long, forcing 64-bit arithmetic.
>
> While iMX8 is arm64, this driver is currently used on 64-bit platforms
> only, where long is 64-bit, so this cannot happen.  But the issue may
> start to happen when the driver is reused for a 32-bit SoC, or when code
> is copied for a new driver.

This IP is also present on i.MX7ULP, which is 32-bit, but not supported yet.

Thanks for taking care of this.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
