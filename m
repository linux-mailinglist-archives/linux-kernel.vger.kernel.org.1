Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F572C0E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbgKWOtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:49:19 -0500
Received: from verein.lst.de ([213.95.11.211]:50791 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbgKWOtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:49:19 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 321D96736F; Mon, 23 Nov 2020 15:49:15 +0100 (CET)
Date:   Mon, 23 Nov 2020 15:49:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     =?utf-8?B?5buW5aiB6ZuE?= <gmpy.liaowx@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] pstore/blk: use the normal block device I/O path
Message-ID: <20201123144914.GA667@lst.de>
References: <20201016132047.3068029-1-hch@lst.de> <20201016132047.3068029-9-hch@lst.de> <CAL3PxMpk_HV40EozhWMDZgc85vvLvosJ-e9CKWyZ+tRBB27hDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3PxMpk_HV40EozhWMDZgc85vvLvosJ-e9CKWyZ+tRBB27hDA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 08, 2020 at 10:43:29PM +0800, 廖威雄 wrote:
> > +       const char devname[] = "/dev/pstore-blk";
> > +       dev_t dev = name_to_dev_t(blkdev);
> > +
> > +       if (!dev)
> > +               return;
> > +       init_unlink(devname);
> > +       init_mknod(devname, S_IFBLK | 0600, new_encode_dev(dev));
> > +       __pstore_blk_init(devname);
> 
> How about pstore/blk making /dev/pstore-blk node no matter build-in
> or module. Then pstore/blk always opens /dev/pstore-blk. By this way,
> blkdev can also be a device number if pstore/blk built as a module.

Please read the comment above blkdev_get_by_dev on why no one should
add new interfaces based on the device number.
