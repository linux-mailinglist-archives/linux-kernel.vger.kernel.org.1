Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0ACA1B2CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 18:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgDUQbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 12:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgDUQbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:31:23 -0400
Received: from coco.lan (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA765206E9;
        Tue, 21 Apr 2020 16:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587486682;
        bh=SCVgdX26l33hUoJQ6kp4XZf+T8BrHO9Vz5zKXmnwi4I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nItIfrKXBsg0FzDMxu9fmm/dDQn+Qz067+HVRj7sDJskNhl43qcOKmPbdp5ViiowE
         oiaFFI/fXonW8O9hK88MvqEKajo7xvBs5ep8cypTnxP3g7Kz8Kqgn683dTDhohTWFQ
         ZyqvWhHNItxhDeRqXgPCkmfa0UzuUg3QXtur0JcY=
Date:   Tue, 21 Apr 2020 18:31:17 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        ira.weiny@intel.com
Subject: Re: [PATCH 12/34] docs: filesystems: convert dax.txt to ReST
Message-ID: <20200421183117.2bf2b716@coco.lan>
In-Reply-To: <20200415154144.GA6733@magnolia>
References: <cover.1586960617.git.mchehab+huawei@kernel.org>
        <71b1f910b2c3569a9fdaa8778378dd734f4f0091.1586960617.git.mchehab+huawei@kernel.org>
        <20200415154144.GA6733@magnolia>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 15 Apr 2020 08:41:44 -0700
"Darrick J. Wong" <darrick.wong@oracle.com> escreveu:

> [add ira weiny to cc]
> 
> On Wed, Apr 15, 2020 at 04:32:25PM +0200, Mauro Carvalho Chehab wrote:
> > - Add a SPDX header;
> > - Adjust document title;
> > - Some whitespace fixes and new line breaks;
> > - Add it to filesystems/index.rst.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/admin-guide/ext4.rst             | 2 +-
> >  Documentation/filesystems/{dax.txt => dax.rst} | 9 +++++++--
> >  Documentation/filesystems/ext2.rst             | 2 +-
> >  Documentation/filesystems/index.rst            | 1 +
> >  4 files changed, 10 insertions(+), 4 deletions(-)
> >  rename Documentation/filesystems/{dax.txt => dax.rst} (97%)
> > 
> > diff --git a/Documentation/admin-guide/ext4.rst b/Documentation/admin-guide/ext4.rst
> > index 9443fcef1876..103bcc345bad 100644
> > --- a/Documentation/admin-guide/ext4.rst
> > +++ b/Documentation/admin-guide/ext4.rst
> > @@ -392,7 +392,7 @@ When mounting an ext4 filesystem, the following option are accepted:
> >  
> >    dax
> >          Use direct access (no page cache).  See
> > -        Documentation/filesystems/dax.txt.  Note that this option is
> > +        Documentation/filesystems/dax.rst.  Note that this option is
> >          incompatible with data=journal.
> >  
> >  Data Mode
> > diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.rst
> > similarity index 97%
> > rename from Documentation/filesystems/dax.txt
> > rename to Documentation/filesystems/dax.rst
> > index 735f3859b19f..5838144f80f0 100644
> > --- a/Documentation/filesystems/dax.txt
> > +++ b/Documentation/filesystems/dax.rst  
> 
> Err, this will collide with the work that Ira's doing on DAX for 5.8[1].
> Can the dax.txt conversion wait?

Well, I can re-schedule it to 5.9. Or, if you merge the dax changes
at linux-next, I can rebase my patch on the top of it.

> 
> --D
> 
> [1] https://lore.kernel.org/linux-xfs/20200415152942.GS6742@magnolia/T/#m804562299416d865d8829caa82589a522b2080a5
> 
> > @@ -1,5 +1,8 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=======================
> >  Direct Access for files
> > ------------------------
> > +=======================
> >  
> >  Motivation
> >  ----------
> > @@ -46,6 +49,7 @@ stall the CPU for an extended period, you should also not attempt to
> >  implement direct_access.
> >  
> >  These block devices may be used for inspiration:
> > +
> >  - brd: RAM backed block device driver
> >  - dcssblk: s390 dcss block device driver
> >  - pmem: NVDIMM persistent memory driver
> > @@ -55,6 +59,7 @@ Implementation Tips for Filesystem Writers
> >  ------------------------------------------
> >  
> >  Filesystem support consists of
> > +
> >  - adding support to mark inodes as being DAX by setting the S_DAX flag in
> >    i_flags
> >  - implementing ->read_iter and ->write_iter operations which use dax_iomap_rw()
> > @@ -127,6 +132,6 @@ by adding optional struct page support for pages under the control of
> >  the driver (see CONFIG_NVDIMM_PFN in drivers/nvdimm for an example of
> >  how to do this). In the non struct page cases O_DIRECT reads/writes to
> >  those memory ranges from a non-DAX file will fail (note that O_DIRECT
> > -reads/writes _of a DAX file_ do work, it is the memory that is being
> > +reads/writes _of a DAX ``file_`` do work, it is the memory that is being
> >  accessed that is key here).  Other things that will not work in the
> >  non struct page case include RDMA, sendfile() and splice().
> > diff --git a/Documentation/filesystems/ext2.rst b/Documentation/filesystems/ext2.rst
> > index d83dbbb162e2..fa416b7a5802 100644
> > --- a/Documentation/filesystems/ext2.rst
> > +++ b/Documentation/filesystems/ext2.rst
> > @@ -24,7 +24,7 @@ check=none, nocheck	(*)	Don't do extra checking of bitmaps on mount
> >  				(check=normal and check=strict options removed)
> >  
> >  dax				Use direct access (no page cache).  See
> > -				Documentation/filesystems/dax.txt.
> > +				Documentation/filesystems/dax.rst.
> >  
> >  debug				Extra debugging information is sent to the
> >  				kernel syslog.  Useful for developers.
> > diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> > index c4f95f76ba6a..8e3ccb4ed483 100644
> > --- a/Documentation/filesystems/index.rst
> > +++ b/Documentation/filesystems/index.rst
> > @@ -24,6 +24,7 @@ algorithms work.
> >     splice
> >     locking
> >     directory-locking
> > +   dax
> >  
> >     automount-support
> >  
> > -- 
> > 2.25.2
> >   



Thanks,
Mauro
