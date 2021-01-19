Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F14C2FC027
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390170AbhASTiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728418AbhASThN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 14:37:13 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F007C061573;
        Tue, 19 Jan 2021 11:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=YNhE+cN1HDNHiTG0YGUXKVf0JQrAZVOCh35c86m/5cA=; b=CzYp77BXE7NHi60dkiyhl0+WrD
        yD91/VbfFP8iTrN369SQPlFRf7ra+rGj0RdJD/l7FcvNkKqYiWKR8dWAqHrQYHeFDmRX5A3Kn3PWj
        kBXiOnFLukMFCbe+uKLs+Wazp8lLqc4S0ciLM+pPWVbt+cVCkTqirMGBPy/bdZbPk8dTKPEJg8QCm
        K7EW3mZiHMtXVYQTuNh1uRXeCupwRbIJCjOFc56NJL64nEMpsj8Bxoc32aiS+yufBrz3FUyKpP2Un
        gSMbXCcVlQ7fDMfLGCHixM5kCdGDg7WboUo9XTDJL9Eb5MPajmJxmESc5p2T9M+b6c+oWWgxSgCBG
        JkChFA5g==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l1wnl-0004fp-IO; Tue, 19 Jan 2021 19:36:29 +0000
Subject: Re: [PATCH v2 08/34] misc: xlink-pcie: Add documentation for XLink
 PCIe driver
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        linux-doc@vger.kernel.org
References: <20210108212600.36850-1-mgross@linux.intel.com>
 <20210108212600.36850-9-mgross@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0e68a2f9-f02d-c777-d9b8-b1ad13555ab3@infradead.org>
Date:   Tue, 19 Jan 2021 11:36:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210108212600.36850-9-mgross@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here are a few doc comments for you:

On 1/8/21 1:25 PM, mgross@linux.intel.com wrote:
> From: Srikanth Thokala <srikanth.thokala@intel.com>
> 
> Provide overview of XLink PCIe driver implementation
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
> ---
>  Documentation/vpu/index.rst      |  1 +
>  Documentation/vpu/xlink-pcie.rst | 90 ++++++++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+)
>  create mode 100644 Documentation/vpu/xlink-pcie.rst
> 

> diff --git a/Documentation/vpu/xlink-pcie.rst b/Documentation/vpu/xlink-pcie.rst
> new file mode 100644
> index 000000000000..2d877c966b1e
> --- /dev/null
> +++ b/Documentation/vpu/xlink-pcie.rst
> @@ -0,0 +1,90 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================================
> +Kernel driver: Xlink-pcie driver
> +================================
> +Supported chips:
> +  * Intel Edge.AI Computer Vision platforms: Keem Bay
> +    Suffix: Bay
> +    Slave address: 6240
> +    Datasheet: Publicly available at Intel
> +
> +Author: Srikanth Thokala Srikanth.Thokala@intel.com
> +
> +Introduction
> +============
> +The Xlink-pcie driver provides transport layer implementation for
> +the data transfers to support Xlink protocol subsystem communication with the
> +peer device. i.e, between remote host system and Keem Bay device.

        device, i.e.,

> +
> +The Keem Bay device is an ARM-based SOC that includes a vision processing
> +unit (VPU) and deep learning, neural network core in the hardware.
> +The Xlink-pcie driver exports a functional device endpoint to the Keem Bay
> +device and supports two-way communication with the peer device.
> +
> +High-level architecture
> +=======================
> +Remote Host: IA CPU
> +Local Host: ARM CPU (Keem Bay)::
> +
> +        +------------------------------------------------------------------------+
> +        |  Remote Host IA CPU              | | Local Host ARM CPU (Keem Bay) |   |
> +        +==================================+=+===============================+===+
> +        |  User App                        | | User App                      |   |
> +        +----------------------------------+-+-------------------------------+---+
> +        |   XLink UAPI                     | | XLink UAPI                    |   |
> +        +----------------------------------+-+-------------------------------+---+
> +        |   XLink Core                     | | XLink Core                    |   |
> +        +----------------------------------+-+-------------------------------+---+
> +        |   XLink PCIe                     | | XLink PCIe                    |   |
> +        +----------------------------------+-+-------------------------------+---+
> +        |   XLink-PCIe Remote Host driver  | | XLink-PCIe Local Host driver  |   |
> +        +----------------------------------+-+-------------------------------+---+
> +        |-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:|:|:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:|
> +        +----------------------------------+-+-------------------------------+---+
> +        |     PCIe Host Controller         | | PCIe Device Controller        | HW|
> +        +----------------------------------+-+-------------------------------+---+
> +               ^                                             ^
> +               |                                             |
> +               |------------- PCIe x2 Link  -----------------|
> +
> +This XLink PCIe driver comprises of two variants:
> +* Local Host driver
> +
> +  * Intended for ARM CPU
> +  * It is based on PCI Endpoint Framework
> +  * Driver path: {tree}/drivers/misc/Xlink-pcie/local_host
> +
> +* Remote Host driver
> +
> +       * Intended for IA CPU
> +       * It is a PCIe endpoint driver
> +       * Driver path: {tree}/drivers/misc/Xlink-pcie/remote_host
> +
> +XLink PCIe communication between local host and remote host is achieved through
> +ring buffer management and MSI/Doorbell interrupts.
> +
> +The Xlink-pcie driver subsystem registers the Keem Bay device as an endpoint
> +driver and provides standard linux PCIe sysfs interface, #

                                Linux
What is the '#' sign for above?

> +/sys/bus/pci/devices/xxxx:xx:xx.0/
> +
> +
> +XLink protocol subsystem
> +========================
> +Xlink is an abstracted control and communication subsystem based on channel
> +identification. It is intended to support VPU technology both at SoC level as
> +well as at IP level, over multiple interfaces.
> +
> +- The Xlink subsystem abstracts several types of communication channels
> +  underneath, allowing the usage of different interfaces with the
> +  same function call interface.
> +- The Communication channels are full-duplex protocol channels allowing
> +  concurrent bidirectional communication.
> +- The Xlink subsystem also supports control operations to VPU either
> +  from standalone local system or from remote system based on communication
> +  interface underneath.
> +- The Xlink subsystem supports the following communication interfaces:
> +    * USB CDC
> +    * Gigabit Ethernet
> +    * PCIe
> +    * IPC
> 


-- 
~Randy
"He closes his eyes and drops the goggles.  You can't get hurt
by looking at a bitmap.  Or can you?"
(Neal Stephenson: Snow Crash)
