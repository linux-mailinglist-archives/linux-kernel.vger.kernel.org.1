Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE9929DAA2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390426AbgJ1X00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:26:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389588AbgJ1XYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:24:55 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8354520796;
        Wed, 28 Oct 2020 23:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603927494;
        bh=3KPUgzIkkF0W2XRKkBY1XXDs2/GUZmif85ZAlleYYxI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LXAZb1ANPXyGeaXMGJw5t+bRpesvXgcbXqmwgeMS0exG5msOuTAL45HkoMjlYXpNz
         wAh6aI7zDEpVALdBqWs2lHvEZFySGXOUzgGS4ZkNMKZPxvSZ0bp2qfxuWPw1oAHrPZ
         DNk+kqRps+Wb2izmK3xpWqer6MoeTQYPseKkOEVY=
Date:   Wed, 28 Oct 2020 16:24:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, hannes@cmpxchg.org,
        mm-commits@vger.kernel.org, zhongjiang-ali@linux.alibaba.com
Subject: Re: +
 mm-memcontrol-correct-the-nr_anon_thps-counter-of-hierarchical-memcg-fix.patch
 added to -mm tree
Message-Id: <20201028162453.530ab33e20b3722a367b8b9a@linux-foundation.org>
In-Reply-To: <20201027072157.GO20500@dhcp22.suse.cz>
References: <20201026210801.n9JtTzchy%akpm@linux-foundation.org>
        <20201027072157.GO20500@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Oct 2020 08:21:57 +0100 Michal Hocko <mhocko@suse.com> wrote:

> > --- a/mm/memcontrol.c~mm-memcontrol-correct-the-nr_anon_thps-counter-of-hierarchical-memcg-fix
> > +++ a/mm/memcontrol.c
> > @@ -4107,7 +4107,7 @@ static int memcg_stat_show(struct seq_fi
> >  		if (memcg1_stats[i] == NR_ANON_THPS)
> >  			nr *= HPAGE_PMD_NR;
> >  #endif
> > -		seq_printf(m, "total_%s %llu\n", memcg1_stat_names[i],
> > +		seq_printf(m, "total_%s %lu\n", memcg1_stat_names[i],
> >  						nr * PAGE_SIZE);
> 
> Shouldn't we cast to u64 instead? 32b systems with a lot of memory are
> quite rare but going over 4G here is not something unimaginable. The
> similar is true for other counters.

Sure..

--- a/mm/memcontrol.c~mm-memcontrol-correct-the-nr_anon_thps-counter-of-hierarchical-memcg-fix-fix
+++ a/mm/memcontrol.c
@@ -4119,8 +4119,8 @@ static int memcg_stat_show(struct seq_fi
 		if (memcg1_stats[i] == NR_ANON_THPS)
 			nr *= HPAGE_PMD_NR;
 #endif
-		seq_printf(m, "total_%s %lu\n", memcg1_stat_names[i],
-						nr * PAGE_SIZE);
+		seq_printf(m, "total_%s %llu\n", memcg1_stat_names[i],
+						(u64)nr * PAGE_SIZE);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
_

