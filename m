Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D97127B4FC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 21:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgI1TFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 15:05:36 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37792 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgI1TFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 15:05:32 -0400
Received: by mail-oi1-f194.google.com with SMTP id a3so2559560oib.4;
        Mon, 28 Sep 2020 12:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XDu2k2l6eYaFtU/ZuyxSaqn6hMorOD2nCW+3Flv0l90=;
        b=OfMNMIvVTPpVZ7oTvC75u6lW/i9N6BHSBM+Ie3P3Vn4ZWf+pAUUdEfKpgEiGa/Y0rJ
         Z7JH3fIrfJ8bfOTTakh4hIOtuuJnDkxxfk2PvmBhhjVFuxYPeYPtEMvTqEvTmhU9mDIU
         gpwgxp/XeeEGIQTMj7NVScZNbq30zwi65d98m+d/isD7LeUJ/8tuGDG6TyEdzq8psJG2
         OT+Pp4BgoLoDO1YLCRTmjeESkzFK08ArNgP6TCD8YJ/r86wZp8Oq5DGf45L2IXy0J8jF
         GIVPPEjkaMxrXR+4NhqwWirIK+wIAGmv1ydePyR8B65zV4XDskMt/Bc/KrrZiKGMOmUw
         DU9g==
X-Gm-Message-State: AOAM530nDbCbCWwAyPJ18AE9L7pgO/De7pxUhiT9vumnkusywq2YOLsu
        /Ny8ETajUZxkP0FYeDbASw==
X-Google-Smtp-Source: ABdhPJzSIhfuMLlGr7rmeHQ1zMkfF5B4ATyTNayvLRTSv847QcF8PXKecjGUO4TVsXOzNVnSq4asCw==
X-Received: by 2002:aca:568d:: with SMTP id k135mr224087oib.136.1601319930279;
        Mon, 28 Sep 2020 12:05:30 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 71sm457506otm.81.2020.09.28.12.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 12:05:29 -0700 (PDT)
Received: (nullmailer pid 3088450 invoked by uid 1000);
        Mon, 28 Sep 2020 19:05:28 -0000
Date:   Mon, 28 Sep 2020 14:05:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Wei Xu <xuwei5@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 01/20] dt-bindings: arm: hisilicon: split the
 dt-bindings of each controller into a separate file
Message-ID: <20200928190528.GA3082719@bogus>
References: <20200928151324.2134-1-thunder.leizhen@huawei.com>
 <20200928151324.2134-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928151324.2134-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 11:13:05PM +0800, Zhen Lei wrote:
> Split the devicetree bindings of each Hisilicon controller from
> hisilicon.txt into a separate file, the file name is the compatible name
> attach the .txt file name extension.
> 
> All Hi6220 dedicated controllers are grouped into subdirectory "hi3620".
> All HiPxx  dedicated controllers are grouped into subdirectory "hipxx"
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../arm/hisilicon/controller/hisilicon,cpuctrl.txt |   8 +
>  .../hisilicon/controller/hisilicon,dsa-subctrl.txt |  15 ++
>  .../controller/hisilicon,hi3798cv200-perictrl.txt  |  21 ++
>  .../controller/hisilicon,hi6220-aoctrl.txt         |  18 ++
>  .../controller/hisilicon,hi6220-mediactrl.txt      |  18 ++
>  .../controller/hisilicon,hi6220-pmctrl.txt         |  18 ++
>  .../controller/hisilicon,hi6220-sramctrl.txt       |  16 ++
>  .../controller/hisilicon,hi6220-sysctrl.txt        |  19 ++
>  .../controller/hisilicon,hip01-sysctrl.txt         |  19 ++
>  .../controller/hisilicon,hip04-bootwrapper.txt     |   9 +
>  .../controller/hisilicon,hip04-fabric.txt          |   5 +
>  .../controller/hisilicon,pcie-sas-subctrl.txt      |  15 ++
>  .../arm/hisilicon/controller/hisilicon,pctrl.txt   |  13 +
>  .../controller/hisilicon,peri-subctrl.txt          |  16 ++
>  .../arm/hisilicon/controller/hisilicon,sysctrl.txt |  25 ++
>  .../bindings/arm/hisilicon/hisilicon.txt           | 262 ---------------------
>  16 files changed, 235 insertions(+), 262 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,dsa-subctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-aoctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-pmctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-sramctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-sysctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip01-sysctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-fabric.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,peri-subctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt
> new file mode 100644
> index 000000000000000..ceffac537671668
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt
> @@ -0,0 +1,8 @@
> +Hisilicon CPU controller
> +
> +Required properties:
> +- compatible : "hisilicon,cpuctrl"
> +- reg : Register address and size
> +
> +The clock registers and power registers of secondary cores are defined
> +in CPU controller, especially in HIX5HD2 SoC.
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,dsa-subctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,dsa-subctrl.txt
> new file mode 100644
> index 000000000000000..4d1c6abf03f6f97
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,dsa-subctrl.txt
> @@ -0,0 +1,15 @@
> +Hisilicon HiP05/HiP06 DSA sub system controller
> +
> +Required properties:
> +- compatible : "hisilicon,dsa-subctrl", "syscon";

