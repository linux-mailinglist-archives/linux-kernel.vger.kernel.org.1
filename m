Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F432F748C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 09:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbhAOIs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 03:48:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:22645 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730254AbhAOIsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 03:48:24 -0500
IronPort-SDR: otUwOAszHYWRxGY+bfkDb+r+kJnozbTdyqLaFkYXt5+pGT8E4ysiYJTl1VhELzH7Z4UcwzBohT
 i6oPGt2qlYcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="240064778"
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="240064778"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 00:47:41 -0800
IronPort-SDR: on8+Bxc11wN/xt986f7vAgSqLFvRKTLK70zFKK8TkcK1dLMvz+SQfPzAnK97FPsY7Z2ZFHm+Gz
 7AewwwY1uGYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="354226722"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.145])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jan 2021 00:47:38 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     huang ying <huang.ying.caritas@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH] mm: Free unused swap cache page in write protection fault handler
References: <20210113024241.179113-1-ying.huang@intel.com>
        <CAHk-=whn5kVxEitkC0AyzvWRyxbF91rMrO9ZG6JHBNYLckpDDw@mail.gmail.com>
        <CAC=cRTNpoqHpbtZM1uDvVQYQZVyRbfPh+Dirb=-Xgoh22u_W1A@mail.gmail.com>
        <20210113031142.GM35215@casper.infradead.org>
        <CAC=cRTNMN5Pmz2PC8p3N2-uJkqLUCW95wr=VWTZmodoECmj6nQ@mail.gmail.com>
        <CAHk-=wh3nL28QfkKV6gpVGjh5iPjoEZtEQYPDvwPgscm-yMAfA@mail.gmail.com>
Date:   Fri, 15 Jan 2021 16:47:37 +0800
In-Reply-To: <CAHk-=wh3nL28QfkKV6gpVGjh5iPjoEZtEQYPDvwPgscm-yMAfA@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 13 Jan 2021 13:09:31 -0800")
Message-ID: <87sg72vb6e.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Jan 12, 2021 at 9:24 PM huang ying <huang.ying.caritas@gmail.com> wrote:
>> >
>> > Couldn't we just move it to the tail of the LRU list so it's reclaimed
>> > first?  Or is locking going to be a problem here?
>>
>> Yes.  That's a way to reduce the disturbance to the page reclaiming.
>> For LRU lock contention, is it sufficient to use another pagevec?
>
> I wonder if this is really worth it. I'd like to see numbers.
>
> Because in probably 99%+ of all cases, that LRU dance is only going to
> hurt and add extra locking overhead and dirty caches.
>
> So I'd like to see some numbers that it actually helps measurably in
> whatever paging-heavy case...

OK.  I will start from a simpler version and only use a pagevec if
there's measurable difference.

Best Regards,
Huang, Ying
