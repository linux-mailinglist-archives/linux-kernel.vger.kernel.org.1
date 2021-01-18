Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6602FA2DB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404823AbhAROWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:22:38 -0500
Received: from foss.arm.com ([217.140.110.172]:36964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392974AbhAROVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:21:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F1911FB;
        Mon, 18 Jan 2021 06:20:24 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F9CE3F68F;
        Mon, 18 Jan 2021 06:20:23 -0800 (PST)
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: rename thermal subnodes for
 rk3399.dtsi
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
References: <20210117150953.16475-1-jbx6244@gmail.com>
 <20210117150953.16475-3-jbx6244@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c92467e0-3901-4a1c-3857-6ef055acc381@arm.com>
Date:   Mon, 18 Jan 2021 14:20:23 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210117150953.16475-3-jbx6244@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-17 15:09, Johan Jonker wrote:
> A test with the command below gives for example this error:
> /arch/arm64/boot/dts/rockchip/rk3399-evb.dt.yaml:
> thermal-zones: 'cpu', 'gpu' do not match any of the regexes:
> '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'
> 
> Rename Rockchip rk3399 thermal subnodes so that it ends
> with "-thermal"
> 
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/
> thermal/thermal-zones.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3399-rock960.dts | 2 +-
>   arch/arm64/boot/dts/rockchip/rk3399.dtsi        | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> index c88295782..b20774081 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> @@ -126,7 +126,7 @@
>   };
>   
>   &thermal_zones {
> -	cpu_thermal: cpu {
> +	cpu_thermal: cpu-thermal {
>   		polling-delay-passive = <100>;
>   		polling-delay = <1000>;
>   		thermal-sensors = <&tsadc 0>;

Passing observation: why is this DT not just referencing &cpu_thermal 
directly to add the board-specific parts (and not repeat all the SoC 
default properties) anyway? Cleaning the whole thing up might have been 
a good idea :/

Robin.

> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 4e94b7ebd..3de493ad6 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -761,7 +761,7 @@
>   	};
>   
>   	thermal_zones: thermal-zones {
> -		cpu_thermal: cpu {
> +		cpu_thermal: cpu-thermal {
>   			polling-delay-passive = <100>;
>   			polling-delay = <1000>;
>   
> @@ -805,7 +805,7 @@
>   			};
>   		};
>   
> -		gpu_thermal: gpu {
> +		gpu_thermal: gpu-thermal {
>   			polling-delay-passive = <100>;
>   			polling-delay = <1000>;
>   
> 
