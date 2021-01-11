Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190072F24AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391589AbhALAZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404178AbhAKXmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:42:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5C0322BED;
        Mon, 11 Jan 2021 23:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610408492;
        bh=5/p7Jy6DV+XZMeDbn3LFI3ulwrZgNlzWs2MdfW159v4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AzaYOT0TFF7zFt2X0i7pJD344pmC8+Sl6MxlnW9Lxpzow0ehD2x3NngnFm4sNXfOU
         +Sm6yZtzF0peC3YCxlUkkXtwMthLGre2/afEDlakFCYzVJOgfnRLX60W8Ntj3VYdgi
         cW3NZWbH6T/JyWLWaFdEyfu4Trw2JzNTTkH8YuZX58hSb/+fVZZKF6YV70Mr5Rp/pI
         hggKk008Pm4x9VLuPRj+iHRmzX7SmOTWrgdczUMTKa+NlJgH9bRNgFGMvGWzdWwyBh
         JE/pFW97pzweHHcraQPdRN8eGhPT/0LCsYpI6qwB//5AA5uf0Lu/0SChuuVAca9W+u
         +kveSghxVdlvA==
Date:   Tue, 12 Jan 2021 01:41:27 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jethro Beekman <jethro@fortanix.com>
Subject: Re: [PATCH v3] x86/sgx: Synchronize encl->srcu in sgx_encl_release().
Message-ID: <X/ziJ9a7sRIeNRWr@kernel.org>
References: <20201216134920.21161-1-jarkko@kernel.org>
 <op.0wppi8q8wjvjmi@mqcpg7oapc828.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.0wppi8q8wjvjmi@mqcpg7oapc828.gar.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 02:22:05PM -0600, Haitao Huang wrote:
> On Wed, 16 Dec 2020 07:49:20 -0600, Jarkko Sakkinen <jarkko@kernel.org>
> wrote:
> 
> > Add synchronize_srcu_expedited() to sgx_encl_release() to catch a grace
> > period initiated by sgx_mmu_notifier_release().
> > 
> > A trivial example of a failing sequence with tasks A and B:
> > 
> > 1. A: -> sgx_release()
> > 2. B: -> sgx_mmu_notifier_release()
> > 3. B: -> list_del_rcu()
> > 3. A: -> sgx_encl_release()
> > 4. A: -> cleanup_srcu_struct()
> > 
> > The loop in sgx_release() observes an empty list because B has removed
> > its
> > entry in the middle, and calls cleanup_srcu_struct() before B has a
> > chance
> > to calls synchronize_srcu().
> > 
> > Fixes: 1728ab54b4be ("x86/sgx: Add a page reclaimer")
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Suggested-by: Haitao Huang <haitao.huang@linux.intel.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v3: Fine-tuned tags, and added missing change log for v2.
> > v2: Switch to synchronize_srcu_expedited().
> >  arch/x86/kernel/cpu/sgx/encl.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/cpu/sgx/encl.c
> > b/arch/x86/kernel/cpu/sgx/encl.c
> > index ee50a5010277..fe7256db6e73 100644
> > --- a/arch/x86/kernel/cpu/sgx/encl.c
> > +++ b/arch/x86/kernel/cpu/sgx/encl.c
> > @@ -438,6 +438,12 @@ void sgx_encl_release(struct kref *ref)
> >  	if (encl->backing)
> >  		fput(encl->backing);
> > +	/*
> > +	 * Each sgx_mmu_notifier_release() starts a grace period. Therefore, an
> > +	 * additional sync is required here.
> > +	 */
> > +	synchronize_srcu_expedited(&encl->srcu);
> > +
> >  	cleanup_srcu_struct(&encl->srcu);
> > 	WARN_ON_ONCE(!list_empty(&encl->mm_list));
> 
> Tested-by: Haitao Huang <haitao.huang@linux.intel.com>

Thanks.

/Jarkko
