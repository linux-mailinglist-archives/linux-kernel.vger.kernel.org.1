Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E2C2D0D38
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgLGJmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:42:24 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36115 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgLGJmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:42:23 -0500
Received: by mail-vs1-f65.google.com with SMTP id s85so7209532vsc.3;
        Mon, 07 Dec 2020 01:42:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OixokW25iwFIxbfuqn64KKlZ7jFOxYUsBipI8vFI4jM=;
        b=aD5QlWLsoVYmNQagB1g+bloUX1AS9PcGeLJLO0r4INEdOF/qHIOdiCAYPZc1P++iGx
         npK2YJymTHUJ1yWXdePPuuGkwRYFUb2BUtZG/yfAeZg+2rUBLPtSuH+oMwcBIRNvL/Ai
         rI5B1VpwslVeowOY9E+BYBm2uWl3c5nxZzkB+nr+Z5y0iOHIUmz0sQ8vFtYFidBIxTDW
         K7Wq8+/Hm8J9E/M+doCVoxO+zUK5yD00JrqvxYhWqG15ZiRmHDcW4RUjRM/cgAwW8LJX
         lmANpPj9ExX1BbzMLLm004P/2ug3GdKT3xlS/KrfEVUiqP2cTO9HeKpI0itOHfPjPHTY
         CBPA==
X-Gm-Message-State: AOAM5337OtZSl9zKDRUBTvhVD7fb8KIVZ8sbHreCXHbFwghrwohHeI0C
        Q/xRo6a08PKfzSfrFgsD50etnV4Wx7ZLzA==
X-Google-Smtp-Source: ABdhPJz1J0MZzTqNGpmk9vNogB7VYsD+gxvbWAOTaCcaaicyOVOZfTCczqNk2xW/2CuHmY277ejSgA==
X-Received: by 2002:a67:de13:: with SMTP id q19mr12243396vsk.40.1607334100299;
        Mon, 07 Dec 2020 01:41:40 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id o192sm1610949vko.19.2020.12.07.01.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 01:41:39 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id j140so7197276vsd.4;
        Mon, 07 Dec 2020 01:41:39 -0800 (PST)
X-Received: by 2002:a67:fb8f:: with SMTP id n15mr12581225vsr.30.1607334099384;
 Mon, 07 Dec 2020 01:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20201207091953.15451-1-huangshuosheng@allwinnertech.com>
In-Reply-To: <20201207091953.15451-1-huangshuosheng@allwinnertech.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 7 Dec 2020 17:41:26 +0800
X-Gmail-Original-Message-ID: <CAGb2v65GJMmwK3Qd5gxGMk=9itqePcg5o=PqTQDXfjTECcJckQ@mail.gmail.com>
Message-ID: <CAGb2v65GJMmwK3Qd5gxGMk=9itqePcg5o=PqTQDXfjTECcJckQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] arm64: dts: allwinner: a100: Add CPU Operating
 Performance Points table
To:     =?UTF-8?B?6buE54OB55Sf?= <huangshuosheng@allwinnertech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Yangtao Li <tiny.windzz@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 5:20 PM Shuosheng Huang
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

Please add this for all CPU cores.

