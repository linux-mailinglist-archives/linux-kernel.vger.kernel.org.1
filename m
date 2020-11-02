Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE79F2A2D37
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgKBOo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgKBOo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:44:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A7DC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LAIhWQkbEQ84z1rg6f9nPHULGOV+ks+CCN5U2ajICqs=; b=e0ip68zaNrPteHrhWIOl5+jLot
        a30V0TtxffodM6dQWHkJ1PvhuSZVZRyixvD+OdL5BtSKd4lTerkUbmvmpSrWVYzwfsbEN40OwSYu4
        jjAVn8feDYdIs7yS0G4zsqNo5kom/t2fHQwr/W/5Ybo8TWn0Wwkuw+GzL0A4Bb8Ihp0U01jaf7Sdn
        W46Zhn9Oa+HliKtVaR45F5C80wwpYCrrFadfATcAtzlUoPHjTEsGEFEaQ5agi17bjiVqcWzSaFCf5
        Uc1t2uaUzHHv5e30GhlxmI1HCuZb5IwON8qbDeHHQo4pgfHH+VJQ/PCNr32SPJfXoDuq0iRZsA4cS
        g/Q1K2tQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZb4j-0007IO-M6; Mon, 02 Nov 2020 14:44:49 +0000
Date:   Mon, 2 Nov 2020 14:44:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Increasing CMA Utilization with a GFP Flag
Message-ID: <20201102144449.GM27442@casper.infradead.org>
References: <cover.1604282969.git.cgoldswo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1604282969.git.cgoldswo@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:39:20AM -0800, Chris Goldsworthy wrote:
> The current approach to increasing CMA utilization introduced in
> commit 16867664936e ("mm,page_alloc,cma: conditionally prefer cma
> pageblocks for movable allocations") increases CMA utilization by
> redirecting MIGRATE_MOVABLE allocations to a CMA region, when
> greater than half of the free pages in a given zone are CMA pages.
> The issue in this approach is that allocations with type
> MIGRATE_MOVABLE can still succumb to pinning. To get around
> this, one approach is to re-direct allocations to the CMA areas, that
> are known not to be victims of pinning.
> 
> To this end, this series brings in __GFP_CMA, which we mark with
> allocations that we know are safe to be redirected to a CMA area.

This feels backwards to me.  What you're essentially saying is "Some
allocations marked with GFP_MOVABLE turn out not to be movable, so we're
going to add another GFP_REALLY_MOVABLE flag" instead of tracking down
which GFP_MOVABLE allocations aren't really movable.

