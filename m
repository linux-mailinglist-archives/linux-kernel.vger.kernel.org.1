Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AF32824D7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 16:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgJCOmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 10:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgJCOmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 10:42:44 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26897206B8;
        Sat,  3 Oct 2020 14:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601736163;
        bh=sbqDqjCCr3e3Ll+vFNyg5piYFp6zzY8KMJ6kJzz7xRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gkz7jRPdfqQJ6f7dQn7SR++jWfFGrgq7MFMSt9B3lIdrGSzsgUkr2+0OWIyr3NPoq
         kvAOUQe6YLzXmwM/NCFKmMQMiQrdgLtaikYZ+radmdxcyPm2ncqiFFo8W8kdOo1eED
         IJUF1Y9RkGffYbIPA4QfFWefb8eNgD+UUnPHU6+A=
Date:   Sat, 3 Oct 2020 16:43:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     sebastien.boeuf@intel.com, stable-commits@vger.kernel.org
Subject: Re: Patch "net: virtio_vsock: Enhance connection semantics" has been
 added to the 4.9-stable tree
Message-ID: <20201003144328.GA862147@kroah.com>
References: <20201002231821.1ED252074B@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002231821.1ED252074B@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 07:18:20PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     net: virtio_vsock: Enhance connection semantics
> 
> to the 4.9-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      net-virtio_vsock-enhance-connection-semantics.patch
> and it can be found in the queue-4.9 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 298b295d45688ac79bebe2e87efa96711e2e0bad
> Author: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Date:   Fri Feb 14 12:48:01 2020 +0100
> 
>     net: virtio_vsock: Enhance connection semantics
>     
>     [ Upstream commit df12eb6d6cd920ab2f0e0a43cd6e1c23a05cea91 ]
>     
>     Whenever the vsock backend on the host sends a packet through the RX
>     queue, it expects an answer on the TX queue. Unfortunately, there is one
>     case where the host side will hang waiting for the answer and might
>     effectively never recover if no timeout mechanism was implemented.
>     
>     This issue happens when the guest side starts binding to the socket,
>     which insert a new bound socket into the list of already bound sockets.
>     At this time, we expect the guest to also start listening, which will
>     trigger the sk_state to move from TCP_CLOSE to TCP_LISTEN. The problem
>     occurs if the host side queued a RX packet and triggered an interrupt
>     right between the end of the binding process and the beginning of the
>     listening process. In this specific case, the function processing the
>     packet virtio_transport_recv_pkt() will find a bound socket, which means
>     it will hit the switch statement checking for the sk_state, but the
>     state won't be changed into TCP_LISTEN yet, which leads the code to pick
>     the default statement. This default statement will only free the buffer,
>     while it should also respond to the host side, by sending a packet on
>     its TX queue.
>     
>     In order to simply fix this unfortunate chain of events, it is important
>     that in case the default statement is entered, and because at this stage
>     we know the host side is waiting for an answer, we must send back a
>     packet containing the operation VIRTIO_VSOCK_OP_RST.
>     
>     One could say that a proper timeout mechanism on the host side will be
>     enough to avoid the backend to hang. But the point of this patch is to
>     ensure the normal use case will be provided with proper responsiveness
>     when it comes to establishing the connection.
>     
>     Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index d64285afe68f3..f66bd0510f138 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -986,6 +986,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  		virtio_transport_free_pkt(pkt);
>  		break;
>  	default:
> +		(void)virtio_transport_reset_no_sock(t, pkt);
>  		virtio_transport_free_pkt(pkt);
>  		break;
>  	}


Also breaks the build on 4.9, so dropping it.

greg k-h
