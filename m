Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586862F7621
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbhAOJ7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 04:59:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbhAOJ72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:59:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9290923888;
        Fri, 15 Jan 2021 09:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610704717;
        bh=9sIfGYn+CB58kDNMQLw6lzQnvI29J9O0n7ueauxjWrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oEeboGETw7lhuzTEW7iyXZDwW3hKbrpRHa4qkMlTbXdlmG07uYA1Sk4sPNXKSMP/f
         UfSLu9aymgt8t8wS1UmPPqNyp526rogbzVHgccdAx/B/73JilQy04U1We4ji7Bo43E
         kYGPvq1JnL45CzegKCrUeSRQGeYOXXvR6w/W/ux9opCB3bpwm50wY7C1zTSU47xAky
         p1yPuMwGPgPqrCaBGxdWewyA6SXOqEAfGXTchx7ZMO871Wiuc6I/IItWVVINinH2+9
         s2QtUmcqmCK7hQz5l1iSq1mDauB6DrRj+s4/mlCzTcbych047lCTWwlS5THluqfAsU
         DrCJJ3+pN8rXQ==
Date:   Fri, 15 Jan 2021 11:58:32 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jethro Beekman <jethro@fortanix.com>
Subject: Re: [PATCH v3] x86/sgx: Synchronize encl->srcu in sgx_encl_release().
Message-ID: <YAFnSGmjYR4ms+p6@kernel.org>
References: <20201216134920.21161-1-jarkko@kernel.org>
 <20210105145749.GF28649@zn.tnic>
 <X/zoarV7gd/LNo4A@kernel.org>
 <op.0w60mzepwjvjmi@mqcpg7oapc828.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.0w60mzepwjvjmi@mqcpg7oapc828.gar.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 10:42:12PM -0600, Haitao Huang wrote:
> On Mon, 11 Jan 2021 18:08:10 -0600, Jarkko Sakkinen <jarkko@kernel.org>
> wrote:
> 
> > On Tue, Jan 05, 2021 at 03:57:49PM +0100, Borislav Petkov wrote:
> > > On Wed, Dec 16, 2020 at 03:49:20PM +0200, Jarkko Sakkinen wrote:
> > > > Add synchronize_srcu_expedited() to sgx_encl_release() to catch a
> > > grace
> > > > period initiated by sgx_mmu_notifier_release().
> > > >
> > > > A trivial example of a failing sequence with tasks A and B:
> > > >
> > > > 1. A: -> sgx_release()
> > > > 2. B: -> sgx_mmu_notifier_release()
> > > > 3. B: -> list_del_rcu()
> > > > 3. A: -> sgx_encl_release()
> > > > 4. A: -> cleanup_srcu_struct()
> > > >
> > > > The loop in sgx_release() observes an empty list because B has
> > > removed its
> > > > entry in the middle, and calls cleanup_srcu_struct() before B has
> > > a chance
> > > > to calls synchronize_srcu().
> > > 
> > > Leading to what? NULL ptr?
> > > 
> > > https://lkml.kernel.org/r/X9e2jOWz1hfXVpQ5@google.com
> > > 
> > > already suggested that you should explain the bug better and add the
> > > splat but I'm still missing that explanation.
> > 
> > OK, I'll try to explain it how I understand the issue.
> > 
> > Consider this loop in the VFS release hook (sgx_release):
> > 
> > 	/*
> > 	 * Drain the remaining mm_list entries. At this point the list contains
> > 	 * entries for processes, which have closed the enclave file but have
> > 	 * not exited yet. The processes, which have exited, are gone from the
> > 	 * list by sgx_mmu_notifier_release().
> > 	 */
> > 	for ( ; ; )  {
> > 		spin_lock(&encl->mm_lock);
> > 
> > 		if (list_empty(&encl->mm_list)) {
> > 			encl_mm = NULL;
> > 		} else {
> > 			encl_mm = list_first_entry(&encl->mm_list,
> > 						   struct sgx_encl_mm, list);
> > 			list_del_rcu(&encl_mm->list);
> > 		}
> > 
> > 		spin_unlock(&encl->mm_lock);
> > 
> > 		/* The enclave is no longer mapped by any mm. */
> > 		if (!encl_mm)
> > 			break;
> > 
> > 		synchronize_srcu(&encl->srcu);
> > 		mmu_notifier_unregister(&encl_mm->mmu_notifier, encl_mm->mm);
> > 		kfree(encl_mm);
> > 	}
> > 
> > 
> > At this point all processes have closed the enclave file, but that
> > doesn't
> > mean that they all have exited yet.
> > 
> > Now, let's imagine that there is exactly one entry in the encl->mm_list.
> > and sgx_release() execution gets scheduled right after returning from
> > synchronize_srcu().
> > 
> > With some bad luck, some process comes and removes that last entry befoe
> > sgx_release() acquires mm_lock. The loop in sgx_release() just leaves
> > 
> > 		/* The enclave is no longer mapped by any mm. */
> > 		if (!encl_mm)
> > 			break;
> > 
> > No synchronize_srcu().
> > 
> > After writing this, I think that the placement for synchronize_srcu()
> > in this patch is not best possible. It should be rather that the
> > above loop would also call synchronize_srcu() when leaving.
> > 
> > I.e. the code change would result:
> > 
> > 	for ( ; ; )  {
> > 		spin_lock(&encl->mm_lock);
> > 
> > 		if (list_empty(&encl->mm_list)) {
> > 			encl_mm = NULL;
> > 		} else {
> > 			encl_mm = list_first_entry(&encl->mm_list,
> > 						   struct sgx_encl_mm, list);
> > 			list_del_rcu(&encl_mm->list);
> > 		}
> > 
> > 		spin_unlock(&encl->mm_lock);
> > 
> >                 /*
> >                  * synchronize_srcu() is mandatory *even* when the list
> > was
> >                  * empty, in order make sure that grace periods stays in
> >                  * sync even when another task took away the last entry
> >                  * (i.e. exiting process when it deletes its mm_list).
> >                  */
> > 		synchronize_srcu(&encl->srcu);
> > 
> > 		/* The enclave is no longer mapped by any mm. */
> > 		if (!encl_mm)
> > 			break;
> > 
> > 		mmu_notifier_unregister(&encl_mm->mmu_notifier, encl_mm->mm);
> > 		kfree(encl_mm);
> > 	}
> > 
> > What do you think? Does this start to make more sense now?
> > I don't have logs for this but the bug can be also reasoned.
> > 
> > /Jarkko
> 
> I did this experiment just now and find it runs much much slower than both
> original code and code with synchronize_srcu_expedited fix in this patch.
> Haitao

Yeah, but using expedited is not really in the scope of a bug fix.

It's a change that needs to be considered separately.

And it's more complicated than that. It also needs data to back it
up. How we can test and compare?

/Jarkko
