Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5A22FE827
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbhAUKy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:54:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729345AbhAUKp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:45:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0ED9F23602;
        Thu, 21 Jan 2021 10:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611225912;
        bh=fzigFkkk+l+r/J77tFRxWfQfBO3irj964pnA7uG4jcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NEvBg0fVJJN3a07ySiKDnkNBQ/uAn9Cppo0UNpZXQ+Y1FVD0n7vlDqF508n1KKWCQ
         3hvjnv7g2uY2q8hY6Vz3+Zv582KznOfbfTTY+44bgJasWjuJl/6POMK/epj9QGodRa
         h6Glwq14tCNJRRAIupVKZVsd5UKkxfJc9kmngVaM=
Date:   Thu, 21 Jan 2021 11:45:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ricky_wu@realtek.com
Cc:     arnd@arndb.de, bhelgaas@google.com, vaibhavgupta40@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: rtsx: init value of aspm_enabled
Message-ID: <YAlbNTkmlhDZTJE5@kroah.com>
References: <20210121103559.2574-1-ricky_wu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121103559.2574-1-ricky_wu@realtek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 06:35:59PM +0800, ricky_wu@realtek.com wrote:
> From: Ricky Wu <ricky_wu@realtek.com>
> 
> make sure ASPM state sync with pcr->aspm_enabled
> init value pcr->aspm_enabled
> 
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
>  drivers/misc/cardreader/rtsx_pcr.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)


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
