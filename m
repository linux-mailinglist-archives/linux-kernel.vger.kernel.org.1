Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACF02A4625
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 14:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgKCNWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 08:22:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:56308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbgKCNWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:22:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604409742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VeA9Qsqxu1/i14CMSGPPmW3KXKC7b+HEm7qKKl5XDvg=;
        b=Pxo79IfAbvAKkRNNFMbGkHgZWU7zirElkyhd/EpedIl5/ACqkBp91t0MQK0Gwnhw0iiO/G
        zK20Exyj3tPnz68nn91WwrEvThhmjjygMxsW7/Mzw82amVnPx/GxV7zJaHowJCDqpugz9m
        IbwhDG6IGCbT463rGcyFKbt3U2zSqXQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF85DAB0E;
        Tue,  3 Nov 2020 13:22:21 +0000 (UTC)
Date:   Tue, 3 Nov 2020 14:22:21 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Message-ID: <20201103132221.GI21990@dhcp22.suse.cz>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook>
 <20201016145308.GA312010@cmpxchg.org>
 <20201016171502.GA102311@blackbook>
 <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
 <20201020162714.GC46039@blackbook>
 <20201020170717.GA153102@carbon.DHCP.thefacebook.com>
 <20201020181822.GA397401@cmpxchg.org>
 <20201021193322.GA300658@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021193322.GA300658@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am sorry but I was quite busy at the time this has been discussed.
Now that I got to this thread finally I am wondering whether this
resp. other root cgroup exceptions have any follow up.

I have seen the issue is fixed in Linus tree by 8de15e920dc8 ("mm:
memcg: link page counters to root if use_hierarchy is false"). Thanks
for taking care of that! I do agree that this approach is the most
reasonable immediate fix.

Btw. we have been carrying a warning about non hierarchical hierarchies
for years in our distribution kernels and haven't heard of any actual
bug reports (except for LTP driven ones). So we might be really close to
simply drop this functionality completely. This would simplify the code
and prevent from future surprises.

Thanks!
-- 
Michal Hocko
SUSE Labs
