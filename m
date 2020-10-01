Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9BF280755
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 21:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732672AbgJATBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 15:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbgJATBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:01:34 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECE0C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 12:01:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id j22so2041891qtj.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FA4b+JjxXDupd9SJaACVBkhyBnQSOUKDxz41oObhr2A=;
        b=ZC/sVh4MTmTpVP1kvhpWmIrWSWjSSBwEAJG9XlrOOb0NRz6k5LT2SNHthNb89UlcUh
         QqeXxS/u0piR9OSBGSFFjFcDckshdJTn1RncXI921BqZsUrRoH3s9uZxCjhSKQq2Fv3C
         jI5soOPJVkA3qey9iJ55SDXHdhq1h8HvBEl59kZ0BiG/YOpJlQ3SCvrHXYmcRJfMBFZv
         RM7bo9q59YsNKJAwsHY+ls6tI1A0aGzX6yI+eRUyeMG9z91clLoQv9mSVUKcN8f7qWik
         kK85g8AsYz9XqLOOFXLpeovR7J3qvV5gbo0kQPnXX5xNKEI7eezE4w+IVCgf+5rrDJov
         LVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FA4b+JjxXDupd9SJaACVBkhyBnQSOUKDxz41oObhr2A=;
        b=A+pOFV8HcT9Drc7n1v2SqFp6Zjq0lQVry1+2msrDmorasEJe+Vy3AYjRzJs241KywF
         iczVVCLECUGXrl7UlcmrN8yH527cAg3NT7FqMUJ2GrZ+hT60X2un7hOwu3i9tvlOlfFN
         XMZenXL0kOGYVUH3OMKeHO2+CNRW5rQr7S1alsirUOH3N8qZR1aIfMK2B/T4TeiW5AHr
         9frKZv7CBosGk4zdcHXvccz3cEiweKOVUXtxH1/J9UgWHsnRVLo5aH3G+CHyshRWZLM4
         u01opYNyfHO+D6XRngjpRuXI5r/SsH32/NJDDUtD9Sc8CvP1ROSusqa+YpOVZvIT/yq8
         E/Iw==
X-Gm-Message-State: AOAM531RKx2LlGW9aSItVRTfCqjz4DC2Le18XeCPOfbc8eaZXSLlW7U2
        insk2oBcepdDqHKxZcWjNQ6aKw==
X-Google-Smtp-Source: ABdhPJzTEnBVYikmvH85woAsYBoLBjCp854qzeNnPxR3BcmIiM34MKzPsFfbojHoXJFeabAQLwLIMA==
X-Received: by 2002:ac8:36ca:: with SMTP id b10mr2720461qtc.135.1601578892005;
        Thu, 01 Oct 2020 12:01:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4e22])
        by smtp.gmail.com with ESMTPSA id f189sm6932506qkd.20.2020.10.01.12.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 12:01:31 -0700 (PDT)
Date:   Thu, 1 Oct 2020 14:59:50 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v4 1/4] mm: memcontrol: use helpers to access page's
 memcg data
Message-ID: <20201001185950.GB500308@cmpxchg.org>
References: <20201001002710.748166-1-guro@fb.com>
 <20201001002710.748166-2-guro@fb.com>
 <20201001134638.GE469663@cmpxchg.org>
 <20201001182739.GA2706729@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001182739.GA2706729@carbon.DHCP.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 11:27:39AM -0700, Roman Gushchin wrote:
> On Thu, Oct 01, 2020 at 09:46:38AM -0400, Johannes Weiner wrote:
> > On Wed, Sep 30, 2020 at 05:27:07PM -0700, Roman Gushchin wrote:
> > > +/*
> > > + * set_page_memcg - associate a page with a memory cgroup
> > > + * @page: a pointer to the page struct
> > > + * @memcg: a pointer to the memory cgroup
> > > + *
> > > + * Associates a page with a memory cgroup.
> > > + */
> > > +static inline void set_page_memcg(struct page *page, struct mem_cgroup *memcg)
> > > +{
> > > +	VM_BUG_ON_PAGE(PageSlab(page), page);
> > > +
> > > +	/*
> > > +	 * Please, refer to page_memcg()'s description for the page and memcg
> > > +	 * binding stability requirements.
> > > +	 */
> > > +	page->memcg_data = (unsigned long)memcg;
> > > +}
> > 
> > Please delete and inline this as per previous feedback, thanks.
> 
> Why it's better?
> It's ok for set_page_memcg(), but obviously worse for set_page_objcgs():
> it was nice to have all bit magic in one place, in few helper functions.
> And now it spills into several places. What's the win?

set_page_objcgs() is a worthwhile abstraction because it includes the
synchronization primitives that make it safe to use wrt
page_objcgs(). They encapsulate the cmpxchg and the READ_ONCE().

set_page_memcg() doesn't do any synchronization and relies fully on
the contextual locking. The name implies that it includes things to
make it safe wrt page_memcg(), which isn't true at all. It's a long
and misleading name for '='.

Btw, I really don't mind having this discussion, but please don't send
revisions that silently ignore feedback you don't agree with.

Thanks
