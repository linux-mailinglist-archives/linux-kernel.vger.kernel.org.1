Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2EF28AEBC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgJLHDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 03:03:46 -0400
Received: from verein.lst.de ([213.95.11.211]:48792 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbgJLHCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:02:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 17FB267357; Mon, 12 Oct 2020 09:02:34 +0200 (CEST)
Date:   Mon, 12 Oct 2020 09:02:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: Re: use case for register_pstore_blk?
Message-ID: <20201012070233.GA2770@lst.de>
References: <20201006155220.GA11668@lst.de> <202010070007.8FF59EC42@keescook> <20201007075537.GA12531@lst.de> <20201007083715.GA15695@lst.de> <202010071130.7EA00291@keescook> <20201007184258.GA6157@lst.de> <202010071147.F6E57A32@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202010071147.F6E57A32@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 12:17:25PM -0700, Kees Cook wrote:
> Do you mean psblk_generic_blk_read() and psblk_generic_blk_write()?
> These are for writing to the block device... I'm happy to adjust this
> if you can show me the better API. (This was being developed in the
> middle of the iov_iter changes, so perhaps I missed a more appropriate
> way to do things.)

The problem is that you use library function for file systems, and
then call them on an instance you don't own, and you're feeding crap
into them like your own methods.

Now given that as far as I can tell you require 4k aligned reads and
writes anyway, there doesn't seem to be any need for this whole page
cache dance to start with, and you could just do the completely trivial
bios submission.  But if for some reason you need to use the page cache,
that needs to be done through fs/block_dev.c APIs instead of through
the side.

> 
> > and it uses name_to_dev_t which must not be used in new code.
> 
> What?
> 
> include/linux/mount.h:
> extern dev_t name_to_dev_t(const char *name);

It used to be a private API, but then the Chromium folks just exported
it in e6e20a7a5f3f49bfee518d5c6849107398d83912 without consulting any
relevant maintainer.  And now we have this mess :(

> Where did this happen, where was it documented, and what should be used
> instead?

Use blkdev_get_by_path only.  If you look at blkdev_get_by_dev it has
this very explicit comment:

 * Use it ONLY if you really do not have anything better - i.e. when
 * you are behind a truly sucky interface and all you are given is a
 * device number.  _Never_ to be used for internal purposes.  If you
 * ever need it - reconsider your API.


> > It also does not happen to share code with the mtd case.
> 
> What? Yes it does: it explicitly uses the pstore/blk configuration
> callback to get the details configured at boot to identify and configure
> the backing device. This is specifically designed this way to avoid
> repeating the mistake of having per-backing-device configuration that is
> essentially only actually used by the pstore storage layer. i.e. the very
> thing I'm trying to get away from in ramoops, efi-pstore, etc: storage
> configuration is tied to the pstore storage layer (i.e. pstore/blk and
> pstore/zone), not the specific backing device (i.e. MTD, blk, RAM, NVRAM,
> EFI variables, etc).

Sharing the config is trivial.  But it shared nothing in the actual
I/O path, which is entirely different for mtd vs block.  And the sad part
is that with fs/pstore/zone.c you have added the right abstraction, one
that totally makes sense.  But only when used by the block and mtd drivers
directly.  Adding another pointless layer of obsfucation and dead code
that doesn't share anything does not help.
