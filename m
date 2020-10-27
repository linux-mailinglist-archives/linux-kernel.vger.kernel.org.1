Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7524A29A607
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508622AbgJ0IBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:01:38 -0400
Received: from verein.lst.de ([213.95.11.211]:37702 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391283AbgJ0IBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:01:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8C46067373; Tue, 27 Oct 2020 09:01:35 +0100 (CET)
Date:   Tue, 27 Oct 2020 09:01:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Kyle Huey <me@kylehuey.com>
Subject: Re: [PATCH] Fix compat regression in process_vm_rw()
Message-ID: <20201027080135.GB22650@lst.de>
References: <f69575e0-5170-2d51-8d74-8b3453723aa3@kernel.dk> <20201027000920.GE3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027000920.GE3576660@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 12:09:20AM +0000, Al Viro wrote:
> On Mon, Oct 26, 2020 at 06:03:18PM -0600, Jens Axboe wrote:
> > The removal of compat_process_vm_{readv,writev} didn't change
> > process_vm_rw(), which always assumes it's not doing a compat syscall.
> > Instead of passing in 'false' unconditionally for 'compat', make it
> > conditional on in_compat_syscall().
> > 
> > Fixes: c3973b401ef2 ("mm: remove compat_process_vm_{readv,writev}")
> > Reported-by: Kyle Huey <me@kylehuey.com>
> > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ACK with some reservations - I suspect that we want an explicit flag
> for process_vm_{read,write}v() that would force the 64bit layout for
> the vector refering to the foreign process.  It's not relevant for
> regression fix; however, as it is these syscalls are not usable for
> 32bit process trying to access memory of 64bit one - there's no way
> to specify the addresses past 4G.

Independent of this fix I think we just need to explicitly prohibit
cross-access.
