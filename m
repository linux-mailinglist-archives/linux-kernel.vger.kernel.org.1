Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08E12695C7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgINTnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgINTm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:42:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0E4C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 12:42:59 -0700 (PDT)
Received: from zn.tnic (p200300ec2f09260089ebb5f4b84dd95c.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:2600:89eb:b5f4:b84d:d95c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B68301EC0593;
        Mon, 14 Sep 2020 21:42:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600112577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7+il9ewnFZ2ENEAK6uzc623uGpDq5p/EzxFKHkMAKSY=;
        b=mV2MRCsEd1YXoM8ckud4LXcoK95PfB2mpHDsuuvR1/6ljTMqPoMTP6kYj7/itWBSt4obNz
        hlaolnb0Syae9c22mY0OmKPClpclZB8WoOp6LC74qy3ci9eWXX0zF8Pe60uJ3kl8YXdEqq
        Y+3WWfumnUQUcOYBjnsz57Sy7/M12w4=
Date:   Mon, 14 Sep 2020 21:42:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20200914194252.GI680@zn.tnic>
References: <1d06ed6485b66b9f674900368b63d7ef79f666ca.1599756789.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d06ed6485b66b9f674900368b63d7ef79f666ca.1599756789.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 12:22:53PM -0500, Josh Poimboeuf wrote:
> The x86 uaccess code uses barrier_nospec() in various places to prevent
> speculative dereferencing of user-controlled pointers (which might be
> combined with further gadgets or CPU bugs to leak data).
> 
> There are some issues with the current implementation:
> 
> - The barrier_nospec() in copy_from_user() was inadvertently removed
>   with: 4b842e4e25b1 ("x86: get rid of small constant size cases in
>   raw_copy_{to,from}_user()")
> 
> - copy_to_user() and friends should also have a speculation barrier,
>   because a speculative write to a user-controlled address can still
>   populate the cache line with the original data.
> 
> - The LFENCE in barrier_nospec() is overkill, when more lightweight user
>   pointer masking can be used instead.
> 
> Remove all existing barrier_nospec() usage, and instead do user pointer
> masking, throughout the x86 uaccess code.  This is similar to what arm64
> is already doing with uaccess_mask_ptr().
> 
> barrier_nospec() is now unused, and can be removed.
> 
> Fixes: 4b842e4e25b1 ("x86: get rid of small constant size cases in raw_copy_{to,from}_user()")
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
> v3:
> 
> - Rebased on vfs#for-next, using TASK_SIZE_MAX now that set_fs() is
>   gone.  I considered just clearing the most significant bit, but that
>   only works for 64-bit, so in the interest of common code I went with
>   the more straightforward enforcement of the TASK_SIZE_MAX limit.
> 
> - Rename the macro to force_user_ptr(), which is more descriptive, and
>   also more distinguishable from a planned future macro for sanitizing
>   __user pointers on syscall entry.
> 
>  Documentation/admin-guide/hw-vuln/spectre.rst |  6 ++--
>  arch/x86/include/asm/barrier.h                |  3 --
>  arch/x86/include/asm/checksum_32.h            |  6 ++--
>  arch/x86/include/asm/futex.h                  |  5 +++
>  arch/x86/include/asm/uaccess.h                | 35 ++++++++++++-------
>  arch/x86/include/asm/uaccess_64.h             | 16 ++++-----
>  arch/x86/lib/csum-wrappers_64.c               |  5 +--
>  arch/x86/lib/getuser.S                        | 10 +++---
>  arch/x86/lib/putuser.S                        |  8 +++++
>  arch/x86/lib/usercopy_32.c                    |  6 ++--
>  arch/x86/lib/usercopy_64.c                    |  7 ++--
>  lib/iov_iter.c                                |  2 +-
>  12 files changed, 65 insertions(+), 44 deletions(-)

After clarifying some stuff on IRC:

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
