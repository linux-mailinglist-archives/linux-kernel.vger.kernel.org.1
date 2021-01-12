Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10502F2DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbhALLRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:17:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:39480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbhALLRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:17:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A69F5AD1E;
        Tue, 12 Jan 2021 11:17:07 +0000 (UTC)
Date:   Tue, 12 Jan 2021 12:17:05 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        pasha.tatashin@soleen.com
Subject: Re: [PATCH 1/5] mm: Introduce ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
Message-ID: <20210112111700.GA13374@linux>
References: <20201217130758.11565-1-osalvador@suse.de>
 <20201217130758.11565-2-osalvador@suse.de>
 <21932014-3027-8ad9-2140-f63500c641d7@redhat.com>
 <20210112072643.GA10774@linux>
 <feef406c-105c-138a-b8af-345684876e25@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feef406c-105c-138a-b8af-345684876e25@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 11:12:30AM +0100, David Hildenbrand wrote:
> On 12.01.21 08:26, Oscar Salvador wrote:
> > You mean introducing only mm/Kconfig change in this patch, and then
> > arch/*/Kconfig changes in separate patches at the end of the series?
> 
> Yeah, or squashing the leftovers of this patch (3 LOC) into patch #2.

Ok, makes sense.

> > I can certainly do that, not sure how much will help with the review,
> > but it might help when bisecting.
> 
> It's usually nicer to explicitly enable stuff per architecture, stating
> why it works on that architecture (and in the best case, even was
> tested!). :)

Fine by me.
I will prepare another re-spin with that in mind then.

It would be great to have some feedback on patch#2 before that (in case you find
some time ;-).

Thanks!

-- 
Oscar Salvador
SUSE L3
