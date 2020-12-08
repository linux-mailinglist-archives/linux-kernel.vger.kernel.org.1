Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC662D33C1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgLHUYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:24:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbgLHUYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:24:33 -0500
Date:   Tue, 8 Dec 2020 20:48:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607456802;
        bh=R9ZTonv2bquTD0w3FW4XMjfaf0WYpoD2MwjmUjHw5oM=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Neqj5W1Aj0Aj7asxkUIrAjZCrI+JoRgHoSfvmxK1TeIwO1tEkINzNOzmcLfVr7CWH
         40THnoTl+5dGwKqHJWfjS4gpdO2kd3UtJquz37F549NiQ+O8eSVChtaPPF7M1w2nDn
         rQ1NxLqzLcuCEjtK7SoL9ahhPF+y4vslwJx+iFyo=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
Cc:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        corbet@lwn.net, leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/22] keembay-ipc: Add Keem Bay IPC module
Message-ID: <X8/YceIsM/Akt/E/@kroah.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-4-mgross@linux.intel.com>
 <X8cyA1qKCwrayEOp@kroah.com>
 <bcf8bad08a5f586093a151126aba2127eee44c02.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcf8bad08a5f586093a151126aba2127eee44c02.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 06:59:09PM +0000, Daniele Alessandrelli wrote:
> Hi Greg,
> 
> Thanks for your feedback.
> 
> On Wed, 2020-12-02 at 07:19 +0100, Greg KH wrote:
> > On Tue, Dec 01, 2020 at 02:34:52PM -0800, mgross@linux.intel.com wrote:
> > > From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > > 
> > > On the Intel Movidius SoC code named Keem Bay, communication between the
> > > Computing Sub-System (CSS), i.e., the CPU, and the Multimedia Sub-System
> > > (MSS), i.e., the VPU is enabled by the Keem Bay Inter-Processor
> > > Communication (IPC) mechanism.
> > > 
> > > Add the driver for using Keem Bay IPC from within the Linux Kernel.
> > > 
> > > Keem Bay IPC uses the following terminology:
> > > 
> > > - Node:    A processing entity that can use the IPC to communicate;
> > > 	   currently, we just have two nodes, CPU (CSS) and VPU (MSS).
> > > 
> > > - Link:    Two nodes that can communicate over IPC form an IPC link
> > > 	   (currently, we just have one link, the one between the CPU
> > > 	   and VPU).
> > > 
> > > - Channel: An IPC link can provide multiple IPC channels. IPC channels
> > > 	   allow communication multiplexing, i.e., the same IPC link can
> > > 	   be used by different applications for different
> > > 	   communications. Each channel is identified by a channel ID,
> > > 	   which must be unique within a single IPC link. Channels are
> > > 	   divided in two categories, High-Speed (HS) channels and
> > > 	   General-Purpose (GP) channels. HS channels have higher
> > > 	   priority over GP channels.
> > > 
> > > Keem Bay IPC mechanism is based on shared memory and hardware FIFOs.
> > > Both the CPU and the VPU have their own hardware FIFO. When the CPU
> > > wants to send an IPC message to the VPU, it writes to the VPU FIFO (MSS
> > > FIFO); similarly, when MSS wants to send an IPC message to the CPU, it
> > > writes to the CPU FIFO (CSS FIFO).
> > > 
> > > A FIFO entry is simply a pointer to an IPC buffer (aka IPC header)
> > > stored in a portion of memory shared between the CPU and the VPU.
> > > Specifically, the FIFO entry contains the (VPU) physical address of the
> > > IPC buffer being transferred.
> > > 
> > > In turn, the IPC buffer contains the (VPU) physical address of the
> > > payload (which must be located in shared memory too) as well as other
> > > information (payload size, IPC channel ID, etc.).
> > > 
> > > Each IPC node instantiates a pool of IPC buffers from its own IPC buffer
> > > memory region. When instantiated, IPC buffers are marked as free. When
> > > the node needs to send an IPC message, it gets the first free buffer it
> > > finds (from its own pool), marks it as allocated (used), and puts its
> > > physical address into the IPC FIFO of the destination node. The
> > > destination node (which is notified by an interrupt when there are
> > > entries pending in its FIFO) extract the physical address from the FIFO
> > > and process the IPC buffer, marking it as free once done (so that the
> > > sender can reuse the buffer).
> > 
> > Any reason you can't use the dmabuf interface for these memory buffers
> > you are creating and having to manage "by hand"?  I thought that was
> > what the kernel was wanting to unify on such that individual
> > drivers/subsystems didn't have to do this on their own.
> 
> My understanding is that the dmabuf interface is used to share DMA
> buffers across different drivers, while these buffers are used only
> internally to the IPC driver (and exchanged only with the VPU
> firmware). They basically are packet headers that are sent to the VPU.

There's no reason you couldn't use these to share your buffers
"internally" as well, because you have the same lifetime rules and
accounting and all other sorts of things you have to handle, right?  Why
rewrite something like this when you should take advantage of common
code instead?

thanks,

greg k-h
