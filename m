Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2DA2C11E9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 18:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390215AbgKWRZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 12:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgKWRZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:25:05 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECEBC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 09:25:05 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id v185so922478vkf.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 09:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YSNrpJ4OndNC4w4ulPWCJT3NfGZKd/DmZdSIZa2BOxk=;
        b=nJp+E2XRY1AUEhkNEZ0HQHS0mF2b3UiEjmB0eFubyH+jomZHsIxS/S+CRJNMqXa1VJ
         5n94PenFnPDOTRSaNBhD1MUdycYZCzk31+4LRFmjGOBHqYTvqIs2NAX9q1aY3ueWjQ57
         qRBCLSSlShNkU0MAOjUEX+nlzwIIqXAL/+ZpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YSNrpJ4OndNC4w4ulPWCJT3NfGZKd/DmZdSIZa2BOxk=;
        b=La31Hn3dmW6WtCU6tSNNT+sIBqXpSh+0pvQHV1w3XVSuwMlZAlEVSKGkiIsewnpQ6x
         x/fxOloF+kwLHWswO2IILRBLpt5V7v1meP1tKt0i/BJbTkEQtn5WrZ//6xlI2xL0ltmc
         b1QnkX/wKRfM2otHIHzI2t89AMdxLiAeQGJpPyeITUvTh6FDXu6LzjvNCR88cSHhs9FJ
         iGccZ072OSV7jdw3YlJ//CJ+f0I/vKuU4XewFBKJkDge+c+tUCfCtlM+TUVP5DVXeUex
         zOJAiy33tYmaL2nL09oi7bJXaQWj5xKhtq9Luqbz+zCLYFnDwB/hMV35T/Vps1smNL1Y
         XAUA==
X-Gm-Message-State: AOAM530dpyWIWJrkyoOyYsiuTiM8P1G9tt0wMACZVmoJWOS5Xmz5Cxd7
        zVh4wL3okZ1iuPpSbMyfCp+D9S6KHOnAsw==
X-Google-Smtp-Source: ABdhPJwnfnZKpvvrryVoYlt0D9D13ImHsV6J+Ki9U2xh1IEItXhophiFUUofWYMi0YZZ+UtPNTnFkA==
X-Received: by 2002:ac5:ccd2:: with SMTP id j18mr852203vkn.20.1606152304598;
        Mon, 23 Nov 2020 09:25:04 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id e9sm1421662vso.32.2020.11.23.09.25.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 09:25:03 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id a10so5900694uan.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 09:25:03 -0800 (PST)
X-Received: by 2002:a9f:24eb:: with SMTP id 98mr611949uar.90.1606152302603;
 Mon, 23 Nov 2020 09:25:02 -0800 (PST)
MIME-Version: 1.0
References: <20201109170018.v4.1.Icaa86f0a4ca45a9a7184da4bc63386b29792d613@changeid>
In-Reply-To: <20201109170018.v4.1.Icaa86f0a4ca45a9a7184da4bc63386b29792d613@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 23 Nov 2020 09:24:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WEL8OyZLGrdVz54XaHS-56D8zbKyN2ZZcnPMsHezPrbQ@mail.gmail.com>
Message-ID: <CAD=FV=WEL8OyZLGrdVz54XaHS-56D8zbKyN2ZZcnPMsHezPrbQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] drm: panel: simple: Fixup the struct panel_desc
 kernel doc
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 9, 2020 at 5:01 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> When I run:
>   scripts/kernel-doc -rst drivers/gpu/drm/panel/panel-simple.c
>
> I see that several of the kernel-doc entries aren't showing up because
> they don't specify the full path down the hierarchy.  Let's fix that
> and also move to inline kernel docs.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v4:
> - ("drm: panel: simple: Fixup the struct panel_desc kernel doc") new for v4.
>
>  drivers/gpu/drm/panel/panel-simple.c | 59 ++++++++++++++++++++--------
>  1 file changed, 42 insertions(+), 17 deletions(-)

I'm curious if there are any outstanding actions I need to take for
this series.  I know I found that on patch #4 I should have added the
sync flags [1] but I was waiting to see if there was any other
feedback before sending a v5.  If there's nothing else I'm happy with
any of:

a) I can send a v5 with that small fix.

b) v4 can land an the maintainer landing can add the ".flags =
DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC," into the patch when
landing.

c) v4 can land and I can send a follow-up patch with the sync flags fix.

I know it's the holidays right now and folks are busy, but I just
wanted to see if there were any actions I needed to take.  Personally
I'm on vacation the last 3 days this week and I imagine I'll come back
to work Monday swamped with email, so today/tomorrow would be an ideal
time to send a spin if one is needed.  Thanks!

-Doug

[1] https://lore.kernel.org/r/CAD=FV=UPkuJ5E2sCQeozNR3CO+LZW=DW9h77vfooeiSMqGnYpA@mail.gmail.com
