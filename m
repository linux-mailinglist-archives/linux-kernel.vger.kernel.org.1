Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CAB2D33DA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgLHU1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:27:13 -0500
Received: from mga03.intel.com ([134.134.136.65]:57493 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728748AbgLHU1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:27:10 -0500
IronPort-SDR: tJLXIR6sVvJ5TSbINON6vcoHPEaSNuCm2wbmG+CCeD474ISR4BvJc9R2KLcn3sDI9/DXxJbwEI
 //jQSzmJmCDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="174068655"
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400"; 
   d="scan'208";a="174068655"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 10:59:17 -0800
IronPort-SDR: iOk6x44I2R/IVHg4tM8RX2trIK1ZUNOMMwudDTHe7d4698zCtrGS7+WSe5ckriz8+Cme2knqd2
 DVNm2ytiwTiw==
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400"; 
   d="scan'208";a="363774089"
Received: from jfallon-mobl1.ger.corp.intel.com ([10.251.88.169])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 10:59:12 -0800
Message-ID: <bcf8bad08a5f586093a151126aba2127eee44c02.camel@linux.intel.com>
Subject: Re: [PATCH 03/22] keembay-ipc: Add Keem Bay IPC module
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>, mgross@linux.intel.com
Cc:     markgross@kernel.org, arnd@arndb.de, bp@suse.de,
        damien.lemoal@wdc.com, dragan.cvetic@xilinx.com, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 08 Dec 2020 18:59:09 +0000
In-Reply-To: <X8cyA1qKCwrayEOp@kroah.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
         <20201201223511.65542-4-mgross@linux.intel.com>
         <X8cyA1qKCwrayEOp@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for your feedback.

On Wed, 2020-12-02 at 07:19 +0100, Greg KH wrote:
> On Tue, Dec 01, 2020 at 02:34:52PM -0800, mgross@linux.intel.com wrote:
> > From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > 
> > On the Intel Movidius SoC code named Keem Bay, communication between the
> > Computing Sub-System (CSS), i.e., the CPU, and the Multimedia Sub-System
> > (MSS), i.e., the VPU is enabled by the Keem Bay Inter-Processor
> > Communication (IPC) mechanism.
> > 
> > Add the driver for using Keem Bay IPC from within the Linux Kernel.
> > 
> > Keem Bay IPC uses the following terminology:
> > 
> > - Node:    A processing entity that can use the IPC to communicate;
> > 	   currently, we just have two nodes, CPU (CSS) and VPU (MSS).
> > 
> > - Link:    Two nodes that can communicate over IPC form an IPC link
> > 	   (currently, we just have one link, the one between the CPU
> > 	   and VPU).
> > 
> > - Channel: An IPC link can provide multiple IPC channels. IPC channels
> > 	   allow communication multiplexing, i.e., the same IPC link can
> > 	   be used by different applications for different
> > 	   communications. Each channel is identified by a channel ID,
> > 	   which must be unique within a single IPC link. Channels are
> > 	   divided in two categories, High-Speed (HS) channels and
> > 	   General-Purpose (GP) channels. HS channels have higher
> > 	   priority over GP channels.
> > 
> > Keem Bay IPC mechanism is based on shared memory and hardware FIFOs.
> > Both the CPU and the VPU have their own hardware FIFO. When the CPU
> > wants to send an IPC message to the VPU, it writes to the VPU FIFO (MSS
> > FIFO); similarly, when MSS wants to send an IPC message to the CPU, it
> > writes to the CPU FIFO (CSS FIFO).
> > 
> > A FIFO entry is simply a pointer to an IPC buffer (aka IPC header)
> > stored in a portion of memory shared between the CPU and the VPU.
> > Specifically, the FIFO entry contains the (VPU) physical address of the
> > IPC buffer being transferred.
> > 
> > In turn, the IPC buffer contains the (VPU) physical address of the
> > payload (which must be located in shared memory too) as well as other
> > information (payload size, IPC channel ID, etc.).
> > 
> > Each IPC node instantiates a pool of IPC buffers from its own IPC buffer
> > memory region. When instantiated, IPC buffers are marked as free. When
> > the node needs to send an IPC message, it gets the first free buffer it
> > finds (from its own pool), marks it as allocated (used), and puts its
> > physical address into the IPC FIFO of the destination node. The
> > destination node (which is notified by an interrupt when there are
> > entries pending in its FIFO) extract the physical address from the FIFO
> > and process the IPC buffer, marking it as free once done (so that the
> > sender can reuse the buffer).
> 
> Any reason you can't use the dmabuf interface for these memory buffers
> you are creating and having to manage "by hand"?  I thought that was
> what the kernel was wanting to unify on such that individual
> drivers/subsystems didn't have to do this on their own.

My understanding is that the dmabuf interface is used to share DMA
buffers across different drivers, while these buffers are used only
internally to the IPC driver (and exchanged only with the VPU
firmware). They basically are packet headers that are sent to the VPU.

So, unless I'm missing something, dmabuf is probably not a good fit
here.

However, it could make sense to use dmabuf to share buffers across the
drivers in the xLink stack. We'll look into that.




