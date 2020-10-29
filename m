Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481A729F0D4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgJ2QKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgJ2QKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:10:43 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE7CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:10:42 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id t67so813398vkb.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TpGj3kui/uWkJ5JQ6tLFNod5bmWWhITkgZJTIzMYPtU=;
        b=Cp5WodJ1rDzMKOKwvLW9Vt6q87Cyvqypv9McqhqXK6314eO8APXaRoAM0apTMDSZkd
         NtIqaNOGuuGXSnWejT5xIJm1ctVN+sSadhqardp6jqQ69YdR/bc+8sgfK6KXm80BnZMW
         aNHfnvzU0Pk5Yb/Y44jkpVJ2sVpqiyOJ2jlH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TpGj3kui/uWkJ5JQ6tLFNod5bmWWhITkgZJTIzMYPtU=;
        b=gq18qiQMPrAsO7dZghrB9HWv8IfWhdZLT+6mwPLfTBzXwxm8wNQDImzvkbyfZn0Goe
         flHLIvU9hBf8R4p/cuOK3scPtcIw5oPTGp8R3yGeB9J438jAjCoj42FF5b7/rUdtmMZC
         /Eh4Lu3uom/ztMMzpsNV3hiEVlzlhjY46HOR+l6OkzJhiCbqxaD325mREeHYFPGLf/PT
         DV+zZVbXCA49XyidWQ8fcaZE2KA1xQ9EEfdu5Fe4EojQbAZZCjD/i8f7V5vJqkyQQVrs
         okfkwMT4Hd6fx3tWZPEwKC+TzFZVo91j16wn8/B57lzl7Uw5cGPs168lD28tvensllLU
         Z3uw==
X-Gm-Message-State: AOAM532N7JRNozGItVBgovcX0x8NJYT9oWKyZqhPyX9EiLu9Rtkndnsk
        gTNyce6t/ZX7ORk/7e5TYw0V1bqrVCWE6Q==
X-Google-Smtp-Source: ABdhPJxynWZtxbr+rPk4oCsxG8FcFh2SzVMP6XRj2hbvY0anp2p7QskskLOkwSHXedvc/+966db/+Q==
X-Received: by 2002:a1f:a94c:: with SMTP id s73mr3699263vke.19.1603987841852;
        Thu, 29 Oct 2020 09:10:41 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id m14sm381541vkk.17.2020.10.29.09.10.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 09:10:41 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id y1so836996uac.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:10:40 -0700 (PDT)
X-Received: by 2002:ab0:6034:: with SMTP id n20mr3245765ual.90.1603987840438;
 Thu, 29 Oct 2020 09:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201029011154.1515687-1-swboyd@chromium.org> <20201029011154.1515687-2-swboyd@chromium.org>
In-Reply-To: <20201029011154.1515687-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Oct 2020 09:10:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UUdYR-R9r9BoHWSoQEejL3P0r+bG1m787tVkNQHhZDuw@mail.gmail.com>
Message-ID: <CAD=FV=UUdYR-R9r9BoHWSoQEejL3P0r+bG1m787tVkNQHhZDuw@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/bridge: ti-sn65dsi86: Combine register accesses
 in ti_sn_aux_transfer()
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

On Wed, Oct 28, 2020 at 6:11 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> These register reads and writes are sometimes directly next to each
> other in the register address space. Let's use regmap bulk read/write
> APIs to get the data with one transfer instead of multiple i2c
> transfers. This helps cut down on the number of transfers in the case of
> something like reading an EDID where we read in blocks of 16 bytes at a
> time and the last for loop here is sending an i2c transfer for each of
> those 16 bytes, one at a time. Ouch!
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> Cc: Sean Paul <seanpaul@chromium.org>

+Sam Ravnborg has helped land a few changes to this bridge drive in
the past, so maybe good to CC him if you have future spins?

> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 50 ++++++++++++---------------
>  1 file changed, 22 insertions(+), 28 deletions(-)

Since we already did some early reviews off-list, it's not a surprise
that I have no comments.  ;-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
