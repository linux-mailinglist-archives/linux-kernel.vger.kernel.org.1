Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E6C282460
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 15:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgJCNzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 09:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgJCNzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 09:55:06 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C02FD206CD;
        Sat,  3 Oct 2020 13:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601733306;
        bh=HZNzoGoSmYeOMNKt7vgl2VklCMtnKO2vUAr8OGrAQ9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WahdQsG6Unek/PESQaVmpQcMhJpAGwIMr3QVFniywzS2MjXtltrkMUQPChxh3QHHP
         0VpG3j75lULjJ4OOp352SWMgEQgS/uf0O+KH0TQhYmZQQvS0sSq+lST/fUsMi+x8/n
         kRZUqkI7mkmeAikia4UoJ79Uz70uE/uL1pDeUU9M=
Date:   Sat, 3 Oct 2020 15:55:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH V3 1/8] sysfs: Add sysfs_emit and sysfs_emit_at to format
 sysfs output
Message-ID: <20201003135551.GA3187@kroah.com>
References: <cover.1600285923.git.joe@perches.com>
 <884235202216d464d61ee975f7465332c86f76b2.1600285923.git.joe@perches.com>
 <20200930115740.GA1611809@kroah.com>
 <202009302108.18B05CA38@keescook>
 <9b57d0d4896a91debc330a70a20ae0f240afbd3b.camel@perches.com>
 <202010021527.DF20CE0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202010021527.DF20CE0@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 03:30:30PM -0700, Kees Cook wrote:
> On Wed, Sep 30, 2020 at 09:22:19PM -0700, Joe Perches wrote:
> > On Wed, 2020-09-30 at 21:17 -0700, Kees Cook wrote:
> > > On Wed, Sep 30, 2020 at 01:57:40PM +0200, Greg Kroah-Hartman wrote:
> > > > Kees, and Rafael, I don't know if you saw this proposal from Joe for
> > > > sysfs files, questions below:
> > > 
> > > I'm a fan. I think the use of sprintf() in sysfs might have been one of
> > > my earliest complaints about unsafe code patterns in the kernel. ;)
> > []
> > > > > +	if (WARN(!buf || offset_in_page(buf),
> > > > > +		 "invalid sysfs_emit: buf:%p\n", buf))
> > 
> > The dump_stack() is also going to emit pointers
> > so I don't see how it does anything but help
> > show where the buffer was.  It is hashed...
> 
> dump_stack() is going to report symbols and register contents.
> 
> I was just pointing out that %p has no value here[1]. The interesting
> states are: "was it NULL?" "how offset was it?". Its actual content
> won't matter.

Ok, suggestions for a better error message are always welcome :)

thanks,

greg k-h
