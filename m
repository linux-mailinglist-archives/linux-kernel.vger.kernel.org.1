Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084FD1E5BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 11:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgE1J1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 05:27:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728199AbgE1J1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 05:27:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84A7D2075F;
        Thu, 28 May 2020 09:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590658070;
        bh=k57ddZ2iG3xeSeJ5Opn/1ZWN3PgWXYsjUWkH9TCCVbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dHKZuFzE5C9C1v4QFWTmR55+/PKpg1Cseo6a3nFPaVNNUV/tmuflNqp4PHFKgoWRw
         xl1EOJJCtB+LT7ssh2ufuPzUGc3xf+K0OSNDU6qPhWFVKON8iqfPXYin5aDQC0Zle+
         molQBuTJNIZ3N5yDCzoaR+dgHoQtzVIYCTrXvIdg=
Date:   Thu, 28 May 2020 11:27:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Enderborg, Peter" <Peter.Enderborg@sony.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] debugfs: Add mount restriction option
Message-ID: <20200528092747.GA3007208@kroah.com>
References: <20200528080031.24149-1-peter.enderborg@sony.com>
 <20200528082753.GA2920930@kroah.com>
 <3e1be4dc-01d4-7fc5-1c82-1c792d3fbc11@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e1be4dc-01d4-7fc5-1c82-1c792d3fbc11@sony.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 08:39:02AM +0000, Enderborg, Peter wrote:
> On 5/28/20 10:27 AM, Greg Kroah-Hartman wrote:
> > On Thu, May 28, 2020 at 10:00:31AM +0200, Peter Enderborg wrote:
> >> Since debugfs include sensitive information it need to be treated
> >> carefully. But it also has many very useful debug functions for userspace.
> >> With this option we can have same configuration for system with
> >> need of debugfs and a way to turn it off. It is needed new
> >> kernel command line parameter to be activated.
> > By "configuration" do you mean "kernel configuration"?  What is wrong
> > with relying on the build option like we do today?
> >
> > You might want to reword all of this to make more sense about the
> > "problem" you are trying to solve here, as I don't really understand it,
> > sorry.
> >
> >
> >> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> >> ---
> >>  fs/debugfs/inode.c | 17 ++++++++++++++++-
> >>  lib/Kconfig.debug  | 10 ++++++++++
> >>  2 files changed, 26 insertions(+), 1 deletion(-)
> > No documentation update?  That's not good :(
> >
> >
> >> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> >> index b7f2e971ecbc..bde37dab77e0 100644
> >> --- a/fs/debugfs/inode.c
> >> +++ b/fs/debugfs/inode.c
> >> @@ -786,10 +786,25 @@ bool debugfs_initialized(void)
> >>  }
> >>  EXPORT_SYMBOL_GPL(debugfs_initialized);
> >>  
> >> +static int allow_debugfs;
> >> +
> >> +static int __init debugfs_kernel(char *str)
> >> +{
> >> +	if (str && !strcmp(str, "true"))
> >> +		allow_debugfs = true;
> >> +
> >> +	return 0;
> >> +
> >> +}
> >> +early_param("debugfs", debugfs_kernel);
> >> +
> >>  static int __init debugfs_init(void)
> >>  {
> >>  	int retval;
> >> -
> >> +#ifdef CONFIG_DEBUG_FS_MOUNT_RESTRICTED
> >> +	if (!allow_debugfs)
> >> +		return -EPERM;
> >> +#endif
> > But you are not restricting the ability to mount it here, you are
> > removing the ability for it to even start up at all.  What does this
> > break for code that thinks the filesystem is registered (i.e. the call
> > to simple_pin_fs() in start_creating() in fs/debugfs/inode.c?
> >
> If it does, the lines below is also cause the same problem.

In a working system, errors in the lines below will never happen :)

thanks,

greg k-h
