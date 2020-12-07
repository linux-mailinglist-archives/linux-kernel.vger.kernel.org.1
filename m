Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663FC2D1C5D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgLGVvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLGVvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:51:49 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65163C061793;
        Mon,  7 Dec 2020 13:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=MApMKOSSa1wXcT7SWWTwmXRkX/JEXOq8UqusNOIGUrA=; b=FywLNEW9KC7uXtr8uTRtILsznD
        j/VigRjIA+fzQl017RZlHTYvrCFU0wK1z3dPrftTo5KRQ/q2F97eXw0RRn4jeE471S57LA1RCarm3
        Bvbqj9UMA3vA9B7n/aT4RIh56pDvZfeLQ2FpWrV/SA+edwaWh+UGveqzBdYsZrJVopyUOtkXPBDgD
        FXZ7P7gpiAN5xiwo7Nau8Vdj5Xlqu8kSiO7fvql+haJQ1o409qJHaDv86BRVFZF8bnASWomW3aGAn
        RERkiVbssd/c2oS8Ayp87oxEx50enqmO868Z6+KRt8C9ya7ihLBr6Qjk1oMyFlgN7gOriN43aufig
        lvBUvBcA==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmOPS-0008Pd-DO; Mon, 07 Dec 2020 21:51:06 +0000
Subject: Re: [PATCH 18/22] xlink-core: Add xlink core driver xLink
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Seamus Kelly <seamus.kelly@intel.com>,
        linux-doc@vger.kernel.org
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-19-mgross@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e6d1942c-8756-6f63-0954-5cd28143f40c@infradead.org>
Date:   Mon, 7 Dec 2020 13:50:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201201223511.65542-19-mgross@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 12/1/20 2:35 PM, mgross@linux.intel.com wrote:
> From: Seamus Kelly <seamus.kelly@intel.com>
> 
> 
> Cc: linux-doc@vger.kernel.org
> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Seamus Kelly <seamus.kelly@intel.com>
> ---
>  Documentation/vpu/index.rst                 |   1 +
>  Documentation/vpu/xlink-core.rst            |  80 ++
>  MAINTAINERS                                 |  12 +
>  drivers/misc/Kconfig                        |   1 +
>  drivers/misc/Makefile                       |   1 +
>  drivers/misc/xlink-core/Kconfig             |  33 +
>  drivers/misc/xlink-core/Makefile            |   5 +
>  drivers/misc/xlink-core/xlink-core.c        | 870 ++++++++++++++++++++
>  drivers/misc/xlink-core/xlink-defs.h        | 175 ++++
>  drivers/misc/xlink-core/xlink-multiplexer.c | 534 ++++++++++++
>  drivers/misc/xlink-core/xlink-multiplexer.h |  35 +
>  drivers/misc/xlink-core/xlink-platform.c    | 160 ++++
>  drivers/misc/xlink-core/xlink-platform.h    |  65 ++
>  include/linux/xlink.h                       | 108 +++
>  include/uapi/misc/xlink_uapi.h              | 145 ++++
>  15 files changed, 2225 insertions(+)
>  create mode 100644 Documentation/vpu/xlink-core.rst
>  create mode 100644 drivers/misc/xlink-core/Kconfig
>  create mode 100644 drivers/misc/xlink-core/Makefile
>  create mode 100644 drivers/misc/xlink-core/xlink-core.c
>  create mode 100644 drivers/misc/xlink-core/xlink-defs.h
>  create mode 100644 drivers/misc/xlink-core/xlink-multiplexer.c
>  create mode 100644 drivers/misc/xlink-core/xlink-multiplexer.h
>  create mode 100644 drivers/misc/xlink-core/xlink-platform.c
>  create mode 100644 drivers/misc/xlink-core/xlink-platform.h
>  create mode 100644 include/linux/xlink.h
>  create mode 100644 include/uapi/misc/xlink_uapi.h

> diff --git a/Documentation/vpu/xlink-core.rst b/Documentation/vpu/xlink-core.rst
> new file mode 100644
> index 000000000000..5410755ff13a
> --- /dev/null
> +++ b/Documentation/vpu/xlink-core.rst
> @@ -0,0 +1,80 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +xLink-core software sub-system

                       subsystem

> +==============================
> +
> +The purpose of the xLink software sub-system is to facilitate communication

                                     subsystem  {throughout/everywhere}

