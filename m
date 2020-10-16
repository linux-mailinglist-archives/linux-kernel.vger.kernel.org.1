Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385BC28FDAA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 07:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388836AbgJPFlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 01:41:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:55714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732871AbgJPFlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 01:41:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B9BECADC2;
        Fri, 16 Oct 2020 05:40:58 +0000 (UTC)
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201014200833.GA19363@carbon.lan>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Richard Palethorpe <rpalethorpe@suse.de>
To:     Roman Gushchin <guro@fb.com>
Cc:     ltp@lists.linux.it, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Christoph Lameter" <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Reply-To: rpalethorpe@suse.de
In-reply-to: <20201014200833.GA19363@carbon.lan>
Date:   Fri, 16 Oct 2020 06:40:57 +0100
Message-ID: <87v9fasp7a.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roman,

Roman Gushchin <guro@fb.com> writes:

> Hi Richard!
>
>> SLAB objects which outlive their memcg are moved to their parent
>> memcg where they may be uncharged. However if they are moved to the
>> root memcg, uncharging will result in negative page counter values as
>> root has no page counters.
>> 
>> To prevent this, we check whether we are about to uncharge the root
>> memcg and skip it if we are. Possibly instead; the obj_cgroups should
>> be removed from their slabs and any per cpu stocks instead of
>> reparenting them to root?
>
> It would be really complex. I think your fix is totally fine.
> We have similar checks in cancel_charge(), uncharge_batch(),
> mem_cgroup_swapout(), mem_cgroup_uncharge_swap() etc.
>
>
> Acked-by: Roman Gushchin <guro@fb.com>
>
> Thanks!

Great I will respin.

-- 
Thank you,
Richard.
