Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336C62CFBA8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 16:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgLEPFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 10:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgLEO60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 09:58:26 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82697C02B8F2;
        Sat,  5 Dec 2020 06:44:55 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id c7so8928318edv.6;
        Sat, 05 Dec 2020 06:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFAHiMN3oJhDdgqFtDbrx6UCUsf17ToyG34xNFNkHjY=;
        b=cJlvK9df8IWrXflwWQvrFhEwakzOBxK1Qy9aQmM75tPwr0/dDGYEAwXyI/OUSDzOQO
         pShryvriThgTjfxIu91v3vmXhFcMC/ZGmWvATLRPoWdj9I8bzLd/n7V3YLZczhs5m3CH
         afzPtHsnd/jfN8El92YR2tFjwyIkpYZnLSSPtaodV8RIdtZYjGPRr2/0SMkVqzT1lXUc
         j9atvTLCnOaBKnWFfvyTBqe4g9pa7TtA92i2dQxmEazqNd63CCu7zDo3YrnuWxr/lK5a
         6cJTAxGB8mWgzHiJMKLkujhXIjHME7nyBBpzpFkt8tBFnpc7m5a6MaA7UObZQGu9QWzK
         HGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFAHiMN3oJhDdgqFtDbrx6UCUsf17ToyG34xNFNkHjY=;
        b=lrMTaks1pyY6A666aJRvQUEU+t6Sh/0zQqQfZq7qvMy32HMa9X6nMKoosERx9GdTPl
         GyHY9HrTn+VhiFGwAIPjkWs8j5ay/+uTkA/H4WCNGCw7CC3tinXBkmWVDAHJRznwJy+y
         VZEPr2XcM+T+vGh9Bs50Juo9JWQ3Bcq0rlJdiEl5xRSai4XU1ixGK2+YXwNlI6ACZ/L5
         RuFlyLYzTcLBQhWbR2O0wFArcwDj2W4e47fn04a4hofOVhHqy6TIFjfLEgwOskFmGBRf
         xeYasLQbIVLsfKAodHQLKHrkpXivxlRIGH6PpMZhRpwmzL8TtNLfwQhKknUEhbzu3jzz
         bzbQ==
X-Gm-Message-State: AOAM532AKKJVu47hpbilS4h3i57//4oZO+hI1T/FTClQl1veC4fWEkl9
        cNjgpo0/qQmJJQA1ycDSjFxc4jNw8c1EbP53QZw=
X-Google-Smtp-Source: ABdhPJz8w4RhKjOt+eNG5VaXyoGnjvEueXytNVeW3mk6jIGOR0Py/VDKIO4Sc6QeQLs2qk3v4z+lEQhrDugaAUU6Wy0=
X-Received: by 2002:a50:cd57:: with SMTP id d23mr12299637edj.95.1607179494143;
 Sat, 05 Dec 2020 06:44:54 -0800 (PST)
MIME-Version: 1.0
References: <20201204071107.25206-1-huangshuosheng@allwinnertech.com>
In-Reply-To: <20201204071107.25206-1-huangshuosheng@allwinnertech.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sat, 5 Dec 2020 22:44:43 +0800
Message-ID: <CAEExFWs0aXNuQyazdfgeFkjrj9cBbY0vZMSgNHRPkf_XCLhJbw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: a100: Add CPU Operating
 Performance Points table
To:     Shuosheng Huang <huangshuosheng@allwinnertech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, jernej.skrabec@siol.net,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI shuosheng,

On Fri, Dec 4, 2020 at 3:11 PM Shuosheng Huang
<huangshuosheng@allwinnertech.com> wrote:
>
> Add an Operating Performance Points table for the CPU cores to
> enable Dynamic Voltage & Frequency Scaling on the A100.
>
> Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> ---
>  .../allwinner/sun50i-a100-allwinner-perf1.dts |  5 ++
>  .../dts/allwinner/sun50i-a100-cpu-opp.dtsi    | 90 +++++++++++++++++++
>  .../arm64/boot/dts/allwinner/sun50i-a100.dtsi |  8 ++
>  3 files changed, 103 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
> index d34c2bb1079f..7c579923f973 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
> @@ -6,6 +6,7 @@
>  /dts-v1/;
>
>  #include "sun50i-a100.dtsi"
> +#include "sun50i-a100-cpu-opp.dtsi"
>
>  /{
>         model = "Allwinner A100 Perf1";
> @@ -20,6 +21,10 @@ chosen {
>         };
>  };
>
> +&cpu0 {
> +       cpu-supply = <&reg_dcdc2>;
> +};
> +
>  &pio {
>         vcc-pb-supply = <&reg_dcdc1>;
>         vcc-pc-supply = <&reg_eldo1>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi
> new file mode 100644
> index 000000000000..bc8ceaa38392
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// Copyright (c) 2020 Yangtao Li <frank@allwinnertech.com>
> +// Copyright (c) 2020 ShuoSheng Huang <huangshuosheng@allwinnertech.com>
> +
> +/ {
> +       cpu_opp_table: cpu-opp-table {
> +               compatible = "allwinner,sun50i-h6-operating-points";
> +               nvmem-cells = <&cpu_speed_grade>;
> +               opp-shared;
> +
> +               opp@408000000 {
> +                       clock-latency-ns = <244144>; /* 8 32k periods */
> +                       opp-hz = /bits/ 64 <408000000>;
> +
> +                       opp-microvolt-speed0 = <900000 900000 1200000>;
> +                       opp-microvolt-speed0 = <900000 900000 1200000>;
> +                       opp-microvolt-speed0 = <900000 900000 1200000>;
> +               };

This should be opp-microvolt-speed0, opp-microvolt-speed1 and
opp-microvolt-speed2.
You may have problems with the replacement when forming the patch.
The following also needs to be modified.

Yangtao
