Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D327222EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 01:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgGPXKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 19:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbgGPXJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:09:19 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E950C08C5E0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 15:38:08 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id g4so2282808uaq.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 15:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=APhlPP59dTHfjeAK3JyZRtdowaZApacEHqoZMv3vuLo=;
        b=lATawDG4pouGQZJSAvvkfunyTMl2IZ73PwYyG84GujpcBQnK6fr5WmNKFfOvC2b00Y
         y0FdmXe4rqtNjweViO0egIcCxyXAX5I3pO8ZsDeUzdVtx3QXDWPix9RMjhNYMwSON64A
         pG4aPJQ70gr5paOUAsbuqgtz69ax08jsU86UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=APhlPP59dTHfjeAK3JyZRtdowaZApacEHqoZMv3vuLo=;
        b=Z23p01piB3hdmwihwPuuT+HZn21RAhGr334yrNOf7aTwG0f0V5qZDT2Sz+Dp4sbzCz
         KJB3wd7qHNjMq1GqGx85RgAQoZzDb7Yl90Zuk2oMlENUo509yWacgi0mXmzceq86A+CE
         ENtcgEU9USdmDr7oMsd8K84/F6PgCbblJMJR9h1RjfAbbnFk7PJppn5jlKqjv7wy3yDL
         ALPmTQqtA0DAQOEbl5oQiWmEI+0PefeyziQ9zeiH5dPB6NimAbEcfUeeKHAni7nfOBET
         LdZ0uNepn6m8WTw6p3w2F2/s/jIpnLoQWyzV5O94LdTFToN5LPtcWaCjo3aLubgdJBtN
         HuuQ==
X-Gm-Message-State: AOAM532gtliLzQOcFviuwiUHWwcsd6Z+APmt3DboFxijS0yvTzowNyZB
        3+dF1El5rqxkhR/N0CTrihBVY1IHAt4=
X-Google-Smtp-Source: ABdhPJwQdYc7b7/u6lddtQ6Qyc/RhjoVxu6z30CbLa9HAVFLZMRXDwJ8gVTM/yWEgf58IxLIpCG2Ww==
X-Received: by 2002:a9f:3184:: with SMTP id v4mr5429864uad.68.1594939087342;
        Thu, 16 Jul 2020 15:38:07 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id d4sm944299vkf.29.2020.07.16.15.38.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 15:38:06 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id l12so2289129uak.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 15:38:05 -0700 (PDT)
X-Received: by 2002:a9f:3dc6:: with SMTP id e6mr5569576uaj.104.1594939085525;
 Thu, 16 Jul 2020 15:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200716191746.23196-1-sibis@codeaurora.org>
In-Reply-To: <20200716191746.23196-1-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 16 Jul 2020 15:37:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XgTvC2Xjw-pVcmS0vooYeGt_BthsWmhBZ4_8u-oJwkbg@mail.gmail.com>
Message-ID: <CAD=FV=XgTvC2Xjw-pVcmS0vooYeGt_BthsWmhBZ4_8u-oJwkbg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Move the fixed-perm property to
 SoC dtsi
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 16, 2020 at 12:18 PM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> All the platforms using SC7180 SoC are expected to have the wlan firmware
> memory statically mapped by the Trusted Firmware. Hence move back the
> qcom,msa-fixed-perm property to the SoC dtsi.
>
> Fixes: 7d484566087c0 ("arm64: dts: qcom: sc7180: Add missing properties for Wifi node")
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts | 1 -
>  arch/arm64/boot/dts/qcom/sc7180.dtsi    | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index 860fc4658b8b1..26cc4913d3ddc 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -392,7 +392,6 @@ video-firmware {
>
>  &wifi {
>         status = "okay";
> -       qcom,msa-fixed-perm;
>         vdd-0.8-cx-mx-supply = <&vreg_l9a_0p6>;
>         vdd-1.8-xo-supply = <&vreg_l1c_1p8>;
>         vdd-1.3-rfa-supply = <&vreg_l2c_1p3>;
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 126e2fce26c1a..a91d3f074625e 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -3233,6 +3233,7 @@ wifi: wifi@18800000 {
>                                 <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH /* CE10 */>,
>                                 <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH /* CE11 */>;
>                         memory-region = <&wlan_mem>;
> +                       qcom,msa-fixed-perm;

Seems good to me.  If someone ever comes up with a firmware where it's
sane to not have this property, we can either delete the property from
those boards or migrate the property to the the existing board dts
files.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
