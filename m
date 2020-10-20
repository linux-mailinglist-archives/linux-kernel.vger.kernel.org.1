Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2C7293AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394139AbgJTMCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:02:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:42070 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394130AbgJTMCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:02:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 01499ABD1;
        Tue, 20 Oct 2020 12:02:37 +0000 (UTC)
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook> <20201016145308.GA312010@cmpxchg.org>
 <20201016171502.GA102311@blackbook>
 <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
 <87k0vlwhzt.fsf@suse.de>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Richard Palethorpe <rpalethorpe@suse.de>
To:     Roman Gushchin <guro@fb.com>
Cc:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>, ltp@lists.linux.it,
        Andrew Morton <akpm@linux-foundation.org>,
        "Shakeel Butt" <shakeelb@google.com>,
        "Christoph Lameter" <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Reply-To: rpalethorpe@suse.de
In-reply-to: <87k0vlwhzt.fsf@suse.de>
Date:   Tue, 20 Oct 2020 13:02:35 +0100
Message-ID: <87h7qpw1es.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Richard Palethorpe <rpalethorpe@suse.de> writes:

> Hello Roman,
>
> Roman Gushchin <guro@fb.com> writes:
>
>> -		page_counter_init(&memcg->memory, NULL);
>> -		page_counter_init(&memcg->swap, NULL);
>> -		page_counter_init(&memcg->kmem, NULL);
>> -		page_counter_init(&memcg->tcpmem, NULL);
>> +		/*
>> +		 * If use_hierarchy == false, consider all page counters direct
>> +		 * descendants of the corresponding root level counters.
>> +		 */
>> +		page_counter_init(&memcg->memory, &root_mem_cgroup->memory);
>> +		page_counter_init(&memcg->swap, &root_mem_cgroup->swap);
>> +		page_counter_init(&memcg->kmem, &root_mem_cgroup->kmem);
>> +		page_counter_init(&memcg->tcpmem, &root_mem_cgroup->tcpmem);
>> +
>>  		/*
>>  		 * Deeper hierachy with use_hierarchy == false doesn't make
>>  		 * much sense so let cgroup subsystem know about this
>
> Perhaps in this case, where the hierarchy is broken, objcgs should also
> be reparented directly to root? Otherwise it will still be possible to
> underflow the counter in a descendant of root which has use_hierarchy=0,
> but also has children.

Sorry ignore me, parent_mem_cgroup already selects root. So in the case
of a broken hierarchy objcgs are reparented directly to root.

-- 
Thank you,
Richard.