> +between multiple users on multiple nodes in the system.
> +
> +There are three types of xLink nodes:
> +
> +1. Remote Host: this is an external IA/x86 host system that is only capable of
> +   communicating directly to the Local Host node on VPU 2.x products.
> +2. Local Host: this is the ARM core within the VPU 2.x  SoC. The Local Host can
> +   communicate upstream to the Remote Host node, and downstream to the VPU IP
> +   node.
> +3. VPU IP: this is the Leon RT core within the VPU 2.x SoC. The VPU IP can only
> +   communicate upstream to the Local Host node.
> +
> +xLink provides a common API across all interfaces for users to access xLink
> +functions and provides user space APIs via an IOCTL interface implemented in
> +the xLink core.
> +
> +xLink manages communications from one interface to another and provides routing
> +of data through multiple channels across a single physical interface.
> +
> +It exposes a common API across all interfaces at both kernel and user level for

                                                                         levels

> +processes/applications to access.
> +
> +It has typical APIs types (open, close, read, write) that you would associate

                  API types

> +with a communication interface.
> +
> +It also has other APIs that are related to other functions that the device can
> +perform e.g. boot, reset get/set device mode.

   perform,

> +The driver is broken down into 4 source files.
> +
> +xlink-core:
> +Contains driver initialization, driver API and IOCTL interface (for user
> +space).
> +
> +xlink-multiplexer:
> +The Multiplexer component is responsible for securely routing messages through
> +multiple communication channels over a single physical interface.
> +
> +xlink-dispatcher:
> +The Dispatcher component is responsible for queueing and handling xLink
> +communication requests from all users in the system and invoking the underlying
> +platform interface drivers.
> +
> +xlink-platform:
> +provides abstraction to each interface supported (PCIe, USB, IPC, etc).
> +
> +Typical xLink transaction (simplified):
> +When a user wants to send data across an interface via xLink it firstly calls
> +xlink connect which connects to the relevant interface (PCIe, USB,IPC,etc) and

                                                                 USB, IPC, etc.) and

> +then xlink open channel.
> +
> +Then it calls xlink write function, this takes the data passes it to the kernel

                                                      data, passes

> +which packages up the data and channel and then adds it to a tx transaction

s/tx/transmit/

> +queue.
> +
> +A separate thread reads this transaction queue and pops off data if available
> +and passes the data to the underlying interface (e.g. PCIe) write function.
> +Using this thread provides serialization of transactions and decouples the user
> +write from the platform write.
> +
> +On the other side of the interface, a thread is continually reading the
> +interface (e.g. PCIe) via the platform interface read function and if it reads
> +any data it adds it to channel packet container.
> +
> +The application at this side of the interface will have called xlink connect,
> +opened the channel and called xlink read function to read data from the
> +interface and if any exists for that channel , the data gets popped from the

                                        channel,

> +channel packet container and copied from kernel space to user space buffer
> +provided by the call.
> +
> +xLink can handle API requests from multi-process and multi-threaded
> +application/processes.
> +
> +xLink maintains 4096 channels per device connected ( via xlink connect ) and

                                                      (via xlink connect) and

> +maintains a separate channel infrastructure for each device.

> diff --git a/drivers/misc/xlink-core/Kconfig b/drivers/misc/xlink-core/Kconfig
> new file mode 100644
> index 000000000000..3ae7dc01007f
> --- /dev/null
> +++ b/drivers/misc/xlink-core/Kconfig
> @@ -0,0 +1,33 @@
> +config XLINK_CORE
> +	tristate "Support for XLINK CORE"
> +	depends on ((XLINK_PCIE_RH_DRIVER || XBAY_XLINK_PCIE_RH_DRIVER) || (XLINK_LOCAL_HOST && (XLINK_PCIE_LH_DRIVER || XBAY_XLINK_PCIE_RH_DRIVER)))
> +	help
> +	  XLINK CORE enables the communication/control Sub-System.

	                                               subsystem {no hyphen]

> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called xlink.ko.
> +
> +config XLINK_LOCAL_HOST
> +	tristate "Support for XLINK LOCAL HOST"
> +	depends on XLINK_IPC
> +	help
> +	  XLINK LOCAL HOST enables local host functionality for
> +	  the communication/control Sub-System.

	                            subsystem.

> +
> +	  Enable this config when building the kernel for the Inel Vision

	                                                      Intel

> +	  Processing Unit (VPU) Local Host core.
> +
> +	  If building for a Remote Host kernel, say N.
> +
> +config XLINK_PSS
> +	tristate "Support for XLINK PSS"
> +	depends on XLINK_LOCAL_HOST
> +	help
> +	  XLINK PSS enables the communication/control Sub-System on a PSS platform.

	                                              subsystem

Where is PSS defined?
Please spell out that acronym somewhere, e.g.:

	tristate "Support for XLINK PSS (Please Say Something)"


> +
> +	  Enable this config when building the kernel for the Intel Vision
> +	  Processing Unit (VPU) in a simulated env.
> +
> +	  If building for a VPU silicon, say N.


-- 
~Randy

