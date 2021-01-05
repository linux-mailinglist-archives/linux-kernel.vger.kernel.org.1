Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DC92EB2BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbhAESnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:43:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbhAESnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609872100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EwI51oteB1zNcM5usbv0yXWNl7lwzAeC8ISFtsCGyIc=;
        b=YOrdPNJIurTAnVyMa2/7g0xdZJ1+0+YoGSMZkMwJ6VBTtYke5hvfFpcU2Xzr3dTabkh3yL
        uhnQuwbFwMc/s+rNO5FM8nVKISavwYPtUlxpNkIIEK1ctSx1OWSY12zb8dlDbzBaFwUqux
        +xbAREousO4AxSqgHxwdIKwwcjihL2A=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-gtbpVctmOAaPE8FcP7e3Vw-1; Tue, 05 Jan 2021 13:41:38 -0500
X-MC-Unique: gtbpVctmOAaPE8FcP7e3Vw-1
Received: by mail-qt1-f198.google.com with SMTP id h18so457873qtr.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:41:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EwI51oteB1zNcM5usbv0yXWNl7lwzAeC8ISFtsCGyIc=;
        b=OWDH0JXNwiqXWpXVdygZUQjckhGWaPi5/1GRbQgx9Udg7XzJn7h7OZ7+bMfPIhRdBC
         0v7f7uFfZSMXeHepN3QU7Tr2OedTGzTfyayR6lSM5u6MupFCRFFiWD1WuboAicW72gTC
         6v8zDn2VD01KL2sGimpiOc/R7PriLcEnc7SAvEpG+l+uThxdiB2smcjkN1wu0al6RDYY
         Zag+oahsgNfb9qG1YAUXQI0Uqz2xmffIqi+WjKncjNyCn+7fnHkFg2Fd14Xr0n7WtDPN
         mPynjZkjsZ8ZjZoARkTjJaOrYjkmudwQiHDloq1Pvr42XLHXEcvzpqQBHOxdEObCbF7y
         /FFg==
X-Gm-Message-State: AOAM532LjMnuOgMFC2NgagTpGi/iJrdebWlcOCoy5BJwDH1BlTy2jcDT
        VYw1AmaMNBwkZ6Em12zA2WWe9oFU2175C0K1CFKG/rB89909Qyx6GnD4bGri/OZD5B8p0khTMbq
        OXhpRjLMGo4bpZeCrQqkNhohV
X-Received: by 2002:ac8:5b82:: with SMTP id a2mr788426qta.215.1609872096994;
        Tue, 05 Jan 2021 10:41:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9YFOrmm19T6QEMieBtVD2lNz6D99wYK0l0XUh/rbEAdM+XNbc0QrqMNjgU4em6as+taSqqw==
X-Received: by 2002:ac8:5b82:: with SMTP id a2mr788401qta.215.1609872096643;
        Tue, 05 Jan 2021 10:41:36 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d2sm365817qtp.71.2021.01.05.10.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 10:41:35 -0800 (PST)
Date:   Tue, 5 Jan 2021 13:41:34 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
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
Message-ID: <20210105184134.GD149908@xz-x1>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-2-namit@vmware.com>
 <20210105150813.GB149908@xz-x1>
 <X/SrMIz50alPOp6i@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/SrMIz50alPOp6i@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 01:08:48PM -0500, Andrea Arcangeli wrote:
> On Tue, Jan 05, 2021 at 10:08:13AM -0500, Peter Xu wrote:
> > On Fri, Dec 25, 2020 at 01:25:28AM -0800, Nadav Amit wrote:
> > > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > > index ab709023e9aa..c08c4055b051 100644
> > > --- a/mm/mprotect.c
> > > +++ b/mm/mprotect.c
> > > @@ -75,7 +75,8 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
> > >  		oldpte = *pte;
> > >  		if (pte_present(oldpte)) {
> > >  			pte_t ptent;
> > > -			bool preserve_write = prot_numa && pte_write(oldpte);
> > > +			bool preserve_write = (prot_numa || uffd_wp_resolve) &&
> > > +					      pte_write(oldpte);
> > 
> > Irrelevant of the other tlb issue, this is a standalone one and I commented in
> > v1 about simply ignore the change if necessary; unluckily that seems to be
> > ignored..  so I'll try again - would below be slightly better?
> > 
> >     if (uffd_wp_resolve && !pte_uffd_wp(oldpte))
> >         continue;
> 
> I posted the exact same code before seeing the above so I take it as a good
> sign :). I'd suggest to add the reverse check to the uffd_wp too.

Agreed. I didn't mention uffd_wp check (which I actually mentioned in the reply
to v1 patchset) here only because the uffd_wp check is pure optimization; while
the uffd_wp_resolve check is more critical because it is potentially a fix of
similar tlb flushing issue where we could have demoted the pte without being
noticed, so I think it's indeed more important as Nadav wanted to fix in the
same patch.

It would be even nicer if we have both covered (all of them can be in
unlikely() as Andrea suggested in the other email), then maybe nicer as a
standalone patch, then mention about the difference of the two in the commit
log (majorly, the resolving change will be more than optimization).

Thanks,

-- 
Peter Xu

