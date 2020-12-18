Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FED2DEBD1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 00:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgLRW74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 17:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgLRW74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 17:59:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2412EC0617B0;
        Fri, 18 Dec 2020 14:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=wZt5jPkvDSYDw1XVc5r0R9C+AIg9SwGtTG0KRX6U9Fw=; b=QEbvfz27RCcd47U1jfTFu5wjHF
        4qNrQqRDEK5VTtx69yxp0uca/x1i6r9+kRqjPkjZftduHIf+VdopkauCB7Ww9g6F+2u0nb0a2xbsz
        TitDRYLBtxSeliJzCYqNRsW5VgY3ze4qHi3BjDyfzX/+k7ZTgYozobXyabbc1Ij7lbF1/KdIEnoJN
        Mlqm3JFUE6TfwAf6/W1+zPyCRpCnC/kEPiXr45t0Vun8wHAoGmvxWcbbqkVLTt3Zg9o70sHHEZU75
        JSuQ3kzfeoJtc48tlp0LffA6kiT8Z43g2bNyHQ/KUoCqcpnRB9VYOq5uuhKcb45uMP37GlZmGrGZH
        QHjumSnw==;
Received: from [2601:1c0:6280:3f0::64ea]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kqOiK-0005zy-Kx; Fri, 18 Dec 2020 22:59:09 +0000
Subject: Re: [PATCH 06/22] misc: xlink-pcie: Add documentation for XLink PCIe
 driver
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        linux-doc@vger.kernel.org
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-7-mgross@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2fd73da0-ee89-3831-bf96-5ed130e90c4d@infradead.org>
Date:   Fri, 18 Dec 2020 14:59:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201201223511.65542-7-mgross@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/20 2:34 PM, mgross@linux.intel.com wrote:
> From: Srikanth Thokala <srikanth.thokala@intel.com>
> 
> Provide overview of XLink PCIe driver implementation
> 
> Cc: linux-doc@vger.kernel.org
> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
> ---
>  Documentation/vpu/index.rst      |  1 +
>  Documentation/vpu/xlink-pcie.rst | 91 ++++++++++++++++++++++++++++++++
>  2 files changed, 92 insertions(+)
>  create mode 100644 Documentation/vpu/xlink-pcie.rst
> 

Hi--

For document, chapter, section, etc., headings, please read & use
Documentation/doc-guide/sphinx.rst:

* Please stick to this order of heading adornments:

  1. ``=`` with overline for document title::

       ==============
       Document title
       ==============

  2. ``=`` for chapters::

       Chapters
       ========

  3. ``-`` for sections::

       Section
       -------

  4. ``~`` for subsections::

       Subsection
       ~~~~~~~~~~

> diff --git a/Documentation/vpu/xlink-pcie.rst b/Documentation/vpu/xlink-pcie.rst
> new file mode 100644
> index 000000000000..bc64b566989d
> --- /dev/null
> +++ b/Documentation/vpu/xlink-pcie.rst
> @@ -0,0 +1,91 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +Kernel driver: xlink-pcie driver
> +================================
> +Supported chips:
> +  * Intel Edge.AI Computer Vision platforms: Keem Bay
> +    Suffix: Bay
> +    Slave address: 6240
> +    Datasheet: Publicly available at Intel
> +
> +Author: Srikanth Thokala Srikanth.Thokala@intel.com
> +
> +-------------
> +Introduction:

No colon at end of chapter/section headings.

> +-------------
> +The xlink-pcie driver in linux-5.4 provides transport layer implementation for

                            Linux 5.4 (?)

> +the data transfers to support xlink protocol subsystem communication with the

                                 Xlink

> +peer device. i.e, between remote host system and the local Keem Bay device.

        device, i.e., between the remote host system and

> +
> +The Keem Bay device is an ARM based SOC that includes a vision processing

                             ARM-based

> +unit (VPU) and deep learning, neural network core in the hardware.
> +The xlink-pcie driver exports a functional device endpoint to the Keem Bay device
> +and supports two-way communication with peer device.

                                      with the peer device.

> +
> +------------------------
> +High-level architecture:
> +------------------------
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
> +  * Driver path: {tree}/drivers/misc/xlink-pcie/local_host
> +
> +* Remote Host driver
> +
> +       * Intended for IA CPU
> +       * It is a PCIe endpoint driver
> +       * Driver path: {tree}/drivers/misc/xlink-pcie/remote_host
> +
> +XLink PCIe communication between local host and remote host is achieved through
> +ring buffer management and MSI/Doorbell interrupts.
> +
> +The xlink-pcie driver subsystem registers Keem Bay device as an endpoint driver

                                   registers the

> +and provides standard linux pcie sysfs interface, # /sys/bus/pci/devices/xxxx:xx:xx.0/

                         Linux PCIe

> +
> +
> +-------------------------
> +XLink protocol subsystem:

No colon at end.

> +-------------------------
> +xlink is an abstracted control and communication subsystem based on channel

   Xlink

> +identification. It is intended to support VPU technology both at SoC level as
> +well as at IP level, over multiple interfaces.
> +
> +- The xlink subsystem abstracts several types of communication channels

         Xlink

> +  underneath, allowing the usage of different interfaces with the
> +  same function call interface.
> +- The Communication channels are full-duplex protocol channels allowing
> +  concurrent bidirectional communication.
> +- The xlink subsystem also supports control operations to VPU either

         Xlink

> +  from standalone local system or from remote system based on communication
> +  interface underneath.
> +- The xlink subsystem supports following communication interfaces:

         Xlink           supports the following


> +    * USB CDC
> +    * Gigabit Ethernet
> +    * PCIe
> +    * IPC
> 


cheers.
-- 
~Randy

