Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13532A73C2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732831AbgKEAaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732231AbgKEAaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:30:04 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E87BC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 16:30:04 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id h5so109924vsp.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 16:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d5o9eOs5Tiv+TUmgROBahgNX011WshZjeFSi3IU5ZO4=;
        b=Jz8xTXMUGfKjYINWV76nnlMyGNncfJDBZmnGTdthlDIuR5k52NxJXwzvCdDKnptQAH
         yS3AyKnVlm7JiwHOaYYSrP0nqH4628VWotg6zKA7qq14CjilU7RYzeQ+E2gm3hCrTYWS
         9h2CZCT1huTTy8VOtstkeS9+YJJ8ZVoinMDpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d5o9eOs5Tiv+TUmgROBahgNX011WshZjeFSi3IU5ZO4=;
        b=Bqqr0xwtWeK4jKnrp7hqasBctqaS/4VNbrD1RrdVS0Pvrznzk8vq68/lIZMMy9yQ0U
         g/f8m915t77qkFbdgBdKgBBjoe+Z3DSkXgZQD/vR037uGaIK95rUaAp4pL7UpyPjgDWK
         4/JAykk9NJdkxWPY0RQeXBQjmRBFbMdR5l/dwmCMEsy2JsQdvbU2HbAREPshwU8U53an
         I7aXSGhR2acgaYFYNf1t2X5J/p7wD9xId9dk+aRO4531BqyDbbK2l486uY0nxW/pwxl4
         jKBYkyZkv5nkcpRVsFgPJt/O7nR+eTjDOCLc2F55Ldk5KIrXlGaOA/4HGRzKK0rE9IYy
         T1Xg==
X-Gm-Message-State: AOAM5305NVGhZ0Hq9dqZ0XbHO9Al5fMJJQTgcItCJzjzA7vyCoD4YNMA
        Z/oNiX386XRLGWIjk7cEF3oz4HJ32JV+5A==
X-Google-Smtp-Source: ABdhPJzKtKyjgvcqRPxLtkC17XqJfZBYCL1rWfNyp5j++RJRbuGPoqGtpNRyIo7K2MpBWaxQHx/zFw==
X-Received: by 2002:a05:6102:10d0:: with SMTP id t16mr439440vsr.9.1604536203554;
        Wed, 04 Nov 2020 16:30:03 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id n20sm499853vkf.33.2020.11.04.16.30.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 16:30:02 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id q4so91194ual.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 16:30:02 -0800 (PST)
X-Received: by 2002:a9f:36a1:: with SMTP id p30mr250823uap.64.1604536202255;
 Wed, 04 Nov 2020 16:30:02 -0800 (PST)
MIME-Version: 1.0
References: <20201103103749.1.I0ed4abdd2b2916fbedf76be254bc3457fb8b9655@changeid>
In-Reply-To: <20201103103749.1.I0ed4abdd2b2916fbedf76be254bc3457fb8b9655@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 4 Nov 2020 16:29:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wc-b75a-QSX8qLq0+fCbcnvh_6q+N6azL=+Tk+rMie1g@mail.gmail.com>
Message-ID: <CAD=FV=Wc-b75a-QSX8qLq0+fCbcnvh_6q+N6azL=+Tk+rMie1g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-trogdor: Make pp3300_a the
 default supply for pp3300_hub
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 3, 2020 at 10:38 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> The trogdor design has two options for supplying the pp3300_hub power rail,
> it can be supplied by pp3300_l7c or pp3300_a. Initially pp3300_l7c was
> used, newer revisions (will) use pp3300_a as supply.
>
> Add a DT node for the pp3300_a path which includes a power switch that is
> controlled by a GPIO. Make this path the default and keep trogdor rev1,
> lazor rev0 and rev1 on pp3300_l7c.

It might not hurt to mention that even on early hardware that GPIO84
was allocated to this purpose but that it was a stuff option for what
actually provided power to the hub.  This explains why it's OK to add
the fixed regulator (just with no clients) even on old hardware.  If
GPIO84 had been used for something else on old hardware this would
have been bad.


> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index bf875589d364..2d64e75a2d6d 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -174,6 +174,21 @@ pp3300_fp_tp: pp3300-fp-tp-regulator {
>                 vin-supply = <&pp3300_a>;
>         };
>
> +       pp3300_hub: pp3300-hub {
> +               compatible = "regulator-fixed";
> +               regulator-name = "pp3300_hub";
> +
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +
> +               gpio = <&tlmm 84 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&en_pp3300_hub>;
> +
> +               vin-supply = <&pp3300_a>;

You're leaving things in a bit of an inconsistent state here.  The
"pp3300_hub_7c" is always_on / boot_on.  This new one isn't.  I know
this is slightly more complicated due to the fact that downstream we
have a way to control the hub power but didn't quite get that resolved
upstream, but the way you have it now, on new hardware upstream will
power off the hub but also keep "pp3300_hub_7c" powered on for no
reason.  Seems like that should be fixed?


> +       };
> +
>         /* BOARD-SPECIFIC TOP LEVEL NODES */
>
>         backlight: backlight {
> @@ -469,7 +484,7 @@ ppvar_l6c: ldo6 {
>                         regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>                 };
>
> -               pp3300_hub:
> +               pp3300_hub_7c:

nit: If it were me, I probably wouldn't have bothered introducing the
"pp3300_hub_7c" alias since it's not a real thing in the schematic.  I
would have just had the older revisions refer to "pp3300_l7c".  If you
really love the "pp3300_hub_7c", though, I won't stand in your way.


>                 pp3300_l7c: ldo7 {
>                         regulator-min-microvolt = <3304000>;
>                         regulator-max-microvolt = <3304000>;
> @@ -1151,6 +1166,19 @@ pinconf {
>                 };
>         };
>
> +       en_pp3300_hub: en-pp3300-hub {
> +               pinmux {
> +                       pins = "gpio84";
> +                       function = "gpio";
> +               };
> +
> +               pinconf {
> +                       pins = "gpio84";
> +                       drive-strength = <2>;
> +                       bias-disable;
> +               };
> +       };
> +
>         en_pp3300_dx_edp: en-pp3300-dx-edp {

"hub" sorts after "dx", so the ordering is slightly wrong here.

-Doug
