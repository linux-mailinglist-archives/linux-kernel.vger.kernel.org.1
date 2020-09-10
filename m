Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C7A264E8B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 21:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgIJTSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 15:18:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731423AbgIJPyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:54:35 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF5D12087C;
        Thu, 10 Sep 2020 15:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599753273;
        bh=06yvRqufpDKTL7eJkUTiaY9kU5FEtoxUdBgPI2zHOnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1aK7tmLdeqBcvUuSqsNwRcB9FXAlcQ9ikJshaBOwu1MeKRb+C3UaySFiBFuvVzFOd
         tQqZ79YSa9ackPE1j5JMlAMYZxYVaYp+9zY0KZt7keuI8//0nivXcy8yHZVwjJ3KJG
         Z6AzNO8odyBG8OvcfuMj+KmSr4C6sh50MTAEqciI=
Date:   Thu, 10 Sep 2020 17:54:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: Re: [PATCH 00/15] Adding GAUDI NIC code to habanalabs driver
Message-ID: <20200910155440.GC1151284@kroah.com>
References: <20200910150328.20545-1-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910150328.20545-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 06:03:13PM +0300, Oded Gabbay wrote:
> This patch-set adds support for initializing and using the GAUDI NIC ports,
> functioning as scale-out interconnect when doing distributed Deep Learning
> training. The training can be performed over tens of thousands of GAUDIs
> and it is done using the RDMA-over-converged-Ethernet (RoCE) v2 protocol.
> 
> Each GAUDI exposes 10x100GbE ports that are designed to scale-out the
> inter-GAUDI communication by integrating a complete communication engine
> on-die. This native integration allows users to use the same scaling
> technology, both inside the server and rack (termed as scale-up), as well
> as for scaling across racks (scale-out). The racks can be connected
> directly between GAUDI processors, or through any number of standard
> Ethernet switches.
> 
> The driver exposes the NIC ports to the user as standard Ethernet ports by
> registering each port to the networking subsystem. This allows the user to
> manage the ports with standard tools such as ifconfig, ethtool, etc. It
> also enables us to connect to the Linux networking stack and thus support
> standard networking protocols, such as IPv4, IPv6, TCP, etc. In addition,
> we can also leverage protocols such as DCB for dynamically configuring
> priorities to avoid congestion.
> 
> For each NIC port there is a matching QMAN entity. For RoCE, the user
> submits workloads to the NIC through the QMAN, same as he does for the
> compute engines. For regular Ethernet, the user sends and receives packets
> through the standard Ethernet sockets. Those sockets are used only as a
> control path. The data path that is used for AI training goes through the
> RoCE interface.
> 
> It is important to note that there are some limitations and uniqueness
> in GAUDI's NIC H/W, compared to other networking adapters that enforced us
> to use a less-than-common driver design:
> 
> 1. The NIC functionality is NOT exposed as different PCI Physical
>    Functions. There is a single PF which is used for compute and
>    networking, as the main goal of the NIC ports is to be used as
>    intra-communication and not as standard network interfaces. This
>    implies we can't connect different drivers to handle the networking
>    ports because it is the same device, from the kernel POV, as the
>    compute. Therefore, we must integrate the networking code into the
>    main habanalabs driver.

That's kind of common, see the long threads on the netdev and IB mailing
lists about this type of issue on other networking cards today.  The
whole "virtual bus" code should help solve this, if Intel ever gets
around to posting a new version of that patch series one day...

But, because you are writing networking driver code here, you really
should run all of this by the netdev@vger.kernel.org maintainers and
developers, as they know how to review this interaction with the network
stack better than anyone else.

Care to resend it and cc: them too?

thanks,

greg k-h
