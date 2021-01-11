Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DDE2F1284
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 13:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbhAKMqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 07:46:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbhAKMqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 07:46:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18F32224B8;
        Mon, 11 Jan 2021 12:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610369135;
        bh=at05HJArNeKKDG7o7RCUH++PakgXJOTjp8UY5j2EBo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z7qiqFwfLDo9Yx3j4OANoNk35Y+L4CpeD45ducxNOwurEQ4Zro1f81e7CmgnE9xLY
         Sb8XGccHj718e2u3uXmhx6EGBgdue1WVXxqIDabxWL13e8YRiZfagR5a3+H8FE+adh
         7+0HyR8PJT/vopBtAewl2pixGzV+FcrfteBN39e0=
Date:   Mon, 11 Jan 2021 13:46:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jorgen Hansen <jhansen@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, pv-drivers@vmware.com
Subject: Re: [PATCH] VMCI: Enforce queuepair max size for
 IOCTL_VMCI_QUEUEPAIR_ALLOC
Message-ID: <X/xItnTyAa7OwSEI@kroah.com>
References: <1610367535-4463-1-git-send-email-jhansen@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610367535-4463-1-git-send-email-jhansen@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 04:18:53AM -0800, Jorgen Hansen wrote:
> When create the VMCI queue pair tracking data structures on the host
> side, the IOCTL for creating the VMCI queue pair didn't validate
> the queue pair size parameters. This change adds checks for this.
> 
> This avoids a memory allocation issue in qp_host_alloc_queue, as
> reported by nslusarek@gmx.net. The check in qp_host_alloc_queue
> has also been updated to enforce the maximum queue pair size
> as defined by VMCI_MAX_GUEST_QP_MEMORY.
> 
> The fix has been verified using sample code supplied by
> nslusarek@gmx.net.
> 
> Reported-by: nslusarek@gmx.net
> Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
> ---
>  drivers/misc/vmw_vmci/vmci_queue_pair.c | 12 ++++++++----
>  include/linux/vmw_vmci_defs.h           |  4 ++--
>  2 files changed, 10 insertions(+), 6 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You sent multiple patches, yet no indication of which ones should be
  applied in which order.  Greg could just guess, but if you are
  receiving this email, he guessed wrong and the patches didn't apply.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for a description of how
  to do this so that Greg has a chance to apply these correctly.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
