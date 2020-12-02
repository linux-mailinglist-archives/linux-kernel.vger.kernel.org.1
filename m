Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF652CB2CF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 03:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgLBC3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 21:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgLBC3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 21:29:30 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE23C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 18:28:50 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r5so653558eda.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 18:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jM9A+3KaaiPpvWPDXTsVYgKekaxWNn0Vy+5ecqlGLPk=;
        b=UcWU6mPHePQD7oxZyJ3QI8EBVRLqdLckOHec4/9GUNtNJH3fJzfnc9+ztdoEZjCkFw
         pYdz6h215kR81M6/JrHPGGE5mAfzQQMgD1i9mIi8EJGhb/u1CYqH6160qHQ3b5goL1aM
         vGHkaj29vjmNYeeFbHudC+HBE9Y4xixArtOHYpdFMqBwTEWbj33jt/2nmtRqLgDNYV2j
         nk9h/P1PBU8VbP7vQVb/h77TvTier9YybxSyjIZYgDPtcCIRqAEwiwv0JSdcyRBwvwtp
         Jw6Pf7YqjvpAz7aDt6cfCQtF6Qt89Z0FDXZ9FlhlIdwAc8bOCefJLS/+H9ccZuhUBswZ
         pWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jM9A+3KaaiPpvWPDXTsVYgKekaxWNn0Vy+5ecqlGLPk=;
        b=XzOCs8Bwc6jRTYdygmO+VpwaGLx31Sd4aUPiybv6RqRvPgrV4JO+bfIXZJQqzznJNM
         Wx0vwoBsLDhNnKf/9Ed8oTRUrHEMCIsjMC/3r/jQGxq6zbzEUIoy6sZfU/gOah1UIZHF
         eQ/g+JSnvcF9sE8mzvBJ37bU95fEx9AjHZHOORPjM7+Rh5dzbiN/CkEV/DzkfZEZ5rxY
         /vw+wVgt2rCeQA2WDPTgSNTzhHdAklzqwGrefdSYGlO3XkB3etiywOv6rwS0dvnAJcu5
         eL2T/ZiePVmiTiIrOnYl3ute685DeIsGrX1FQB7AJBTz/EZSFuZHwchWcj1XG/+7LQbh
         aMcg==
X-Gm-Message-State: AOAM533OL5uiz3V7bBRve9hNoA0TeRJnEo5oCF6ugZnoSZI1HUGiSJ/b
        PG3QjQbtsftp5SRn16bNXF8q4gAWFVEAD4Ey6eWKeGeAdn90DQ==
X-Google-Smtp-Source: ABdhPJxxdgVGhyjxYPVa1iHrBXTrpKmswqz6i0GnJFbV69X4wbpncFo9Iyek+7pIGpd5QudB/5mxTjUf/+DRUG+1QUI=
X-Received: by 2002:a50:e00f:: with SMTP id e15mr584892edl.210.1606876129090;
 Tue, 01 Dec 2020 18:28:49 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4isen63tJ7q02rvVuu_Rm6QPdT0Bu-P_HJ2zePMySFNNg@mail.gmail.com>
 <20201201022412.GG4327@casper.infradead.org> <CAPcyv4j7wtjOSg8vL5q0PPjWdaknY-PC7m9x-Q1R_YL5dhE+bQ@mail.gmail.com>
 <20201201204900.GC11935@casper.infradead.org>
In-Reply-To: <20201201204900.GC11935@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 1 Dec 2020 18:28:45 -0800
Message-ID: <CAPcyv4jNVroYmirzKw_=CsEixOEACdL3M1Wc4xjd_TFv3h+o8Q@mail.gmail.com>
Subject: Re: mapcount corruption regression
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yi Zhang <yi.zhang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 12:49 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Dec 01, 2020 at 12:42:39PM -0800, Dan Williams wrote:
> > On Mon, Nov 30, 2020 at 6:24 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Mon, Nov 30, 2020 at 05:20:25PM -0800, Dan Williams wrote:
> > > > Kirill, Willy, compound page experts,
> > > >
> > > > I am seeking some debug ideas about the following splat:
> > > >
> > > > BUG: Bad page state in process lt-pmem-ns  pfn:121a12
> > > > page:0000000051ef73f7 refcount:0 mapcount:-1024
> > > > mapping:0000000000000000 index:0x0 pfn:0x121a12
> > >
> > > Mapcount of -1024 is the signature of:
> > >
> > > #define PG_guard        0x00000400
> >
> > Oh, thanks for that. I overlooked how mapcount is overloaded. Although
> > in v5.10-rc4 that value is:
> >
> > #define PG_table        0x00000400
>
> Ah, I was looking at -next, where Roman renumbered it.
>
> I know UML had a problem where it was not clearing PG_table, but you
> seem to be running on bare metal.  SuperH did too, but again, you're
> not using SuperH.
>
> > >
> > > (the bits are inverted, so this turns into 0xfffffbff which is reported
> > > as -1024)
> > >
> > > I assume you have debug_pagealloc enabled?
> >
> > Added it, but no extra spew. I'll dig a bit more on how PG_table is
> > not being cleared in this case.
>
> I only asked about debug_pagealloc because that sets PG_guard.  Since
> the problem is actually PG_table, it's not relevant.

As a shot in the dark I reverted:

    b2b29d6d0119 mm: account PMD tables like PTE tables

...and the test passed.

Yi, do you see the same?
