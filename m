Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E522DEC4A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 01:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgLSAJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 19:09:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:27012 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgLSAJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 19:09:17 -0500
IronPort-SDR: RgM1hIb7Ppv/kJucWYGLaCY+RHJWKTgxddYfjUK4SLlg7BuaXasrG13dnvU/WfozzNssf2fvbg
 C7nVRGKzZV4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="175668070"
X-IronPort-AV: E=Sophos;i="5.78,431,1599548400"; 
   d="scan'208";a="175668070"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 16:07:31 -0800
IronPort-SDR: 5apeQInjqN1QtnzWe4LXLxbLfwawLGtuxvxGuwLtpRuitCis6i5rtlIA6G98NFCAt799C06QgB
 EK1PpOr2QIVg==
X-IronPort-AV: E=Sophos;i="5.78,431,1599548400"; 
   d="scan'208";a="394032333"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 16:07:30 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 4DD876363;
        Fri, 18 Dec 2020 16:07:30 -0800 (PST)
Date:   Fri, 18 Dec 2020 16:07:30 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, linux-kernel@vger.kernel.org,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 06/22] misc: xlink-pcie: Add documentation for XLink PCIe
 driver
Message-ID: <20201219000730.GA37040@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-7-mgross@linux.intel.com>
 <2fd73da0-ee89-3831-bf96-5ed130e90c4d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fd73da0-ee89-3831-bf96-5ed130e90c4d@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 02:59:00PM -0800, Randy Dunlap wrote:
> On 12/1/20 2:34 PM, mgross@linux.intel.com wrote:
> > From: Srikanth Thokala <srikanth.thokala@intel.com>
> > 
> > Provide overview of XLink PCIe driver implementation
> > 
> > Cc: linux-doc@vger.kernel.org
> > Reviewed-by: Mark Gross <mgross@linux.intel.com>
> > Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
> > ---
> >  Documentation/vpu/index.rst      |  1 +
> >  Documentation/vpu/xlink-pcie.rst | 91 ++++++++++++++++++++++++++++++++
> >  2 files changed, 92 insertions(+)
> >  create mode 100644 Documentation/vpu/xlink-pcie.rst
> > 
> 
> Hi--
> 
> For document, chapter, section, etc., headings, please read & use
> Documentation/doc-guide/sphinx.rst:
> 
> * Please stick to this order of heading adornments:
> 
>   1. ``=`` with overline for document title::
> 
>        ==============
>        Document title
>        ==============
> 
>   2. ``=`` for chapters::
> 
>        Chapters
>        ========
> 
>   3. ``-`` for sections::
> 
>        Section
>        -------
> 
>   4. ``~`` for subsections::
> 
>        Subsection
>        ~~~~~~~~~~
Thanks for the help!  I'm new to the sphix markup language and appreciate your
advice.  I'll reread that doc-guide.

We'll address the issues on our next posting once the marge window closes.

thanks again for the reviews!

--mark


