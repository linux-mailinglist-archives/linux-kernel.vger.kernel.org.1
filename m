Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088632A946A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgKFKgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:36:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:44804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgKFKf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:35:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604658958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JO9QaKV8QokxL9flHG3B/4fqlGVbc8b4XbTgyRZDSR0=;
        b=rZIVSPh+DJVp6WGxjNkY2MfA2nwZ+Msigbg75QgtsOaNuD6fZxXFYDGlC+lLylv82aHcC7
        8+Z/JAbXmBhh3xRo0s0Y9/ORu8P1f/lZ+cEKD9dfX52sLpi7oY6VZyelPocvbX2lDHFlYM
        WKsq/6rngghwaUUVuSKmcsnEEnr0flU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F734AB8F;
        Fri,  6 Nov 2020 10:35:58 +0000 (UTC)
Date:   Fri, 6 Nov 2020 11:35:57 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, dave.hansen@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] mm: fix OOMs for binding workloads to movable
 zone only node
Message-ID: <20201106103557.GC7247@dhcp22.suse.cz>
References: <20201105120818.GC21348@dhcp22.suse.cz>
 <4029c079-b1f3-f290-26b6-a819c52f5200@suse.cz>
 <20201105125828.GG21348@dhcp22.suse.cz>
 <20201105130710.GB16525@shbuild999.sh.intel.com>
 <20201105131245.GH21348@dhcp22.suse.cz>
 <20201105134305.GA16424@shbuild999.sh.intel.com>
 <20201105161612.GM21348@dhcp22.suse.cz>
 <20201106070656.GA129085@shbuild999.sh.intel.com>
 <20201106081026.GB7247@dhcp22.suse.cz>
 <20201106090857.GB129085@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106090857.GB129085@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 06-11-20 17:08:57, Feng Tang wrote:
[...]
> You are right, there are quiet several types of page allocations failures.
> The callstack in patch 2/2 is a GFP_HIGHUSER from pipe_write, and there
> are more types of kernel allocation requests which will got blocked by
> the differnt  check. My RFC patch just gave a easiest one-for-all hack to
> let them bypass it.
> 
> Do we need to tackle them case by case?

No, I do not think, how we can change those __GFP_HARDWALL without
breaking the isolation.

-- 
Michal Hocko
SUSE Labs
