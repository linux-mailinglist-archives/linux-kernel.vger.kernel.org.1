Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5D52DC7FC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 21:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgLPUxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 15:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgLPUxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 15:53:35 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71779C061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 12:52:54 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id x20so32314041lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 12:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vkdNbAXJT7PhCwQlg2OILB1sS2zw/a+6Z3NYSr5wu6w=;
        b=yFad8AE/AQK6llfX6tOw1g5IO0dT9I4sS8IBJVb3uQ7r/hEeNTRfkdl+9cQZ+jWPLE
         qqu50D4RVFNN6os+efS0By1w6nQ4ps9AjqGArnaE6ntl16cZYncDvgVlwuiH0dbuKCFw
         BryDmTWBboRR7BllifqkUAszd82CCmbXiFjsHwJB7YAAcrXbKWt0QkwgUKyUUd9YnRtg
         d2DAjXG3Srywp6TfpxUfdxDmJAHQMeNw5c4Y81YBcKLya0gxv3pzS21fpUCUrzLfvKTU
         X7v4ytEoKQytHmrfWe+f+eB+76Ef+FDIHzf2D3oSbEVXTp9fjVYzzei7Bu4ZiNLl0w3H
         LELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vkdNbAXJT7PhCwQlg2OILB1sS2zw/a+6Z3NYSr5wu6w=;
        b=V8HufXKBmPfGLTPuZO9+2B9yCpD5I4Mrtj/Z1wyDT38Y1JotsfWW6fpiL/hoWE8G/v
         8n6Il3fZ6B6vlIMc6tl87HtLawigHAVn9wbs9NXbxALkzbSaai0CrWkVF6mwhnCLgLnt
         e5w+vsJyi3Wvgb4fMdA/0qke+W0XVTvv2PUUiHk79pfgH5J1YermXrtO0nb2mxDLE16D
         VxThTUArdB3KFoCH8lVouHaBQRXGtCkzAY2x3lkQSe53AoCGAXOVgE1nW71MBuWUfePO
         Kt2ERp0/sxdU8dAlCfD01XIhtl08icECHDASSJvjeAx+aK4YIj9kxhdFqL0E/TGft+77
         8R/g==
X-Gm-Message-State: AOAM532hUVKjhQsTeihh2yZPJrVJ5zLOOFENGzHsTukJfShhymIrHTPo
        ZuYtuq29b4YI44uPqj650R/h006qpW4HK8DZzTQH9YxwRo8=
X-Google-Smtp-Source: ABdhPJwNTG6XhtSllHr7QZCJ9dxFjH2Ugc2EnjaDWzXT1+chx7RIEQDXqYx/2BQcvfCH6W+E6YGshpge9V7PWgEKBrU=
X-Received: by 2002:a19:495d:: with SMTP id l29mr9093794lfj.465.1608151972803;
 Wed, 16 Dec 2020 12:52:52 -0800 (PST)
MIME-Version: 1.0
References: <5fd76cf2.1c69fb81.6f19b.b16a@mx.google.com> <483b08f2-09c3-e753-d2ce-4e34fee627f3@collabora.com>
 <CACRpkdbozXM3FHQB9+GcPJZdNT+Vi1223m2uEqqJ21ukY1A4Gw@mail.gmail.com>
 <8e5e0251-9450-5c93-cd2e-c44779a72b0c@collabora.com> <CACRpkdb8Bgie3dJME5qQwu_33b6zVYzAayJnHJUCzrkntpNNXw@mail.gmail.com>
 <600ff528-71b0-ac02-0266-ddc5e3b6fcf4@collabora.com>
In-Reply-To: <600ff528-71b0-ac02-0266-ddc5e3b6fcf4@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Dec 2020 21:52:41 +0100
Message-ID: <CACRpkdbb84M4k-te0uwfDxX4PR05Z=SXZC8nM_HH=GbkNoCf7A@mail.gmail.com>
Subject: Re: linusw/devel bisection: baseline.bootrr.mediatek-mt8173-pinctrl-probed
 on mt8173-elm-hana
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Johan Hovold <johan@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        Sean Wang <sean.wang@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 6:30 PM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
> On 16/12/2020 12:41, Linus Walleij wrote:
> > On Wed, Dec 16, 2020 at 11:10 AM Guillaume Tucker
> > <guillaume.tucker@collabora.com> wrote:
> >
> >>> It seems we need to teach the core to ignore the name (empty string).
> >>
> >> OK great, I see you've sent a patch for that.  I'll check if we
> >> can confirm it fixes the issue (something I'd like to also
> >> automate...).
> >
> > Yups would love to hear if this solves it, it should be in today's
> > -next.
>
> Yes in fact it appears to be all fixed on your for-next branch:
>
>   https://kernelci.org/test/case/id/5fda32f92738afa48dc94ce1/

We found other problems with my rushed patches so I pulled them
out anyways, I will tighten them up and make a better job for
the next kernel cycle.

Thanks for your help!

Yours,
Linus Walleij
