Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AED42D363A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 23:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbgLHWZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 17:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbgLHWZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 17:25:44 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD972C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 14:25:03 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id v8so10393379vso.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 14:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AxYYdD625aASAaVaKZf+ek64hWUOmEA30M0W7p5diOs=;
        b=PWCPTPXdf9qzkpa8lQrpH0dg+cA2CjB8tVpfj3R15FX88qylOFpgSJt6UiRye6R/Xi
         aLLzYbaTq8/LqfFulq/ntwHbHeb7wmAAEBKarvhDc+O1d2rO6Ue+8tP6oQT+UyHlyE2i
         UnZP7lb07czgcJmcm1C5mfNG8xfH9K7FwigtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AxYYdD625aASAaVaKZf+ek64hWUOmEA30M0W7p5diOs=;
        b=lHjbSAsw4w/RmGWYIhOtQHwrOyZAm7E/ok3J2i0/peGqrsqHbV7u9fCpfpeiJ2yZRt
         p/YXrEtVHIi0znb/mByqgmskj4wcsH4WHUqlH9EQsDjbIcBsB2X2uZr4SaXOFQT7acYr
         abKcHUxMHJuZtDI5YIlLjo0gwG/s4/BG5Uzr1GK6f02DdHPb3kIxYu+DXe9XbMbo2sGh
         f6rVoJf5dKwVrrjQSbwGoYgRAQn+0yA+1uRJDP/nimkyo4yxBdIQIoZw9R6vtzYgxva7
         XXY4QSdJ6p5QRRNOXvAY4gufsewjkYIL3masPhIPms4qkSeBo7DHGXGBZcT+TC2e8C5p
         Fm+A==
X-Gm-Message-State: AOAM532ZYfuyER0AaavfKuZEOqSaWVOQ2x+GNU9BFi8zHlMwsxwyxgGW
        SzWCFr0biosCeWNQhHTTZAHX+tBw8RXyhw==
X-Google-Smtp-Source: ABdhPJyjCVC2FCs9Vby3nXEuZ9xQPJkAnvhKLcFN5R5flg6ql4Fjfo2TBbTom+DkXnp3k+JaqjfsYA==
X-Received: by 2002:a67:89c8:: with SMTP id l191mr279116vsd.8.1607466302718;
        Tue, 08 Dec 2020 14:25:02 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id s6sm31286vkk.20.2020.12.08.14.25.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 14:25:01 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id i62so71468vkb.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 14:25:01 -0800 (PST)
X-Received: by 2002:a1f:3fc9:: with SMTP id m192mr214325vka.17.1607466301140;
 Tue, 08 Dec 2020 14:25:01 -0800 (PST)
MIME-Version: 1.0
References: <20201202200252.986230-1-swboyd@chromium.org>
In-Reply-To: <20201202200252.986230-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 8 Dec 2020 14:24:49 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VQ5GxedWDm6cFfTirEFCS2Mmb--Ey8s_cnSyPSE3MPmA@mail.gmail.com>
Message-ID: <CAD=FV=VQ5GxedWDm6cFfTirEFCS2Mmb--Ey8s_cnSyPSE3MPmA@mail.gmail.com>
Subject: Re: [PATCH v3] iio: sx9310: Fix semtech,avg-pos-strength setting when
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

On Wed, Dec 2, 2020 at 12:02 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This DT property can be 0, 16, and then 64, but not 32. The math here
> doesn't recognize this slight bump in the power of 2 numbers and
> translates a DT property of 64 into the register value '3' when it
> really should be '2'. Fix it by subtracting one more if the number being
> translated is larger than 31. Also use clamp() because we're here.
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
> Changes from v2 (https://lore.kernel.org/r/20201120182944.543428-1-swboyd@chromium.org):
>  * Use clamp()
>  * Add comment to clarify
>
> Changes from v1 (https://lore.kernel.org/r/20201120073842.3232458-1-swboyd@chromium.org):
>  * Changed ternary to consider 17 to 31 as the same as 16
>
>  drivers/iio/proximity/sx9310.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
