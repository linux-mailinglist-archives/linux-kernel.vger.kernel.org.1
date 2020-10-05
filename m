Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A8528373D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgJEODe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:03:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:53330 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgJEODe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:03:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601906613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xP91B5mqabvjugrhh4GTrezdAi0BDZMCQ4LhVZZrZ5Q=;
        b=kvuk4YYSZMOMTRBH0bfXIeAfp1Zq5BpC5PiY5FAKbgN9x8zM1nJ/jFjmL6bnuRD5l9tIDq
        B28SqUKVJSxi9OhWVTqNBmANuTuAXU50NvIrbcY04GUYbBpE/lz0Q2wM++Tuv/WKvgIiyR
        iRY7zB9R7hUZ6Fd1Bor2f2sMIesHmkM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F5A4AC5F;
        Mon,  5 Oct 2020 14:03:33 +0000 (UTC)
Date:   Mon, 5 Oct 2020 16:03:30 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH 8/9] mm, page_alloc: drain all pcplists during memory
 offline
Message-ID: <20201005140330.GD4555@dhcp22.suse.cz>
References: <20200922143712.12048-1-vbabka@suse.cz>
 <20200922143712.12048-9-vbabka@suse.cz>
 <a247fc08-d2d8-4f09-88e0-2ebbb5f67890@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a247fc08-d2d8-4f09-88e0-2ebbb5f67890@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-09-20 12:46:27, David Hildenbrand wrote:
> On 22.09.20 16:37, Vlastimil Babka wrote:
[...]
> > +/*
> > + * Spill all the per-cpu pages from all CPUs back into the buddy allocator.
> > + *
> > + * When zone parameter is non-NULL, spill just the single zone's pages.
> > + *
> > + * Note that this can be extremely slow as the draining happens in a workqueue.
> > + */
> > +void drain_all_pages(struct zone *zone)
> > +{
> > +	__drain_all_pages(zone, false);
> > +}
> > +
> >  #ifdef CONFIG_HIBERNATION
> >  
> >  /*
> > 
> 
> Interesting race. Instead of this ugly __drain_all_pages() with a
> boolean parameter, can we have two properly named functions to be used
> in !page_alloc.c code without scratching your head what the difference is?

I tend to agree here. I would even fold this into the next patch because
disable/enable interface is much more manageable.

-- 
Michal Hocko
SUSE Labs
