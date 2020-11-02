Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34972A2D08
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgKBOcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:32:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgKBOcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:32:05 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B74C206F8;
        Mon,  2 Nov 2020 14:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604327524;
        bh=hdSD27BmKkljWgELsG4M7hzHyWwvXMiYXLs+RoEtORQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=odH1OjUoqkvAfxa7Fr3NRH1dqFGoHJLHrOuG+84VAQyeVRsWK0VNdR+gZv4jDPvvQ
         vwswAk68ATeAMcJBpRt7+RK4AVL0beshAWJWRFUovYVn14FinJhq5fczZCRGZtXMTk
         qt9buLnM5aVbE7EOMZ/mIdTL4TrFxJBdHGUT+C+I=
Date:   Mon, 2 Nov 2020 15:32:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Joe Perches <joe@perches.com>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] mm: shmem: Convert shmem_enabled_show to use
 sysfs_emit_at
Message-ID: <20201102143259.GA1024551@kroah.com>
References: <cover.1604261483.git.joe@perches.com>
 <a06810c216a45e5f6f1b9f49fbe2f332ca3c8972.1604261483.git.joe@perches.com>
 <20201101204834.GF27442@casper.infradead.org>
 <616b92af9378e9f9697555074bba1e377450477f.camel@perches.com>
 <20201101211910.GG27442@casper.infradead.org>
 <bc1a4a2a7ff69eeee131744881e1e8c72444be01.camel@perches.com>
 <20201101220604.GI27442@casper.infradead.org>
 <20201102133343.GA1011963@kroah.com>
 <20201102140836.GJ27442@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102140836.GJ27442@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 02:08:36PM +0000, Matthew Wilcox wrote:
> On Mon, Nov 02, 2020 at 02:33:43PM +0100, Greg Kroah-Hartman wrote:
> > > Oh, ugh, sysfs_emit() should be able to work on a buffer that isn't
> > > page aligned.  Greg, how about this?
> > 
> > How can sysfs_emit() be called on a non-page-aligned buffer?  It's being
> > used on the buffer that was passed to the sysfs call.
> > 
> > And if you are writing multiple values to a single sysfs file output,
> > well, not good...
> 
> See shmem_enabled_show() in mm/shmem.c (output at
> /sys/kernel/mm/transparent_hugepage/shmem_enabled on your machine).
> 
> I don't claim it's a good interface, but it exists.

Ok, that's a common pattern for sysfs files, not that bad.

What's wrong with using sysfs_emit_at()?  We want sysfs_emit() to "know"
that the buffer is PAGE_SIZE big, if you try to allow offsets in it,
that defeats the purpose of the check.

Or am I missing something else here?

thanks,

greg k-h
