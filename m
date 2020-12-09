Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEEF2D4EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 00:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388658AbgLIX0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 18:26:50 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45439 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgLIX0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 18:26:50 -0500
Received: by mail-oi1-f196.google.com with SMTP id f132so3642570oib.12;
        Wed, 09 Dec 2020 15:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jc2ISjfXNaO85nQIietRnAGYyI+v3pGIabwFQbhBCBc=;
        b=nP80m31+ItpqhqBZ7bhlCdEnpU/y+37tKkvCKFyPNuRdUK2yuy9gpgAyZk27Sl09VO
         UMDGdtU/mzdgYQPU24MpKL4FbeF19PoCL0y4OcLCF/asgYIodil6cpx0VVZH2MCxOQpe
         7ghDWWvuwMCxf1hGZROoKxbLlD/rsqzagSYcrrHXK5spxq03VJQpNWKKu+96wKS4y1s9
         f1GhvpQrDjzcCxS5k1PhtZO2r0jAPmx21fR4GB45ozO5X51TrLgFQpl5S4tO4wIuwmVv
         ew33NDDbLTMIpQA1zYWIlMxEo+bAWv235Bsot+tSNpAMkMQiqhv1SEpkS47cdsKP0/DK
         aRBg==
X-Gm-Message-State: AOAM532EMv73oNfoD7asEepcSrlCgiBgYdX+GZoNpSfEu92e5N9eh4CU
        0DnwUqP8htUB/50Hh7+zww==
X-Google-Smtp-Source: ABdhPJy3tbfTw1QZ7hS9mbcPe125z2HoZDeqARwEGnYbbJVl2zxIkM8YrmT619hhKAVkakp26p84vw==
X-Received: by 2002:aca:c492:: with SMTP id u140mr3592966oif.51.1607556368107;
        Wed, 09 Dec 2020 15:26:08 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 94sm700356otw.41.2020.12.09.15.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 15:26:07 -0800 (PST)
Received: (nullmailer pid 1275546 invoked by uid 1000);
        Wed, 09 Dec 2020 23:26:06 -0000
Date:   Wed, 9 Dec 2020 17:26:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: Add basic devicetree support for
 SM8350 SoC
Message-ID: <20201209232606.GB1258791@robh.at.kernel.org>
References: <20201204054347.2877857-1-vkoul@kernel.org>
 <20201204054347.2877857-4-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204054347.2877857-4-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 11:13:46AM +0530, Vinod Koul wrote:
