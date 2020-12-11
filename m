Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264682D71AB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436867AbgLKIYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:24:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436843AbgLKIXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:23:38 -0500
Date:   Fri, 11 Dec 2020 09:22:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607674977;
        bh=cEG2dsj6Lc6hGoLQ5vnXHriRwLps+wvQMuWoBGz3oZY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZ0T/585KVykK2BUWWeG+N6Tr1DG3CJKUYjAs5HVaCvebo6n7ZHc0cSoBucF7nWmp
         AudiBgBvkQ9wWOvIZSMSyPsODkSsZdAxtmJJWDSvdB0TjWcZQnabz2yF4Cmd5Qh5Nz
         rY0LiDByWBSJQfU42ph8bLcH/CywUnNIZD0saO5U=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
Cc:     Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com
Subject: Re: [PATCH 03/22] keembay-ipc: Add Keem Bay IPC module
Message-ID: <X9MsXRDcdoftq8ZC@kroah.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-4-mgross@linux.intel.com>
 <X8cyA1qKCwrayEOp@kroah.com>
 <bcf8bad08a5f586093a151126aba2127eee44c02.camel@linux.intel.com>
 <X8/YceIsM/Akt/E/@kroah.com>
 <a5a13b6b399745f1f8b369334b0e626ee16d532a.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5a13b6b399745f1f8b369334b0e626ee16d532a.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 06:38:24PM +0000, Daniele Alessandrelli wrote:
> On Tue, 2020-12-08 at 20:48 +0100, Greg KH wrote:
> > On Tue, Dec 08, 2020 at 06:59:09PM +0000, Daniele Alessandrelli wrote:
> > > Hi Greg,
> > > 
> > > Thanks for your feedback.
> > > 
> > > On Wed, 2020-12-02 at 07:19 +0100, Greg KH wrote:
> > > > On Tue, Dec 01, 2020 at 02:34:52PM -0800, mgross@linux.intel.com wrote:
> > > > > From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > > > > 
> > > > > On the Intel Movidius SoC code named Keem Bay, communication between the
> > > > > Computing Sub-System (CSS), i.e., the CPU, and the Multimedia Sub-System
> > > > > (MSS), i.e., the VPU is enabled by the Keem Bay Inter-Processor
> > > > > Communication (IPC) mechanism.
> > > > > 
> > > > > Add the driver for using Keem Bay IPC from within the Linux Kernel.
> > > > > 
> > > > > Keem Bay IPC uses the following terminology:
> > > > > 
> > > > > - Node:    A processing entity that can use the IPC to communicate;
> > > > > 	   currently, we just have two nodes, CPU (CSS) and VPU (MSS).
> > > > > 
> > > > > - Link:    Two nodes that can communicate over IPC form an IPC link
> > > > > 	   (currently, we just have one link, the one between the CPU
> > > > > 	   and VPU).
> > > > > 
> > > > > - Channel: An IPC link can provide multiple IPC channels. IPC channels
> > > > > 	   allow communication multiplexing, i.e., the same IPC link can
> > > > > 	   be used by different applications for different
> > > > > 	   communications. Each channel is identified by a channel ID,
> > > > > 	   which must be unique within a single IPC link. Channels are
> > > > > 	   divided in two categories, High-Speed (HS) channels and
> > > > > 	   General-Purpose (GP) channels. HS channels have higher
> > > > > 	   priority over GP channels.
> > > > > 
> > > > > Keem Bay IPC mechanism is based on shared memory and hardware FIFOs.
> > > > > Both the CPU and the VPU have their own hardware FIFO. When the CPU
> > > > > wants to send an IPC message to the VPU, it writes to the VPU FIFO (MSS
> > > > > FIFO); similarly, when MSS wants to send an IPC message to the CPU, it
> > > > > writes to the CPU FIFO (CSS FIFO).
> > > > > 
> > > > > A FIFO entry is simply a pointer to an IPC buffer (aka IPC header)
> > > > > stored in a portion of memory shared between the CPU and the VPU.
> > > > > Specifically, the FIFO entry contains the (VPU) physical address of the
> > > > > IPC buffer being transferred.
> > > > > 
> > > > > In turn, the IPC buffer contains the (VPU) physical address of the
> > > > > payload (which must be located in shared memory too) as well as other
> > > > > information (payload size, IPC channel ID, etc.).
> > > > > 
> > > > > Each IPC node instantiates a pool of IPC buffers from its own IPC buffer
> > > > > memory region. When instantiated, IPC buffers are marked as free. When
> > > > > the node needs to send an IPC message, it gets the first free buffer it
> > > > > finds (from its own pool), marks it as allocated (used), and puts its
> > > > > physical address into the IPC FIFO of the destination node. The
> > > > > destination node (which is notified by an interrupt when there are
> > > > > entries pending in its FIFO) extract the physical address from the FIFO
> > > > > and process the IPC buffer, marking it as free once done (so that the
> > > > > sender can reuse the buffer).
> > > > 
> > > > Any reason you can't use the dmabuf interface for these memory buffers
> > > > you are creating and having to manage "by hand"?  I thought that was
> > > > what the kernel was wanting to unify on such that individual
> > > > drivers/subsystems didn't have to do this on their own.
> > > 
> > > My understanding is that the dmabuf interface is used to share DMA
> > > buffers across different drivers, while these buffers are used only
> > > internally to the IPC driver (and exchanged only with the VPU
> > > firmware). They basically are packet headers that are sent to the VPU.
> > 
> > There's no reason you couldn't use these to share your buffers
> > "internally" as well, because you have the same lifetime rules and
> > accounting and all other sorts of things you have to handle, right?  Why
> > rewrite something like this when you should take advantage of common
> > code instead?
> 
> I looked at dma-buf again, but I'm still failing to see how we can use
> it in this driver :/
> 
> The problem I'm not able to solve is exactly how to match the lifetime
> of this IPC packets (IPC buffers is probably a misleading name, my bad
> for using it in the code) with the dma-buf lifetime rules.
> 
> Basically, these IPC packets are cache-aligned (64 bytes) and have the
> following fixed structure:
>  
>    struct kmb_ipc_buf {
>           u32 data_addr;
>           u32 data_size;
>           u16 channel;
>           u8  src_node;
>           u8  dst_node;
>           u8  status;
>    } __packed __aligned(KMB_IPC_ALIGNMENT);

