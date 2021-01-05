Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE052EA41B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbhAEDv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 22:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbhAEDv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 22:51:27 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09126C061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 19:50:47 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id r5so29588892eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 19:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b3i2DWNklZVjsl2UAKCa7AqbN0KVFXiRrj/Leq+WDOM=;
        b=QaoV+dt85/SIxPaD152+bpRXhieIfNZjXCLFUmnjYeOVSlH2J6hfzWGAON68nNBgrD
         /TguU7C/InTWFGCWhMMaUvR7E8YseVqLQhvWeGBHfIum06L67uPE7MK4PTnqxNrhKbi0
         Top9zLT03LMVUN9t9xou9mOwcAu0SfHQ8vG3cNhJZ94pMrW4w26tG2JgcA4Vz2Cr4+HC
         8m1ps6dEEn5wYPuqceRcDZBtkNqB42Io6Hq+8OWaLe+fItq9KgaSbkU3ML5wcpih3N4Z
         i36QU52gQvhylBwEKNULGyufAdMV0f6PG3GdI2IvKEIxPWba7I2olzRfKUvZqdepRwUn
         agJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b3i2DWNklZVjsl2UAKCa7AqbN0KVFXiRrj/Leq+WDOM=;
        b=gerrG+Ssbs8cOn8+y/fPlQ7PPrZmxZLs39fxtmFfAJl2fRJJc3FIyGIef5s18coYB7
         sv5vPisOQeZAO4AvvpKwPhCFb471KK5EA+SbGeYcPVR+CMjkqv/cNV61Off82q7jzhHN
         6l/QWYcsuOrgVE+youM0VCPi5VtoeT+JQ2qdzomf7cgyvT5JC4gd4CqmXcSr5Z/fLyLR
         cJBvGmPQe/ih4O0S20McDPMM1ASFNadwN1cb7PF0k41ZATIqQue55GjJOX7RloOLHOKq
         eE9YVQzcBZRCbdGWLoqsa9nJ60TX/nHGo/uueqYDNKUfwMvnCv3tK6x5i9vlFmwjkRkC
         ENBA==
X-Gm-Message-State: AOAM531lfcZIIsj1fziOnMzWwQ6jvFdSf4EMx83S5Y3u8Yph3w0nDqW8
        vR/fkZtWWSRtnEXsIjCbXu7WL4VB/443TLaznTWINw==
X-Google-Smtp-Source: ABdhPJwknNce1uVDk7EBKnwBvIlU5uz+2znHV465a20iudsxykeAovWJHlAtM2Cs1s+X+Z7S8tkSSZkk+wewPh3CAo8=
X-Received: by 2002:aa7:df0f:: with SMTP id c15mr75010622edy.354.1609818645726;
 Mon, 04 Jan 2021 19:50:45 -0800 (PST)
MIME-Version: 1.0
References: <20210101042914.5313-1-rdunlap@infradead.org> <CAPcyv4jAiqyFg_BUHh_bJRG-BqzvOwthykijRapB_8i6VtwTmQ@mail.gmail.com>
 <f7803685-e255-7cfe-5259-e2a7dc5ab581@infradead.org>
In-Reply-To: <f7803685-e255-7cfe-5259-e2a7dc5ab581@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 4 Jan 2021 19:50:39 -0800
Message-ID: <CAPcyv4jPwk_xjeVjv0LhXr_d9+dbcEDJ_YOF+qrX97e_CE8yRA@mail.gmail.com>
Subject: Re: [PATCH v2] fs/dax: include <asm/page.h> to fix build error on ARC
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vgupts@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 7:47 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 1/4/21 12:13 PM, Dan Williams wrote:
> > On Thu, Dec 31, 2020 at 8:29 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> fs/dax.c uses copy_user_page() but ARC does not provide that interface,
> >> resulting in a build error.
> >>
> >> Provide copy_user_page() in <asm/page.h> (beside copy_page()) and
> >> add <asm/page.h> to fs/dax.c to fix the build error.
> >>
> >> ../fs/dax.c: In function 'copy_cow_page_dax':
> >> ../fs/dax.c:702:2: error: implicit declaration of function 'copy_user_page'; did you mean 'copy_to_user_page'? [-Werror=implicit-function-declaration]
> >>
> >> Fixes: cccbce671582 ("filesystem-dax: convert to dax_direct_access()")
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Vineet Gupta <vgupta@synopsys.com>
> >> Cc: linux-snps-arc@lists.infradead.org
> >> Cc: Dan Williams <dan.j.williams@intel.com>
> >> Acked-by: Vineet Gupta <vgupts@synopsys.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Matthew Wilcox <willy@infradead.org>
> >> Cc: Jan Kara <jack@suse.cz>
> >> Cc: linux-fsdevel@vger.kernel.org
> >> Cc: linux-nvdimm@lists.01.org
> >> ---
> >> v2: rebase, add more Cc:
> >>
> >>  arch/arc/include/asm/page.h |    1 +
> >>  fs/dax.c                    |    1 +
> >>  2 files changed, 2 insertions(+)
> >>
> >> --- lnx-511-rc1.orig/fs/dax.c
> >> +++ lnx-511-rc1/fs/dax.c
> >> @@ -25,6 +25,7 @@
> >>  #include <linux/sizes.h>
> >>  #include <linux/mmu_notifier.h>
> >>  #include <linux/iomap.h>
> >> +#include <asm/page.h>
> >
> > I would expect this to come from one of the linux/ includes like
> > linux/mm.h. asm/ headers are implementation linux/ headers are api.
> >
> > Once you drop that then the subject of this patch can just be "arc:
> > add a copy_user_page() implementation", and handled by the arc
> > maintainer (or I can take it with Vineet's ack).
>
> Got it. Thanks.
> Vineet is copied. I expect that he will take the v3 patch.
>
> >>  #include <asm/pgalloc.h>
> >
> > Yes, this one should have a linux/ api header to front it, but that's
> > a cleanup for another day.
>
> That line is only part of the contextual diff in this patch.
> I guess you are just commenting in general, along with your earlier
> paragraph.

Yes, I was prefetching a "...hey, but, there's an asm/ include right
below this one?"
