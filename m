Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DAF279012
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 20:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbgIYSJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 14:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgIYSJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 14:09:33 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D24C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 11:09:32 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q5so3726508qkc.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wa9gWLx8z4A2Sdz4YX5ym9IbFeWjmAsR60a/YwhrF7g=;
        b=YwqbC9lPy36VZWkKl+K8aVGMJIBi1EI+wnp/laEjsdhzwamlwgXBtcYaBq207t/YkN
         O1kpjl5Umv897XlWSCzI8KDyqETPiyB3/woECIyysL2MYsrgihufs0yPtVaP34zwhzb9
         hBHmLwXV3E2Q0EXbmz64ep+2P70dhdRVZdiHvc96Mr//knUp+EyHal2p0ov6Qng7hTBu
         3+aGOtizgFi05EPrYm+CHzFyCWm/G1JPojWihtVPw1Rbbt3p34pVQy/DxxBVlHpV+jYJ
         ncI3ORDBdDt870ca85FaNOZsGZpSkITH0GlcjaGUdW+dD09pcJxqeVse6ddpBKut4QFc
         aXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wa9gWLx8z4A2Sdz4YX5ym9IbFeWjmAsR60a/YwhrF7g=;
        b=oMZGnSFpXnK0bPp335Z8K7LYdpzHiz+2KbvDy7oozYqA0S/ojsrLmFvFbg6/18FOpj
         ADUhOnMA6zSoJr0VAG3+xZET1Nyg3AFSrYc9MlHIK5lsYfakhYdypZfMPFJee2MG3mQt
         lm7kGY3lNYCOCTiFvZGNC0XSGNCCSFnLuE+evu2AkfWfLhWC8idQ4AToZTET2p2C/wbH
         L49qMpNdBfVgX54oK9iqJFzd/7N6vw5OclWVZjW7iL11e9xTSl+iL2AmAO5yg9uJWo3o
         bApmBycQb0vVSASw3GXG3s1pA8pA/EZn0gdI3H+PqcgO0XZGSEXt07Q9E5hvWeGhYnvt
         ddBg==
X-Gm-Message-State: AOAM531deatlYGefFoPbMwOg3JTrSm0iOZTC4c40i69SOWKXUgbf4xk/
        hC7qMvNiyN8YmAcKDRQjiTOFiw==
X-Google-Smtp-Source: ABdhPJwqUx1fk0fsqTKbsJfr9GkWo66OhRQUzkuYvej53ZH02a7apfdzcG2VGQfp/ZOKxMtMrY25ww==
X-Received: by 2002:a37:e53:: with SMTP id 80mr1165768qko.243.1601057371751;
        Fri, 25 Sep 2020 11:09:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:6423])
        by smtp.gmail.com with ESMTPSA id g18sm2348430qtu.69.2020.09.25.11.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 11:09:31 -0700 (PDT)
Date:   Fri, 25 Sep 2020 14:07:57 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v1 3/4] mm: introduce page memcg flags
Message-ID: <20200925180757.GB362187@cmpxchg.org>
References: <20200922203700.2879671-1-guro@fb.com>
 <20200922203700.2879671-4-guro@fb.com>
 <20200924200122.GC329853@cmpxchg.org>
 <20200924203905.GD1899519@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924203905.GD1899519@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 01:39:05PM -0700, Roman Gushchin wrote:
> On Thu, Sep 24, 2020 at 04:01:22PM -0400, Johannes Weiner wrote:
> > On Tue, Sep 22, 2020 at 01:36:59PM -0700, Roman Gushchin wrote:
> > > The lowest bit in page->memcg_data is used to distinguish between
> > > struct memory_cgroup pointer and a pointer to a objcgs array.
> > > All checks and modifications of this bit are open-coded.
> > > 
> > > Let's formalize it using page memcg flags, defined in page_memcg_flags
> > > enum and replace all open-coded accesses with test_bit()/__set_bit().
> > > 
> > > Few additional flags might be added later. Flags are intended to be
> > > mutually exclusive.
> > > 
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > ---
> > >  include/linux/memcontrol.h | 29 +++++++++++++++++++----------
> > >  1 file changed, 19 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index ab3ea3e90583..9a49f1e1c0c7 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -343,6 +343,11 @@ struct mem_cgroup {
> > >  
> > >  extern struct mem_cgroup *root_mem_cgroup;
> > >  
> > > +enum page_memcg_flags {
> > > +	/* page->memcg_data is a pointer to an objcgs vector */
> > > +	PG_MEMCG_OBJ_CGROUPS,
> > 
> > How about enum memcg_data_flags and PGMEMCG_OBJCG?
> 
> Honestly I prefer the original names. I'm ok with enum memcg_data_flags,
> if you prefer it. PGMEMCG_OBJCG looks bulky with too many letters
> without a separator, also we use object cgroups (plural) everywhere,
> like OBJCGS vs OBJCG. PG_MEMCG_OBJCGS works for me.

Fair enough, it's a bit dense.

MEMCG_DATA_OBJCGS could work too. It wouldn't introduce a new prefix
and would relate to the field those flags belong to.

> > > @@ -371,13 +376,7 @@ static inline struct mem_cgroup *page_mem_cgroup_check(struct page *page)
> > >  {
> > >  	unsigned long memcg_data = page->memcg_data;
> > >  
> > > -	/*
> > > -	 * The lowest bit set means that memcg isn't a valid
> > > -	 * memcg pointer, but a obj_cgroups pointer.
> > > -	 * In this case the page is shared and doesn't belong
> > > -	 * to any specific memory cgroup.
> > > -	 */
> > > -	if (memcg_data & 0x1UL)
> > > +	if (test_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data))
> > >  		return NULL;
> > >  
> > >  	return (struct mem_cgroup *)memcg_data;
> > > @@ -422,7 +421,13 @@ static inline void clear_page_mem_cgroup(struct page *page)
> > >   */
> > >  static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
> > >  {
> > > -	return (struct obj_cgroup **)(page->memcg_data & ~0x1UL);
> > > +	unsigned long memcg_data = page->memcg_data;
> > > +
> > > +	VM_BUG_ON_PAGE(memcg_data && !test_bit(PG_MEMCG_OBJ_CGROUPS,
> > > +					       &memcg_data), page);
> > > +	__clear_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data);
> > 
> > The flag names make sense to me, but this shouldn't be using test_bit,
> > __clear_bit, __set_bit etc. on local variables. It suggests that it's
> > modifying some shared/global state, when it's just masking out a bit
> > during a read. We usually just open-code the bitwise ops for that.
> 
> It will be way more bulky otherwise, all those memcg_data & (1UL << PG_MEMCG_OBJ_CGROUPS) etc.

Does anybody need the bit numbers? You can make them masks directly:

enum memcg_data_flags {
	MEMCG_DATA_OBJCGS	= (1 << 0),
	...
}

and do memcg_data | MEMCG_DATA_OBJCGS.

cgroup-defs.h alone has 3 examples of this. It's very common.

> I don't see why these bitops helpers can't be used on local variables.
> Is the preference to not use them this way documented anywhere?

The bitops are for shared state, that's why set_bit(), clear_bit(),
test_bit() provide atomicity, and the __ versions of them usually
indicate that outside locking is provided.

Grep for __clear_bit() and most of the time it's on a shared data
structure and surrounded by some sort of lock or atomic context.

Why would you want to replace a single | expression with an RMW
transaction involving three statements and a function call to
__set_bit()?
