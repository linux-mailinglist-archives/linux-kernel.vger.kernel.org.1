Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BB32A2FD4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgKBQat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgKBQat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:30:49 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF4DC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:30:49 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id l22so3404vsa.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sREWGA01ccOZZ+Ac51fB5ORg2kfgSZpXJMerDUOeHQU=;
        b=QYCxrHXxOIzJRxoAyAIb0dG0Gl0FXPKT7ruPaIvINw1xlkDTkX4uUBFDqf2YFMeZOI
         9mcgE/JXeOyT2MlShJ4MxRdtqhxjf6do0o6f7koqGRhIfzaXzKXlKHkx9WDf5pYYVP2i
         uEuI7tqTsgV9KOGrWFC00ME+3sIQYj9ymedsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sREWGA01ccOZZ+Ac51fB5ORg2kfgSZpXJMerDUOeHQU=;
        b=na7bAoGffqHKN+QHBvnMuiQxoitdiL5NSkF4FS6dlaTCuRCYryIqGICt7K50ZYSn0s
         Lx/mEspt1TI8/GrTSaL3jS+Msiw3LTLyeaNp624OQH1M/YgsRmqtlX1OXPlT4OD9MgN1
         sCBiTAegl17KPYspYJ17Ml9L6Y1PSIohdp/nxJIhFrylVHjOFSVf7KRCd5lBqPRsKGTP
         GsvmrxF54XI7e70+mcJhgJvcSh7IzJHKCjmhcRSDkKj3Dpv/LGTWfEP1jG6FQTlBjJDp
         qAB6vDi6IhhbJAMW20KXWTJ5F8pOpCf33cySHZ+UmMzuCD4r+p1/KggG6eNZV0KpmOXy
         nD3g==
X-Gm-Message-State: AOAM53123gytQaWWrpMbVS2jeOgLwkUrmQObPkBjY2j5plTTggXYFiao
        g421yYTN23hdzZO9yVgJjcTE/OQrXTlAIQ==
X-Google-Smtp-Source: ABdhPJzQLWvqgpT2Qa7/pqtA1cruaKEuUEEUFlxtyxOeQ4iIp38VbfKY0RvtjhI4+RXGDDy7qnTmxw==
X-Received: by 2002:a67:6f06:: with SMTP id k6mr15239773vsc.20.1604334648210;
        Mon, 02 Nov 2020 08:30:48 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id c21sm1621326vsh.31.2020.11.02.08.30.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 08:30:47 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id k125so3068496vka.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:30:47 -0800 (PST)
X-Received: by 2002:a1f:8a:: with SMTP id 132mr3074242vka.17.1604334646803;
 Mon, 02 Nov 2020 08:30:46 -0800 (PST)
MIME-Version: 1.0
References: <20201030011738.2028313-1-swboyd@chromium.org> <20201030011738.2028313-5-swboyd@chromium.org>
In-Reply-To: <20201030011738.2028313-5-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 Nov 2020 08:30:35 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UgFBiRNY7mJtciPt21=G4Em564z6p9VhLF-n-3DcQtJg@mail.gmail.com>
Message-ID: <CAD=FV=UgFBiRNY7mJtciPt21=G4Em564z6p9VhLF-n-3DcQtJg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/bridge: ti-sn65dsi86: Update reply on aux failures
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

On Thu, Oct 29, 2020 at 6:17 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We should be setting the drm_dp_aux_msg::reply field if a NACK or a
> SHORT reply happens. Update the error bit handling logic in
> ti_sn_aux_transfer() to handle these cases and notify upper layers that
> such errors have happened. This helps the retry logic understand that a
> timeout has happened, or to shorten the read length if the panel isn't
> able to handle the longest read possible.
>
> Note: I don't have any hardware that exhibits these code paths so this
> is written based on reading the datasheet for this bridge and inspecting
> the code and how this is called.
>
> Changes in v2:
>  - Handle WRITE_STATUS_UPDATE properly
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> Cc: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 36 ++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 4 deletions(-)

This looks right to me, now.  Hopefully if/when someone ends up with
hardware that exercises these codepaths they'll at least be in a
better state and maybe they will all just work!  :-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
