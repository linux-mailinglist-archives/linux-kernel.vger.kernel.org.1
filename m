Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A868D2EB398
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 20:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbhAETpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 14:45:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38215 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730927AbhAETpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 14:45:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609875814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JyQ8Yx6ecRcdkus2Q+iowXLy4MC41M17PpJ0LhrHNpk=;
        b=iAI+/Q5WbyfUjWrrnVGsjguE7ysktIm57VVuZbPPXNESFyEz12BmmljMEtLffBEwBbgQyl
        bQ9yfeRtWfLmdGwzKGK+qpS+TQfTgBorbR90NCUk+a9/rbxTa9MD4gLhuqQExpbrqVcYIa
        IVy/Xv6g9JUpqTkGwIG9GZSjvSSu4OI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-zJEKqUUVNSm2upNzcFyuXA-1; Tue, 05 Jan 2021 14:43:32 -0500
X-MC-Unique: zJEKqUUVNSm2upNzcFyuXA-1
Received: by mail-qv1-f69.google.com with SMTP id eb4so488543qvb.21
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 11:43:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JyQ8Yx6ecRcdkus2Q+iowXLy4MC41M17PpJ0LhrHNpk=;
        b=THXicuEAERxexUqliupd7pn60sLbrHxKpxTCZIT7P2Re+m9fs9FzuJh58df+HkHIGO
         9VPiQMkJiDGbIqqdGg8a2aFyF5Wi822Ig5oKQ6CnMjsn5QdQQf54lk/WOt12fDKT8qkB
         gkh7wYwXooEadMb3Fh7HlTPrnn9hdjrM0PBzJ+kCO/UIGIzT8d/aGF8DBnPrnYMu2fdW
         nuYbcmjmOXAM3ivFwXBgwSum1b74665j51x4D0LvWUcvcq5U33xIbL7fx7MxODyZ35DC
         O8upqEmc4Ep/0ZS6UdDsCTXl/m5HzyV7kQPWg2OiszKdJPxEpJBFa5l6gQt/AXzMLgug
         n11A==
X-Gm-Message-State: AOAM531HTorOmym2oHYSKDS9AGccs2RWbeITMnhaN2zvVDTl44gplaZJ
        WpPePVAC1ZbFm10fZMzGTEaGX/jbttmD23LynrLxOgyduxmrVsz0QJeNvAXpIxRbOC8eIN17KuI
        OAaQtaFeKqXNjPRQX6Tm0eKnO
X-Received: by 2002:a05:6214:4c7:: with SMTP id ck7mr1111273qvb.7.1609875812204;
        Tue, 05 Jan 2021 11:43:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyekDcfWUxGQnFBPKSLKN8PBvaWikC0raWQa6ze3medUNTdPRfPM8cyuocGWhnfMQ4ih8L1zQ==
X-Received: by 2002:a05:6214:4c7:: with SMTP id ck7mr1111250qvb.7.1609875811957;
        Tue, 05 Jan 2021 11:43:31 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id w8sm36806qts.50.2021.01.05.11.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:31 -0800 (PST)
Date:   Tue, 5 Jan 2021 14:43:29 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Message-ID: <20210105194329.GF149908@xz-x1>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-2-namit@vmware.com>
 <20210105150813.GB149908@xz-x1>
 <070CFD88-57A0-40FF-9614-6ED47B214301@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <070CFD88-57A0-40FF-9614-6ED47B214301@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 07:07:51PM +0000, Nadav Amit wrote:
> > On Jan 5, 2021, at 7:08 AM, Peter Xu <peterx@redhat.com> wrote:
> > 
> > On Fri, Dec 25, 2020 at 01:25:28AM -0800, Nadav Amit wrote:
> >> diff --git a/mm/mprotect.c b/mm/mprotect.c
> >> index ab709023e9aa..c08c4055b051 100644
> >> --- a/mm/mprotect.c
> >> +++ b/mm/mprotect.c
> >> @@ -75,7 +75,8 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
> >> 		oldpte = *pte;
> >> 		if (pte_present(oldpte)) {
> >> 			pte_t ptent;
> >> -			bool preserve_write = prot_numa && pte_write(oldpte);
> >> +			bool preserve_write = (prot_numa || uffd_wp_resolve) &&
> >> +					      pte_write(oldpte);
> > 
> > Irrelevant of the other tlb issue, this is a standalone one and I commented in
> > v1 about simply ignore the change if necessary; unluckily that seems to be
> > ignored..  so I'll try again - would below be slightly better?
> > 
> >    if (uffd_wp_resolve && !pte_uffd_wp(oldpte))
> >        continue;
> > 
> > Firstly, current patch is confusing at least to me, because "uffd_wp_resolve"
> > means "unprotect the pte", whose write bit should mostly be cleared already
> > when uffd_wp_resolve is applicable.  Then "preserve_write" for that pte looks
> > odd already.
> > 
> > Meanwhile, if that really happens (when pte write bit set, but during a
> > uffd_wp_resolve request) imho there is really nothing we can do, so we should
> > simply avoid touching that at all, and also avoid ptep_modify_prot_start,
> > pte_modify, ptep_modify_prot_commit, calls etc., which takes extra cost.
> 
> Sorry for missing your feedback before. What you suggest makes perfect
> sense.

No problem.  I actually appreciated a lot for all your great works on these.
The strange thing is the userfaultfd kselftest seems to be working always fine
locally to me (probably another reason that I mostly test uffd-wp with
umapsort), so I won't be able to reproduce some issue you (and Andrea) have
encountered.  It's great you unveiled all these hard tlb problems and nailed
them down so lives should be easier for all of us.

Thanks,

-- 
Peter Xu

