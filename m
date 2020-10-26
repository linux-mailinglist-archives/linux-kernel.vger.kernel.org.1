Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23B7299C76
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410355AbgJZX7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:59:13 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:13105 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404516AbgJZX7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:59:11 -0400
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9762ce0000>; Tue, 27 Oct 2020 07:59:10 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 23:59:10 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 26 Oct 2020 23:59:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpbTM169MJNAx26lZqpvhlZhIl1OGv/jAFhOng5txp7ykVW60l/TzTCFh6mpx70nBxow96TgdP4leTvlhAfJbepJ0JbfmIvaMW6TgSD0GVswdq8v3Ork1hUhwzG3lAZwHTk62UvXP7CapzD/hwe8kvzc8YSaIppeJMmKI3ZJvzSZthbJ9W/Kn/L3tAs/w+V6PEzpUZEcS6yxq9SPji4VKCBNou1IShOqLNBwqQ4+gS8YWW3RMFXkgX06KW1s/B/wsCeWPaZ0VkMvaLpF10RLneCZyJBSIqtDKjQbZWTOc2VFF7bKJtxlZGJK+TJ6LF1JQEqQrK5hFk6YDgQbXN283Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0G2MtcEyKqDowZPRjXkL9Xo5WtQtV8ZJaFSxUo6t9Zg=;
 b=PuR8XHuPmK6LiZV0gU0LPuVfffj3JE8HQTPLgODi92MH7a06LXNmPUHPzN4APBVwAEC8+20NOl7yP07lVbh7D7/oZOo2JBQ4aXkHVgKcdE14lbv0cRH5PyuP804JAfeehYKBUqVsUrsS6VEt26NF6zPgKLjNi66IO2OkhKws4qnTp1s/FC5D0tVmdCd80TFvuV/0MslP+zyxv8n+FKcEnVrQoP5781KAfdSfCusgT3o1bVI3aZLwScTr0ofMjfqR+/8zyuaDB1Y2T5+dOOtdXAIXzofxRol80Od1LvvPDGLWtj5GNzrsWtFTGVcj8FghUfLd1h4YSABBiPOWdDIblg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Mon, 26 Oct
 2020 23:59:05 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 23:59:05 +0000
Date:   Mon, 26 Oct 2020 20:59:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
CC:     <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 1/2] mm: reorganize internal_get_user_pages_fast()
Message-ID: <20201026235903.GE1523783@nvidia.com>
References: <1-v1-281e425c752f+2df-gup_fork_jgg@nvidia.com>
 <16c50bb0-431d-5bfb-7b80-a8af0b4da90f@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <16c50bb0-431d-5bfb-7b80-a8af0b4da90f@nvidia.com>
X-ClientProxiedBy: YTBPR01CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::49) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTBPR01CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 23:59:05 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXCOF-00958G-OB; Mon, 26 Oct 2020 20:59:03 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603756750; bh=0G2MtcEyKqDowZPRjXkL9Xo5WtQtV8ZJaFSxUo6t9Zg=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=YB25exIyAL+YAPKP7yj154gTGRS2pmOJB+2EbNMUvuBicq9xzuxiLEQWM/AXIA2qs
         fiV5QxFtNSEu7a1QJdKWgJtE5hXjqFhtJx4LXh0U07R+57TsEb9HvKEIpuhVMLbcA9
         /xmV5Uak31mcgCoaQZ/3SeTd/CkqOfT3pKnJkgh1jQnvAos7RE55hwCxIcDCIC9zBc
         fI1bT26a+U5C9x/MbkocNLBlhMMlGl/eyi53TgH85spMxC4BicaNbXzLueHJB6+vpg
         wLnHkVpOR9YXNh4oaW9TR7+JlckQROz/iCUsj0cVbB5QMGVvFjn9BvFvDJFyiZVB84
         Jur+Vpb0chEqw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 09:44:17PM -0700, John Hubbard wrote:
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> >   mm/gup.c | 88 +++++++++++++++++++++++++++++---------------------------
> >   1 file changed, 46 insertions(+), 42 deletions(-)
> > 
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 102877ed77a4b4..ecbe1639ea2af7 100644
> > +++ b/mm/gup.c
> > @@ -2671,13 +2671,42 @@ static int __gup_longterm_unlocked(unsigned long start, int nr_pages,
> >   	return ret;
> >   }
> > +static unsigned int lockless_pages_from_mm(unsigned long addr,
> 
> It would be slightly more consistent to use "start" here, too, instead of addr.
> 
> Separately, I'm not joyful about the change to unsigned int for the
> return type. I understand why you did it and that's perfectly sound
> reasoning: there is no -ERRNO possible here, and nr_pinned will always
> be >=0. And it's correct, although it does have a type mismatch in the
> return value.

I did it because I had to check that ignoring a negative return or
doing some wonky negative arithmetic wasn't some sneaky beahvior. It
isn't, the value is really unsigned. So I documented it to save the
next person this work.

I think the proper response is to ultimately change the
gup_pgd_range() call tree to take the unsigned as well.

> a) change all the nr_pages and nr_pinned throughout, to "long", or
> 
> b) change all the nr_pages and nr_pinned all function args, and use int
> return types throughout, as a "O or -ERRNO, only" return value
> convention.

The gup_pgd_range() this stuff largely does return

I think gup_pgd_range() works as it does due to 
 
> > +	start += (unsigned long)nr_pinned << PAGE_SHIFT;
> > +	pages += nr_pinned;
> > +	ret = __gup_longterm_unlocked(start, nr_pages - nr_pinned, gup_flags,
> > +				      pages);
> > +	if (ret < 0) {
> >   		/* Have to be a bit careful with return values */
> 
> ...and can we move that comment up one level, so that it reads:
> 
> 	/* Have to be a bit careful with return values */
> 	if (ret < 0) {
> 		if (nr_pinned)
> 			return nr_pinned;
> 		return ret;
> 	}
> 	return ret + nr_pinned;

I actually deliberately put it inside the if because there is nothing
tricky about ret < 0, that is basically perfectly normal. It is only
the logic to drop the error code sometimes that is tricky..

> Thinking about this longer term, it would be nice if the whole gup/pup API
> set just stopped pretending that anyone cares about partial success, because
> they *don't*. If we had return values of "0 or -ERRNO" throughout, and an
> additional set of API wrappers that did some sort of limited retry just like
> some of the callers do, that would be a happier story.

It seems like a good idea to me

I'll get the other notes in a v2

Thanks,
Jason
