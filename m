Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DC02B68C5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgKQPdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:33:13 -0500
Received: from m12-12.163.com ([220.181.12.12]:60800 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgKQPdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:33:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=QXb/z
        g1X4H1k8Xsn4vadPNzXgtECSKbY8Ay5LD6piDE=; b=V9sb2iZ0eNiRjSsdrgUVj
        Z5SQETLe1/Sa8fwSdcsUTXWW7i4wKsqwzYEeGU+C1LH/sSHDYLUMgV/jVZACgmms
        rAUJ5OO+2rEbf/PR0Hx/xj2Tu4cCUWX7OS0MxBNHg/KXNlH0ThgJzicUvvQUiffL
        iSq8X+heQ+nz0mbNwnEycc=
Received: from localhost (unknown [101.86.213.176])
        by smtp8 (Coremail) with SMTP id DMCowABXe+zU7LNf+Ef_CA--.52617S2;
        Tue, 17 Nov 2020 23:31:32 +0800 (CST)
Date:   Tue, 17 Nov 2020 23:31:32 +0800
From:   Hui Su <sh_def@163.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>, hughd@google.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        mm-commits@vger.kernel.org, sh_def@163.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: + mm-shmem-use-kmem_cache_zalloc-in-shmem_alloc_inode.patch
 added to -mm tree
Message-ID: <20201117153132.GA4153@rlk>
References: <20201116230526.NkEfmeDCH%akpm@linux-foundation.org>
 <alpine.LSU.2.11.2011162149210.1082@eggly.anvils>
 <20201117181246.5f29f9ca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117181246.5f29f9ca@canb.auug.org.au>
X-CM-TRANSID: DMCowABXe+zU7LNf+Ef_CA--.52617S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF48Gr1Duw4rXF1fKryrXrb_yoW8AF4xpF
        WfGFsxta1DJryxGryxK3Z2qr109rWftrWjqFy5Jw18ZFn5ZF1DKr4vkr1rWF95CFyrGF1j
        vF4UWr1xur4UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMCJm9UUUUU=
X-Originating-IP: [101.86.213.176]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiMRTfX1UMWYUOOgAAsU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:12:46PM +1100, Stephen Rothwell wrote:
> Hi Hugh,
> 
> On Mon, 16 Nov 2020 22:17:20 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:
> >
> > On Mon, 16 Nov 2020, akpm@linux-foundation.org wrote:
> > > 
> > > The patch titled
> > >      Subject: mm/shmem: use kmem_cache_zalloc in shmem_alloc_inode()
> > > has been added to the -mm tree.  Its filename is
> > >      mm-shmem-use-kmem_cache_zalloc-in-shmem_alloc_inode.patch
> > > 
> > > This patch should soon appear at
> > >     https://ozlabs.org/~akpm/mmots/broken-out/mm-shmem-use-kmem_cache_zalloc-in-shmem_alloc_inode.patch
> > > and later at
> > >     https://ozlabs.org/~akpm/mmotm/broken-out/mm-shmem-use-kmem_cache_zalloc-in-shmem_alloc_inode.patch
> > > 
> > > Before you just go and hit "reply", please:
> > >    a) Consider who else should be cc'ed
> > >    b) Prefer to cc a suitable mailing list as well
> > >    c) Ideally: find the original patch on the mailing list and do a
> > >       reply-to-all to that, adding suitable additional cc's
> > > 
> > > *** Remember to use Documentation/process/submit-checklist.rst when testing your code ***
> > > 
> > > The -mm tree is included into linux-next and is updated
> > > there every 3-4 working days
> > > 
> > > ------------------------------------------------------
> > > From: Hui Su <sh_def@163.com>
> > > Subject: mm/shmem: use kmem_cache_zalloc in shmem_alloc_inode()  
> > 
> > Andrew, Stephen, please revert this untested "cleanup" from your
> > trees a.s.a.p: it's a disaster for anyone using shmem/tmpfs.
> 
> Thanks for that.  I have also bisected my boot failures to that commit
> and so have reverted it from linux-next today.
> 
> -- 
> Cheers,
> Stephen Rothwell

Sorry for not full testing the change.
Please ignore this change.

Thanks.


