Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B84A2EA813
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbhAEJ5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:57:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:60876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbhAEJ5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:57:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609840583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QvOYoDvfxGPDWYxvtgGuddRRzjuOX66FxsdlUwuf/7k=;
        b=r+JgTbKMyJUR8zxupmmXMHeSyaBnY09RAVghmxV+yhGjgwYSyVBxnt3B1pB49AAy3ZhN9u
        Qlo5q9IazZJtecwvfprCh9eZIHe7An7vzG4qH7e1WFcAkdAMZMY7Nis6JsIAUrs+7eVpb0
        EnT6NToW5grNyKZ7oIIqGYGT0urBWbw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F16FBAE87;
        Tue,  5 Jan 2021 09:56:22 +0000 (UTC)
Date:   Tue, 5 Jan 2021 10:56:21 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Liang Li <liliangleo@didiglobal.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [RFC v2 PATCH 4/4] mm: pre zero out free pages to speed up page
 allocation for __GFP_ZERO
Message-ID: <20210105095621.GB13207@dhcp22.suse.cz>
References: <a5ba7bdf-8510-d0a0-9c22-ec1b81019982@intel.com>
 <43576DAD-8A3B-4691-8808-90C5FDCF03B7@redhat.com>
 <6bfcc500-7c11-f66a-26ea-e8b8bcc79e28@intel.com>
 <20210105092037.GY13207@dhcp22.suse.cz>
 <71953119-06ff-0bb8-1879-09e24bf80446@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71953119-06ff-0bb8-1879-09e24bf80446@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05-01-21 10:29:45, David Hildenbrand wrote:
> On 05.01.21 10:20, Michal Hocko wrote:
[...]
> > A global knob with all or nothing sounds like an easier to use and
> > maintain solution to me.
> 
> I mean, that brings me back to my original suggestion: just use
> hugetlbfs and implement some sort of pre-zeroing there (worker thread,
> whatsoever). Most vfio users should already be better of using hugepages.

Shifting background zeroying to hugetlb would solve the problem with the
work accounting, right? Somebody has to pay for that work and piggy back
on all other CPU consumers by default is not acceptable even when that
is reduced to hugetlb.
-- 
Michal Hocko
SUSE Labs
