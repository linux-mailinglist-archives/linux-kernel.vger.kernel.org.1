Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9D11C4FBE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 09:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgEEH6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 03:58:35 -0400
Received: from outbound-smtp09.blacknight.com ([46.22.139.14]:43813 "EHLO
        outbound-smtp09.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbgEEH6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 03:58:35 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp09.blacknight.com (Postfix) with ESMTPS id E95FD1C4F39
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:58:33 +0100 (IST)
Received: (qmail 11419 invoked from network); 5 May 2020 07:58:33 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 5 May 2020 07:58:33 -0000
Date:   Tue, 5 May 2020 08:58:31 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Henry Willard <henry.willard@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Limit boost_watermark on small zones.
Message-ID: <20200505075831.GC3758@techsingularity.net>
References: <1588294148-6586-1-git-send-email-henry.willard@oracle.com>
 <20200501155729.a479c4b27f127d9aa866bd8e@linux-foundation.org>
 <20200504124409.GB3758@techsingularity.net>
 <20200504133604.5fd0b0b11b93bb4d9a0fed68@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200504133604.5fd0b0b11b93bb4d9a0fed68@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 01:36:04PM -0700, Andrew Morton wrote:
> On Mon, 4 May 2020 13:44:09 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:
> 
> > On Fri, May 01, 2020 at 03:57:29PM -0700, Andrew Morton wrote:
> > > On Thu, 30 Apr 2020 17:49:08 -0700 Henry Willard <henry.willard@oracle.com> wrote:
> > > 
> > > > Commit 1c30844d2dfe ("mm: reclaim small amounts of memory when an external
> > > > fragmentation event occurs") adds a boost_watermark() function which
> > > > increases the min watermark in a zone by at least pageblock_nr_pages or
> > > > the number of pages in a page block. On Arm64, with 64K pages and 512M
> > > > huge pages, this is 8192 pages or 512M. It does this regardless of the
> > > > number of managed pages managed in the zone or the likelihood of success.
> > > > This can put the zone immediately under water in terms of allocating pages
> > > > from the zone, and can cause a small machine to fail immediately due to
> > > > OoM. Unlike set_recommended_min_free_kbytes(), which substantially
> > > > increases min_free_kbytes and is tied to THP, boost_watermark() can be
> > > > called even if THP is not active. The problem is most likely to appear
> > > > on architectures such as Arm64 where pageblock_nr_pages is very large.
> > > > 
> > > > It is desirable to run the kdump capture kernel in as small a space as
> > > > possible to avoid wasting memory. In some architectures, such as Arm64,
> > > > there are restrictions on where the capture kernel can run, and therefore,
> > > > the space available. A capture kernel running in 768M can fail due to OoM
> > > > immediately after boost_watermark() sets the min in zone DMA32, where
> > > > most of the memory is, to 512M. It fails even though there is over 500M of
> > > > free memory. With boost_watermark() suppressed, the capture kernel can run
> > > > successfully in 448M.
> > > > 
> > > > This patch limits boost_watermark() to boosting a zone's min watermark only
> > > > when there are enough pages that the boost will produce positive results.
> > > > In this case that is estimated to be four times as many pages as
> > > > pageblock_nr_pages.
> > > > 
> > > 
> > ...
> > Acked-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Cool.  I wonder if we should backport this into -stable kernels?  "can
> cause a small machine to fail immediately" sounds serious, but
> 1c30844d2dfe is from December 2018.  Any thoughts?

There is no harm in marking it stable. Clearly it does not happen very
often but it's not impossible. 32-bit x86 is a lot less common now which
would previously have been vulnerable to triggering this easily. ppc64
has a larger base page size but typically only has one zone. arm64 is
likely the most vulnerable, particularly when CMA is configured with a
small movable zone.

-- 
Mel Gorman
SUSE Labs
