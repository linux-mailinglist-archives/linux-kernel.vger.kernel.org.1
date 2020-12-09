Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87BBF2D46C2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 17:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgLIQaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 11:30:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:46928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbgLIQaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 11:30:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607531376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9xUW8Dmv5mRMmD07Vnox+GxN1NtoZFKgjjUp7YIwwjg=;
        b=fUEW8+h0L6wEknj3P4q4OGgeLzaYH6bXInbPHNzFUGnBNwx2u5SY2U0Vp2ojubvOSS8UPQ
        dbrYzPBlWEgXsxbYF3CSHKzt1Afgu+6JKmrSCPmi6W0n5jsvJGGHIMSuTAP23LXrVlKjHw
        PWjfU96c+eRvRKqGTBYVIOlCCO/i6Ik=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7C279AD71;
        Wed,  9 Dec 2020 16:29:36 +0000 (UTC)
Date:   Wed, 9 Dec 2020 17:29:35 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Hui Su <sh_def@163.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/page_alloc: simplify kmem cgroup charge/uncharge code
Message-ID: <20201209162935.GD26090@dhcp22.suse.cz>
References: <20201207142204.GA18516@rlk>
 <CALvZod45tRyx+7VagQQ=9SqabNR5Y=f0U0T0AFtOFWdzUgJbxQ@mail.gmail.com>
 <20201208060747.GA56968@rlk>
 <CALvZod56cWta66q4w4ndiPmgfVGkViAFfivh8L8eUBPqJRWFCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod56cWta66q4w4ndiPmgfVGkViAFfivh8L8eUBPqJRWFCg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-12-20 09:12:23, Shakeel Butt wrote:
> +Michal Hocko
> 
> Message starts at https://lkml.kernel.org/r/20201207142204.GA18516@rlk
> 
> On Mon, Dec 7, 2020 at 10:08 PM Hui Su <sh_def@163.com> wrote:
> >
> > On Mon, Dec 07, 2020 at 09:28:46AM -0800, Shakeel Butt wrote:
> > > On Mon, Dec 7, 2020 at 6:22 AM Hui Su <sh_def@163.com> wrote:
> > >
> > > The reason to keep __memcg_kmem_[un]charge_page functions is that they
> > > were called in the very hot path. Can you please check the performance
> > > impact of your change and if the generated code is actually same or
> > > different.
> >
> > Hi, Shakeel:
> >
> > I objdump the mm/page_alloc.o and comapre them, it change the assemble code
> > indeed. In fact, it change some code order, which i personally think won't have
> > impact on performance. And i ran the ltp mm and conatiner test, it seems nothing
> > abnormal.
> 
> Did you run the tests in a memcg? The change is behind a static key of
> kmem accounting which is enabled for subcontainers.
> 
> >
> > BUT i still want to check whether this change will have negative impact on
> > perforance due to this change code was called in the very hot path like you
> > said, AND saddly i did not find a way to quantify the impact on performance.
> > Can you give me some suggestion about how to quantify the performance or some
> > tool?
> >
> 
> At least I think we can try with a simple page allocation in a loop
> i.e. alloc_page(GFP_KERNEL_ACCOUNT). I will think of any existing
> benchmark which exercises this code path.
> 
> Michal, do you have any suggestions?

I have to say I do not see any big benefit from the patch and it alters
a real hot path to check for the flag even in cases where kmem
accounting is not enabled, unless I am misreading the code.

-- 
Michal Hocko
SUSE Labs