If that is shared out of the kernel, please use the proper data types
for it.

And it isn't properly padded out?  That feels like a hardware design
mistake somewhere, anyway...

> Now, let's ignore the first 5 fields and focus on the last one that
> controls the lifetime of the packet. The status field can be either
> FREE or ALLOCATED (perhaps should be renamed to IN_USE).
>  
> Basically, during probe, the driver allocates an array (pool) of these
> packets from its 'local' reserved memory region. This is done using
> dma_alloc_coherent(). This array remains allocated until remove() is
> called.
>  
> At run-time, every time the driver sends a message to the VPU, the
> following happens:
> 
>    1. The IPC driver loops through the array of 'local' packets to find
>       the first one marked as FREE
>    2. The IPC driver marks the packet as IN_USE and shares it with the VPU
>       by putting its physical address into the VPU HW FIFO.
>    3. The VPU Firmware processes the packet and, when done with it, it
>       marks it as FREE again so that the IPC driver can use it again.

How does the firmware "mark it as free"?

> Please note that the IPC driver is not notified by the VPU when the
> packet is marked as free (there is no IRQ or other async mechanism to
> do that). The driver will simply find the message free the next time it
> loops over the message pool again (i.e., when it is trying to send a
> new message).
>  
> Given that the free operation is silently done by the VPU, I'm failing
> to see how I can use dmabuf (or gen_pool or dma_pool). Is there
> anything that I'm missing?

So maybe this isn't set up to use the dma buffers, but it still feels
really odd.  I recommend getting a review by the dmabuf authors before
declaring that you really should be rolling your own buffer management
logic here, as you can see that it feels like you are doing much the
same thing, sharing memory outside of the kernel to something else.

thanks,

greg k-h
