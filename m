Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DB827AE2E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgI1MvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:51:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47492 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726504AbgI1MvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:51:19 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DD04ACC174299F491E94;
        Mon, 28 Sep 2020 20:51:16 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Mon, 28 Sep 2020
 20:51:10 +0800
Subject: Re: [PATCH v3 02/21] dt-bindings: arm: hisilicon: split the
 dt-bindings of each controller into a separate file
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20200927062129.4573-1-thunder.leizhen@huawei.com>
 <20200927062129.4573-3-thunder.leizhen@huawei.com>
 <5F71D923.3040509@hisilicon.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <885ea642-2e4b-c1ae-094b-831638a1eba9@huawei.com>
Date:   Mon, 28 Sep 2020 20:51:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5F71D923.3040509@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/28 20:37, Wei Xu wrote:
> Hi Zhen Lei,
> 
> 
> 
> On 2020/9/27 14:21, Zhen Lei wrote:
>> Split the devicetree bindings of each Hisilicon controller from
>> hisilicon.txt into a separate file, the file name is the compatible name
>> attach the .txt file name extension.
>>
>> All Hi6220 dedicated controllers are grouped into subdirectory "hi3620".
>> All HiPxx  dedicated controllers are grouped into subdirectory "hipxx"
> 
> Some of the IPs are maybe shared among the different SoCs.
> I think it is better not to group by SoCs.
> Otherwise looks fine to me.
> Thanks!

OK, I will discard the subdirectory "hi3620" and "hipxx".