> Add basic devicetree support for Qualcomm Technologies, Inc SM8350 SoC.
> This adds gcc, pinctrl, reserved memory, uart, cpu nodes for this SoC.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 496 +++++++++++++++++++++++++++
>  1 file changed, 496 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8350.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> new file mode 100644
> index 000000000000..9e4bb29abe62
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -0,0 +1,496 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2020, Linaro Limaited
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,gcc-sm8350.h>
> +#include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/mailbox/qcom-ipcc.h>
> +#include <dt-bindings/power/qcom-aoss-qmp.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +
> +/ {
> +	interrupt-parent = <&intc>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	chosen { };
> +
> +	clocks {
> +		xo_board: xo-board {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <38400000>;
> +			clock-output-names = "xo_board";
> +		};
> +
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32000>;
> +			#clock-cells = <0>;
> +		};
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		CPU0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";

Not documented. Nor likely specific enough to be accepted.

> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +			L2_0: l2-cache {
> +			      compatible = "cache";
> +			      next-level-cache = <&L3_0>;

Should have a 'level' property IIRC.

> +				L3_0: l3-cache {

Seems like this should be outside of cpus.

> +				      compatible = "cache";
> +				};
> +			};
> +		};
> +
> +		CPU1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x100>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_100>;
> +			L2_100: l2-cache {
> +			      compatible = "cache";
> +			      next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU2: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x200>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_200>;
> +			L2_200: l2-cache {
> +			      compatible = "cache";
> +			      next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU3: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x300>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_300>;
> +			L2_300: l2-cache {
> +			      compatible = "cache";
> +			      next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU4: cpu@400 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo485";
> +			reg = <0x0 0x400>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_400>;
> +			L2_400: l2-cache {
> +			      compatible = "cache";
> +			      next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU5: cpu@500 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo485";
> +			reg = <0x0 0x500>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_500>;
> +			L2_500: l2-cache {
> +			      compatible = "cache";
> +			      next-level-cache = <&L3_0>;
> +			};
> +
> +		};
> +
> +		CPU6: cpu@600 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo485";
> +			reg = <0x0 0x600>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_600>;
> +			L2_600: l2-cache {
> +			      compatible = "cache";
> +			      next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU7: cpu@700 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo485";
> +			reg = <0x0 0x700>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_700>;
> +			L2_700: l2-cache {
> +			      compatible = "cache";
> +			      next-level-cache = <&L3_0>;
> +			};
> +		};
> +	};
> +
> +	firmware {
> +		scm: scm {
> +			compatible = "qcom,scm";

SoC specific compatible?

> +			#reset-cells = <1>;
> +		};
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		/* We expect the bootloader to fill in the size */
> +		reg = <0x0 0x80000000 0x0 0x0>;
> +	};
> +
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +	};

Non-homogeneous system (big.LITTLE?), but only 1 PMU? All cores have the 
same events?

> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		hyp_mem: memory@80000000 {
> +			reg = <0x0 0x80000000 0x0 0x600000>;
> +			no-map;
> +		};
> +
> +		xbl_aop_mem: memory@80700000 {
> +			no-map;
> +			reg = <0x0 0x80700000 0x0 0x160000>;
> +		};
> +
> +		cmd_db: memory@80860000 {
> +			compatible = "qcom,cmd-db";
> +			reg = <0x0 0x80860000 0x0 0x20000>;
> +			no-map;
> +		};
> +
> +		reserved_xbl_uefi_log: memory@80880000 {
> +			reg = <0x0 0x80880000 0x0 0x14000>;
> +			no-map;
> +		};
> +
> +		smem_mem: memory@80900000 {
> +			reg = <0x0 0x80900000 0x0 0x200000>;
> +			no-map;
> +		};
> +
> +		cpucp_fw_mem: memory@80b00000 {
> +			reg = <0x0 0x80b00000 0x0 0x100000>;
> +			no-map;
> +		};
> +
> +		cdsp_secure_heap: memory@80c00000 {
> +			reg = <0x0 0x80c00000 0x0 0x4600000>;
> +			no-map;
> +		};
> +
> +		pil_camera_mem: mmeory@85200000 {
> +			reg = <0x0 0x85200000 0x0 0x500000>;
> +			no-map;
> +		};
> +
> +		pil_video_mem: memory@85700000 {
> +			reg = <0x0 0x85700000 0x0 0x500000>;
> +			no-map;
> +		};
> +
> +		pil_cvp_mem: memory@85c00000 {
> +			reg = <0x0 0x85c00000 0x0 0x500000>;
> +			no-map;
> +		};
> +
> +		pil_adsp_mem: memory@86100000 {
> +			reg = <0x0 0x86100000 0x0 0x2100000>;
> +			no-map;
> +		};
> +
> +		pil_slpi_mem: memory@88200000 {
> +			reg = <0x0 0x88200000 0x0 0x1500000>;
> +			no-map;
> +		};
> +
> +		pil_cdsp_mem: memory@89700000 {
> +			reg = <0x0 0x89700000 0x0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		pil_ipa_fw_mem: memory@8b500000 {
> +			reg = <0x0 0x8b500000 0x0 0x10000>;
> +			no-map;
> +		};
> +
> +		pil_ipa_gsi_mem: memory@8b510000 {
> +			reg = <0x0 0x8b510000 0x0 0xa000>;
> +			no-map;
> +		};
> +
> +		pil_gpu_mem: memory@8b51a000 {
> +			reg = <0x0 0x8b51a000 0x0 0x2000>;
> +			no-map;
> +		};
> +
> +		pil_spss_mem: memory@8b600000 {
> +			reg = <0x0 0x8b600000 0x0 0x100000>;
> +			no-map;
> +		};
> +
> +		pil_modem_mem: memory@8b800000 {
> +			reg = <0x0 0x8b800000 0x0 0x10000000>;
> +			no-map;
> +		};
> +
> +		hyp_reserved_mem: memory@d0000000 {
> +			reg = <0x0 0xd0000000 0x0 0x800000>;
> +			no-map;
> +		};
> +
> +		pil_trustedvm_mem: memory@d0800000 {
> +			reg = <0x0 0xd0800000 0x0 0x76f7000>;
> +			no-map;
> +		};
> +
> +		qrtr_shbuf: memory@d7ef7000 {
> +			reg = <0x0 0xd7ef7000 0x0 0x9000>;
> +			no-map;
> +		};
> +
> +		chan0_shbuf: memory@d7f00000 {
> +			reg = <0x0 0xd7f00000 0x0 0x80000>;
> +			no-map;
> +		};
> +
> +		chan1_shbuf: memory@d7f80000 {
> +			reg = <0x0 0xd7f80000 0x0 0x80000>;
> +			no-map;
> +		};
> +
> +		removed_mem: memory@d8800000 {
> +			reg = <0x0 0xd8800000 0x0 0x6800000>;
> +			no-map;
> +		};
> +	};
> +
> +	smem: qcom,smem {
> +		compatible = "qcom,smem";
> +		memory-region = <&smem_mem>;
> +		hwlocks = <&tcsr_mutex 3>;
> +	};
> +
> +	soc: soc@0 {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0 0 0 0 0x10 0>;
> +		dma-ranges = <0 0 0 0 0x10 0>;
> +		compatible = "simple-bus";
> +
> +		gcc: clock-controller@100000 {
> +			compatible = "qcom,gcc-sm8350";
> +			reg = <0x0 0x00100000 0x0 0x1f0000>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +			clock-names = "bi_tcxo", "sleep_clk";
> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>;
> +		};
> +
> +		ipcc: mailbox@408000 {
> +			compatible = "qcom,sm8350-ipcc", "qcom,ipcc";
> +			reg = <0 0x00408000 0 0x1000>;
> +			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			#mbox-cells = <2>;
> +		};
> +
> +		qupv3_id_1: geniqup@9c0000 {
> +			compatible = "qcom,geni-se-qup";
> +			reg = <0x0 0x009c0000 0x0 0x6000>;
> +			clock-names = "m-ahb", "s-ahb";
> +			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
> +				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			status = "disabled";
> +
> +			uart2: serial@98c000 {
> +				compatible = "qcom,geni-debug-uart";
> +				reg = <0 0x0098c000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_uart3_default>;
> +				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		tcsr_mutex: hwlock@1f40000 {
> +			compatible = "qcom,tcsr-mutex";
> +			reg = <0x0 0x01f40000 0x0 0x40000>;
> +			#hwlock-cells = <1>;
> +		};
> +
> +		pdc: interrupt-controller@b220000 {
> +			compatible = "qcom,sm8350-pdc", "qcom,pdc";
> +			reg = <0 0x0b220000 0 0x30000>, <0 0x17c000f0 0 0x60>;
> +			qcom,pdc-ranges = <0 480 40>, <40 140 14>, <54 263 1>,   <55 306 4>,
> +					  <59 312 3>, <62 374 2>,  <64 434 2>,   <66 438 3>,
> +					  <69 86 1>,  <70 520 54>, <124 609 31>, <155 63 1>,
> +					  <156 716 12>;
> +			#interrupt-cells = <2>;
> +			interrupt-parent = <&intc>;
> +			interrupt-controller;
> +		};
> +
> +		aoss_qmp: qmp@c300000 {
> +			compatible = "qcom,sm8350-aoss-qmp";
> +			reg = <0 0x0c300000 0 0x100000>;
> +			interrupts-extended = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP
> +						     IRQ_TYPE_EDGE_RISING>;
> +			mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +			#clock-cells = <0>;
> +			#power-domain-cells = <1>;
> +		};
> +
> +		tlmm: pinctrl@f000000 {
> +			compatible = "qcom,sm8350-pinctrl";
> +			reg = <0 0x0f100000 0 0x300000>;
> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			gpio-ranges = <&tlmm 0 0 203>;
> +
> +			qup_uart3_default: qup-uart3-default {
> +				mux {
> +					pins = "gpio18", "gpio19";
> +					function = "qup3";
> +				};
> +			};
> +		};
> +
> +		intc: interrupt-controller@17a00000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
> +			      <0x0 0x17a60000 0x0 0x100000>;    /* GICR * 8 */
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		timer@17c20000 {
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			compatible = "arm,armv7-timer-mem";
> +			reg = <0x0 0x17c20000 0x0 0x1000>;
> +			clock-frequency = <19200000>;
> +
> +			frame@17c21000 {
> +				frame-number = <0>;
> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0 0x17c21000 0x0 0x1000>,
> +				      <0x0 0x17c22000 0x0 0x1000>;
> +			};
> +
> +			frame@17c23000 {
> +				frame-number = <1>;
> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0 0x17c23000 0x0 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@17c25000 {
> +				frame-number = <2>;
> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0 0x17c25000 0x0 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@17c27000 {
> +				frame-number = <3>;
> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0 0x17c27000 0x0 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@17c29000 {
> +				frame-number = <4>;
> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0 0x17c29000 0x0 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@17c2b000 {
> +				frame-number = <5>;
> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0 0x17c2b000 0x0 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@17c2d000 {
> +				frame-number = <6>;
> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0 0x17c2d000 0x0 0x1000>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		apps_rsc: rsc@18200000 {
> +			label = "apps_rsc";
> +			compatible = "qcom,rpmh-rsc";
> +			reg = <0x0 0x18200000 0x0 0x10000>,
> +				<0x0 0x18210000 0x0 0x10000>,
> +				<0x0 0x18220000 0x0 0x10000>;
> +			reg-names = "drv-0", "drv-1", "drv-2";
> +			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +			qcom,tcs-offset = <0xd00>;
> +			qcom,drv-id = <2>;
> +			qcom,tcs-config = <ACTIVE_TCS  2>, <SLEEP_TCS   3>,
> +					  <WAKE_TCS    3>, <CONTROL_TCS 1>;
> +
> +			rpmhcc: clock-controller {
> +				compatible = "qcom,sm8350-rpmh-clk";
> +				#clock-cells = <1>;
> +				clock-names = "xo";
> +				clocks = <&xo_board>;
> +			};
> +
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +};
> -- 
> 2.26.2
> 
