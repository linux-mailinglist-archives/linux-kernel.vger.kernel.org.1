Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9132D1A8B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 21:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgLGUcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 15:32:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgLGUcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 15:32:16 -0500
Date:   Mon, 7 Dec 2020 12:31:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607373095;
        bh=dhTYw5ud5BHG353VDU98B6oku7U8oYVLLb0qfO+807U=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=quqI6HvAxjJmHmIGWgnOEhVqCKxsw2nK1FZAzQbWE3iZbYr1DtYpN4kqYqU0j6K7u
         EQwBC2bJUgkZMkIwwTXJLHfJpYu9oQ0QtIYsG4hfYDP6yeN3swQXd1dnanC92DmmDC
         zTU+NpydZswxnwwRiSRSXnBBBXABXnmrpHneONDrtQe7/nKtF2vfR2HRndFEh6EXuY
         vm0612R4OkJuXEuphzN6Zt74JZ3yxt1g0dm2iue1VQuZ5attVzegJRp+X5NOoMIktI
         JPG0GF7atd7fwxZd8SRSc9hF6RhFXR1xy3aM1KyR6GFzjX3nDA8Qjk1g2MCiKg7Iro
         ZQ20RwLhUq9Xw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix race of pending_pages in
 decompression
Message-ID: <X86RJdLhOVRm28Eu@gmail.com>
References: <20201205042626.1113600-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205042626.1113600-1-daeho43@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 05, 2020 at 01:26:26PM +0900, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> I found out f2fs_free_dic() is invoked in a wrong timing, but
> f2fs_verify_bio() still needed the dic info and it triggered the
> below kernel panic. It has been caused by the race condition of
> pending_pages value between decompression and verity logic, when
> the same compression cluster had been split in different bios.
> By split bios, f2fs_verify_bio() ended up with decreasing
> pending_pages value before it is reset to nr_cpages by
> f2fs_decompress_pages() and caused the kernel panic.
> 
> [ 4416.564763] Unable to handle kernel NULL pointer dereference
>                at virtual address 0000000000000000
> ...
> [ 4416.896016] Workqueue: fsverity_read_queue f2fs_verity_work
> [ 4416.908515] pc : fsverity_verify_page+0x20/0x78
> [ 4416.913721] lr : f2fs_verify_bio+0x11c/0x29c
> [ 4416.913722] sp : ffffffc019533cd0
> [ 4416.913723] x29: ffffffc019533cd0 x28: 0000000000000402
> [ 4416.913724] x27: 0000000000000001 x26: 0000000000000100
> [ 4416.913726] x25: 0000000000000001 x24: 0000000000000004
> [ 4416.913727] x23: 0000000000001000 x22: 0000000000000000
> [ 4416.913728] x21: 0000000000000000 x20: ffffffff2076f9c0
> [ 4416.913729] x19: ffffffff2076f9c0 x18: ffffff8a32380c30
> [ 4416.913731] x17: ffffffc01f966d97 x16: 0000000000000298
> [ 4416.913732] x15: 0000000000000000 x14: 0000000000000000
> [ 4416.913733] x13: f074faec89ffffff x12: 0000000000000000
> [ 4416.913734] x11: 0000000000001000 x10: 0000000000001000
> [ 4416.929176] x9 : ffffffff20d1f5c7 x8 : 0000000000000000
> [ 4416.929178] x7 : 626d7464ff286b6b x6 : ffffffc019533ade
> [ 4416.929179] x5 : 000000008049000e x4 : ffffffff2793e9e0
> [ 4416.929180] x3 : 000000008049000e x2 : ffffff89ecfa74d0
> [ 4416.929181] x1 : 0000000000000c40 x0 : ffffffff2076f9c0
> [ 4416.929184] Call trace:
> [ 4416.929187]  fsverity_verify_page+0x20/0x78
> [ 4416.929189]  f2fs_verify_bio+0x11c/0x29c
> [ 4416.929192]  f2fs_verity_work+0x58/0x84
> [ 4417.050667]  process_one_work+0x270/0x47c
> [ 4417.055354]  worker_thread+0x27c/0x4d8
> [ 4417.059784]  kthread+0x13c/0x320
> [ 4417.063693]  ret_from_fork+0x10/0x18
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> v3: back to v1 and enabled verity in a unit of cluster
> v2: merged verity_pages with pending_pages, and increased the
>     pending_pages count only if STEP_VERITY is set on bio

I am trying to review this but it is very hard, as the f2fs compression code is
very hard to understand.

It looks like a 'struct decompress_io_ctx' represents the work to decompress a
particular cluster.  Since the compressed data of the cluster can be read using
multiple bios, there is a reference count of how many pages are remaining to be
read before all the cluster's pages have been read and decompression can start.

What I don't understand is why that reference counting needs to work differently
depending on whether verity is enabled or not.  Shouldn't it be exactly the
same?

There also seems to be some confusion about the scope of STEP_VERITY.  Before
f2fs compression was added, it was a per-bio thing.  But now in a compressed
file, it's really a per-cluster thing, since all decompressed pages in a
compressed cluster are verified (or not verified) at once.

Wouldn't it make a lot more sense to, when a cluster needs both compression and
verity, *not* set STEP_VERITY on the bios, but rather set a similar flag in the
decompress_io_ctx?

- Eric
