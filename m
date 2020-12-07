Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82372D1A13
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 20:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgLGTyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 14:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgLGTyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:54:52 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00312C061749;
        Mon,  7 Dec 2020 11:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=1b61RvH52vfjnAKlEJGNRv8bKm9R+jIRDMCUhpsedCo=; b=t6a9Qyx+keIz4kVcMBsxIsG4y2
        xSGihNgl4eERBjSHOktovQU5G1BYHpw31g7SbPpq+CRaXPmCXYWTbKCKaOBMCbZQX68ZXb4Lc7IBK
        XpWCacp85QfytgZlahv3+Q6lvmLYNXBqa5MYgzMRN7hHFzXNuUHzKmvnFtJQPQ3rVclS+82y7eGGJ
        Dm4CiXSff4v5BVMnyt7QXTk+OTZNB7hafM0n8n2UNDgIw6E9JBGlVAkanvSITq83YSSvBascy3hd2
        6YJE5yLxo+flQmkLEi5dc7JEk4uOtf86QdXkaEBuEHGTITOSt9MwpHPoBU3tJ6Nxkag6JGe7dJYs7
        AxJm9SOg==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmMaE-000486-Ac; Mon, 07 Dec 2020 19:54:06 +0000
Subject: Re: [PATCH 16/22] xlink-ipc: Add xlink ipc driver
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Seamus Kelly <seamus.kelly@intel.com>,
        linux-doc@vger.kernel.org,
        Ryan Carnaghi <ryan.r.carnaghi@intel.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-17-mgross@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0177c5ba-58cc-cef6-9970-044d8655ea5d@infradead.org>
Date:   Mon, 7 Dec 2020 11:53:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201201223511.65542-17-mgross@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahoy--

On 12/1/20 2:35 PM, mgross@linux.intel.com wrote:
> From: Seamus Kelly <seamus.kelly@intel.com>
> 
> Add xLink driver, which interfaces the xLink Core driver with the Keem
> Bay VPU IPC driver, thus enabling xLink to control and communicate with
> the VPU IP present on the Intel Keem Bay SoC.
> 
> Specifically the driver enables xLink Core to:
> 
> * Boot / Reset the VPU IP
> * Register to VPU IP event notifications (device connected, device
>   disconnected, WDT event)
> * Query the status of the VPU IP (OFF, BUSY, READY, ERROR, RECOVERY)
> * Exchange data with the VPU IP, using the Keem Bay IPC mechanism
>   - Including the ability to send 'volatile' data (i.e., small amount of
>     data, up to 128-bytes that was not allocated in the CPU/VPU shared
>     memory region)
> 
> Cc: linux-doc@vger.kernel.org
> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Seamus Kelly <seamus.kelly@intel.com>
> Signed-off-by: Ryan Carnaghi <ryan.r.carnaghi@intel.com>
> ---
>  Documentation/vpu/index.rst        |   1 +
>  Documentation/vpu/xlink-ipc.rst    |  50 ++
>  MAINTAINERS                        |   6 +
>  drivers/misc/Kconfig               |   1 +
>  drivers/misc/Makefile              |   1 +
>  drivers/misc/xlink-ipc/Kconfig     |   7 +
>  drivers/misc/xlink-ipc/Makefile    |   4 +
>  drivers/misc/xlink-ipc/xlink-ipc.c | 879 +++++++++++++++++++++++++++++
>  include/linux/xlink-ipc.h          |  48 ++
>  9 files changed, 997 insertions(+)
>  create mode 100644 Documentation/vpu/xlink-ipc.rst
>  create mode 100644 drivers/misc/xlink-ipc/Kconfig
>  create mode 100644 drivers/misc/xlink-ipc/Makefile
>  create mode 100644 drivers/misc/xlink-ipc/xlink-ipc.c
>  create mode 100644 include/linux/xlink-ipc.h

> diff --git a/Documentation/vpu/xlink-ipc.rst b/Documentation/vpu/xlink-ipc.rst
> new file mode 100644
> index 000000000000..af583579e70d
> --- /dev/null
> +++ b/Documentation/vpu/xlink-ipc.rst
> @@ -0,0 +1,50 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +Kernel driver: xLink IPC driver
> +=================================
> +Supported chips:
> +
> +* | Intel Edge.AI Computer Vision platforms: Keem Bay
> +  | Suffix: Bay
> +  | Datasheet: (not yet publicly available)
> +
> +------------
> +Introduction
> +------------
> +
> +The xLink IPC driver interfaces the xLink Core driver with the Keem Bay VPU IPC
> +driver, thus enabling xLink to control and communicate with the VPU IP present
> +on the Intel Keem Bay SoC.
> +
> +Specifically the driver enables xLink Core to:
> +
> +* Boot / Reset the VPU IP
> +* Register to VPU IP event notifications (device connected, device disconnected,
> +  WDT event)
> +* Query the status of the VPU IP (OFF, BUSY, READY, ERROR, RECOVERY)
> +* Exchange data with the VPU IP, using the Keem Bay IPC mechanism
> +
> +  * Including the ability to send 'volatile' data (i.e., small amount of data,
> +    up to 128-bytes that was not allocated in the CPU/VPU shared memory region)
> +
> +Sending / Receiving 'volatile' data
> +-----------------------------------
> +
> +Data to be exchanged with Keem Bay IPC needs to be allocated in the portion of
> +DDR shared between the CPU and VPU.
> +
> +This can be impractical for small amount of data that user code can allocate

                                     amounts

> +on the stack.
> +
> +To reduce the burden on user code, xLink Core provides special send / receive
> +functions to send up to 128 bytes of 'volatile data', i.e., data that is not
> +allocated in the shared memory and that might also disappear after the xLink
> +API is called (e.g., because allocated on the stack).
> +
> +The xLink IPC driver implements support for transferring such 'volatile data'
> +to the VPU using Keem Bay IPC. To this end, the driver reserved some memory in

better:                                                   reserves

> +the shared memory region.
> +
> +When volatile data is to be sent, xLink IPC allocates a buffer from the
> +reserved memory region and copies the volatile data to the buffer. The buffer
> +is then transferred to the VPU using Keem Bay IPC.

> diff --git a/drivers/misc/xlink-ipc/Kconfig b/drivers/misc/xlink-ipc/Kconfig
> new file mode 100644
> index 000000000000..6aa2592fe9a3
> --- /dev/null
> +++ b/drivers/misc/xlink-ipc/Kconfig
> @@ -0,0 +1,7 @@
> +config XLINK_IPC
> +	tristate "Support for XLINK IPC"
> +	depends on KEEMBAY_VPU_IPC
> +	help
> +	  XLINK IPC enables the communication/control IPC Sub-System.
> +
> +	  Select M if you have an Intel SoC with a Vision Processing Unit (VPU)

End that sentence with a '.', please.


-- 
~Randy

