Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927E62CB4EB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 07:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgLBGTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 01:19:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbgLBGTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 01:19:18 -0500
Date:   Wed, 2 Dec 2020 07:19:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606889917;
        bh=u1OkzUBGLWjMLSmOkxWV8Jg5mD2VB2KK9yyrZEzajkY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=HYTVMDfRx1QWCWdXYU4Z5jAMZEe5KZb9d2JMxSHqTuwdcksWKzocQ1ip07L0X3RLL
         4cbMqfKk0z4aLAcrvWo1ZDGoa75l2NyGbhUvxdl2oAIq+wwGuR3R7c5NFYuyO5fXar
         rojc1XgrL4TRNy4QFfQBWGy5S3fKTLZhFyksc5Lg=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     mgross@linux.intel.com
Cc:     markgross@kernel.org, arnd@arndb.de, bp@suse.de,
        damien.lemoal@wdc.com, dragan.cvetic@xilinx.com, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Subject: Re: [PATCH 03/22] keembay-ipc: Add Keem Bay IPC module
Message-ID: <X8cyA1qKCwrayEOp@kroah.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-4-mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201223511.65542-4-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 02:34:52PM -0800, mgross@linux.intel.com wrote:
> From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> 
> On the Intel Movidius SoC code named Keem Bay, communication between the
> Computing Sub-System (CSS), i.e., the CPU, and the Multimedia Sub-System
> (MSS), i.e., the VPU is enabled by the Keem Bay Inter-Processor
> Communication (IPC) mechanism.
> 
> Add the driver for using Keem Bay IPC from within the Linux Kernel.
> 
> Keem Bay IPC uses the following terminology:
> 
> - Node:    A processing entity that can use the IPC to communicate;
> 	   currently, we just have two nodes, CPU (CSS) and VPU (MSS).
> 
> - Link:    Two nodes that can communicate over IPC form an IPC link
> 	   (currently, we just have one link, the one between the CPU
> 	   and VPU).
> 
> - Channel: An IPC link can provide multiple IPC channels. IPC channels
> 	   allow communication multiplexing, i.e., the same IPC link can
> 	   be used by different applications for different
> 	   communications. Each channel is identified by a channel ID,
> 	   which must be unique within a single IPC link. Channels are
> 	   divided in two categories, High-Speed (HS) channels and
> 	   General-Purpose (GP) channels. HS channels have higher
> 	   priority over GP channels.
> 
> Keem Bay IPC mechanism is based on shared memory and hardware FIFOs.
> Both the CPU and the VPU have their own hardware FIFO. When the CPU
> wants to send an IPC message to the VPU, it writes to the VPU FIFO (MSS
> FIFO); similarly, when MSS wants to send an IPC message to the CPU, it
> writes to the CPU FIFO (CSS FIFO).
> 
> A FIFO entry is simply a pointer to an IPC buffer (aka IPC header)
> stored in a portion of memory shared between the CPU and the VPU.
> Specifically, the FIFO entry contains the (VPU) physical address of the
> IPC buffer being transferred.
> 
> In turn, the IPC buffer contains the (VPU) physical address of the
> payload (which must be located in shared memory too) as well as other
> information (payload size, IPC channel ID, etc.).
> 
> Each IPC node instantiates a pool of IPC buffers from its own IPC buffer
> memory region. When instantiated, IPC buffers are marked as free. When
> the node needs to send an IPC message, it gets the first free buffer it
> finds (from its own pool), marks it as allocated (used), and puts its
> physical address into the IPC FIFO of the destination node. The
> destination node (which is notified by an interrupt when there are
> entries pending in its FIFO) extract the physical address from the FIFO
> and process the IPC buffer, marking it as free once done (so that the
> sender can reuse the buffer).

Any reason you can't use the dmabuf interface for these memory buffers
you are creating and having to manage "by hand"?  I thought that was
what the kernel was wanting to unify on such that individual
drivers/subsystems didn't have to do this on their own.

thanks,

greg k-h
