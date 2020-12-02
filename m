Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEC02CB439
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 06:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgLBFII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 00:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLBFIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 00:08:07 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276E4C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 21:07:27 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id jx16so910290ejb.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 21:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KwNZsFRA/IYGRcCT2QHYfNwg6PsGCIWZOBcgb5DDj88=;
        b=gueikS+aDT27nyPzPyzkwYn1k3AuHzdfALOFE07LukUrb2sb/ctSsjJhidsFcEMaCm
         gYKAbv8txSy41RAkcLddla+GjCPUv3xaJLTF/hg6J7s2OBWVIx4aWZUtuNXolHUgAcOC
         j4JETcEyYEEloJVXYLbImTzYYPV3CS0B27bycb5eE8HFygnMwcbqZuW3uCZ9L17k2JDQ
         gPt5CX/HOx09bJvyYwA4cipDB96S+/og5gEdJcu16JoTXuCiFjR6t7B/YXqIw/4CMU4K
         Bey6XI70dVU7zez0+E1OoBhRYwm1q4Ida/9ZI5c+606mM8Fm5WcSQogYwlT3hEVg/vMt
         ncNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KwNZsFRA/IYGRcCT2QHYfNwg6PsGCIWZOBcgb5DDj88=;
        b=r4/hfHLD2rHndADUo0usO6G9uatI1V0H79aBadXD9aXRg1A6gN5V4No4N2KqeNLXCC
         8564ELQRT51J47O67Hk3AbBy3lGEjnQ05CkNxH8oQ/zVGGu8VE5djvI7FHcW0W0HQ7vD
         EQSBaPCLyIPhAZqhJIOKce7aTgmzXQo+wqosv2chD8nhEdXEM+vhpZv+YUi82Hj0gGFN
         L1deG1AXZDVnOcRYZxADXVqMKlrV8PjGZh+TfF8m+Y+rr1vulUGRI3btSmW8PzMMt/co
         09MHIOOzpHFMIu9Gc8xPXpnieB3k5qvRkwA84qnchRbIHTE8cUexM+famvxa5IpAFCx9
         VF1w==
X-Gm-Message-State: AOAM533Q3JU2l3K30II5nIbCvPLRiCAZGckTiW36kKxIodj9KRg0SthQ
        utpaMWI/6IYXazCXt15teZmD/g8rV1Tf5Rwc6QkLqg==
X-Google-Smtp-Source: ABdhPJwxvS7rb7CChYsxSarjfQNmQlqikNgrYtFAORWl/FJzy4zu8qlhsn1pLIhxzClr1QxUZ5ykdF9PH/vyWHnxS5A=
X-Received: by 2002:a17:906:c51:: with SMTP id t17mr679087ejf.523.1606885645772;
 Tue, 01 Dec 2020 21:07:25 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4isen63tJ7q02rvVuu_Rm6QPdT0Bu-P_HJ2zePMySFNNg@mail.gmail.com>
 <20201201022412.GG4327@casper.infradead.org> <CAPcyv4j7wtjOSg8vL5q0PPjWdaknY-PC7m9x-Q1R_YL5dhE+bQ@mail.gmail.com>
 <20201201204900.GC11935@casper.infradead.org> <CAPcyv4jNVroYmirzKw_=CsEixOEACdL3M1Wc4xjd_TFv3h+o8Q@mail.gmail.com>
 <20201202034308.GD11935@casper.infradead.org>
In-Reply-To: <20201202034308.GD11935@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 1 Dec 2020 21:07:22 -0800
Message-ID: <CAPcyv4jk2-6hRZAC+=-wuXwFyYK9uKiRX=pVc0Q0UeB9yc=y1w@mail.gmail.com>
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

On Tue, Dec 1, 2020 at 7:43 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Dec 01, 2020 at 06:28:45PM -0800, Dan Williams wrote:
> > On Tue, Dec 1, 2020 at 12:49 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Dec 01, 2020 at 12:42:39PM -0800, Dan Williams wrote:
> > > > On Mon, Nov 30, 2020 at 6:24 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Mon, Nov 30, 2020 at 05:20:25PM -0800, Dan Williams wrote:
> > > > > > Kirill, Willy, compound page experts,
> > > > > >
> > > > > > I am seeking some debug ideas about the following splat:
> > > > > >
> > > > > > BUG: Bad page state in process lt-pmem-ns  pfn:121a12
> > > > > > page:0000000051ef73f7 refcount:0 mapcount:-1024
> > > > > > mapping:0000000000000000 index:0x0 pfn:0x121a12
> > > > >
> > > > > Mapcount of -1024 is the signature of:
> > > > >
> > > > > #define PG_guard        0x00000400
> > > >
> > > > Oh, thanks for that. I overlooked how mapcount is overloaded. Although
> > > > in v5.10-rc4 that value is:
> > > >
> > > > #define PG_table        0x00000400
> > >
> > > Ah, I was looking at -next, where Roman renumbered it.
> > >
> > > I know UML had a problem where it was not clearing PG_table, but you
> > > seem to be running on bare metal.  SuperH did too, but again, you're
> > > not using SuperH.
> > >
> > > > >
> > > > > (the bits are inverted, so this turns into 0xfffffbff which is reported
> > > > > as -1024)
> > > > >
> > > > > I assume you have debug_pagealloc enabled?
> > > >
> > > > Added it, but no extra spew. I'll dig a bit more on how PG_table is
> > > > not being cleared in this case.
> > >
> > > I only asked about debug_pagealloc because that sets PG_guard.  Since
> > > the problem is actually PG_table, it's not relevant.
> >
> > As a shot in the dark I reverted:
> >
> >     b2b29d6d0119 mm: account PMD tables like PTE tables
> >
> > ...and the test passed.
>
> That's not really surprising ... you're still freeing PMD tables without
> calling the destructor, which means that you're leaking ptlocks on
> configs that can't embed the ptlock in the struct page.

Ok, so potentially this new tracking is highlighting a long standing
bug that was previously silent. That would explain the ambiguous
bisect results.

> I suppose it shows that you're leaking a PMD table rather than a PTE
> table, so that might help track it down.  Checking for PG_table in
> free_unref_page() and calling show_stack() will probably help more.

Will do.
