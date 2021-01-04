Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567AA2E954F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 13:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbhADMwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 07:52:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:52650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbhADMwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 07:52:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609764688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FB8hy0U9RwYKVBKY1CojR4FapZx1ziXIahEY9it/cng=;
        b=OuLz91gDvfLpxzWsAlBiGbMZM6Pia2k8ev2LOZsYiMlx1v/WnHaWSHkS+w7rqSmORZG+27
        Wk5cyIHHQhAe/FQQr+pOPXiiFpk5GJFf2bqvFEzghJ5HXjtFwE9Yb6hnSTbHJfXtqtCV7c
        Qj7AjF6aRtoaR5ATecWr5hCzup66iq0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 60094ACAF;
        Mon,  4 Jan 2021 12:51:28 +0000 (UTC)
Date:   Mon, 4 Jan 2021 13:51:22 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Liang Li <liliang324@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Liang Li <liliangleo@didiglobal.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
Message-ID: <20210104125122.GD13207@dhcp22.suse.cz>
References: <20201221162519.GA22504@open-light-1.localdomain>
 <20201222122312.GH874@casper.infradead.org>
 <CA+2MQi8GMLfSFN30G8EEeXXsC5M+Et2oRMnynUp==eRbY0Z2Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+2MQi8GMLfSFN30G8EEeXXsC5M+Et2oRMnynUp==eRbY0Z2Wg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-12-20 22:42:13, Liang Li wrote:
> > > =====================================================
> > > QEMU use 4K pages, THP is off
> > >                   round1      round2      round3
> > > w/o this patch:    23.5s       24.7s       24.6s
> > > w/ this patch:     10.2s       10.3s       11.2s
> > >
> > > QEMU use 4K pages, THP is on
> > >                   round1      round2      round3
> > > w/o this patch:    17.9s       14.8s       14.9s
> > > w/ this patch:     1.9s        1.8s        1.9s
> > > =====================================================
> >
> > The cost of zeroing pages has to be paid somewhere.  You've successfully
> > moved it out of this path that you can measure.  So now you've put it
> > somewhere that you're not measuring.  Why is this a win?
> 
> Win or not depends on its effect. For our case, it solves the issue
> that we faced, so it can be thought as a win for us.  If others don't
> have the issue we faced, the result will be different, maybe they will
> be affected by the side effect of this feature. I think this is your
> concern behind the question. right? I will try to do more tests and
> provide more benchmark performance data.

Yes, zeroying memory does have a noticeable overhead but we cannot
simply allow tasks to spil over this overhead to all other users by
default. So if anything this would need to be an opt-in feature
configurable by administrator.
-- 
Michal Hocko
SUSE Labs
