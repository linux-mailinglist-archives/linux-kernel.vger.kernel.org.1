Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC2D1DFFEC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 17:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgEXPi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 11:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgEXPi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:38:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC85520787;
        Sun, 24 May 2020 15:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590334736;
        bh=FoydNPDHm8qaVR+FtRDqDSa8qSbQgfYOf6vh0Y6IBhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QgprcXwq0iv1tzjJUWjhCXd6iSnF9cnQDHiKse1W9RzCLswUJusFGLIH3P0i09s/e
         C6Ke/WCLnee74Ee/27UQUAeZnvSc0pAmCgw6vjsQgdMFWmh+C0Y4F2vW9oiFyUF7Wz
         1xt8FMe4AgQVYiqL2Ib6ykX+KlRhtRAugDFkTY4U=
Date:   Sun, 24 May 2020 17:38:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] Driver core fixes for 5.7-rc7 - take 2
Message-ID: <20200524153854.GA5120@kroah.com>
References: <20200523131759.GA55886@kroah.com>
 <20200523152922.GA224858@kroah.com>
 <CAHk-=wih_B_8a48Au=6B+gwFcYnM7qF02dGX3R0QN_2bzVcjVA@mail.gmail.com>
 <20200524150018.GB11262@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524150018.GB11262@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 05:00:18PM +0200, Greg KH wrote:
> On Sat, May 23, 2020 at 11:14:28AM -0700, Linus Torvalds wrote:
> > On Sat, May 23, 2020 at 8:29 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > The kobject patch that was originally in here has now been reverted, as
> > > Guenter reported boot problems with it on some of his systems.
> > 
> > Hmm. That original patch looks obviously buggy: in kobject_cleanup()
> > it would end up doing "kobject_put(parent)" regardless of whether it
> > had actually done __kobject_del() or not.
> > 
> > That _could_ have been intentional, but considering the commit
> > message, it clearly wasn't in this case.  It might be worth re-trying
> > to the commit, just with that fixed.
> 
> Turns out that wasn't the real problem here, the culprit is the
> lib/test_printf.c code trying to tear down a kobject tree from the
> parent down to the children (i.e. in the backwards order).

The fix for this is now posted here:
	https://lore.kernel.org/lkml/20200524153041.2361-1-gregkh@linuxfoundation.org/

along with a kobject change to emit the remove uevent when the object is
removed from sysfs (and still has a valid parent pointer), and not some
unspecified time in the future.

Let's see if people find this a better solution, and if so, I'll send it
to you later in the week.

thanks,

greg k-h