IIRC people (I don't remember exactly who) have reported that if the first
CPU core is offline, i.e. having Linux booting off one of the other CPU
cores, then cpufreq sort of breaks as the CPU no longer has a regulator tied
to it.

Also, please separate the changes in sun50i-a100-allwinner-perf1.dts to
one patch titled "Enable cpufreq for <some device>".

>  &pio {
>         vcc-pb-supply = <&reg_dcdc1>;
>         vcc-pc-supply = <&reg_eldo1>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi
> new file mode 100644
> index 000000000000..e245823d70e8
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
> +                       opp-microvolt-speed1 = <900000 900000 1200000>;
> +                       opp-microvolt-speed2 = <900000 900000 1200000>;
> +               };
> +
> +               opp@600000000 {
> +                       clock-latency-ns = <244144>; /* 8 32k periods */
> +                       opp-hz = /bits/ 64 <600000000>;
> +
> +                       opp-microvolt-speed0 = <900000 900000 1200000>;
> +                       opp-microvolt-speed1 = <900000 900000 1200000>;
> +                       opp-microvolt-speed2 = <900000 900000 1200000>;
> +               };
> +
> +               opp@816000000 {
> +                       clock-latency-ns = <244144>; /* 8 32k periods */
> +                       opp-hz = /bits/ 64 <816000000>;
> +
> +                       opp-microvolt-speed0 = <940000 940000 1200000>;
> +                       opp-microvolt-speed1 = <900000 900000 1200000>;
> +                       opp-microvolt-speed2 = <900000 900000 1200000>;
> +               };
> +
> +               opp@1080000000 {
> +                       clock-latency-ns = <244144>; /* 8 32k periods */
> +                       opp-hz = /bits/ 64 <1080000000>;
> +
> +                       opp-microvolt-speed0 = <1020000 1020000 1200000>;
> +                       opp-microvolt-speed1 = <980000 980000 1200000>;
> +                       opp-microvolt-speed2 = <950000 950000 1200000>;
> +               };
> +
> +               opp@1200000000 {
> +                       clock-latency-ns = <244144>; /* 8 32k periods */
> +                       opp-hz = /bits/ 64 <1200000000>;
> +
> +                       opp-microvolt-speed0 = <1100000 1100000 1200000>;
> +                       opp-microvolt-speed1 = <1020000 1020000 1200000>;
> +                       opp-microvolt-speed2 = <1000000 1000000 1200000>;
> +               };
> +
> +               opp@1320000000 {
> +                       clock-latency-ns = <244144>; /* 8 32k periods */
> +                       opp-hz = /bits/ 64 <1320000000>;
> +
> +                       opp-microvolt-speed0 = <1160000 1160000 1200000>;
> +                       opp-microvolt-speed1 = <1060000 1060000 1200000>;
> +                       opp-microvolt-speed2 = <1030000 1030000 1200000>;
> +               };
> +
> +               opp@1464000000 {
> +                       clock-latency-ns = <244144>; /* 8 32k periods */
> +                       opp-hz = /bits/ 64 <1464000000>;
> +
> +                       opp-microvolt-speed0 = <1180000 1180000 1200000>;
> +                       opp-microvolt-speed1 = <1180000 1180000 1200000>;
> +                       opp-microvolt-speed2 = <1130000 1130000 1200000>;
> +               };
> +       };
> +};
> +
> +&cpu0 {
> +       operating-points-v2 = <&cpu_opp_table>;
> +};
> +
> +&cpu1 {
> +       operating-points-v2 = <&cpu_opp_table>;
> +};
> +
> +&cpu2 {
> +       operating-points-v2 = <&cpu_opp_table>;
> +};
> +
> +&cpu3 {
> +       operating-points-v2 = <&cpu_opp_table>;
> +};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> index cc321c04f121..8f370a175ce6 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> @@ -23,6 +23,7 @@ cpu0: cpu@0 {
>                         device_type = "cpu";
>                         reg = <0x0>;
>                         enable-method = "psci";
> +                       clocks = <&ccu CLK_CPUX>;
>                 };
>
>                 cpu@1 {
> @@ -30,6 +31,7 @@ cpu@1 {
>                         device_type = "cpu";
>                         reg = <0x1>;
>                         enable-method = "psci";
> +                       clocks = <&ccu CLK_CPUX>;
>                 };
>
>                 cpu@2 {
> @@ -37,6 +39,7 @@ cpu@2 {
>                         device_type = "cpu";
>                         reg = <0x2>;
>                         enable-method = "psci";
> +                       clocks = <&ccu CLK_CPUX>;
>                 };
>
>                 cpu@3 {
> @@ -44,6 +47,7 @@ cpu@3 {
>                         device_type = "cpu";
>                         reg = <0x3>;
>                         enable-method = "psci";
> +                       clocks = <&ccu CLK_CPUX>;
>                 };
>         };

This part should probably be in a separate "fix" patch titled
"add clocks to CPU cores".

> @@ -121,6 +125,10 @@ efuse@3006000 {
>                         ths_calibration: calib@14 {
>                                 reg = <0x14 8>;
>                         };
> +
> +                       cpu_speed_grade: cpu-speed-grade@1c {
> +                               reg = <0x1c 0x2>;
> +                       };

And this would be another patch, "Add CPU speed grade efuse cell".

So your series would look like:

1. cpufreq: sun50i: add efuse_xlate to get efuse version
2. cpufreq: sun50i: add a100 cpufreq support
3. arm64: dts: allwinner: a100: Add clocks to CPU cores
4. arm64: dts: allwinner: a100: Add CPU speed grade efuse cell
5. arm64: dts: allwinner: a100: Add Add CPU Operating Performance Points table
6. arm64: dts: allwinner: a100: Enable cpufreq on <some device>


Regards
ChenYu


>                 };
>
>                 pio: pinctrl@300b000 {


> --
> 2.28.0
>
