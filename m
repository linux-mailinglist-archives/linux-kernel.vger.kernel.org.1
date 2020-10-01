Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422C62808C4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgJAUu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgJAUu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:50:28 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A47A120738;
        Thu,  1 Oct 2020 20:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601585428;
        bh=tkftAJJw4eHQVipuxbLGrDEWsKQk8VPMXCHg34fOM/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sUQDBWR994orJZ2Ogvh5Bk7s23V9UNKAk1A+SY9j0ShN2y/O9UsXUCbkEvs1Xoch9
         6Oswz/7CHuDRVysLAp2KmaWnsG3IUyg64nTdGNGhnitZDeluy0TQ7+AMZ0IVZeR2Po
         k04krle85Z2vFyUmi9GduHDe1tlwNg7Z3/FJIv1s=
Date:   Thu, 1 Oct 2020 22:50:29 +0200
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
Message-ID: <20201001205029.GC915579@kroah.com>
References: <cover.1600285923.git.joe@perches.com>
 <884235202216d464d61ee975f7465332c86f76b2.1600285923.git.joe@perches.com>
 <20200930115740.GA1611809@kroah.com>
 <202009302108.18B05CA38@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009302108.18B05CA38@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 09:17:03PM -0700, Kees Cook wrote:
> On Wed, Sep 30, 2020 at 01:57:40PM +0200, Greg Kroah-Hartman wrote:
> > Kees, and Rafael, I don't know if you saw this proposal from Joe for
> > sysfs files, questions below:
> 
> I'm a fan. I think the use of sprintf() in sysfs might have been one of
> my earliest complaints about unsafe code patterns in the kernel. ;)

Ok, great.

> > > +/**
> > > + *	sysfs_emit - scnprintf equivalent, aware of PAGE_SIZE buffer.
> > > + *	@buf:	start of PAGE_SIZE buffer.
> > > + *	@fmt:	format
> > > + *	@...:	optional arguments to @format
> > > + *
> > > + *
> > > + * Returns number of characters written to @buf.
> > > + */
> > > +int sysfs_emit(char *buf, const char *fmt, ...)
> > > +{
> > > +	va_list args;
> > > +	int len;
> > > +
> > > +	if (WARN(!buf || offset_in_page(buf),
> > > +		 "invalid sysfs_emit: buf:%p\n", buf))
> 
> I don't want the %p here, but otherwise, sure. I'd also make it a _ONCE
> variant:
> 
> 	if (WARN_ONCE(!buf || offset_in_page(buf),
> 		 "invalid sysfs_emit: offset_in_page(buf):%zd\n",
> 		  buf ? offset_in_page(buf) : 0))

As Joe points out, _ONCE doesn't work because this happens from all
sysfs files, not just one.

thanks,

greg k-h
