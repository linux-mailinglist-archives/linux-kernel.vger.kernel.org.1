Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CE82F4A02
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbhAMLWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:22:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:41494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbhAMLWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:22:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610536923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BERZzqS3AsWI9fkOEv6JI4kHq6LvsjxZvila2Ua7qOA=;
        b=fDRKWR84ed7mn2oLjc1fpmb+rNDnDvgFN1pzXTSpqgPd3HlHhfK8vdPNjg4Ga9xLU96GrS
        0P9OZ4BnjIUQUdYsN/bNs2MDVA33Yw62HKteSLs/ZlqEjYnOjurK2oBG8qvN/VIjcYMWmP
        pB73oTqIPRGTWVeYzi956G9dkLIvl0s=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E52ECAB92;
        Wed, 13 Jan 2021 11:22:02 +0000 (UTC)
Date:   Wed, 13 Jan 2021 12:22:01 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v4 4/6] mm: hugetlb: retry dissolve page
 when hitting race
Message-ID: <20210113112201.GX22493@dhcp22.suse.cz>
References: <20210113052209.75531-1-songmuchun@bytedance.com>
 <20210113052209.75531-5-songmuchun@bytedance.com>
 <20210113093331.GV22493@dhcp22.suse.cz>
 <CAMZfGtUObSSyRZfv8CHucp6WmUZZBupKD9hbNHVpAv_PuWtMhw@mail.gmail.com>
 <20210113103836.GW22493@dhcp22.suse.cz>
 <CAMZfGtUTZZyL6Pdop-SHt2vs2hLuYfB9dumhRHBm7QLzyRNzZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtUTZZyL6Pdop-SHt2vs2hLuYfB9dumhRHBm7QLzyRNzZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-01-21 19:11:06, Muchun Song wrote:
> On Wed, Jan 13, 2021 at 6:38 PM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > > I just want the fix patch to be small enough.
> > > So I do the retry in this patch. If you do not agree with this. I
> > > will fold this into the previous patch.
> > >
> > > Do you mean this?
> > >
> > > cpu_relax();
> > > cond_resched();
> > > cpu_relax();
> >
> > No, I am questiong the use of cpu_relax. What is the point?
> 
> If there is no task to be scheduled. Here is just a while loop.
> The cpu_relax is a good thing to insert into busy-wait loops,
> right?

Well in an ideal world we would simply have a way to block and wait for
the particular page. This is probably an overkill for a rare event like
this. And while you are right that theoretically there might be nobody
else to run but I find it rather unlikely considering that this path is
racing with somebody. Sure there is even less likely possibility that
the race is actually waiting for worker context but really I would just
make it simple retry loop. If we ever hit a real busy loop then this
would be pretty straightforward to spot and fix up.

It's not like I am against the patch with cpu_relax but I find it
excessive for this purpose. If you feel strongly then just keep it.

Once the two patches are squashed I will ack it.
-- 
Michal Hocko
SUSE Labs