> 
> Best Regards,
> Wei
> 
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  .../controller/hi3620/hisilicon,hi6220-aoctrl.txt  |  18 ++
>>  .../hi3620/hisilicon,hi6220-mediactrl.txt          |  18 ++
>>  .../controller/hi3620/hisilicon,hi6220-pmctrl.txt  |  18 ++
>>  .../hi3620/hisilicon,hi6220-sramctrl.txt           |  16 ++
>>  .../controller/hi3620/hisilicon,hi6220-sysctrl.txt |  19 ++
>>  .../controller/hipxx/hisilicon,hip01-sysctrl.txt   |  19 ++
>>  .../hipxx/hisilicon,hip04-bootwrapper.txt          |   9 +
>>  .../controller/hipxx/hisilicon,hip04-fabric.txt    |   5 +
>>  .../arm/hisilicon/controller/hisilicon,cpuctrl.txt |   8 +
>>  .../hisilicon/controller/hisilicon,dsa-subctrl.txt |  15 ++
>>  .../controller/hisilicon,hi3798cv200-perictrl.txt  |  21 ++
>>  .../controller/hisilicon,pcie-sas-subctrl.txt      |  15 ++
>>  .../arm/hisilicon/controller/hisilicon,pctrl.txt   |  13 +
>>  .../controller/hisilicon,peri-subctrl.txt          |  16 ++
>>  .../arm/hisilicon/controller/hisilicon,sysctrl.txt |  25 ++
>>  .../bindings/arm/hisilicon/hisilicon.txt           | 264 +--------------------
>>  16 files changed, 236 insertions(+), 263 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-aoctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-mediactrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-pmctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sysctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip01-sysctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-bootwrapper.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-fabric.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,dsa-subctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,peri-subctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-aoctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-aoctrl.txt
>> new file mode 100644
>> index 000000000000000..8f70ac0ebbdf252
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-aoctrl.txt
>> @@ -0,0 +1,18 @@
>> +Hisilicon Hi6220 Power Always ON domain controller
>> +
>> +Required properties:
>> +- compatible : "hisilicon,hi6220-aoctrl"
>> +- reg : Register address and size
>> +- #clock-cells: should be set to 1, many clock registers are defined
>> +  under this controller and this property must be present.
>> +
>> +Hisilicon designs this system controller to control the power always
>> +on domain for mobile platform.
>> +
>> +Example:
>> +	/*for Hi6220*/
>> +	ao_ctrl: ao_ctrl@f7800000 {
>> +		compatible = "hisilicon,hi6220-aoctrl", "syscon";
>> +		reg = <0x0 0xf7800000 0x0 0x2000>;
>> +		#clock-cells = <1>;
>> +	};
>> \ No newline at end of file
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-mediactrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-mediactrl.txt
>> new file mode 100644
>> index 000000000000000..95bf5f5c7abed7c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-mediactrl.txt
>> @@ -0,0 +1,18 @@
>> +Hisilicon Hi6220 Media domain controller
>> +
>> +Required properties:
>> +- compatible : "hisilicon,hi6220-mediactrl"
>> +- reg : Register address and size
>> +- #clock-cells: should be set to 1, many clock registers are defined
>> +  under this controller and this property must be present.
>> +
>> +Hisilicon designs this system controller to control the multimedia
>> +domain(e.g. codec, G3D ...) for mobile platform.
>> +
>> +Example:
>> +	/*for Hi6220*/
>> +	media_ctrl: media_ctrl@f4410000 {
>> +		compatible = "hisilicon,hi6220-mediactrl", "syscon";
>> +		reg = <0x0 0xf4410000 0x0 0x1000>;
>> +		#clock-cells = <1>;
>> +	};
>> \ No newline at end of file
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-pmctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-pmctrl.txt
>> new file mode 100644
>> index 000000000000000..46f5d8c775cea25
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-pmctrl.txt
>> @@ -0,0 +1,18 @@
>> +Hisilicon Hi6220 Power Management domain controller
>> +
>> +Required properties:
>> +- compatible : "hisilicon,hi6220-pmctrl"
>> +- reg : Register address and size
>> +- #clock-cells: should be set to 1, some clock registers are define
>> +  under this controller and this property must be present.
>> +
>> +Hisilicon designs this system controller to control the power management
>> +domain for mobile platform.
>> +
>> +Example:
>> +	/*for Hi6220*/
>> +	pm_ctrl: pm_ctrl@f7032000 {
>> +		compatible = "hisilicon,hi6220-pmctrl", "syscon";
>> +		reg = <0x0 0xf7032000 0x0 0x1000>;
>> +		#clock-cells = <1>;
>> +	};
>> \ No newline at end of file
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.txt
>> new file mode 100644
>> index 000000000000000..963a2cb13a249d9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.txt
>> @@ -0,0 +1,16 @@
>> +Hisilicon Hi6220 SRAM controller
>> +
>> +Required properties:
>> +- compatible : "hisilicon,hi6220-sramctrl", "syscon"
>> +- reg : Register address and size
>> +
>> +Hisilicon's SoCs use sram for multiple purpose; on Hi6220 there have several
>> +SRAM banks for power management, modem, security, etc. Further, use "syscon"
>> +managing the common sram which can be shared by multiple modules.
>> +
>> +Example:
>> +	/*for Hi6220*/
>> +	sram: sram@fff80000 {
>> +		compatible = "hisilicon,hi6220-sramctrl", "syscon";
>> +		reg = <0x0 0xfff80000 0x0 0x12000>;
>> +	};
>> \ No newline at end of file
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sysctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sysctrl.txt
>> new file mode 100644
>> index 000000000000000..2ded19f26e61a7c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sysctrl.txt
>> @@ -0,0 +1,19 @@
>> +Hisilicon Hi6220 system controller
>> +
>> +Required properties:
>> +- compatible : "hisilicon,hi6220-sysctrl"
>> +- reg : Register address and size
>> +- #clock-cells: should be set to 1, many clock registers are defined
>> +  under this controller and this property must be present.
>> +
>> +Hisilicon designs this controller as one of the system controllers,
>> +its main functions are the same as Hisilicon system controller, but
>> +the register offset of some core modules are different.
>> +
>> +Example:
>> +	/*for Hi6220*/
>> +	sys_ctrl: sys_ctrl@f7030000 {
>> +		compatible = "hisilicon,hi6220-sysctrl", "syscon";
>> +		reg = <0x0 0xf7030000 0x0 0x2000>;
>> +		#clock-cells = <1>;
>> +	};
>> \ No newline at end of file
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip01-sysctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip01-sysctrl.txt
>> new file mode 100644
>> index 000000000000000..7cc52596c82e583
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip01-sysctrl.txt
>> @@ -0,0 +1,19 @@
>> +Hisilicon HiP01 system controller
>> +
>> +Required properties:
>> +- compatible : "hisilicon,hip01-sysctrl"
>> +- reg : Register address and size
>> +
>> +The HiP01 system controller is mostly compatible with hisilicon
>> +system controller,but it has some specific control registers for
>> +HIP01 SoC family, such as slave core boot, and also some same
>> +registers located at different offset.
>> +
>> +Example:
>> +
>> +	/* for hip01-ca9x2 */
>> +	sysctrl: system-controller@10000000 {
>> +		compatible = "hisilicon,hip01-sysctrl", "hisilicon,sysctrl";
>> +		reg = <0x10000000 0x1000>;
>> +		reboot-offset = <0x4>;
>> +	};
>> \ No newline at end of file
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-bootwrapper.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-bootwrapper.txt
>> new file mode 100644
>> index 000000000000000..baad98ec700e789
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-bootwrapper.txt
>> @@ -0,0 +1,9 @@
>> +Bootwrapper boot method (software protocol on SMP):
>> +
>> +Required Properties:
>> +- compatible: "hisilicon,hip04-bootwrapper";
>> +- boot-method: Address and size of boot method.
>> +  [0]: bootwrapper physical address
>> +  [1]: bootwrapper size
>> +  [2]: relocation physical address
>> +  [3]: relocation size
>> \ No newline at end of file
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-fabric.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-fabric.txt
>> new file mode 100644
>> index 000000000000000..1709ac91d4cd99c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-fabric.txt
>> @@ -0,0 +1,5 @@
>> +Fabric:
>> +
>> +Required Properties:
>> +- compatible: "hisilicon,hip04-fabric";
>> +- reg: Address and size of Fabric
>> \ No newline at end of file
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt
>> new file mode 100644
>> index 000000000000000..0188ec93d2df70d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt
>> @@ -0,0 +1,8 @@
>> +Hisilicon CPU controller
>> +
>> +Required properties:
>> +- compatible : "hisilicon,cpuctrl"
>> +- reg : Register address and size
>> +
>> +The clock registers and power registers of secondary cores are defined
>> +in CPU controller, especially in HIX5HD2 SoC.
>> \ No newline at end of file
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,dsa-subctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,dsa-subctrl.txt
>> new file mode 100644
>> index 000000000000000..88f81760ddc8621
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,dsa-subctrl.txt
>> @@ -0,0 +1,15 @@
>> +Hisilicon HiP05/HiP06 DSA sub system controller
>> +
>> +Required properties:
>> +- compatible : "hisilicon,dsa-subctrl", "syscon";
>> +- reg : Register address and size
>> +
>> +The DSA sub system controller is shared by peripheral controllers in
>> +HiP05 or HiP06 Soc to implement some basic configurations.
>> +
>> +Example:
>> +	/* for HiP05 dsa sub system */
>> +	pcie_sas: system_controller@a0000000 {
>> +		compatible = "hisilicon,dsa-subctrl", "syscon";
>> +		reg = <0xa0000000 0x10000>;
>> +	};
>> \ No newline at end of file
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
>> new file mode 100644
>> index 000000000000000..beca239e0830e76
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
>> @@ -0,0 +1,21 @@
>> +Hisilicon Hi3798CV200 Peripheral Controller
>> +
>> +The Hi3798CV200 Peripheral Controller controls peripherals, queries
>> +their status, and configures some functions of peripherals.
>> +
>> +Required properties:
>> +- compatible: Should contain "hisilicon,hi3798cv200-perictrl", "syscon"
>> +  and "simple-mfd".
>> +- reg: Register address and size of Peripheral Controller.
>> +- #address-cells: Should be 1.
>> +- #size-cells: Should be 1.
>> +
>> +Examples:
>> +
>> +	perictrl: peripheral-controller@8a20000 {
>> +		compatible = "hisilicon,hi3798cv200-perictrl", "syscon",
>> +			     "simple-mfd";
>> +		reg = <0x8a20000 0x1000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +	};
>> \ No newline at end of file
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.txt
>> new file mode 100644
>> index 000000000000000..43efdaf408f6fe1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.txt
>> @@ -0,0 +1,15 @@
>> +Hisilicon HiP05/HiP06 PCIe-SAS sub system controller
>> +
>> +Required properties:
>> +- compatible : "hisilicon,pcie-sas-subctrl", "syscon";
>> +- reg : Register address and size
>> +
>> +The PCIe-SAS sub system controller is shared by PCIe and SAS controllers in
>> +HiP05 or HiP06 Soc to implement some basic configurations.
>> +
>> +Example:
>> +	/* for HiP05 PCIe-SAS sub system */
>> +	pcie_sas: system_controller@b0000000 {
>> +		compatible = "hisilicon,pcie-sas-subctrl", "syscon";
>> +		reg = <0xb0000000 0x10000>;
>> +	};
>> \ No newline at end of file
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pctrl.txt
>> new file mode 100644
>> index 000000000000000..cb89a217c243066
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pctrl.txt
>> @@ -0,0 +1,13 @@
>> +PCTRL: Peripheral misc control register
>> +
>> +Required Properties:
>> +- compatible: "hisilicon,pctrl"
>> +- reg: Address and size of pctrl.
>> +
>> +Example:
>> +
>> +	/* for Hi3620 */
>> +	pctrl: pctrl@fca09000 {
>> +		compatible = "hisilicon,pctrl";
>> +		reg = <0xfca09000 0x1000>;
>> +	};
>> \ No newline at end of file
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,peri-subctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,peri-subctrl.txt
>> new file mode 100644
>> index 000000000000000..95e58d43913c0d9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,peri-subctrl.txt
>> @@ -0,0 +1,16 @@
>> +Hisilicon HiP05/HiP06 PERI sub system controller
>> +
>> +Required properties:
>> +- compatible : "hisilicon,peri-subctrl", "syscon";
>> +- reg : Register address and size
>> +
>> +The PERI sub system controller is shared by peripheral controllers in
>> +HiP05 or HiP06 Soc to implement some basic configurations. The peripheral
>> +controllers include mdio, ddr, iic, uart, timer and so on.
>> +
>> +Example:
>> +	/* for HiP05 sub peri system */
>> +	peri_c_subctrl: syscon@80000000 {
>> +		compatible = "hisilicon,peri-subctrl", "syscon";
>> +		reg = <0x0 0x80000000 0x0 0x10000>;
>> +	};
>> \ No newline at end of file
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.txt
>> new file mode 100644
>> index 000000000000000..b62c4c5c0dd0bf8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.txt
>> @@ -0,0 +1,25 @@
>> +Hisilicon system controller
>> +
>> +Required properties:
>> +- compatible : "hisilicon,sysctrl"
>> +- reg : Register address and size
>> +
>> +Optional properties:
>> +- smp-offset : offset in sysctrl for notifying slave cpu booting
>> +		cpu 1, reg;
>> +		cpu 2, reg + 0x4;
>> +		cpu 3, reg + 0x8;
>> +		If reg value is not zero, cpun exit wfi and go
>> +- resume-offset : offset in sysctrl for notifying cpu0 when resume
>> +- reboot-offset : offset in sysctrl for system reboot
>> +
>> +Example:
>> +
>> +	/* for Hi3620 */
>> +	sysctrl: system-controller@fc802000 {
>> +		compatible = "hisilicon,sysctrl";
>> +		reg = <0xfc802000 0x1000>;
>> +		smp-offset = <0x31c>;
>> +		resume-offset = <0x308>;
>> +		reboot-offset = <0x4>;
>> +	};
>> \ No newline at end of file
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> index a97f643e7d1c760..f7e52476f5f2f3c 100644
>> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> @@ -54,266 +54,4 @@ Required root node properties:
>>  
>>  HiP07 D05 Board
>>  Required root node properties:
>> -	- compatible = "hisilicon,hip07-d05";
>> -
>> -Hisilicon system controller
>> -
>> -Required properties:
>> -- compatible : "hisilicon,sysctrl"
>> -- reg : Register address and size
>> -
>> -Optional properties:
>> -- smp-offset : offset in sysctrl for notifying slave cpu booting
>> -		cpu 1, reg;
>> -		cpu 2, reg + 0x4;
>> -		cpu 3, reg + 0x8;
>> -		If reg value is not zero, cpun exit wfi and go
>> -- resume-offset : offset in sysctrl for notifying cpu0 when resume
>> -- reboot-offset : offset in sysctrl for system reboot
>> -
>> -Example:
>> -
>> -	/* for Hi3620 */
>> -	sysctrl: system-controller@fc802000 {
>> -		compatible = "hisilicon,sysctrl";
>> -		reg = <0xfc802000 0x1000>;
>> -		smp-offset = <0x31c>;
>> -		resume-offset = <0x308>;
>> -		reboot-offset = <0x4>;
>> -	};
>> -
>> ------------------------------------------------------------------------
>> -Hisilicon Hi3798CV200 Peripheral Controller
>> -
>> -The Hi3798CV200 Peripheral Controller controls peripherals, queries
>> -their status, and configures some functions of peripherals.
>> -
>> -Required properties:
>> -- compatible: Should contain "hisilicon,hi3798cv200-perictrl", "syscon"
>> -  and "simple-mfd".
>> -- reg: Register address and size of Peripheral Controller.
>> -- #address-cells: Should be 1.
>> -- #size-cells: Should be 1.
>> -
>> -Examples:
>> -
>> -	perictrl: peripheral-controller@8a20000 {
>> -		compatible = "hisilicon,hi3798cv200-perictrl", "syscon",
>> -			     "simple-mfd";
>> -		reg = <0x8a20000 0x1000>;
>> -		#address-cells = <1>;
>> -		#size-cells = <1>;
>> -	};
>> -
>> ------------------------------------------------------------------------
>> -Hisilicon Hi6220 system controller
>> -
>> -Required properties:
>> -- compatible : "hisilicon,hi6220-sysctrl"
>> -- reg : Register address and size
>> -- #clock-cells: should be set to 1, many clock registers are defined
>> -  under this controller and this property must be present.
>> -
>> -Hisilicon designs this controller as one of the system controllers,
>> -its main functions are the same as Hisilicon system controller, but
>> -the register offset of some core modules are different.
>> -
>> -Example:
>> -	/*for Hi6220*/
>> -	sys_ctrl: sys_ctrl@f7030000 {
>> -		compatible = "hisilicon,hi6220-sysctrl", "syscon";
>> -		reg = <0x0 0xf7030000 0x0 0x2000>;
>> -		#clock-cells = <1>;
>> -	};
>> -
>> -
>> -Hisilicon Hi6220 Power Always ON domain controller
>> -
>> -Required properties:
>> -- compatible : "hisilicon,hi6220-aoctrl"
>> -- reg : Register address and size
>> -- #clock-cells: should be set to 1, many clock registers are defined
>> -  under this controller and this property must be present.
>> -
>> -Hisilicon designs this system controller to control the power always
>> -on domain for mobile platform.
>> -
>> -Example:
>> -	/*for Hi6220*/
>> -	ao_ctrl: ao_ctrl@f7800000 {
>> -		compatible = "hisilicon,hi6220-aoctrl", "syscon";
>> -		reg = <0x0 0xf7800000 0x0 0x2000>;
>> -		#clock-cells = <1>;
>> -	};
>> -
>> -
>> -Hisilicon Hi6220 Media domain controller
>> -
>> -Required properties:
>> -- compatible : "hisilicon,hi6220-mediactrl"
>> -- reg : Register address and size
>> -- #clock-cells: should be set to 1, many clock registers are defined
>> -  under this controller and this property must be present.
>> -
>> -Hisilicon designs this system controller to control the multimedia
>> -domain(e.g. codec, G3D ...) for mobile platform.
>> -
>> -Example:
>> -	/*for Hi6220*/
>> -	media_ctrl: media_ctrl@f4410000 {
>> -		compatible = "hisilicon,hi6220-mediactrl", "syscon";
>> -		reg = <0x0 0xf4410000 0x0 0x1000>;
>> -		#clock-cells = <1>;
>> -	};
>> -
>> -
>> -Hisilicon Hi6220 Power Management domain controller
>> -
>> -Required properties:
>> -- compatible : "hisilicon,hi6220-pmctrl"
>> -- reg : Register address and size
>> -- #clock-cells: should be set to 1, some clock registers are define
>> -  under this controller and this property must be present.
>> -
>> -Hisilicon designs this system controller to control the power management
>> -domain for mobile platform.
>> -
>> -Example:
>> -	/*for Hi6220*/
>> -	pm_ctrl: pm_ctrl@f7032000 {
>> -		compatible = "hisilicon,hi6220-pmctrl", "syscon";
>> -		reg = <0x0 0xf7032000 0x0 0x1000>;
>> -		#clock-cells = <1>;
>> -	};
>> -
>> -
>> -Hisilicon Hi6220 SRAM controller
>> -
>> -Required properties:
>> -- compatible : "hisilicon,hi6220-sramctrl", "syscon"
>> -- reg : Register address and size
>> -
>> -Hisilicon's SoCs use sram for multiple purpose; on Hi6220 there have several
>> -SRAM banks for power management, modem, security, etc. Further, use "syscon"
>> -managing the common sram which can be shared by multiple modules.
>> -
>> -Example:
>> -	/*for Hi6220*/
>> -	sram: sram@fff80000 {
>> -		compatible = "hisilicon,hi6220-sramctrl", "syscon";
>> -		reg = <0x0 0xfff80000 0x0 0x12000>;
>> -	};
>> -
>> ------------------------------------------------------------------------
>> -Hisilicon HiP01 system controller
>> -
>> -Required properties:
>> -- compatible : "hisilicon,hip01-sysctrl"
>> -- reg : Register address and size
>> -
>> -The HiP01 system controller is mostly compatible with hisilicon
>> -system controller,but it has some specific control registers for
>> -HIP01 SoC family, such as slave core boot, and also some same
>> -registers located at different offset.
>> -
>> -Example:
>> -
>> -	/* for hip01-ca9x2 */
>> -	sysctrl: system-controller@10000000 {
>> -		compatible = "hisilicon,hip01-sysctrl", "hisilicon,sysctrl";
>> -		reg = <0x10000000 0x1000>;
>> -		reboot-offset = <0x4>;
>> -	};
>> -
>> ------------------------------------------------------------------------
>> -Hisilicon HiP05/HiP06 PCIe-SAS sub system controller
>> -
>> -Required properties:
>> -- compatible : "hisilicon,pcie-sas-subctrl", "syscon";
>> -- reg : Register address and size
>> -
>> -The PCIe-SAS sub system controller is shared by PCIe and SAS controllers in
>> -HiP05 or HiP06 Soc to implement some basic configurations.
>> -
>> -Example:
>> -	/* for HiP05 PCIe-SAS sub system */
>> -	pcie_sas: system_controller@b0000000 {
>> -		compatible = "hisilicon,pcie-sas-subctrl", "syscon";
>> -		reg = <0xb0000000 0x10000>;
>> -	};
>> -
>> -Hisilicon HiP05/HiP06 PERI sub system controller
>> -
>> -Required properties:
>> -- compatible : "hisilicon,peri-subctrl", "syscon";
>> -- reg : Register address and size
>> -
>> -The PERI sub system controller is shared by peripheral controllers in
>> -HiP05 or HiP06 Soc to implement some basic configurations. The peripheral
>> -controllers include mdio, ddr, iic, uart, timer and so on.
>> -
>> -Example:
>> -	/* for HiP05 sub peri system */
>> -	peri_c_subctrl: syscon@80000000 {
>> -		compatible = "hisilicon,peri-subctrl", "syscon";
>> -		reg = <0x0 0x80000000 0x0 0x10000>;
>> -	};
>> -
>> -Hisilicon HiP05/HiP06 DSA sub system controller
>> -
>> -Required properties:
>> -- compatible : "hisilicon,dsa-subctrl", "syscon";
>> -- reg : Register address and size
>> -
>> -The DSA sub system controller is shared by peripheral controllers in
>> -HiP05 or HiP06 Soc to implement some basic configurations.
>> -
>> -Example:
>> -	/* for HiP05 dsa sub system */
>> -	pcie_sas: system_controller@a0000000 {
>> -		compatible = "hisilicon,dsa-subctrl", "syscon";
>> -		reg = <0xa0000000 0x10000>;
>> -	};
>> -
>> ------------------------------------------------------------------------
>> -Hisilicon CPU controller
>> -
>> -Required properties:
>> -- compatible : "hisilicon,cpuctrl"
>> -- reg : Register address and size
>> -
>> -The clock registers and power registers of secondary cores are defined
>> -in CPU controller, especially in HIX5HD2 SoC.
>> -
>> ------------------------------------------------------------------------
>> -PCTRL: Peripheral misc control register
>> -
>> -Required Properties:
>> -- compatible: "hisilicon,pctrl"
>> -- reg: Address and size of pctrl.
>> -
>> -Example:
>> -
>> -	/* for Hi3620 */
>> -	pctrl: pctrl@fca09000 {
>> -		compatible = "hisilicon,pctrl";
>> -		reg = <0xfca09000 0x1000>;
>> -	};
>> -
>> ------------------------------------------------------------------------
>> -Fabric:
>> -
>> -Required Properties:
>> -- compatible: "hisilicon,hip04-fabric";
>> -- reg: Address and size of Fabric
>> -
>> ------------------------------------------------------------------------
>> -Bootwrapper boot method (software protocol on SMP):
>> -
>> -Required Properties:
>> -- compatible: "hisilicon,hip04-bootwrapper";
>> -- boot-method: Address and size of boot method.
>> -  [0]: bootwrapper physical address
>> -  [1]: bootwrapper size
>> -  [2]: relocation physical address
>> -  [3]: relocation size
>> +	- compatible = "hisilicon,hip07-d05";
>> \ No newline at end of file
>>
> 
> .
> 