This and others with only 'reg' can just be moved to syscon.yaml.

> +- reg : Register address and size
> +
> +The DSA sub system controller is shared by peripheral controllers in
> +HiP05 or HiP06 Soc to implement some basic configurations.
> +
> +Example:
> +	/* for HiP05 dsa sub system */
> +	pcie_sas: system_controller@a0000000 {
> +		compatible = "hisilicon,dsa-subctrl", "syscon";
> +		reg = <0xa0000000 0x10000>;
> +	};
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
> new file mode 100644
> index 000000000000000..0d5282f4670658d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
> @@ -0,0 +1,21 @@
> +Hisilicon Hi3798CV200 Peripheral Controller
> +
> +The Hi3798CV200 Peripheral Controller controls peripherals, queries
> +their status, and configures some functions of peripherals.
> +
> +Required properties:
> +- compatible: Should contain "hisilicon,hi3798cv200-perictrl", "syscon"
> +  and "simple-mfd".
> +- reg: Register address and size of Peripheral Controller.
> +- #address-cells: Should be 1.
> +- #size-cells: Should be 1.
> +
> +Examples:
> +
> +	perictrl: peripheral-controller@8a20000 {
> +		compatible = "hisilicon,hi3798cv200-perictrl", "syscon",
> +			     "simple-mfd";
> +		reg = <0x8a20000 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +	};
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-aoctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-aoctrl.txt
> new file mode 100644
> index 000000000000000..5a723c1d45f4a17
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-aoctrl.txt
> @@ -0,0 +1,18 @@
> +Hisilicon Hi6220 Power Always ON domain controller
> +
> +Required properties:
> +- compatible : "hisilicon,hi6220-aoctrl"
> +- reg : Register address and size
> +- #clock-cells: should be set to 1, many clock registers are defined
> +  under this controller and this property must be present.
> +
> +Hisilicon designs this system controller to control the power always
> +on domain for mobile platform.
> +
> +Example:
> +	/*for Hi6220*/
> +	ao_ctrl: ao_ctrl@f7800000 {
> +		compatible = "hisilicon,hi6220-aoctrl", "syscon";
> +		reg = <0x0 0xf7800000 0x0 0x2000>;
> +		#clock-cells = <1>;
> +	};
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.txt
> new file mode 100644
> index 000000000000000..dcfdcbcb6455771
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.txt
> @@ -0,0 +1,18 @@
> +Hisilicon Hi6220 Media domain controller
> +
> +Required properties:
> +- compatible : "hisilicon,hi6220-mediactrl"
> +- reg : Register address and size
> +- #clock-cells: should be set to 1, many clock registers are defined
> +  under this controller and this property must be present.
> +
> +Hisilicon designs this system controller to control the multimedia
> +domain(e.g. codec, G3D ...) for mobile platform.
> +
> +Example:
> +	/*for Hi6220*/
> +	media_ctrl: media_ctrl@f4410000 {
> +		compatible = "hisilicon,hi6220-mediactrl", "syscon";
> +		reg = <0x0 0xf4410000 0x0 0x1000>;
> +		#clock-cells = <1>;
> +	};
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-pmctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-pmctrl.txt
> new file mode 100644
> index 000000000000000..972842f07b5a2ce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-pmctrl.txt
> @@ -0,0 +1,18 @@
> +Hisilicon Hi6220 Power Management domain controller
> +
> +Required properties:
> +- compatible : "hisilicon,hi6220-pmctrl"
> +- reg : Register address and size
> +- #clock-cells: should be set to 1, some clock registers are define
> +  under this controller and this property must be present.
> +
> +Hisilicon designs this system controller to control the power management
> +domain for mobile platform.
> +
> +Example:
> +	/*for Hi6220*/
> +	pm_ctrl: pm_ctrl@f7032000 {
> +		compatible = "hisilicon,hi6220-pmctrl", "syscon";
> +		reg = <0x0 0xf7032000 0x0 0x1000>;
> +		#clock-cells = <1>;
> +	};
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-sramctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-sramctrl.txt
> new file mode 100644
> index 000000000000000..086b7acccc5edc4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-sramctrl.txt
> @@ -0,0 +1,16 @@
> +Hisilicon Hi6220 SRAM controller
> +
> +Required properties:
> +- compatible : "hisilicon,hi6220-sramctrl", "syscon"
> +- reg : Register address and size
> +
> +Hisilicon's SoCs use sram for multiple purpose; on Hi6220 there have several
> +SRAM banks for power management, modem, security, etc. Further, use "syscon"
> +managing the common sram which can be shared by multiple modules.
> +
> +Example:
> +	/*for Hi6220*/
> +	sram: sram@fff80000 {
> +		compatible = "hisilicon,hi6220-sramctrl", "syscon";
> +		reg = <0x0 0xfff80000 0x0 0x12000>;
> +	};
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-sysctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-sysctrl.txt
> new file mode 100644
> index 000000000000000..07e318eda254f52
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-sysctrl.txt
> @@ -0,0 +1,19 @@
> +Hisilicon Hi6220 system controller
> +
> +Required properties:
> +- compatible : "hisilicon,hi6220-sysctrl"
> +- reg : Register address and size
> +- #clock-cells: should be set to 1, many clock registers are defined
> +  under this controller and this property must be present.
> +
> +Hisilicon designs this controller as one of the system controllers,
> +its main functions are the same as Hisilicon system controller, but
> +the register offset of some core modules are different.
> +
> +Example:
> +	/*for Hi6220*/
> +	sys_ctrl: sys_ctrl@f7030000 {
> +		compatible = "hisilicon,hi6220-sysctrl", "syscon";
> +		reg = <0x0 0xf7030000 0x0 0x2000>;
> +		#clock-cells = <1>;
> +	};
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip01-sysctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip01-sysctrl.txt
> new file mode 100644
> index 000000000000000..db2dfdce799db91
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip01-sysctrl.txt
> @@ -0,0 +1,19 @@
> +Hisilicon HiP01 system controller
> +
> +Required properties:
> +- compatible : "hisilicon,hip01-sysctrl"
> +- reg : Register address and size
> +
> +The HiP01 system controller is mostly compatible with hisilicon
> +system controller,but it has some specific control registers for
> +HIP01 SoC family, such as slave core boot, and also some same
> +registers located at different offset.
> +
> +Example:
> +
> +	/* for hip01-ca9x2 */
> +	sysctrl: system-controller@10000000 {
> +		compatible = "hisilicon,hip01-sysctrl", "hisilicon,sysctrl";
> +		reg = <0x10000000 0x1000>;
> +		reboot-offset = <0x4>;
> +	};
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.txt
> new file mode 100644
> index 000000000000000..b0d53333f4fdae1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.txt
> @@ -0,0 +1,9 @@
> +Bootwrapper boot method (software protocol on SMP):
> +
> +Required Properties:
> +- compatible: "hisilicon,hip04-bootwrapper";
> +- boot-method: Address and size of boot method.
> +  [0]: bootwrapper physical address
> +  [1]: bootwrapper size
> +  [2]: relocation physical address
> +  [3]: relocation size
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-fabric.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-fabric.txt
> new file mode 100644
> index 000000000000000..40453d02f2024bd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-fabric.txt
> @@ -0,0 +1,5 @@
> +Fabric:
> +
> +Required Properties:
> +- compatible: "hisilicon,hip04-fabric";
> +- reg: Address and size of Fabric
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.txt
> new file mode 100644
> index 000000000000000..1ef086bda81a3f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.txt
> @@ -0,0 +1,15 @@
> +Hisilicon HiP05/HiP06 PCIe-SAS sub system controller
> +
> +Required properties:
> +- compatible : "hisilicon,pcie-sas-subctrl", "syscon";
> +- reg : Register address and size
> +
> +The PCIe-SAS sub system controller is shared by PCIe and SAS controllers in
> +HiP05 or HiP06 Soc to implement some basic configurations.
> +
> +Example:
> +	/* for HiP05 PCIe-SAS sub system */
> +	pcie_sas: system_controller@b0000000 {
> +		compatible = "hisilicon,pcie-sas-subctrl", "syscon";
> +		reg = <0xb0000000 0x10000>;
> +	};
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pctrl.txt
> new file mode 100644
> index 000000000000000..deec777bc3a850a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pctrl.txt
> @@ -0,0 +1,13 @@
> +PCTRL: Peripheral misc control register
> +
> +Required Properties:
> +- compatible: "hisilicon,pctrl"
> +- reg: Address and size of pctrl.
> +
> +Example:
> +
> +	/* for Hi3620 */
> +	pctrl: pctrl@fca09000 {
> +		compatible = "hisilicon,pctrl";
> +		reg = <0xfca09000 0x1000>;
> +	};
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,peri-subctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,peri-subctrl.txt
> new file mode 100644
> index 000000000000000..b96c2896078b914
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,peri-subctrl.txt
> @@ -0,0 +1,16 @@
> +Hisilicon HiP05/HiP06 PERI sub system controller
> +
> +Required properties:
> +- compatible : "hisilicon,peri-subctrl", "syscon";
> +- reg : Register address and size
> +
> +The PERI sub system controller is shared by peripheral controllers in
> +HiP05 or HiP06 Soc to implement some basic configurations. The peripheral
> +controllers include mdio, ddr, iic, uart, timer and so on.
> +
> +Example:
> +	/* for HiP05 sub peri system */
> +	peri_c_subctrl: syscon@80000000 {
> +		compatible = "hisilicon,peri-subctrl", "syscon";
> +		reg = <0x0 0x80000000 0x0 0x10000>;
> +	};
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.txt
> new file mode 100644
> index 000000000000000..963f7f1ca7a2f0c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.txt
> @@ -0,0 +1,25 @@
> +Hisilicon system controller
> +
> +Required properties:
> +- compatible : "hisilicon,sysctrl"
> +- reg : Register address and size
> +
> +Optional properties:
> +- smp-offset : offset in sysctrl for notifying slave cpu booting
> +		cpu 1, reg;
> +		cpu 2, reg + 0x4;
> +		cpu 3, reg + 0x8;
> +		If reg value is not zero, cpun exit wfi and go
> +- resume-offset : offset in sysctrl for notifying cpu0 when resume
> +- reboot-offset : offset in sysctrl for system reboot
> +
> +Example:
> +
> +	/* for Hi3620 */
> +	sysctrl: system-controller@fc802000 {
> +		compatible = "hisilicon,sysctrl";
> +		reg = <0xfc802000 0x1000>;
> +		smp-offset = <0x31c>;
> +		resume-offset = <0x308>;
> +		reboot-offset = <0x4>;
> +	};
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> index a97f643e7d1c760..ffe760a636b5e7f 100644
> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> @@ -55,265 +55,3 @@ Required root node properties:
>  HiP07 D05 Board
>  Required root node properties:
>  	- compatible = "hisilicon,hip07-d05";
> -
> -Hisilicon system controller
> -
> -Required properties:
> -- compatible : "hisilicon,sysctrl"
> -- reg : Register address and size
> -
> -Optional properties:
> -- smp-offset : offset in sysctrl for notifying slave cpu booting
> -		cpu 1, reg;
> -		cpu 2, reg + 0x4;
> -		cpu 3, reg + 0x8;
> -		If reg value is not zero, cpun exit wfi and go
> -- resume-offset : offset in sysctrl for notifying cpu0 when resume
> -- reboot-offset : offset in sysctrl for system reboot
> -
> -Example:
> -
> -	/* for Hi3620 */
> -	sysctrl: system-controller@fc802000 {
> -		compatible = "hisilicon,sysctrl";
> -		reg = <0xfc802000 0x1000>;
> -		smp-offset = <0x31c>;
> -		resume-offset = <0x308>;
> -		reboot-offset = <0x4>;
> -	};
> -
> ------------------------------------------------------------------------
> -Hisilicon Hi3798CV200 Peripheral Controller
> -
> -The Hi3798CV200 Peripheral Controller controls peripherals, queries
> -their status, and configures some functions of peripherals.
> -
> -Required properties:
> -- compatible: Should contain "hisilicon,hi3798cv200-perictrl", "syscon"
> -  and "simple-mfd".
> -- reg: Register address and size of Peripheral Controller.
> -- #address-cells: Should be 1.
> -- #size-cells: Should be 1.
> -
> -Examples:
> -
> -	perictrl: peripheral-controller@8a20000 {
> -		compatible = "hisilicon,hi3798cv200-perictrl", "syscon",
> -			     "simple-mfd";
> -		reg = <0x8a20000 0x1000>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -	};
> -
> ------------------------------------------------------------------------
> -Hisilicon Hi6220 system controller
> -
> -Required properties:
> -- compatible : "hisilicon,hi6220-sysctrl"
> -- reg : Register address and size
> -- #clock-cells: should be set to 1, many clock registers are defined
> -  under this controller and this property must be present.
> -
> -Hisilicon designs this controller as one of the system controllers,
> -its main functions are the same as Hisilicon system controller, but
> -the register offset of some core modules are different.
> -
> -Example:
> -	/*for Hi6220*/
> -	sys_ctrl: sys_ctrl@f7030000 {
> -		compatible = "hisilicon,hi6220-sysctrl", "syscon";
> -		reg = <0x0 0xf7030000 0x0 0x2000>;
> -		#clock-cells = <1>;
> -	};
> -
> -
> -Hisilicon Hi6220 Power Always ON domain controller
> -
> -Required properties:
> -- compatible : "hisilicon,hi6220-aoctrl"
> -- reg : Register address and size
> -- #clock-cells: should be set to 1, many clock registers are defined
> -  under this controller and this property must be present.
> -
> -Hisilicon designs this system controller to control the power always
> -on domain for mobile platform.
> -
> -Example:
> -	/*for Hi6220*/
> -	ao_ctrl: ao_ctrl@f7800000 {
> -		compatible = "hisilicon,hi6220-aoctrl", "syscon";
> -		reg = <0x0 0xf7800000 0x0 0x2000>;
> -		#clock-cells = <1>;
> -	};
> -
> -
> -Hisilicon Hi6220 Media domain controller
> -
> -Required properties:
> -- compatible : "hisilicon,hi6220-mediactrl"
> -- reg : Register address and size
> -- #clock-cells: should be set to 1, many clock registers are defined
> -  under this controller and this property must be present.
> -
> -Hisilicon designs this system controller to control the multimedia
> -domain(e.g. codec, G3D ...) for mobile platform.
> -
> -Example:
> -	/*for Hi6220*/
> -	media_ctrl: media_ctrl@f4410000 {
> -		compatible = "hisilicon,hi6220-mediactrl", "syscon";
> -		reg = <0x0 0xf4410000 0x0 0x1000>;
> -		#clock-cells = <1>;
> -	};
> -
> -
> -Hisilicon Hi6220 Power Management domain controller
> -
> -Required properties:
> -- compatible : "hisilicon,hi6220-pmctrl"
> -- reg : Register address and size
> -- #clock-cells: should be set to 1, some clock registers are define
> -  under this controller and this property must be present.
> -
> -Hisilicon designs this system controller to control the power management
> -domain for mobile platform.
> -
> -Example:
> -	/*for Hi6220*/
> -	pm_ctrl: pm_ctrl@f7032000 {
> -		compatible = "hisilicon,hi6220-pmctrl", "syscon";
> -		reg = <0x0 0xf7032000 0x0 0x1000>;
> -		#clock-cells = <1>;
> -	};
> -
> -
> -Hisilicon Hi6220 SRAM controller
> -
> -Required properties:
> -- compatible : "hisilicon,hi6220-sramctrl", "syscon"
> -- reg : Register address and size
> -
> -Hisilicon's SoCs use sram for multiple purpose; on Hi6220 there have several
> -SRAM banks for power management, modem, security, etc. Further, use "syscon"
> -managing the common sram which can be shared by multiple modules.
> -
> -Example:
> -	/*for Hi6220*/
> -	sram: sram@fff80000 {
> -		compatible = "hisilicon,hi6220-sramctrl", "syscon";
> -		reg = <0x0 0xfff80000 0x0 0x12000>;
> -	};
> -
> ------------------------------------------------------------------------
> -Hisilicon HiP01 system controller
> -
> -Required properties:
> -- compatible : "hisilicon,hip01-sysctrl"
> -- reg : Register address and size
> -
> -The HiP01 system controller is mostly compatible with hisilicon
> -system controller,but it has some specific control registers for
> -HIP01 SoC family, such as slave core boot, and also some same
> -registers located at different offset.
> -
> -Example:
> -
> -	/* for hip01-ca9x2 */
> -	sysctrl: system-controller@10000000 {
> -		compatible = "hisilicon,hip01-sysctrl", "hisilicon,sysctrl";
> -		reg = <0x10000000 0x1000>;
> -		reboot-offset = <0x4>;
> -	};
> -
> ------------------------------------------------------------------------
> -Hisilicon HiP05/HiP06 PCIe-SAS sub system controller
> -
> -Required properties:
> -- compatible : "hisilicon,pcie-sas-subctrl", "syscon";
> -- reg : Register address and size
> -
> -The PCIe-SAS sub system controller is shared by PCIe and SAS controllers in
> -HiP05 or HiP06 Soc to implement some basic configurations.
> -
> -Example:
> -	/* for HiP05 PCIe-SAS sub system */
> -	pcie_sas: system_controller@b0000000 {
> -		compatible = "hisilicon,pcie-sas-subctrl", "syscon";
> -		reg = <0xb0000000 0x10000>;
> -	};
> -
> -Hisilicon HiP05/HiP06 PERI sub system controller
> -
> -Required properties:
> -- compatible : "hisilicon,peri-subctrl", "syscon";
> -- reg : Register address and size
> -
> -The PERI sub system controller is shared by peripheral controllers in
> -HiP05 or HiP06 Soc to implement some basic configurations. The peripheral
> -controllers include mdio, ddr, iic, uart, timer and so on.
> -
> -Example:
> -	/* for HiP05 sub peri system */
> -	peri_c_subctrl: syscon@80000000 {
> -		compatible = "hisilicon,peri-subctrl", "syscon";
> -		reg = <0x0 0x80000000 0x0 0x10000>;
> -	};
> -
> -Hisilicon HiP05/HiP06 DSA sub system controller
> -
> -Required properties:
> -- compatible : "hisilicon,dsa-subctrl", "syscon";
> -- reg : Register address and size
> -
> -The DSA sub system controller is shared by peripheral controllers in
> -HiP05 or HiP06 Soc to implement some basic configurations.
> -
> -Example:
> -	/* for HiP05 dsa sub system */
> -	pcie_sas: system_controller@a0000000 {
> -		compatible = "hisilicon,dsa-subctrl", "syscon";
> -		reg = <0xa0000000 0x10000>;
> -	};
> -
> ------------------------------------------------------------------------
> -Hisilicon CPU controller
> -
> -Required properties:
> -- compatible : "hisilicon,cpuctrl"
> -- reg : Register address and size
> -
> -The clock registers and power registers of secondary cores are defined
> -in CPU controller, especially in HIX5HD2 SoC.
> -
> ------------------------------------------------------------------------
> -PCTRL: Peripheral misc control register
> -
> -Required Properties:
> -- compatible: "hisilicon,pctrl"
> -- reg: Address and size of pctrl.
> -
> -Example:
> -
> -	/* for Hi3620 */
> -	pctrl: pctrl@fca09000 {
> -		compatible = "hisilicon,pctrl";
> -		reg = <0xfca09000 0x1000>;
> -	};
> -
> ------------------------------------------------------------------------
> -Fabric:
> -
> -Required Properties:
> -- compatible: "hisilicon,hip04-fabric";
> -- reg: Address and size of Fabric
> -
> ------------------------------------------------------------------------
> -Bootwrapper boot method (software protocol on SMP):
> -
> -Required Properties:
> -- compatible: "hisilicon,hip04-bootwrapper";
> -- boot-method: Address and size of boot method.
> -  [0]: bootwrapper physical address
> -  [1]: bootwrapper size
> -  [2]: relocation physical address
> -  [3]: relocation size
> -- 
> 1.8.3
> 
> 
