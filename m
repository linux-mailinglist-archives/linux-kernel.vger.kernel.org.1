Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEFB2ED17B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbhAGOMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:12:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:45212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727773AbhAGOMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:12:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610028693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d/0aJd6L6cFlMGhErbrEFew79EQmA27uvTCPjDXMcns=;
        b=m02pAfMHvIF+TcFwI29qCrYeH501CPFnrCwYHhh8IXlpgSNW9evNAMK+HPf/Cma8zM2oUW
        A5M3K4cRMKJapbwN8zIli+GQkaWE33QyuyMJMUukAVHDob0Z7bAaqU+ZtyLUXoOLknzq2Y
        5hLcVjGD0Xrz3ExoPvLHNYlI00g5FAo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A425AB748;
        Thu,  7 Jan 2021 14:11:33 +0000 (UTC)
Date:   Thu, 7 Jan 2021 15:11:30 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v2 3/6] mm: hugetlb: fix a race between
 freeing and dissolving the page
Message-ID: <20210107141130.GL13207@dhcp22.suse.cz>
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-4-songmuchun@bytedance.com>
 <20210106165632.GT13207@dhcp22.suse.cz>
 <CAMZfGtWML+PUnK=jJJ1XFmv=VdKOZYmKjyYU=nhpq-1sSGKMqg@mail.gmail.com>
 <20210107084146.GD13207@dhcp22.suse.cz>
 <CAMZfGtVr83yb30EHp5i+f90nn5gnNfGH31Q2ebdV-5nnQXCsAQ@mail.gmail.com>
 <20210107111827.GG13207@dhcp22.suse.cz>
 <CAMZfGtV_k=FxcWfazpuT=3ByXSqK-CH-E3yRQUE_dG6JMnAZeg@mail.gmail.com>
 <20210107123854.GJ13207@dhcp22.suse.cz>
 <CAMZfGtWUP1H47ZGcczsmqsQvxYP=FK9vYVr8WbOY_9UG2SCv0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWUP1H47ZGcczsmqsQvxYP=FK9vYVr8WbOY_9UG2SCv0A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07-01-21 20:59:33, Muchun Song wrote:
> On Thu, Jan 7, 2021 at 8:38 PM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > Right. Can we simply back off in the dissolving path when ref count is
> > 0 && PageHuge() if list_empty(page->lru)? Is there any other scenario
> > when the all above is true and the page is not being freed?
> 
> The list_empty(&page->lru) may always return false.
> The page before freeing is on the active list
> (hstate->hugepage_activelist).Then it is on the free list
> after freeing. So list_empty(&page->lru) is always false.

The point I was trying to make is that the page has to be enqueued when
it is dissolved and freed. If the page is not enqueued then something
racing. But then I have realized that this is not a great check to
detect the race because pages are going to be released to buddy
allocator and that will reuse page->lru again. So scratch that and sorry
for the detour.

But that made me think some more and one way to reliably detect the race
should be PageHuge() check in the freeing path. This is what dissolve
path does already. PageHuge becomes false during update_and_free_page()
while holding the hugetlb_lock. So can we use that?
-- 
Michal Hocko
SUSE Labs
