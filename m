Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD80281501
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388109AbgJBOYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgJBOYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:24:09 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B27C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 07:24:09 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w12so1481502qki.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 07:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J6aAVCPaMvKSHOZjnjEf6/gbikFRYlnB3sj1/Tf0Wm0=;
        b=tZEYQ2oiZPhVz0jxDWbJSFolyVeR1WXMHqMWkqBm4CC21X68tD3whGHoER1ydI+9rN
         RC53o8XjkPPaCJV81P5x1wvk+Sv0noq1kwwbWmizk6nVyRHxqDkeGxtkjQeTDIHmdsif
         uIqHYeNLVsujCrIJsM4IM29P0kNyKBbtBf/O7jZ2xYIo1KKOVjyxhgxVVbzrMTXpBCfz
         SkeLUWU6XlfNW4Bgd+pASbn21mhPKCqZk0fWZUtvtazY3g/ld4s1noL7/1gls/YefNbo
         +DCuYMVde8SOoCb1XEKCty0rGezCgAJzZtaPJ+urg2sQ+XkJjh+Juo5GQGE9aw+2EODo
         3CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J6aAVCPaMvKSHOZjnjEf6/gbikFRYlnB3sj1/Tf0Wm0=;
        b=IFG6DUq7LlR4H2mbc9U4pQwKea5cr1gtV0I6QwcKG/Zgncg3KMjPXrkL5/HF1Rfzz8
         l0vGF/bYupkj9yml30wTPhFEVljEUbCTLQSuxdQcN2leqCWbpF14BCHJmn0ow4Fpc/ZA
         FkiV+fm8QJCJYQSBeKxPswuwabUQbbWjd6+kXkeDGw5fD/tgCA/0+GAsjK5q0oYG+iQ+
         MV2zCnexS3gXZnwvachw33fCb5Kbuq/PO+8ucq2aP7bwDySFDx5FqP5M7XfAvUnNP7lM
         5fMXjCaCQuKHNSM/hkH1Oqo4e9jV6db8s4NvB0cjsf30hU4ezZju/0GnzVHJg7Kg6sA7
         yZzA==
X-Gm-Message-State: AOAM531gFWkQrkTauCurbp/cuqCA4nida0Q3rdSCYAe5hMW0iK8vRAv6
        QD/tC88B9pMuB/5ohBLLoYDzyA==
X-Google-Smtp-Source: ABdhPJyRuEXfi/Ldsn3i78m/8J1WyOXKLYmIY0cIc1CstIXxKppiLlcAewJ2ISLpYUnLTRHe5FyHLw==
X-Received: by 2002:a05:620a:656:: with SMTP id a22mr2259439qka.63.1601648648098;
        Fri, 02 Oct 2020 07:24:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:d668])
        by smtp.gmail.com with ESMTPSA id y30sm1176545qth.7.2020.10.02.07.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 07:24:07 -0700 (PDT)
Date:   Fri, 2 Oct 2020 10:22:25 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v4 1/4] mm: memcontrol: use helpers to access page's
 memcg data
Message-ID: <20201002142225.GB525590@cmpxchg.org>
References: <20201001002710.748166-1-guro@fb.com>
 <20201001002710.748166-2-guro@fb.com>
 <20201001134638.GE469663@cmpxchg.org>
 <20201001182739.GA2706729@carbon.DHCP.thefacebook.com>
 <20201001185950.GB500308@cmpxchg.org>
 <20201001205143.GE2706729@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001205143.GE2706729@carbon.DHCP.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 01:51:43PM -0700, Roman Gushchin wrote:
> On Thu, Oct 01, 2020 at 02:59:50PM -0400, Johannes Weiner wrote:
> > On Thu, Oct 01, 2020 at 11:27:39AM -0700, Roman Gushchin wrote:
> > > On Thu, Oct 01, 2020 at 09:46:38AM -0400, Johannes Weiner wrote:
> > > > On Wed, Sep 30, 2020 at 05:27:07PM -0700, Roman Gushchin wrote:
> > > > > +/*
> > > > > + * set_page_memcg - associate a page with a memory cgroup
> > > > > + * @page: a pointer to the page struct
> > > > > + * @memcg: a pointer to the memory cgroup
> > > > > + *
> > > > > + * Associates a page with a memory cgroup.
> > > > > + */
> > > > > +static inline void set_page_memcg(struct page *page, struct mem_cgroup *memcg)
> > > > > +{
> > > > > +	VM_BUG_ON_PAGE(PageSlab(page), page);
> > > > > +
> > > > > +	/*
> > > > > +	 * Please, refer to page_memcg()'s description for the page and memcg
> > > > > +	 * binding stability requirements.
> > > > > +	 */
> > > > > +	page->memcg_data = (unsigned long)memcg;
> > > > > +}
> > > > 
> > > > Please delete and inline this as per previous feedback, thanks.
> > > 
> > > Why it's better?
> > > It's ok for set_page_memcg(), but obviously worse for set_page_objcgs():
> > > it was nice to have all bit magic in one place, in few helper functions.
> > > And now it spills into several places. What's the win?
> > 
> > set_page_objcgs() is a worthwhile abstraction because it includes the
> > synchronization primitives that make it safe to use wrt
> > page_objcgs(). They encapsulate the cmpxchg and the READ_ONCE().
> > 
> > set_page_memcg() doesn't do any synchronization and relies fully on
> > the contextual locking. The name implies that it includes things to
> > make it safe wrt page_memcg(), which isn't true at all. It's a long
> > and misleading name for '='.
> > 
> > Btw, I really don't mind having this discussion, but please don't send
> > revisions that silently ignore feedback you don't agree with.
> 
> I'm not ignoring: I thought you was looking to remove clear_page_* functions,
> but it wasn't clear you want eliminate set_page_memcg() function. Please, when
> you asking for some "style" changes, please, provide some rationale, it's way
> less obvious than you think, what exactly you don't like in the proposed version.

https://lore.kernel.org/lkml/20200930210124.GB469663@cmpxchg.org/
mentions and provides a rationale for inlining the setting and
clearing (unnecessary abstraction/encapsulation).

This is a code base shared by many different developers. It's routine
to be asked for style changes that make the new code blend in with its
surroundings, follow precedents and use idiomatic constructs, or avoid
anti-patterns that are known to cause maintenance burden or make it
harder to hack or debug the code.

If I'm being too terse and something isn't clear, please just ask for
clarification.
