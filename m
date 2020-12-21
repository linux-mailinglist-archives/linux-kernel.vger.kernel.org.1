Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95ADD2DFC04
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 13:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgLUMp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 07:45:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgLUMp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 07:45:26 -0500
Date:   Mon, 21 Dec 2020 13:46:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1608554685;
        bh=PBUW9Lx+G53wYGSrbtEAM4HN5gntZsw8HL1tFF3G2V4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=YgZGL83lfemTCEe+XHlHWz1bKJ44ruN3dOwcPv5zrX8CfP7jyjrlHtGfzfUFKjGjU
         pzuOYa0PEK8FexptM8wWeN5/sVKTQ/DDH0XMPtZr0cPtpWZQhn/N7mazIgGKNBv/16
         pIA7tnyQHn9lCpVGR3SgQcUULUK/OExOMt0CFyvc=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anjandev Momi <anjan@momi.ca>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon-usb: octeon-hcd: fixed indent and ending
 with brace coding style issue
Message-ID: <X+CZCejDffbbkQ2T@kroah.com>
References: <20201221091508.17280-1-anjan@momi.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221091508.17280-1-anjan@momi.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 09:15:57AM +0000, Anjandev Momi wrote:
> Fixed coding style issues
> 
> Signed-off-by: Anjandev Momi <anjan@momi.ca>
> ---
>  drivers/staging/octeon-usb/octeon-hcd.c | 96 ++++++++++++-------------
>  1 file changed, 46 insertions(+), 50 deletions(-)
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
