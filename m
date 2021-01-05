Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF922EB22A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbhAESKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:10:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41289 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726703AbhAESKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609870161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uFQPSNwpG15/ebAkFhceGrpURfg73EkrLU4VuQedFsM=;
        b=gM2gMU+Fjq+XRj6lNTgxr7jC5xE+EiicUtt416ht6AfVk3VYJG2IhH21PI725ONx8q5cFf
        Wc5HoE0LIFbPwoeMb6DBjOSHfqUpwmZLIN+aXUuw2y/L4aTo/CS7V3cG0NUNqdxRswOuqY
        291ojpBKG6h/SzbPau7pDAC9UxAPOlY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-C7R7sj9dO1G-rBHPar36-w-1; Tue, 05 Jan 2021 13:09:17 -0500
X-MC-Unique: C7R7sj9dO1G-rBHPar36-w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13431CC62C;
        Tue,  5 Jan 2021 18:09:15 +0000 (UTC)
Received: from mail (ovpn-112-76.rdu2.redhat.com [10.10.112.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 34D5560C72;
        Tue,  5 Jan 2021 18:08:49 +0000 (UTC)
Date:   Tue, 5 Jan 2021 13:08:48 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Message-ID: <X/SrMIz50alPOp6i@redhat.com>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-2-namit@vmware.com>
 <20210105150813.GB149908@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105150813.GB149908@xz-x1>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 10:08:13AM -0500, Peter Xu wrote:
> On Fri, Dec 25, 2020 at 01:25:28AM -0800, Nadav Amit wrote:
> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index ab709023e9aa..c08c4055b051 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -75,7 +75,8 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
> >  		oldpte = *pte;
> >  		if (pte_present(oldpte)) {
> >  			pte_t ptent;
> > -			bool preserve_write = prot_numa && pte_write(oldpte);
> > +			bool preserve_write = (prot_numa || uffd_wp_resolve) &&
> > +					      pte_write(oldpte);
> 
> Irrelevant of the other tlb issue, this is a standalone one and I commented in
> v1 about simply ignore the change if necessary; unluckily that seems to be
> ignored..  so I'll try again - would below be slightly better?
> 
>     if (uffd_wp_resolve && !pte_uffd_wp(oldpte))
>         continue;

I posted the exact same code before seeing the above so I take it as a good
sign :). I'd suggest to add the reverse check to the uffd_wp too.

> Firstly, current patch is confusing at least to me, because "uffd_wp_resolve"
> means "unprotect the pte", whose write bit should mostly be cleared already
> when uffd_wp_resolve is applicable.  Then "preserve_write" for that pte looks
> odd already.
> 
> Meanwhile, if that really happens (when pte write bit set, but during a
> uffd_wp_resolve request) imho there is really nothing we can do, so we should
> simply avoid touching that at all, and also avoid ptep_modify_prot_start,
> pte_modify, ptep_modify_prot_commit, calls etc., which takes extra cost.

Agreed. It should not just defer the flush, by doing continue we will
not flush anything.

So ultimately the above will be an orthogonal optimization, but now I
get the why the deferred tlb flush on the cpu0 of the v2 patch was the
problematic one. I didn't see we lacked the above optimization and I
thought we were discussing still the regular case where un-wrprotect
is called on a pte with uffd-wp set.

thanks,
Andrea

