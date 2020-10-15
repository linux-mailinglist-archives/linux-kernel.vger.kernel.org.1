Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AA728FAAD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 23:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbgJOV3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 17:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgJOV3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 17:29:46 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5B5C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 14:29:45 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id ce10so204423ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 14:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shNugDWCSFxMFaQhudWs8qBWQPZ07aTny77+Ie1FHlk=;
        b=WsvessV78yuDktprTp/4iqa3Adv1XtNl2N/v19ZJnZoqVtqW3R89jenV6efR955q/r
         w/t7xoaoNh7s+6TICZL6hGqJEjkuoQuGozFyTv0FDKf47JoY98kaBG86Az0J9yrlcxxG
         WWCFFWYtDAiJztGSud9FB31svTcPtnbTB6Mhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shNugDWCSFxMFaQhudWs8qBWQPZ07aTny77+Ie1FHlk=;
        b=QBMWfn3/NbzPeQEK9PVYDF0dKqH7Pgxfoue9yh6miHCBnz1ybu4Vnpovj20UQanghy
         FjnbEt0TRWr3BltHRJfPY7cMi0Z1v6ZTQXIKLaLbMRLDgGpKIWESR1SURiJSFiJr8NRX
         5Ksq8HPARuXJCCbKwu5Vj1SuzwKEd0105v0Wu9TPMCvq0b5VK6KyTD3lrMsA16vr/fN0
         JqHAtXZ1iWGwsJG19k2Sha3cxTl+vW2pMrvmsRPClt9K/QAxDekQus3W+l1uPbexx3pB
         UoCaHxYyMhWY0wmSTIPEBLzhPYgpiO7dH7oHVVIpW4pXbh4hskcP9npuD2ZZAQnZ2LSE
         n6gw==
X-Gm-Message-State: AOAM533lrYEz1fvUBv0WLcnUj4NE5b0rICqlEv8XBFYW2mG5oq7JsCSL
        G66iFxmE266DeufgVcjS7Yvt/g4NySXOrg==
X-Google-Smtp-Source: ABdhPJxaD7CyZ2/0M2VNLxFP8slYdbB8fGVvzW9Ka54sM7nxUac5yP0v9iA9S4v0oOMjRO2DSdSx/w==
X-Received: by 2002:a17:906:350d:: with SMTP id r13mr337279eja.117.1602797383543;
        Thu, 15 Oct 2020 14:29:43 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id i4sm235518ejz.62.2020.10.15.14.29.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 14:29:42 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id t20so197519edr.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 14:29:42 -0700 (PDT)
X-Received: by 2002:a50:e40b:: with SMTP id d11mr491296edm.198.1602797381996;
 Thu, 15 Oct 2020 14:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201013080103.410133-1-amstan@chromium.org> <20201013010056.v2.2.I96b8d872ec51171f19274e43e96cadc092881271@changeid>
 <20201014141946.mkrvpkrttucffkhj@holly.lan>
In-Reply-To: <20201014141946.mkrvpkrttucffkhj@holly.lan>
From:   Alexandru M Stan <amstan@chromium.org>
Date:   Thu, 15 Oct 2020 14:29:05 -0700
X-Gmail-Original-Message-ID: <CAHNYxRx3J7XUE-hWa8-6_bOePsw1oeY9uuuehy=yCxN2RyqsjQ@mail.gmail.com>
Message-ID: <CAHNYxRx3J7XUE-hWa8-6_bOePsw1oeY9uuuehy=yCxN2RyqsjQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ARM: dts: rockchip: veyron: Remove 0 point from brightness-levels
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 7:19 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Oct 13, 2020 at 01:01:02AM -0700, Alexandru Stan wrote:
> > After the "PWM backlight interpolation adjustments" patches, the
> > backlight interpolation works a little differently. The way these
> > dts files were working before was relying on a bug (IMHO).
> >
> > Remove the 0-3 range since otherwise we would have a 252 long
> > interpolation that would slowly go between 0 and 3, looking really bad
> > in userspace.
> >
> > We don't need the 0% point, userspace seems to handle this just fine
> > because it uses the bl_power property to turn off the display.
> >
> > Signed-off-by: Alexandru Stan <amstan@chromium.org>
>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

Thank you!

>
> Note also shouldn't this be patch 1 of the set. AFAICT it makes sense
> whether or not the interpolation algorithm is changed.

Yeah, I guess it could be. Sorry I didn't think of it that way before,
I'm used to landing things in a group.

In particular on veyron I assume it will almost be a noop without
having my driver patch (especially with the findings of 0% not being
that important).

Feel free to land this independently.

>
>
> Daniel.

Alexandru Stan (amstan)
