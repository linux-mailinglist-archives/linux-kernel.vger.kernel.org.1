Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C012DCD2C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 08:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgLQHxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 02:53:41 -0500
Received: from mail-bn8nam12on2043.outbound.protection.outlook.com ([40.107.237.43]:16993
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727151AbgLQHxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 02:53:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGGlqje9AXKXOOUIC3RGjxuIfhG9jo7NNaisCnC3uvhQhnFdpLcQLPAjRXcl4SofyDkXnIGiizFq75rZDItpU3ZeuOP2JnHAU8Fk4WgIfrGf0d6yt64WcCYVio7jGcTuef1QiQEpscKRrQhRFANdb8YDvL4b4FSyVP9p8WKBkidjdch9hC0UFf1MZMa61zO/4pVqtazW0Kf3ikUk5u5XDSYHEhADmQ8ojHWGknbmCmXIKHxMgc3aBQP8cI+80PmFlDSf6OTJkIEU2g66g3QDP4L8R7Us0iBWEU9IDj+PmMwQQ9mM1j0jdUM0BwZPrRcMpVaHD5mqWcY52H5BMRebSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPs5IulGt1ppE0l8vRiUkY1fSFnE60s/PISB0QHqosA=;
 b=dgwZi5qQHzBe4XtP/YC1pfzq2PoFU4zNyNKfwa7RZC0u3e7hAxNQkBhzky9jnxZdL//XwHAbaoVA9P+132aOlYmI2ja0pLxF/Pi2oIXqCojRaMLVgB/eP8BTvp9HMmegVi4ajNnjKEoLV8jw0+rbzfv44+dDu9HaYPOMp4CBOe4luH1tT62ri1yMcMFLLgHUoj411YOoM3RYgKIR+RyB9RZsRYEA0rXk36lQM1aRQQ65+lIumO8oTcDZDQL/VnQsQQrCYJ1f1t7wOQfETNBsBYRrSK5dF5j8EEDu8MPQCIxlzEkfYtaLcuzGn7FcZuN9tWtdDzyuEr6cI2MUITf9YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPs5IulGt1ppE0l8vRiUkY1fSFnE60s/PISB0QHqosA=;
 b=hlBiYw+3SNemPjwFDjVwyDeRbuSSUx0n+eMnJRruv0xONghicv9k6vtLCYRPGt6NtlZdKuEpFmnidZGdgigsmUf9HTpRtMeRKcnPXfQS9EBdn416BIr0Gx0jM7vRv0Vzp0pYX2PaRTPx/FlMiTnNsuA6wS2SgkGupFM0UJ80ThA=
Received: from BLAPR03CA0174.namprd03.prod.outlook.com (2603:10b6:208:32c::29)
 by SN6PR02MB4799.namprd02.prod.outlook.com (2603:10b6:805:a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Thu, 17 Dec
 2020 07:52:42 +0000
Received: from BL2NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:32c:cafe::77) by BLAPR03CA0174.outlook.office365.com
 (2603:10b6:208:32c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17 via Frontend
 Transport; Thu, 17 Dec 2020 07:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT003.mail.protection.outlook.com (10.152.76.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.12 via Frontend Transport; Thu, 17 Dec 2020 07:52:40 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 16 Dec 2020 23:52:39 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 16 Dec 2020 23:52:39 -0800
Envelope-to: michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhih@xilinx.com,
 maxz@xilinx.com,
 stefanos@xilinx.com,
 mdf@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=42038 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1kpo5X-0007Xr-DZ; Wed, 16 Dec 2020 23:52:39 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 6354)
        id 9752860010B; Wed, 16 Dec 2020 23:51:10 -0800 (PST)
From:   Sonal Santan <sonal.santan@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Sonal Santan <sonal.santan@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <lizhih@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <trix@redhat.com>, <mdf@kernel.org>
Subject: [PATCH V2 XRT Alveo 1/6] Documentation: fpga: Add a document describing XRT Alveo drivers
Date:   Wed, 16 Dec 2020 23:50:41 -0800
Message-ID: <20201217075046.28553-2-sonals@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201217075046.28553-1-sonals@xilinx.com>
References: <20201217075046.28553-1-sonals@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64808781-c932-49f9-6fb0-08d8a260ba8a
X-MS-TrafficTypeDiagnostic: SN6PR02MB4799:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4799A3DA37D34193BF94FBADBBC40@SN6PR02MB4799.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gVPpf3gFHEzqcCOksQC6p/IpqiveAm+DamqOjQ2M2/XSKU6hwHyDyq3rZer+cGvjIFI1V5/5gg1ItHz8lbTCFPqpORCWB92nCv9kEA3EVJcGVf9Anz2/gDZIPvWMK+bFyxxeX2Q6UJsv9iAjcCRMvsg7+MYB3eOhso8EZKfMUtC0fTqCLh5A1MmW1yB6i2KHDRIEFWzlwFf/1fKy5eLWsY/XkNANaLHKQUVTXkHNzuehX8TX1/pSXAJM6216fK3vEurzzguIN1tDoQtaP76iEYK4Dzyh9y3ocG/C9RCXK/r1IhW4l8e0FN+RvZqQbhmoPYW7cI2pVwBCBVZk/jrmZfJ2ooUqWhrXx6YdYmQW2ubZ7OHSkB5K0wo24B423YcVF0eWJzGf49PRQ3Duvb1Wxo4VU+QQt/Z3exU50muBXF2O4w3bjezyyjVFJRavU7oPR9GTvV8Le2OxM3nGRvW4Mw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966005)(30864003)(70586007)(70206006)(47076004)(478600001)(336012)(6916009)(186003)(2616005)(316002)(6266002)(44832011)(36756003)(82310400003)(82740400003)(1076003)(5660300002)(2906002)(7636003)(8676002)(8936002)(4326008)(42186006)(26005)(426003)(6666004)(356005)(54906003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 07:52:40.1690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64808781-c932-49f9-6fb0-08d8a260ba8a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4799
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sonal Santan <sonal.santan@xilinx.com>

Describe XRT driver architecture and provide basic overview of
Xilinx Alveo platform.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
---
 Documentation/fpga/index.rst |   1 +
 Documentation/fpga/xrt.rst   | 649 +++++++++++++++++++++++++++++++++++
 2 files changed, 650 insertions(+)
 create mode 100644 Documentation/fpga/xrt.rst

diff --git a/Documentation/fpga/index.rst b/Documentation/fpga/index.rst
index f80f95667ca2..30134357b70d 100644
--- a/Documentation/fpga/index.rst
+++ b/Documentation/fpga/index.rst
@@ -8,6 +8,7 @@ fpga
     :maxdepth: 1
 
     dfl
+    xrt
 
 .. only::  subproject and html
 
diff --git a/Documentation/fpga/xrt.rst b/Documentation/fpga/xrt.rst
new file mode 100644
index 000000000000..8faf259be1c3
--- /dev/null
+++ b/Documentation/fpga/xrt.rst
@@ -0,0 +1,649 @@
+==================================
+XRTV2 Linux Kernel Driver Overview
+==================================
+
+Authors:
+
+* Sonal Santan <sonal.santan@xilinx.com>
+* Max Zhen <max.zhen@xilinx.com>
+* Lizhi Hou <lizhi.hou@xilinx.com>
+
+XRTV2 drivers are second generation `XRT <https://github.com/Xilinx/XRT>`_
+drivers which support `Alveo <https://www.xilinx.com/products/boards-and-kits/alveo.html>`_
+PCIe platforms from Xilinx.
+
+XRTV2 drivers support *subsystem* style data driven platforms where driver's
+configuration and behavior is determined by meta data provided by the platform
+(in *device tree* format). Primary management physical function (MPF) driver
+is called **xmgmt**. Primary user physical function (UPF) driver is called
+**xuser** and HW subsystem drivers are packaged into a library module called
+**xrt-lib**, which is shared by **xmgmt** and **xuser** (under development).
+
+Alveo Platform Overview
+=======================
+
+Alveo platforms are architected as two physical FPGA partitions: *Shell* and
+*User*. The Shell provides basic infrastructure for the Alveo platform like
+PCIe connectivity, board management, Dynamic Function Exchange (DFX), sensors,
+clocking, reset, and security. User partition contains user compiled FPGA
+binary which is loaded by a process called DFX also known as partial
+reconfiguration.
+
+Physical partitions require strict HW compatibility with each other for DFX to
+work properly. Every physical partition has two interface UUIDs: *parent* UUID
+and *child* UUID. For simple single stage platforms, Shell → User forms parent
+child relationship. For complex two stage platforms, Base → Shell → User forms
+the parent child relationship chain.
+
+.. note::
+   Partition compatibility matching is key design component of Alveo platforms
+   and XRT. Partitions have child and parent relationship. A loaded partition
+   exposes child partition UUID to advertise its compatibility requirement for
+   child partition. When loading a child partition the xmgmt management driver
+   matches parent UUID of the child partition against child UUID exported by
+   the parent. Parent and child partition UUIDs are stored in the *xclbin*
+   (for user) or *xsabin* (for base and shell). Except for root UUID, VSEC,
+   hardware itself does not know about UUIDs. UUIDs are stored in xsabin and
+   xclbin.
+
+
+The physical partitions and their loading is illustrated below::
+
+           SHELL                               USER
+        +-----------+                  +-------------------+
+        |           |                  |                   |
+        | VSEC UUID | CHILD     PARENT |    LOGIC UUID     |
+        |           o------->|<--------o                   |
+        |           | UUID       UUID  |                   |
+        +-----+-----+                  +--------+----------+
+              |                                 |
+              .                                 .
+              |                                 |
+          +---+---+                      +------+--------+
+          |  POR  |                      | USER COMPILED |
+          | FLASH |                      |    XCLBIN     |
+          +-------+                      +---------------+
+
+
+Loading Sequence
+----------------
+
+The Shell partition is loaded from flash at system boot time. It establishes the
+PCIe link and exposes two physical functions to the BIOS. After OS boot, xmgmt
+driver attaches to PCIe physical function 0 exposed by the Shell and then looks
+for VSEC in PCIe extended configuration space. Using VSEC it determines the logic
+UUID of Shell and uses the UUID to load matching *xsabin* file from Linux firmware
+directory. The xsabin file contains metadata to discover peripherals that are part
+of Shell and firmware(s) for any embedded soft processors in Shell.
+
+The Shell exports child interface UUID which is used for compatibility check when
+loading user compiled xclbin over the User partition as part of DFX. When a user
+requests loading of a specific xclbin the xmgmt management driver reads the parent
+interface UUID specified in the xclbin and matches it with child interface UUID
+exported by Shell to determine if xclbin is compatible with the Shell. If match
+fails loading of xclbin is denied.
+
+xclbin loading is requested using ICAP_DOWNLOAD_AXLF ioctl command. When loading
+xclbin, xmgmt driver performs the following *logical* operations:
+
+1. Sanity check the xclbin contents
+2. Isolate the User partition
+3. Download the bitstream using the FPGA config engine (ICAP)
+4. De-isolate the User partition
+5. Program the clocks (ClockWiz) driving the User partition
+6. Wait for memory controller (MIG) calibration
+
+`Platform Loading Overview <https://xilinx.github.io/XRT/master/html/platforms_partitions.html>`_
+provides more detailed information on platform loading.
+
+
+xsabin
+------
+
+Each Alveo platform comes packaged with its own xsabin. The xsabin is trusted
+component of the platform. For format details refer to :ref:`xsabin/xclbin Container Format`.
+xsabin contains basic information like UUIDs, platform name and metadata in the
+form of device tree. See :ref:`Device Tree Usage` for details and example.
+
+xclbin
+------
+
+xclbin is compiled by end user using
+`Vitis <https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html>`_
+tool set from Xilinx. The xclbin contains sections describing user compiled
+acceleration engines/kernels, memory subsystems, clocking information etc. It also
+contains bitstream for the user partition, UUIDs, platform name, etc. xclbin uses
+the same container format as xsabin which is described below.
+
+
+xsabin/xclbin Container Format
+------------------------------
+
+xclbin/xsabin is ELF-like binary container format. It is structured as series of sections.
+There is a file header followed by several section headers which is followed by sections.
+A section header points to an actual section. There is an optional signature at the end.
+The format is defined by header file ``xclbin.h``. The following figure illustrates a
+typical xclbin::
+
+
+           +---------------------+
+           |                     |
+           |       HEADER        |
+           +---------------------+
+           |   SECTION  HEADER   |
+           |                     |
+           +---------------------+
+           |         ...         |
+           |                     |
+           +---------------------+
+           |   SECTION  HEADER   |
+           |                     |
+           +---------------------+
+           |       SECTION       |
+           |                     |
+           +---------------------+
+           |         ...         |
+           |                     |
+           +---------------------+
+           |       SECTION       |
+           |                     |
+           +---------------------+
+           |      SIGNATURE      |
+           |      (OPTIONAL)     |
+           +---------------------+
+
+
+xclbin/xsabin files can be packaged, un-packaged and inspected using XRT utility
+called **xclbinutil**. xclbinutil is part of XRT open source software stack. The
+source code for xclbinutil can be found at
+https://github.com/Xilinx/XRT/tree/master/src/runtime_src/tools/xclbinutil
+
+For example to enumerate the contents of a xclbin/xsabin use the *--info* switch
+as shown below::
+
+  xclbinutil --info --input /opt/xilinx/firmware/u50/gen3x16-xdma/blp/test/bandwidth.xclbin
+  xclbinutil --info --input /lib/firmware/xilinx/862c7020a250293e32036f19956669e5/partition.xsabin
+
+
+Device Tree Usage
+-----------------
+
+As mentioned previously xsabin stores metadata which advertise HW subsystems present
+in a partition. The metadata is stored in device tree format with well defined schema.
+Subsystem instantiations are captured as children of ``addressable_endpoints`` node.
+Subsystem nodes have standard attributes like ``reg``, ``interrupts`` etc. Additionally
+the nodes also have PCIe specific attributes: ``pcie_physical_function`` and
+``pcie_bar_mapping``. These identify which PCIe physical function and which BAR space
+in that physical function the subsystem resides. XRT management driver uses this
+information to bind *platform drivers* to the subsystem instantiations. The platform
+drivers are found in **xrt-lib.ko** kernel module defined later. Below is an example
+of device tree for Alveo U50 platform::
+
+  /dts-v1/;
+
+  /{
+        logic_uuid = "f465b0a3ae8c64f619bc150384ace69b";
+
+        schema_version {
+                major = <0x01>;
+                minor = <0x00>;
+        };
+
+        interfaces {
+
+                @0 {
+                        interface_uuid = "862c7020a250293e32036f19956669e5";
+                };
+        };
+
+        addressable_endpoints {
+
+                ep_blp_rom_00 {
+                        reg = <0x00 0x1f04000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
+                };
+
+                ep_card_flash_program_00 {
+                        reg = <0x00 0x1f06000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_quad_spi-1.0\0axi_quad_spi";
+                        interrupts = <0x03 0x03>;
+                };
+
+                ep_cmc_firmware_mem_00 {
+                        reg = <0x00 0x1e20000 0x00 0x20000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
+
+                        firmware {
+                                firmware_product_name = "cmc";
+                                firmware_branch_name = "u50";
+                                firmware_version_major = <0x01>;
+                                firmware_version_minor = <0x00>;
+                        };
+                };
+
+                ep_cmc_intc_00 {
+                        reg = <0x00 0x1e03000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_intc-1.0\0axi_intc";
+                        interrupts = <0x04 0x04>;
+                };
+
+                ep_cmc_mutex_00 {
+                        reg = <0x00 0x1e02000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
+                };
+
+                ep_cmc_regmap_00 {
+                        reg = <0x00 0x1e08000 0x00 0x2000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
+
+                        firmware {
+                                firmware_product_name = "sc-fw";
+                                firmware_branch_name = "u50";
+                                firmware_version_major = <0x05>;
+                        };
+                };
+
+                ep_cmc_reset_00 {
+                        reg = <0x00 0x1e01000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
+                };
+
+                ep_ddr_mem_calib_00 {
+                        reg = <0x00 0x63000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
+                };
+
+                ep_debug_bscan_mgmt_00 {
+                        reg = <0x00 0x1e90000 0x00 0x10000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-debug_bridge-1.0\0debug_bridge";
+                };
+
+                ep_ert_base_address_00 {
+                        reg = <0x00 0x21000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
+                };
+
+                ep_ert_command_queue_mgmt_00 {
+                        reg = <0x00 0x40000 0x00 0x10000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-ert_command_queue-1.0\0ert_command_queue";
+                };
+
+                ep_ert_command_queue_user_00 {
+                        reg = <0x00 0x40000 0x00 0x10000>;
+                        pcie_physical_function = <0x01>;
+                        compatible = "xilinx.com,reg_abs-ert_command_queue-1.0\0ert_command_queue";
+                };
+
+                ep_ert_firmware_mem_00 {
+                        reg = <0x00 0x30000 0x00 0x8000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
+
+                        firmware {
+                                firmware_product_name = "ert";
+                                firmware_branch_name = "v20";
+                                firmware_version_major = <0x01>;
+                        };
+                };
+
+                ep_ert_intc_00 {
+                        reg = <0x00 0x23000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_intc-1.0\0axi_intc";
+                        interrupts = <0x05 0x05>;
+                };
+
+                ep_ert_reset_00 {
+                        reg = <0x00 0x22000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
+                };
+
+                ep_ert_sched_00 {
+                        reg = <0x00 0x50000 0x00 0x1000>;
+                        pcie_physical_function = <0x01>;
+                        compatible = "xilinx.com,reg_abs-ert_sched-1.0\0ert_sched";
+                        interrupts = <0x09 0x0c>;
+                };
+
+                ep_fpga_configuration_00 {
+                        reg = <0x00 0x1e88000 0x00 0x8000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_hwicap-1.0\0axi_hwicap";
+                        interrupts = <0x02 0x02>;
+                };
+
+                ep_icap_reset_00 {
+                        reg = <0x00 0x1f07000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
+                };
+
+                ep_msix_00 {
+                        reg = <0x00 0x00 0x00 0x20000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-msix-1.0\0msix";
+                        pcie_bar_mapping = <0x02>;
+                };
+
+                ep_pcie_link_mon_00 {
+                        reg = <0x00 0x1f05000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
+                };
+
+                ep_pr_isolate_plp_00 {
+                        reg = <0x00 0x1f01000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
+                };
+
+                ep_pr_isolate_ulp_00 {
+                        reg = <0x00 0x1000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
+                };
+
+                ep_uuid_rom_00 {
+                        reg = <0x00 0x64000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
+                };
+
+                ep_xdma_00 {
+                        reg = <0x00 0x00 0x00 0x10000>;
+                        pcie_physical_function = <0x01>;
+                        compatible = "xilinx.com,reg_abs-xdma-1.0\0xdma";
+                        pcie_bar_mapping = <0x02>;
+                };
+        };
+
+  }
+
+
+
+Deployment Models
+=================
+
+Baremetal
+---------
+
+In bare-metal deployments both MPF and UPF are visible and accessible. xmgmt
+driver binds to MPF. xmgmt driver operations are privileged and available to
+system administrator. The full stack is illustrated below::
+
+                            HOST
+
+                 [XMGMT]            [XUSER]
+                    |                  |
+                    |                  |
+                 +-----+            +-----+
+                 | MPF |            | UPF |
+                 |     |            |     |
+                 | PF0 |            | PF1 |
+                 +--+--+            +--+--+
+          ......... ^................. ^..........
+                    |                  |
+                    |   PCIe DEVICE    |
+                    |                  |
+                 +--+------------------+--+
+                 |         SHELL          |
+                 |                        |
+                 +------------------------+
+                 |         USER           |
+                 |                        |
+                 |                        |
+                 |                        |
+                 |                        |
+                 +------------------------+
+
+
+
+Virtualized
+-----------
+
+In virtualized deployments privileged MPF is assigned to host but unprivileged
+UPF is assigned to guest VM via PCIe pass-through. xmgmt driver in host binds
+to MPF. xmgmt driver operations are privileged and only accessible by hosting
+service provider. The full stack is illustrated below::
+
+
+                                 .............
+                  HOST           .    VM     .
+                                 .           .
+                 [XMGMT]         .  [XUSER]  .
+                    |            .     |     .
+                    |            .     |     .
+                 +-----+         .  +-----+  .
+                 | MPF |         .  | UPF |  .
+                 |     |         .  |     |  .
+                 | PF0 |         .  | PF1 |  .
+                 +--+--+         .  +--+--+  .
+          ......... ^................. ^..........
+                    |                  |
+                    |   PCIe DEVICE    |
+                    |                  |
+                 +--+------------------+--+
+                 |         SHELL          |
+                 |                        |
+                 +------------------------+
+                 |         USER           |
+                 |                        |
+                 |                        |
+                 |                        |
+                 |                        |
+                 +------------------------+
+
+
+
+Driver Modules
+==============
+
+xrt-lib.ko
+----------
+
+Repository of all subsystem drivers and pure software modules that can potentially
+be shared between xmgmt and xuser. All these drivers are structured as Linux
+*platform driver* and are instantiated by xmgmt (or xuser in future) based on meta
+data associated with hardware. The metadata is in the form of device tree as
+explained before.
+
+xmgmt.ko
+--------
+
+The xmgmt driver is a PCIe device driver driving MPF found on Xilinx's Alveo
+PCIE device. It consists of one *root* driver, one or more *partition* drivers
+and one or more *leaf* drivers. The root and MPF specific leaf drivers are in
+xmgmt.ko. The partition driver and other leaf drivers are in xrt-lib.ko.
+
+The instantiation of specific partition driver or leaf driver is completely data
+driven based on meta data (mostly in device tree format) found through VSEC
+capability and inside firmware files, such as xsabin or xclbin file. The root
+driver manages life cycle of multiple partition drivers, which, in turn, manages
+multiple leaf drivers. This allows a single set of driver code to support all
+kinds of subsystems exposed by different shells. The difference among all
+these subsystems will be handled in leaf drivers with root and partition drivers
+being part of the infrastructure and provide common services for all leaves found
+on all platforms.
+
+The driver object model looks like the following::
+
+                    +-----------+
+                    |   root    |
+                    +-----+-----+
+                          |
+              +-----------+-----------+
+              |                       |
+              v                       v
+        +-----------+          +-----------+
+        | partition |    ...   | partition |
+        +-----+-----+          +------+----+
+              |                       |
+              |                       |
+        +-----+----+            +-----+----+
+        |          |            |          |
+        v          v            v          v
+    +------+   +------+     +------+   +------+
+    | leaf |...| leaf |     | leaf |...| leaf |
+    +------+   +------+     +------+   +------+
+
+
+xmgmt-root
+^^^^^^^^^^
+
+The xmgmt-root driver is a PCIe device driver attached to MPF. It's part of the
+infrastructure of the MPF driver and resides in xmgmt.ko. This driver
+
+* manages one or more partition drivers
+* provides access to functionalities that requires pci_dev, such as PCIE config
+  space access, to other leaf drivers through parent calls
+* together with partition driver, facilities event callbacks for other leaf drivers
+* together with partition driver, facilities inter-leaf driver calls for other leaf
+  drivers
+
+When root driver starts, it will explicitly create an initial partition instance,
+which contains leaf drivers that will trigger the creation of other partition
+instances. The root driver will wait for all partitions and leaves to be created
+before it returns from it's probe routine and claim success of the initialization
+of the entire xmgmt driver.
+
+.. note::
+   See code in ``common/xrt-root.c`` and ``mgmt/xmgmt-root.c``
+
+
+partition
+^^^^^^^^^
+
+The partition driver is a platform device driver whose life cycle is managed by
+root and does not have real IO mem or IRQ resources. It's part of the
+infrastructure of the MPF driver and resides in xrt-lib.ko. This driver
+
+* manages one or more leaf drivers so that multiple leaves can be managed as a
+  group
+* provides access to root from leaves, so that parent calls, event notifications
+  and inter-leaf calls can happen
+
+In xmgmt, an initial partition driver instance will be created by root, which
+contains leaves that will trigger partition instances to be created to manage
+groups of leaves found on different partitions on hardware, such as VSEC, Shell,
+and User.
+
+Every *fpga_region* has a partition object associated with it. The partition is
+created when xclbin image is loaded on the fpga_region. The existing partition
+is destroyed when a new xclbin image is loaded. The fpga_region persists
+across xclbin downloads.
+
+.. note::
+   See code in ``lib/subdevs/xrt-partition.c``
+
+
+leaves
+^^^^^^
+
+The leaf driver is a platform device driver whose life cycle is managed by
+a partition driver and may or may not have real IO mem or IRQ resources. They
+are the real meat of xmgmt and contains platform specific code to Shell and
+User found on a MPF.
+
+A leaf driver may not have real hardware resources when it merely acts as a
+driver that manages certain in-memory states for xmgmt. These in-memory states
+could be shared by multiple other leaves.
+
+Leaf drivers assigned to specific hardware resources drive specific subsystem in
+the device. To manipulate the subsystem or carry out a task, a leaf driver may
+ask help from root via parent calls and/or from other leaves via inter-leaf calls.
+
+A leaf can also broadcast events through infrastructure code for other leaves
+to process. It can also receive event notification from infrastructure about
+certain events, such as post-creation or pre-exit of a particular leaf.
+
+.. note::
+   See code in ``lib/subdevs/*.c``
+
+
+FPGA Manager Interaction
+========================
+
+fpga_manager
+------------
+
+An instance of fpga_manager is created by xmgmt_main and is used for xclbin
+image download. fpga_manager requires the full xclbin image before it can
+start programming the FPGA configuration engine via ICAP subdev driver.
+
+fpga_region
+-----------
+
+A new instance of fpga_region is created like a *child* region for every
+interface exposed by currently loaded xclbin or xsabin in the *parent*
+fpga_region. The device tree of the *parent* fpga_region defines the
+resources for a new instance of fpga_bridge which isolates the parent from
+child fpga_region. This new instance of fpga_bridge will be used when a
+xclbin image is loaded on the child fpga_region. After the xclbin image is
+downloaded to the fpga_region, a partition instance is created for the
+fpga_region using the device tree obtained as part of xclbin. This device
+tree defines any child interfaces then it can trigger the creation of
+fpga_bridge and fpga_region for the next region in the chain.
+
+fpga_bridge
+-----------
+
+Like fpga_region, matching fpga_bridge is also created by walking the device
+tree of the parent partition.
+
+Driver Interfaces
+=================
+
+xmgmt Driver Ioctls
+-------------------
+
+Ioctls exposed by xmgmt driver to user space are enumerated in the following table:
+
+== ===================== ============================= ===========================
+#  Functionality         ioctl request code            data format
+== ===================== ============================= ===========================
+1  FPGA image download   XMGMT_IOCICAPDOWNLOAD_AXLF    xmgmt_ioc_bitstream_axlf
+2  CL frequency scaling  XMGMT_IOCFREQSCALE            xmgmt_ioc_freqscaling
+== ===================== ============================= ===========================
+
+A xclbin can be downloaded by using xbmgmt tool from XRT open source suite. See
+example usage below ::
+
+  xbmgmt partition --program --path /lib/firmware/xilinx/862c7020a250293e32036f19956669e5/test/verify.xclbin --force
+
+xmgmt Driver Sysfs
+------------------
+
+xmgmt driver exposes a rich set of sysfs interfaces. Subsystem platform
+drivers export sysfs node for every platform instance.
+
+Every partition also exports its UUIDs. See below for examples::
+
+  /sys/bus/pci/devices/0000:06:00.0/xmgmt_main.0/interface_uuids
+  /sys/bus/pci/devices/0000:06:00.0/xmgmt_main.0/logic_uuids
+
+
+hwmon
+-----
+
+xmgmt driver exposes standard hwmon interface to report voltage, current,
+temperature, power, etc. These can easily be viewed using *sensors* command
+line utility.
+
+
+Platform Security Considerations
+================================
+
+`Security of Alveo Platform <https://xilinx.github.io/XRT/master/html/security.html>`_
+discusses the deployment options and security implications in great detail.
-- 
2.17.1

