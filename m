Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5D42874C2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 15:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgJHNDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 09:03:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:35082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729869AbgJHNDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 09:03:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602162199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vf5Wt7D1zxqCKMXMwmMZy1+71o3Joc/s2siIjasYxzo=;
        b=fq0fVdUR/zXLKe3FNmDTnTvHSKletIxo0s403Kvxk1VF+d8ExVVO9wEu/O0RqOm1nTan0p
        yeVsuCiXZIA2hTpg2e8+kH1YSR8S5WO7j7/JjeVGdVjOA1P1A3LsKZzSikyV9Jgx3mAfOC
        4H+sZrkDR3abEJp6EUp6B/9XJlpH61I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CD31AB011;
        Thu,  8 Oct 2020 13:03:19 +0000 (UTC)
Date:   Thu, 8 Oct 2020 15:03:18 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 3/7] mm, page_alloc: remove setup_pageset()
Message-ID: <20201008130318.GE4967@dhcp22.suse.cz>
References: <20201008114201.18824-1-vbabka@suse.cz>
 <20201008114201.18824-4-vbabka@suse.cz>
 <20201008122309.GB4967@dhcp22.suse.cz>
 <a6d39f3b-3dea-3b97-018a-a53f07155d39@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6d39f3b-3dea-3b97-018a-a53f07155d39@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08-10-20 14:56:13, Vlastimil Babka wrote:
> On 10/8/20 2:23 PM, Michal Hocko wrote:
> > On Thu 08-10-20 13:41:57, Vlastimil Babka wrote:
> > > We initialize boot-time pagesets with setup_pageset(), which sets high and
> > > batch values that effectively disable pcplists.
> > > 
> > > We can remove this wrapper if we just set these values for all pagesets in
> > > pageset_init(). Non-boot pagesets then subsequently update them to the proper
> > > values.
> > > 
> > > No functional change.
> > > 
> > > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > 
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Thanks!
> 
> > Btw. where do we initialize pcp->count? I thought that pcp allocator
> > zeroes out the allocated memory but alloc_percpu is GFP_KERNEL like.
> 
> pageset_init() does:
> memset(p, 0, sizeof(*p))

Ohh, I have missed pcp is embeded into per_cpu_pageset. Using it as s
pointer here confused me. Sorry about the noise.

-- 
Michal Hocko
SUSE Labs
