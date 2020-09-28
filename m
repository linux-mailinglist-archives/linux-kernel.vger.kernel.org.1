Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8E427B0D6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgI1PWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726651AbgI1PWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:22:40 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601306558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bGZWgwzuGIdAypUrofmdQnD4jfN7gEMGxpknQBWzkOA=;
        b=XiBZAAbtJ7dDSXUT7qRjju9qSSn6m0fVxWu7lD4DwMfD6IWeIjP761MbNMdiwekf9EWOiM
        o7rPK/5SUPasIUUmk1RzEv8ZGv22JLmMxzCmEqvmqfZXDHWAsvPtpYPILrb1jfASGy7q/f
        BnDaaXzuGmeUO5JU4zn8ZZxKY06+Vsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-X5AXtCc6OP6C_QKUxT9PQQ-1; Mon, 28 Sep 2020 11:22:34 -0400
X-MC-Unique: X5AXtCc6OP6C_QKUxT9PQQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22FF81868405;
        Mon, 28 Sep 2020 15:22:32 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6887D100238C;
        Mon, 28 Sep 2020 15:22:31 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08SFMUjU032257;
        Mon, 28 Sep 2020 11:22:30 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08SFMS8e032253;
        Mon, 28 Sep 2020 11:22:29 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 28 Sep 2020 11:22:28 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Matthew Wilcox <willy@infradead.org>
cc:     Dave Chinner <david@fromorbit.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" 
        <rajesh.tadakamadla@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: NVFS XFS metadata (was: [PATCH] pmem: export the symbols
 __copy_user_flushcache and __copy_from_user_flushcache)
In-Reply-To: <alpine.LRH.2.02.2009240853200.3485@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2009281105200.27411@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com> <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com> <alpine.LRH.2.02.2009161359540.20710@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009191336380.3478@file01.intranet.prod.int.rdu2.redhat.com> <20200922050314.GB12096@dread.disaster.area> <alpine.LRH.2.02.2009220815420.16480@file01.intranet.prod.int.rdu2.redhat.com> <20200922172553.GL32101@casper.infradead.org>
 <alpine.LRH.2.02.2009240853200.3485@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 Sep 2020, Mikulas Patocka wrote:

> On Tue, 22 Sep 2020, Matthew Wilcox wrote:
> 
> > > There is a small window when renamed inode is neither in source nor in 
> > > target directory. Fsck will reclaim such inode and add it to lost+found - 
> > > just like on EXT2.
> > 
> > ... ouch.  If you have to choose, it'd be better to link it to the second
> > directory then unlink it from the first one.  Then your fsck can detect
> > it has the wrong count and fix up the count (ie link it into both
> > directories rather than neither).
> 
> I admit that this is lame and I'll fix it. Rename is not so 
> performance-critical, so I can add a small journal for this.

Hi

I have implmemented transactions in nvfs and I use them for rename, 
setattr, atomic xattr replacement and for RENAME_EXCHANGE.

You can download the current version here:
git://leontynka.twibright.com/nvfs.git

Mikulas

