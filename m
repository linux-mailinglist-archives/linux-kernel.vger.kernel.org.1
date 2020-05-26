Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFD71DFFE6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 17:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387720AbgEXPfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 11:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgEXPfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:35:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65902207CB;
        Sun, 24 May 2020 15:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590334506;
        bh=E8UEpF+FHR7JwtgCX5qsPu9Jts5pgO1PoKNJAS7GS3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M6uqNT8/6cSvlY8QC7DkkcHqlAqpaYum9jpPhEu0mXK1LVHHNBuvrGN7M4DCImMdT
         ipkipaSbOYq3CFyOE+xgPxqDEuC6tuyReqA+ju6gma8hpSmVjWhR7Q3xakgJzhGcy0
         U2xfk41dxwTNQxMd7qx4Qv5hsjHzATMztDfolRFQ=
Date:   Sun, 24 May 2020 17:35:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] kobject: Make sure the parent does not get released
 before its children
Message-ID: <20200524153504.GA2684@kroah.com>
References: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
 <20200523153643.GA226270@kroah.com>
 <7a5e4740-8099-ef70-776f-0d92ce84ab3d@infradead.org>
 <20200524125727.GA2430@kroah.com>
 <20200524131405.GA24073@kroah.com>
 <20200524132812.GA2401@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524132812.GA2401@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 03:28:12PM +0200, Greg Kroah-Hartman wrote:
> On Sun, May 24, 2020 at 03:14:05PM +0200, Greg Kroah-Hartman wrote:
> > On Sun, May 24, 2020 at 02:57:27PM +0200, Greg Kroah-Hartman wrote:
> > > On Sat, May 23, 2020 at 08:44:06AM -0700, Randy Dunlap wrote:
> > > > On 5/23/20 8:36 AM, Greg Kroah-Hartman wrote:
> > > > > On Wed, May 13, 2020 at 06:18:40PM +0300, Heikki Krogerus wrote:
> > > > >> In the function kobject_cleanup(), kobject_del(kobj) is
> > > > >> called before the kobj->release(). That makes it possible to
> > > > >> release the parent of the kobject before the kobject itself.
> > > > >>
> > > > >> To fix that, adding function __kboject_del() that does
> > > > >> everything that kobject_del() does except release the parent
> > > > >> reference. kobject_cleanup() then calls __kobject_del()
> > > > >> instead of kobject_del(), and separately decrements the
> > > > >> reference count of the parent kobject after kobj->release()
> > > > >> has been called.
> > > > >>
> > > > >> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > > > >> Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > > >> Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
> > > > >> Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > >> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > >> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > > > >> Tested-by: Brendan Higgins <brendanhiggins@google.com>
> > > > >> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > > > >> ---
> > > > >>  lib/kobject.c | 30 ++++++++++++++++++++----------
> > > > >>  1 file changed, 20 insertions(+), 10 deletions(-)
> > > > > 
> > > > > Stepping back, now that it turns out this patch causes more problems
> > > > > than it fixes, how is everyone reproducing the original crash here?
> > > > 
> > > > Just load lib/test_printf.ko and boom!
> > > 
> > > Thanks, that helps.
> > > 
> > > Ok, in messing around with the kobject core more, originally we thought
> > > this was an issue of the kobject uevent happening for the parent pointer
> > > (when the parent was invalid).  so, moving things around some more, and
> > > now I'm crashing in software_node_release() when we are trying to access
> > > swnode->parent->child_ids as parent is invalid there.
> > > 
> > > So I feel like this is a swnode bug, or a use of swnode in a way it
> > > shouldn't be that the testing framework is exposing somehow.
> > > 
> > > Let me dig deeper...
> > 
> > Ah, ick, static software nodes trying to be cleaned up in the totally
> > wrong order.  You can't just try to randomly clean up a kobject anywhere
> > in the middle of the hierarchy, that's flat out not going to work
> > properly.  let me unwind it...
> 
> Ok, the patch below fixes the test, there's not really anything wrong
> with the kobject core, except maybe the kobject uevent for removal,
> which I'll send a patch for.
> 
> I'll write these up as a real set of patches after a bit.

They are now here:
	https://lore.kernel.org/lkml/20200524153041.2361-1-gregkh@linuxfoundation.org/

thanks,

greg k-h
