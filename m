Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CA01DAA10
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 07:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgETFol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 01:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgETFol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 01:44:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 352652075F;
        Wed, 20 May 2020 05:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589953479;
        bh=ZSFGZSaSAHQFHwCrw/WChCi7NvAdkE7dPM4CwL7wCgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hnlUkCfqrT8CtMlGqxFJacI9Br3vxlAhOyNgh5yz7gQ6VZei0HpH913A1355N/HPD
         vS6j6TR7wPc47peYKA+fjP+hKf4F8n3C2pJ0dSFMIOxd3CUAZ/MdqEUo21XZKqiTdT
         55mAM/K6awkz0qC1KHpIZ+0N0cOwhUoem4MOJez0=
Date:   Wed, 20 May 2020 07:44:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2] /dev/mem: Revoke mappings when a driver claims the
 region
Message-ID: <20200520054436.GC2180554@kroah.com>
References: <158987153989.4000084.17143582803685077783.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200519121115.GC332015@kroah.com>
 <CAPcyv4gTkWx_q4sDXVyS+ybh0Nj7ybPUXGC4HCHQCO4eGxXwiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gTkWx_q4sDXVyS+ybh0Nj7ybPUXGC4HCHQCO4eGxXwiQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:27:02AM -0700, Dan Williams wrote:
> On Tue, May 19, 2020 at 5:11 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, May 19, 2020 at 12:03:06AM -0700, Dan Williams wrote:
> > > Close the hole of holding a mapping over kernel driver takeover event of
> > > a given address range.
> > >
> > > Commit 90a545e98126 ("restrict /dev/mem to idle io memory ranges")
> > > introduced CONFIG_IO_STRICT_DEVMEM with the goal of protecting the
> > > kernel against scenarios where a /dev/mem user tramples memory that a
> > > kernel driver owns. However, this protection only prevents *new* read(),
> > > write() and mmap() requests. Established mappings prior to the driver
> > > calling request_mem_region() are left alone.
> > >
> > > Especially with persistent memory, and the core kernel metadata that is
> > > stored there, there are plentiful scenarios for a /dev/mem user to
> > > violate the expectations of the driver and cause amplified damage.
> > >
> > > Teach request_mem_region() to find and shoot down active /dev/mem
> > > mappings that it believes it has successfully claimed for the exclusive
> > > use of the driver. Effectively a driver call to request_mem_region()
> > > becomes a hole-punch on the /dev/mem device.
> > >
> > > The typical usage of unmap_mapping_range() is part of
> > > truncate_pagecache() to punch a hole in a file, but in this case the
> > > implementation is only doing the "first half" of a hole punch. Namely it
> > > is just evacuating current established mappings of the "hole", and it
> > > relies on the fact that /dev/mem establishes mappings in terms of
> > > absolute physical address offsets. Once existing mmap users are
> > > invalidated they can attempt to re-establish the mapping, or attempt to
> > > continue issuing read(2) / write(2) to the invalidated extent, but they
> > > will then be subject to the CONFIG_IO_STRICT_DEVMEM checking that can
> > > block those subsequent accesses.
> > >
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Russell King <linux@arm.linux.org.uk>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Fixes: 90a545e98126 ("restrict /dev/mem to idle io memory ranges")
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > > Changes since v1 [1]:
> > >
> > > - updated the changelog to describe the usage of unmap_mapping_range().
> > >   No other logic changes:
> > >
> > > [1]: http://lore.kernel.org/r/158662721802.1893045.12301414116114602646.stgit@dwillia2-desk3.amr.corp.intel.com
> > >
> > > Greg, Andrew,
> > >
> > > I have a regression test for this case now. This was found by an
> > > intermittent data corruption scenario on pmem from a test tool using
> > > /dev/mem.
> >
> > Ick, why are test tools messing around in /dev/mem :)
> 
> Yeah, I'm all for useful tools, just not at the expense of kernel integrity.
> 
> > Anyway, this seems sane to me, want me to take it through my tree?
> 
> Yes please, seems to belong with the driver core.

Ok, will wait for a v3 to handle the issue that was just found in
review.

thanks,

greg k-h
