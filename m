Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B780B2859B8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgJGHnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbgJGHnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:43:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E9BC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 00:43:01 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQ460-000lFA-IE; Wed, 07 Oct 2020 09:42:44 +0200
Message-ID: <115d17aa221b73a479e26ffee52899ddb18b1f53.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/2] mmap locking API: Order lock of nascent mm
 outside lock of live mm
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Michel Lespinasse <walken@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Date:   Wed, 07 Oct 2020 09:42:42 +0200
In-Reply-To: <20201006225450.751742-2-jannh@google.com>
References: <20201006225450.751742-1-jannh@google.com>
         <20201006225450.751742-2-jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-07 at 00:54 +0200, Jann Horn wrote:
> Until now, the mmap lock of the nascent mm was ordered inside the mmap lock
> of the old mm (in dup_mmap() and in UML's activate_mm()).
> A following patch will change the exec path to very broadly lock the
> nascent mm, but fine-grained locking should still work at the same time for
> the old mm.
> 
> In particular, mmap locking calls are hidden behind the copy_from_user()
> calls and such that are reached through functions like copy_strings() -
> when a page fault occurs on a userspace memory access, the mmap lock
> will be taken.
> 
> To do this in a way that lockdep is happy about, let's turn around the lock
> ordering in both places that currently nest the locks.
> Since SINGLE_DEPTH_NESTING is normally used for the inner nesting layer,
> make up our own lock subclass MMAP_LOCK_SUBCLASS_NASCENT and use that
> instead.
> 
> The added locking calls in exec_mmap() are temporary; the following patch
> will move the locking out of exec_mmap().
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  arch/um/include/asm/mmu_context.h |  3 +--
>  fs/exec.c                         |  4 ++++
>  include/linux/mmap_lock.h         | 23 +++++++++++++++++++++--
>  kernel/fork.c                     |  7 ++-----
>  4 files changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
> index 17ddd4edf875..c13bc5150607 100644
> --- a/arch/um/include/asm/mmu_context.h
> +++ b/arch/um/include/asm/mmu_context.h
> @@ -48,9 +48,8 @@ static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
>  	 * when the new ->mm is used for the first time.
>  	 */
>  	__switch_mm(&new->context.id);
> -	mmap_write_lock_nested(new, SINGLE_DEPTH_NESTING);
> +	mmap_assert_write_locked(new);
>  	uml_setup_stubs(new);
> -	mmap_write_unlock(new);
>  }

FWIW, this was I believe causing lockdep issues.

I think I had previously determined that this was pointless, since it's
still nascent and cannot be used yet? But I didn't really know for sure,
and this patch was never applied:

https://patchwork.ozlabs.org/project/linux-um/patch/20200604133752.397dedea0758.I7a24aaa26794eb3fa432003c1bf55cbb816489e2@changeid/

I guess your patches will also fix the lockdep complaints in UML in this
area, I hope I'll be able to test it soon.

johannes

