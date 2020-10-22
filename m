Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D52B296784
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 01:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373225AbgJVXIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 19:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373217AbgJVXIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 19:08:12 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEEBC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 16:08:12 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id i62so769221vkb.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 16:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XqZRiMhuJbb9xQjfZ/Kso8UhUVd+NGKCMF23xD+oK5A=;
        b=G0PWbSpxIEODLM5nxyFaH4wcSC5Tof/eTKvTFJfDjb4jdSxh2k8WP0w07CycnNkqSs
         uVupbWaEV3DgvKcdVUr023+qrEjkshzPyyEO/uc3JhL9c/OIwsiOvagKq1aJG5DeQy7e
         iP06v2r5JX4Qjn83Q+ncdtCN2QZf0gf30vzfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XqZRiMhuJbb9xQjfZ/Kso8UhUVd+NGKCMF23xD+oK5A=;
        b=lIimYo312PzVg9mFOhBZnWgceaedDXJsae7v6OLRnNTBt+kSUkChYy/o+HyiDLyPgT
         TPMDUM3N2xJOvYmdZFSnZAjx9imo5O65PPPgl90uvRsVK1lRftZ0jukiK9gUPpwC81oR
         tqPWLVDpyWRHNyr4lFsik9ODlkgKzN61qO3Oe4jhFa2wVJM5XjQwsKkFiPPYXSeM7qm+
         mvwDhysJtd9et9kkUxnCqFPhjj9JM7v/ECEec91ux0h6+mRBd6gR1AKbY1vpZr8w6L1r
         AalnYpXy4ptiZDOD4vs7nXWTQjDjlfH2bLq+/6nm+wy+gcO2F5JpfhAdShrK25Njzboi
         qI6A==
X-Gm-Message-State: AOAM531wJ+ikcGk8gdZk+qUS1qi3xhlkCpK/8UiHxOPJ2IAweus3qCTZ
        suUYLnfrc4ijMMRwZBlg/zkVb3jE82+G0g==
X-Google-Smtp-Source: ABdhPJzYwIONsEscid/Bi0HZLFXm8GXy2Oke3BfBMmqLuwmU1scMG2AA6MkL5nxkYPH33IU8be1+2w==
X-Received: by 2002:a1f:a801:: with SMTP id r1mr3809170vke.1.1603408091459;
        Thu, 22 Oct 2020 16:08:11 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id s70sm484541vka.45.2020.10.22.16.08.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 16:08:10 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id r9so957184uat.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 16:08:10 -0700 (PDT)
X-Received: by 2002:a9f:31ce:: with SMTP id w14mr3531663uad.104.1603408090224;
 Thu, 22 Oct 2020 16:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201022050445.930403-1-amstan@chromium.org> <20201021220404.v3.2.Ie4d84af5a85e8dcb8f575845518fa39f324a827d@changeid>
In-Reply-To: <20201021220404.v3.2.Ie4d84af5a85e8dcb8f575845518fa39f324a827d@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 22 Oct 2020 16:07:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VeRs=EzBoQkVNVYnrEmUAwV0B-zKtYeS9s80TpEjPmgg@mail.gmail.com>
Message-ID: <CAD=FV=VeRs=EzBoQkVNVYnrEmUAwV0B-zKtYeS9s80TpEjPmgg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: trogdor: Add brightness-levels
To:     Alexandru Stan <amstan@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 21, 2020 at 10:05 PM Alexandru Stan <amstan@chromium.org> wrote:
>
> We want userspace to represent the human perceived brightness.
> Since the led drivers and the leds themselves don't have a
> linear response to the value we give them in terms of perceived
> brightness, we'll bake the curve into the dts.
>
> The panel also doesn't have a good response under 5%, so we'll avoid
> sending it anything lower than that.
>
> Note: Ideally this patch should be coupled with the driver change from
> "backlight: pwm_bl: Fix interpolation", but it can work without it,
> without looking too ugly.
>
> Signed-off-by: Alexandru Stan <amstan@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
