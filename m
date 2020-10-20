Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33C0283C52
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgJEQTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:19:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:40786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbgJEQTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:19:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E18B7B13C;
        Mon,  5 Oct 2020 16:19:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7B57C1E12F3; Mon,  5 Oct 2020 18:19:41 +0200 (CEST)
Date:   Mon, 5 Oct 2020 18:19:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: ext4 regression in v5.9-rc2 from e7bfb5c9bb3d on ro fs with
 overlapped bitmaps
Message-ID: <20201005161941.GF4225@quack2.suse.cz>
References: <CAHk-=wj-H5BYCU_kKiOK=B9sN3BtRzL4pnne2AJPyf54nQ+d=w@mail.gmail.com>
 <20201005081454.GA493107@localhost>
 <20201005094601.GB4225@quack2.suse.cz>
 <20201005101641.GA516771@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005101641.GA516771@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-10-20 03:16:41, Josh Triplett wrote:
> On Mon, Oct 05, 2020 at 11:46:01AM +0200, Jan Kara wrote:
> > On Mon 05-10-20 01:14:54, Josh Triplett wrote:
> > > Ran into an ext4 regression when testing upgrades to 5.9-rc kernels:
> > > 
> > > Commit e7bfb5c9bb3d ("ext4: handle add_system_zone() failure in
> > > ext4_setup_system_zone()") breaks mounting of read-only ext4 filesystems
> > > with intentionally overlapping bitmap blocks.
> > > 
> > > On an always-read-only filesystem explicitly marked with
> > > EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS, prior to that commit, it's safe to
> > > point all the block and inode bitmaps to a single block of all 1s,
> > > because a read-only filesystem will never allocate or free any blocks or
> > > inodes.
> > > However, after that commit, the block validity check rejects such
> > > filesystems with -EUCLEAN and "failed to initialize system zone (-117)".
> > > This causes systems that previously worked correctly to fail when
> > > upgrading to v5.9-rc2 or later.
> > > 
> > > This was obviously a bugfix, and I'm not suggesting that it should be
> > > reverted; it looks like this effectively worked by accident before,
> > > because the block_validity check wasn't fully functional. However, this
> > > does break real systems, and I'd like to get some kind of regression fix
> > > in before 5.9 final if possible. I think it would suffice to make
> > > block_validity default to false if and only if
> > > EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS is set.
> > > 
> > > Does that seem like a reasonable fix?
> > 
> > Well, but EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS is your internal feature
> > that's not present in current upstream kernel AFAICS.
> 
> It isn't "my" feature; the value for
> EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS is defined in the headers in the
> e2fsprogs tree. The kernel currently does absolutely nothing with it,
> nor did it previously need to; it's just an RO_COMPAT feature which
> ensures that the kernel can only mount the filesystem read-only. The
> point is that an always-read-only filesystem will never change the block
> or inode bitmaps, so ensuring they don't overlap is unnecessary (and
> harmful).

Ah, I see. I missed EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS is actually
defined in e2fsprogs. Then what you suggests makes sense I guess and it's
good the headers are synced up again...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
