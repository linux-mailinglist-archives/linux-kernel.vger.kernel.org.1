Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A3A2BB340
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbgKTSbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730611AbgKTSbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:31:32 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01479C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 10:31:32 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id x11so5509316vsx.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 10:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7OcGIZK4DIQmCs0MRiTREZT+eK02Kd2oT8srQAYVh0=;
        b=oNrAv97R01ZPBXpaa4/GoGl6M2RtjB6dD90dTdlL/xBkGbRUGLt66iNnIWxbYCoLm3
         SwQ7gh347RrBJipvRcbnk0870OeY5XoftdqJG54iTeegaMKrE6RzFv+cLvm+Tjsb5sQ9
         GXUi93aCVxrpOPQa/PGa6bXKdZX6mx8Dk+6l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7OcGIZK4DIQmCs0MRiTREZT+eK02Kd2oT8srQAYVh0=;
        b=N9I5eN5YBr3Uft9eFLyZA2KrzGazNSM4EBrAxkDKowUGGuVeVPyMahDHA0F7MfJdVW
         mi2OS4rYGM1W9SLIPhF8ISU19QVLxnuwiSyg67UzGguw80X8t8Fxo45IYPYh79wpw995
         z3Ug0h00WmJUDyLa9fAfMpZRibsm7mGzAcD2K2PlFa80Pd585LRRNYE6KW0i9Q1LY8BX
         kypXdxg3ZUt1gq7bLJiGjv7vEMZKJltJVEjvhOAuDP9gjHBScDcVQOTcG+5R9akJX5J5
         Zam6ldaS+JauP0y5Y85moLf/vtVJvq7+I1/GoSyuNNKfbOFqwy9iGRdrQ0XaMkTlIYhx
         BYgA==
X-Gm-Message-State: AOAM53229a9GQ8ZWY8qsk5G1PYyBXA5E4ShHVoKCkhNjANLmr4+3cdo3
        mpDR8uVShvtwaM8/MAe3XI+4PUkMkgr8pg==
X-Google-Smtp-Source: ABdhPJwwCCemgYGt03AZOFnD9iKKKYSqzUZqNrI3dgLPrbqhYXpfNWEcrKtd+zfn8hAhRmCsz19uTQ==
X-Received: by 2002:a67:8884:: with SMTP id k126mr13484148vsd.44.1605897091027;
        Fri, 20 Nov 2020 10:31:31 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 187sm375033vsv.6.2020.11.20.10.31.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 10:31:30 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id r14so5494228vsa.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 10:31:30 -0800 (PST)
X-Received: by 2002:a67:4242:: with SMTP id p63mr13488967vsa.34.1605897089926;
 Fri, 20 Nov 2020 10:31:29 -0800 (PST)
MIME-Version: 1.0
References: <20201120182944.543428-1-swboyd@chromium.org>
In-Reply-To: <20201120182944.543428-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Nov 2020 10:31:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W3cBGGTksNTh0m_j7VPJJvo6qwUm6+9-z=RhnN5av0dA@mail.gmail.com>
Message-ID: <CAD=FV=W3cBGGTksNTh0m_j7VPJJvo6qwUm6+9-z=RhnN5av0dA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: sx9310: Fix semtech,avg-pos-strength setting when
 > 16
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 20, 2020 at 10:29 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This DT property can be 0, 16, and then 64, but not 32. The math here
> doesn't recognize this slight bump in the power of 2 numbers and
> translates a DT property of 64 into the register value '3' when it
> really should be '2'. Fix it by subtracting one more if the number being
> translated is larger than 16.
>
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Evan Green <evgreen@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v1 (https://lore.kernel.org/r/20201120073842.3232458-1-swboyd@chromium.org):
>  * Changed ternary to consider 17 to 31 as the same as 16
>
>  drivers/iio/proximity/sx9310.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
