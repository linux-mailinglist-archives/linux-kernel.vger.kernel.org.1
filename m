Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13304278FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 19:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgIYRky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 13:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgIYRky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 13:40:54 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28738C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 10:40:54 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g3so2579853qtq.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 10:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cDIBTX4j1F4RBBZXKBGzNC8LUyQ83Ku16jkTShBNc8M=;
        b=SdHhC+1L75vQLuFjPi0R7p76vnAEm6IIVGwly35puSHubrJQiOSaJhY6X+RVAhFYri
         m3y4Y5lvOmkZvpKj6IlYy0IHlp5cGcnYed8jNT7ESi2R2I0tnviJjj++1CtWUltI5whF
         uhK5BLNUH6rlA2A/oSeYGlAmUdLLJY7vgZCzi4cl1Eb+N0PCYjBOAyKI3xjvPzwz1lsz
         kXS0j54/jIPcQu3eUtHi/VkcGMV32M+GDF1D8YJVRuOqZUC0XlLAwutBM6MztOWt5KYF
         OQIoNU4lnfDfi7y7pkewZgGKH97bpOd4uketEzYYDgmm8smsQOSXaR7smkpHON0S2eXA
         op9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cDIBTX4j1F4RBBZXKBGzNC8LUyQ83Ku16jkTShBNc8M=;
        b=iDJs39On6uF4sW8Qh1BOAJwi9B9ej1Jsd3os8DBC36TE+g0CqIDvpZVnSDsQMa8jcd
         fjufldKp1PuLbRucp071pSRI14lULrgQUQbpiN92U90jMnpt8MmxRmyby5QnKTJCsREy
         vjxkHAL8R04nQT18drJ4vjxi8ZiebdmXSBx8whawaTWumsICwlTyt7vFCb/IQfySVGM+
         vPLuIUN1JD84d2bndd5UDLXR/vCcYtJLttC9GCOKxKfgVZu7MML4b70a1uqztoGJFjeS
         IYRHG04oVe4Idro/WgwEdxlr/ukxKNrx25EZeoaWUCJrmLkMO5V0prTyocvJA47VQ3i+
         LGiw==
X-Gm-Message-State: AOAM5300hmGMIwgqgx/mdLw0NVRzSw4VHw/0VYW+z39070RVAY+RRhyB
        z+pBoWcHsbpX41qelzuqKp9KKQ==
X-Google-Smtp-Source: ABdhPJxhUp/b1vrWysEHm3BS09RNw+0LsEk944KXsGbzuwrjVzQf8yiMKX2egcYDFqV8v/s1Be5foA==
X-Received: by 2002:ac8:4806:: with SMTP id g6mr735265qtq.380.1601055653290;
        Fri, 25 Sep 2020 10:40:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:6423])
        by smtp.gmail.com with ESMTPSA id g18sm2292983qtu.69.2020.09.25.10.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 10:40:52 -0700 (PDT)
Date:   Fri, 25 Sep 2020 13:39:19 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v1 1/4] mm: memcontrol: use helpers to access page's
 memcg data
Message-ID: <20200925173919.GA362187@cmpxchg.org>
References: <20200922203700.2879671-1-guro@fb.com>
 <20200922203700.2879671-2-guro@fb.com>
 <20200924194508.GA329853@cmpxchg.org>
 <20200924202700.GB1899519@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924202700.GB1899519@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 01:27:00PM -0700, Roman Gushchin wrote:
> On Thu, Sep 24, 2020 at 03:45:08PM -0400, Johannes Weiner wrote:
> > On Tue, Sep 22, 2020 at 01:36:57PM -0700, Roman Gushchin wrote:
> > > Currently there are many open-coded reads and writes of the
> > > page->mem_cgroup pointer, as well as a couple of read helpers,
> > > which are barely used.
> > > 
> > > It creates an obstacle on a way to reuse some bits of the pointer
> > > for storing additional bits of information. In fact, we already do
> > > this for slab pages, where the last bit indicates that a pointer has
> > > an attached vector of objcg pointers instead of a regular memcg
> > > pointer.
> > > 
> > > This commits introduces 4 new helper functions and converts all
> > > raw accesses to page->mem_cgroup to calls of these helpers:
> > >   struct mem_cgroup *page_mem_cgroup(struct page *page);
> > >   struct mem_cgroup *page_mem_cgroup_check(struct page *page);
> > >   void set_page_mem_cgroup(struct page *page, struct mem_cgroup *memcg);
> > >   void clear_page_mem_cgroup(struct page *page);
> > 
> > Sounds reasonable to me!
> > 
> > > page_mem_cgroup_check() is intended to be used in cases when the page
> > > can be a slab page and have a memcg pointer pointing at objcg vector.
> > > It does check the lowest bit, and if set, returns NULL.
> > > page_mem_cgroup() contains a VM_BUG_ON_PAGE() check for the page not
> > > being a slab page. So do set_page_mem_cgroup() and clear_page_mem_cgroup().
> > > 
> > > To make sure nobody uses a direct access, struct page's
> > > mem_cgroup/obj_cgroups is converted to unsigned long memcg_data.
> > > Only new helpers and a couple of slab-accounting related functions
> > > access this field directly.
> > > 
> > > page_memcg() and page_memcg_rcu() helpers defined in mm.h are removed.
> > > New page_mem_cgroup() is a direct analog of page_memcg(), while
> > > page_memcg_rcu() has a single call site in a small rcu-read-lock
> > > section, so it's just not worth it to have a separate helper. So
> > > it's replaced with page_mem_cgroup() too.
> > 
> > page_memcg_rcu() does READ_ONCE(). We need to keep that for lockless
> > accesses.
> 
> Ok, how about page_memcg() and page_objcgs() which always do READ_ONCE()?
> Because page_memcg_rcu() has only a single call site, I would prefer to
> have one helper instead of two.

Well, page_objcgs() needs it everywhere because the pointer changes
locklessly, so that makes sense to me.

For page_memcg(), I'll have to NAK that approach. It's not justified
to impose ordering cost on a hundred callers that don't need it. And
it muddies the serialization rules of the interface.

> > > @@ -2956,8 +2935,14 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
> > >  		return NULL;
> > >  	}
> > >  
> > > -	/* All other pages use page->mem_cgroup */
> > > -	return page->mem_cgroup;
> > > +	/*
> > > +	 * page_mem_cgroup_check() is used here, because page_has_obj_cgroups()
> > > +	 * check above could fail because the object cgroups vector wasn't set
> > > +	 * at that moment, but it can be set concurrently.
> > > +	 * page_mem_cgroup_check(page) will guarantee tat a proper memory
> > > +	 * cgroup pointer or NULL will be returned.
> > > +	 */
> > > +	return page_mem_cgroup_check(page);
> > 
> > The code right now doesn't look quite safe. As per above, without the
> > READ_ONCE the compiler might issue multiple loads and we may get a
> > pointer with the low bit set.
> > 
> > Maybe slightly off-topic, but what are "all other pages" in general?
> > I don't see any callsites that ask for ownership on objects whose
> > backing pages may belong to a single memcg. That wouldn't seem to make
> > too much sense. Unless I'm missing something, this function should
> > probably tighten up its scope a bit and only work on stuff that is
> > actually following the obj_cgroup protocol.
> 
> Kernel stacks can be slabs or generic pages/vmallocs. Also large kmallocs
> are using the page allocator, so they don't follow the objcg protocol.

Ah, that's super valuable information! Instead of deleting the "all
other pages" comment, could you please elaborate on it?

Thanks!
