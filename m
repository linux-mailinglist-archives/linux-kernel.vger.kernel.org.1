Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002092640D2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 11:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgIJJA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 05:00:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:59310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729986AbgIJJAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:00:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9011AEC4;
        Thu, 10 Sep 2020 09:00:39 +0000 (UTC)
Date:   Thu, 10 Sep 2020 11:00:18 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [RFC 2/5] mm, page_alloc: calculate pageset high and batch once
 per zone
Message-ID: <20200910090018.GC2285@linux>
References: <20200907163628.26495-1-vbabka@suse.cz>
 <20200907163628.26495-3-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907163628.26495-3-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 06:36:25PM +0200, Vlastimil Babka wrote:
> We currently call pageset_set_high_and_batch() for each possible cpu,
> which repeats the same calculations of high and batch values.
> 
> Instead call it once per zone, and it applies the calculated values
> to all per-cpu pagesets of the zone.
> 
> This also allows removing zone_pageset_init() and __zone_pcp_update() wrappers.
> 
> No functional change.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

I like this, it simplifies the things.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
