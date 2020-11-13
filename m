Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA702B1D85
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgKMOcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:32:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgKMOck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:32:40 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A52F72078B;
        Fri, 13 Nov 2020 14:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605277953;
        bh=ibhpij5Sc2832hpGnZRN8WkXc/rD2lRPwkMZgUBmZJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UJlHQbt0lVVLNbJyblDchr8rEQIkNecaa9sL/ObwF2I3powi0vcRFrglVYj60dpC9
         DN1lxaPwuoz111B4Y5dxK2ioDwqHxg9u9Yjr1UmniQtz1J9TD8/7MXxvmh9m/lFUw8
         gnV0oFkwCt0SQmI8Cu12dwtVMbee7QyGyOGNpe2E=
Date:   Fri, 13 Nov 2020 15:33:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sotir Danailov <sndanailov@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: staging: small refactor
Message-ID: <X66ZORk3YvZ2Ufml@kroah.com>
References: <20201107160106.5367-1-sndanailov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107160106.5367-1-sndanailov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 07, 2020 at 06:01:06PM +0200, Sotir Danailov wrote:
> Small refactor of 3 files in the staging directory.
> 
> Signed-off-by: Sotir Danailov <sndanailov@gmail.com>
> ---
>  drivers/staging/mt7621-pci/pci-mt7621.c   |  1 -
>  drivers/staging/rtl8188eu/core/rtw_ap.c   |  4 +++-
>  drivers/staging/rtl8188eu/core/rtw_xmit.c | 25 +++++++++++++++--------
>  3 files changed, 20 insertions(+), 10 deletions(-)

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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
