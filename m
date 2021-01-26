Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BD4303B80
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392361AbhAZLXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:23:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:52760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390466AbhAZIwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:52:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02D71229C4;
        Tue, 26 Jan 2021 08:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611651087;
        bh=O/jysFJbiQhGrCJuXWNUhpNvfIeZoCi15ejwmu1MSsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5E2TELYiJY0TW4jXy0qXy56GnExAudQxN0BUpJCLK6afrIhxQBsCbNTygJggEP1N
         qo1WfxApG1qRxdYBK8g/82KTgCGFKlWCeq9A/Br6hwhK3+u10o2fRpSIsANaIS+GQ9
         OKuCAGMW46PHhvSOL79NHTgHY1e4i9JWNbvBHlXA=
Date:   Tue, 26 Jan 2021 09:51:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     mateng <ayowoe@163.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        mateng <mateng@yulong.com>
Subject: Re: [PATCH] misc/vmw_vmci: fix typo
Message-ID: <YA/YDSvmUhYLOl3f@kroah.com>
References: <20210126084010.1941-1-ayowoe@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126084010.1941-1-ayowoe@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 04:40:10PM +0800, mateng wrote:
> From: mateng <mateng@yulong.com>
> 
> change 'addres' to 'address'
> 
> Signed-off-by: mateng <mateng@yulong.com>
> ---
>  drivers/misc/vmw_vmci/vmci_queue_pair.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.h b/drivers/misc/vmw_vmci/vmci_queue_pair.h
> index 00017fc..c4e6e92 100644
> --- a/drivers/misc/vmw_vmci/vmci_queue_pair.h
> +++ b/drivers/misc/vmw_vmci/vmci_queue_pair.h
> @@ -104,7 +104,7 @@ struct vmci_qp_dtch_info {
>  struct vmci_qp_page_store {
>  	/* Reference to pages backing the queue pair. */
>  	u64 pages;
> -	/* Length of pageList/virtual addres range (in pages). */
> +	/* Length of pageList/virtual address range (in pages). */
>  	u32 len;
>  };
>  
> -- 
> 1.9.1
> 
> 

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

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
