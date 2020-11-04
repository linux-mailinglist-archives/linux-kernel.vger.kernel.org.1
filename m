Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA6F2A69BD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbgKDQ2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgKDQ2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:28:07 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C96C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:28:07 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id x11so9183009vsx.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 08:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LjuXhQKMkVF/DFnAs8lSgplGwULXo7VijpW+tg4xDRo=;
        b=CYyTnjZ9sT5OzEIgvIcFGZuSxN+Eid8b5mYJi0Nf25q32LAUY54og5lkDHh40Aba16
         LH63QeOb6L4WxI5TKhvVzq3fugcyltMxwbtRFqilu5XPRVURd3DTemYhTopb7D8fQFWL
         Xzsdh7fnY7Z9kQZojTdOMe9r9rq7AtR5hF0FQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LjuXhQKMkVF/DFnAs8lSgplGwULXo7VijpW+tg4xDRo=;
        b=l6/HQTmOxsRffMC55v5Um2V1KN8iHMRTobdzYvsEpEmMXuPoAq5xGRXYto0oN9x//2
         ApsQOg+qTiIb5q62nnv5Lchfy4MZCJEBXaVr18nWQ0t1p7vhRWxPY6UqpVVTm7LExE6M
         my7c2fV8MN+IKaSCHZcFMqa/U6RQ4oBK4M2UPl7x35/C5nlCtkJDVy6WugRgKLe8r+3L
         snr6x7grsAML1QNHH2rXb3pqPmSmhuRThVWrdqsysG3ALb598wc05QD6zv+mvDQ22LrB
         YMnka/+dDHGCZf/f8NS+78qwcC4wkvkFjqV8EJlJJF8IR1xpL09IsBlqgQn5SBZHcfrz
         LHyw==
X-Gm-Message-State: AOAM531rakBqycnGp1IWLkJi9oqZNQEDusQdk5460Ru+4Y37t7FTrO5n
        mWapl/vwsJDWxZK34ZfH+3avfkuHbjTghw==
X-Google-Smtp-Source: ABdhPJybEqvXczFVkTZ3PIL3QmEMUjxeutgN2BiqkCC2WXHNE/90m5XhyhE/p/HPyksri0lD3UzWng==
X-Received: by 2002:a67:c914:: with SMTP id w20mr23003180vsk.15.1604507286056;
        Wed, 04 Nov 2020 08:28:06 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id s20sm330497vkl.8.2020.11.04.08.28.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 08:28:05 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id f15so6212168uaq.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 08:28:05 -0800 (PST)
X-Received: by 2002:a9f:2f15:: with SMTP id x21mr14344167uaj.104.1604507284609;
 Wed, 04 Nov 2020 08:28:04 -0800 (PST)
MIME-Version: 1.0
References: <20201104162356.1251-1-m.reichl@fivetechno.de>
In-Reply-To: <20201104162356.1251-1-m.reichl@fivetechno.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 4 Nov 2020 08:27:53 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VdcG_DQs+er5g-p=pX_G79Nzciv=M0MDZDhTr2c4sh8g@mail.gmail.com>
Message-ID: <CAD=FV=VdcG_DQs+er5g-p=pX_G79Nzciv=M0MDZDhTr2c4sh8g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Assign a fixed index to mmc devices
 on rk3399 boards.
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Robin Murphy <robin.murphy@arm.com>, wens@kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 4, 2020 at 8:24 AM Markus Reichl <m.reichl@fivetechno.de> wrote:
>
> Recently introduced async probe on mmc devices can shuffle block IDs.
> Pin them to fixed values to ease booting in environments where UUIDs
> are not practical. Use newly introduced aliases for mmcblk devices from [1].
>
> [1]
> https://patchwork.kernel.org/patch/11747669/
>
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
