Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD7C2F4AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbhAMMEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:04:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:34892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbhAMMEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:04:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610539402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=12ieSSfl0b2FyOCtz8cA53D36htolHYLrszhHSjuYYc=;
        b=NE4Epht7NIj2h4xRVr+aSXAdG95nDCqZh3OKJYJYcuaeGDSVQc5LEktrafZYEqu1p62/yy
        Z/2F9sZe+8YhQjr7QW2CkV2hlsV0kjJVZkORNyyNxI/YHcCqFvnKOyFJ/1dGJycYn9WaH/
        iRIyO0g0vsRVbnSVkzDSJkv7updxo64=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 79F74AB92;
        Wed, 13 Jan 2021 12:03:22 +0000 (UTC)
Date:   Wed, 13 Jan 2021 13:03:20 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v4 4/6] mm: hugetlb: retry dissolve page
 when hitting race
Message-ID: <20210113120320.GY22493@dhcp22.suse.cz>
References: <20210113052209.75531-1-songmuchun@bytedance.com>
 <20210113052209.75531-5-songmuchun@bytedance.com>
 <20210113093331.GV22493@dhcp22.suse.cz>
 <CAMZfGtUObSSyRZfv8CHucp6WmUZZBupKD9hbNHVpAv_PuWtMhw@mail.gmail.com>
 <20210113103836.GW22493@dhcp22.suse.cz>
 <CAMZfGtUTZZyL6Pdop-SHt2vs2hLuYfB9dumhRHBm7QLzyRNzZA@mail.gmail.com>
 <20210113111449.GA26873@linux>
 <CAMZfGtWn95u2s11MUk33z4MDVec5j4+usRasTqHxRp9Ud73mSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWn95u2s11MUk33z4MDVec5j4+usRasTqHxRp9Ud73mSA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-01-21 19:20:17, Muchun Song wrote:
> On Wed, Jan 13, 2021 at 7:15 PM Oscar Salvador <osalvador@suse.de> wrote:
> >
> > On Wed, Jan 13, 2021 at 07:11:06PM +0800, Muchun Song wrote:
> > > If there is no task to be scheduled. Here is just a while loop.
> > > The cpu_relax is a good thing to insert into busy-wait loops,
> > > right?
> >
> > But if the race window is that small, does it make sense?
> 
> Actually, there is one exception. The race window could
> become larger. If the page is freed via a workqueue (see
> free_huge_page()). In this case, the cpu_relax() can
> make sense. Right?

The system would have to be under serious stress for WQ to clog. I do
not expect there would be nothing runable at that stage. Possible?
Maybe but if that matters than a short sleep would be more preferable
than cpu_relax.
-- 
Michal Hocko
SUSE Labs