> 
> > diff --git a/Documentation/vpu/xlink-pcie.rst b/Documentation/vpu/xlink-pcie.rst
> > new file mode 100644
> > index 000000000000..bc64b566989d
> > --- /dev/null
> > +++ b/Documentation/vpu/xlink-pcie.rst
> > @@ -0,0 +1,91 @@
> > +.. SPDX-License-Identifier: GPL-2.0-only
> > +
> > +Kernel driver: xlink-pcie driver
> > +================================
> > +Supported chips:
> > +  * Intel Edge.AI Computer Vision platforms: Keem Bay
> > +    Suffix: Bay
> > +    Slave address: 6240
> > +    Datasheet: Publicly available at Intel
> > +
> > +Author: Srikanth Thokala Srikanth.Thokala@intel.com
> > +
> > +-------------
> > +Introduction:
> 
> No colon at end of chapter/section headings.
> 
> > +-------------
> > +The xlink-pcie driver in linux-5.4 provides transport layer implementation for
> 
>                             Linux 5.4 (?)
> 
> > +the data transfers to support xlink protocol subsystem communication with the
> 
>                                  Xlink
> 
> > +peer device. i.e, between remote host system and the local Keem Bay device.
> 
>         device, i.e., between the remote host system and
> 
> > +
> > +The Keem Bay device is an ARM based SOC that includes a vision processing
> 
>                              ARM-based
> 
> > +unit (VPU) and deep learning, neural network core in the hardware.
> > +The xlink-pcie driver exports a functional device endpoint to the Keem Bay device
> > +and supports two-way communication with peer device.
> 
>                                       with the peer device.
> 
> > +
> > +------------------------
> > +High-level architecture:
> > +------------------------
> > +Remote Host: IA CPU
> > +Local Host: ARM CPU (Keem Bay)::
> > +
> > +        +------------------------------------------------------------------------+
> > +        |  Remote Host IA CPU              | | Local Host ARM CPU (Keem Bay) |   |
> > +        +==================================+=+===============================+===+
> > +        |  User App                        | | User App                      |   |
> > +        +----------------------------------+-+-------------------------------+---+
> > +        |   XLink UAPI                     | | XLink UAPI                    |   |
> > +        +----------------------------------+-+-------------------------------+---+
> > +        |   XLink Core                     | | XLink Core                    |   |
> > +        +----------------------------------+-+-------------------------------+---+
> > +        |   XLink PCIe                     | | XLink PCIe                    |   |
> > +        +----------------------------------+-+-------------------------------+---+
> > +        |   XLink-PCIe Remote Host driver  | | XLink-PCIe Local Host driver  |   |
> > +        +----------------------------------+-+-------------------------------+---+
> > +        |-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:|:|:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:|
> > +        +----------------------------------+-+-------------------------------+---+
> > +        |     PCIe Host Controller         | | PCIe Device Controller        | HW|
> > +        +----------------------------------+-+-------------------------------+---+
> > +               ^                                             ^
> > +               |                                             |
> > +               |------------- PCIe x2 Link  -----------------|
> > +
> > +This XLink PCIe driver comprises of two variants:
> > +* Local Host driver
> > +
> > +  * Intended for ARM CPU
> > +  * It is based on PCI Endpoint Framework
> > +  * Driver path: {tree}/drivers/misc/xlink-pcie/local_host
> > +
> > +* Remote Host driver
> > +
> > +       * Intended for IA CPU
> > +       * It is a PCIe endpoint driver
> > +       * Driver path: {tree}/drivers/misc/xlink-pcie/remote_host
> > +
> > +XLink PCIe communication between local host and remote host is achieved through
> > +ring buffer management and MSI/Doorbell interrupts.
> > +
> > +The xlink-pcie driver subsystem registers Keem Bay device as an endpoint driver
> 
>                                    registers the
> 
> > +and provides standard linux pcie sysfs interface, # /sys/bus/pci/devices/xxxx:xx:xx.0/
> 
>                          Linux PCIe
> 
> > +
> > +
> > +-------------------------
> > +XLink protocol subsystem:
> 
> No colon at end.
> 
> > +-------------------------
> > +xlink is an abstracted control and communication subsystem based on channel
> 
>    Xlink
> 
> > +identification. It is intended to support VPU technology both at SoC level as
> > +well as at IP level, over multiple interfaces.
> > +
> > +- The xlink subsystem abstracts several types of communication channels
> 
>          Xlink
> 
> > +  underneath, allowing the usage of different interfaces with the
> > +  same function call interface.
> > +- The Communication channels are full-duplex protocol channels allowing
> > +  concurrent bidirectional communication.
> > +- The xlink subsystem also supports control operations to VPU either
> 
>          Xlink
> 
> > +  from standalone local system or from remote system based on communication
> > +  interface underneath.
> > +- The xlink subsystem supports following communication interfaces:
> 
>          Xlink           supports the following
> 
> 
> > +    * USB CDC
> > +    * Gigabit Ethernet
> > +    * PCIe
> > +    * IPC
> > 
> 
> 
> cheers.
> -- 
> ~Randy
> 
