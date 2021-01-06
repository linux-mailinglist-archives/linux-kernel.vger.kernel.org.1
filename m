Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5F72EBF85
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 15:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbhAFOWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 09:22:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbhAFOWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:22:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D806C22DD3;
        Wed,  6 Jan 2021 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609942934;
        bh=Cb1pMkbG+D1lMDSZbLfzNbe9TFmhAojQGLpCxZfsZfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hH6ty5vh9rDgEOugJ3Vf4jWy4Xn1kpzqi8VKbT7TAyxTi1chPQaq5gRTAnz12Ouly
         7q+RgJJNa1u/b9fE6JJx+XHQeacgabdMvDRUd/HzWqun5aq9CeYTv+6behFSse6XDJ
         39EiAC8qjMKGhFjq4eRDaOuYueo4pxq1PtLbbySg=
Date:   Wed, 6 Jan 2021 15:23:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eli Billauer <eli.billauer@gmail.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: xillybus: Add driver for XillyUSB (Xillybus
 variant for USB)
Message-ID: <X/XH5Q6APKKt4kRR@kroah.com>
References: <20201213170503.59017-1-eli.billauer@gmail.com>
 <X/Rt+bUJ9Hs2F8nF@kroah.com>
 <5FF5C31C.6050804@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5FF5C31C.6050804@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 04:03:08PM +0200, Eli Billauer wrote:
> Hello Greg,
> 
> Merging XillyUSB's driver into xillybus_core.c was of course the initial
> idea. Practically, it turned out that this doesn't reduce the number of code
> lines nor makes the code easier to understand: The XillyUSB driver is a
> completely different deal internally, in almost every aspect of it.
> 
> Indeed, the two drivers do basically the same thing: They create a pipe-like
> API using a hardware interface that is based upon buffers. This is what most
> of the code in both drivers is about. As this underlying hardware interface
> is so fundamentally different, there is little in common between the
> drivers.
> 
> The existing xillybus_core.c driver is based upon direct memory register +
> DMA interaction with the hardware. XillyUSB relies on the USB framework for
> all communication. I'll try to demonstrate the practical differences with
> two examples.
> 
> (1) Sending commands to the hardware: The existing Xillybus driver just
> writes to registers in memory space. Its XillyUSB counterpart calls
> xillyusb_send_opcode() to prepare a little packet for transmission over USB,
> and may possibly sleep if there's a (temporary) lack of resources to
> complete that task.
> 
> (2) Data handling: The existing Xillybus driver just copies user data to and
> from DMA buffers. Its main business is to maintain and juggle these buffers
> with the hardware. The XillyUSB driver, on the other hand, manages a pool of
> URBs to efficiently shuffle the data to and from the hardware. The main
> challenge is to keep the data flowing at 400 MB/s.
> 
> This goes on for every single aspect of the two drivers: They do the same
> things essentially, but the actual actions are completely different, as they
> have different means to do get the job done. And completely different
> challenges.

That's fine, but I'm talking about the userspace api.  You should not be
creating two different userspace apis just because the bus transport
changed for the hardware.

We don't do that for things like tty devices, right?  :)

So please, share the same core code that exports the api to userspace to
be common, do not create a new one, like you did here.

thanks,

greg k-h
