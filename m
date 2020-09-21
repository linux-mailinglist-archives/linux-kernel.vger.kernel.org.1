Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493A9272AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgIUQFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:05:40 -0400
Received: from outbound-smtp32.blacknight.com ([81.17.249.64]:40961 "EHLO
        outbound-smtp32.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726395AbgIUQFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:05:40 -0400
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 12:05:39 EDT
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp32.blacknight.com (Postfix) with ESMTPS id C5F66BEB91
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 16:58:38 +0100 (IST)
Received: (qmail 27922 invoked from network); 21 Sep 2020 15:58:38 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.127])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Sep 2020 15:58:38 -0000
Date:   Mon, 21 Sep 2020 16:58:37 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     mateusznosek0@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [RFC PATCH] mm/page_alloc.c: clean code by merging two functions
Message-ID: <20200921155837.GH3179@techsingularity.net>
References: <20200916110118.6537-1-mateusznosek0@gmail.com>
 <20200921123607.GT2142832@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200921123607.GT2142832@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 03:36:07PM +0300, Mike Rapoport wrote:
> Hi,
> 
> (added Mel)
> 
> On Wed, Sep 16, 2020 at 01:01:18PM +0200, mateusznosek0@gmail.com wrote:
> > From: Mateusz Nosek <mateusznosek0@gmail.com>
> > 
> > The 'finalise_ac' function is just 'epilogue' for 'prepare_alloc_pages'.
> > Therefore there is no need to keep them both so 'finalise_ac' content can
> > be merged into 'prepare_alloc_pages' code. It would make
> > '__alloc_pages_nodemask' cleaner when it comes to readability.
> 
> These functions were split from alloc_pages_nodemask() by commit
> 9cd7555875bb ("mm, page_alloc: split alloc_pages_nodemask()"), so at the
> very least I'd add Mel to 'cc. 
> 

The changelog explains the intent. At the time, there was demand for a
bulk page allocator for networking support and one was prototyped
https://lore.kernel.org/lkml/20170109163518.6001-5-mgorman@techsingularity.net/
but the networking side to consume the interface was never finished.

-- 
Mel Gorman
SUSE Labs
