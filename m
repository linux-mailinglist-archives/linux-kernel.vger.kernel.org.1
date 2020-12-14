Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A012DA2DD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 22:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440029AbgLNVvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 16:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406618AbgLNVvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 16:51:00 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39C4C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 13:50:19 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id 9so13798760oiq.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 13:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=jOxU8kZwhYfdYwRPjwXKdZug7e2Tg+3U90XP5oXdV88=;
        b=OaHrUT9fYU+oAqziL4DHHzFQZ8epAwywU163d2MuFcMg/MfRQz8NereEj4lKumaYC0
         CbIqfGs0dURuxdVZxSUs9h/popHBTuJMLhxuRPVsff1UDpPGIM45gQZznsOJZAh1XV8t
         vYVR/ZzNiK0C6N92iB4JF7e1YDIV1USc36JmOZaEWw5FKH8xdktORJFmhXxTJJtchcJz
         nZv7GoThbNrH7+g+0TEd5Z1haOYyireT0d2LLOpNaxCeE7I1RBitPYJ1ktS881iucm5y
         KbXzcDzHmdqRNiDsQMJc5BbGviVBHdU6zwEyCjRNc0DF2jSb7BX127MlhczV7k9iSfFv
         SoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=jOxU8kZwhYfdYwRPjwXKdZug7e2Tg+3U90XP5oXdV88=;
        b=qywwTnu6PNuMmF0DawI8qnTnw9ias+Rk9FrkF+jzEJNkUJKsv/djyepNpgs5xbq/zn
         3VpP5mDMbbXkqvlE7l9WAz4gIWIOWEliHhLdjBmBkJf3ejA7vlBGrx6W+WdGuOJJBYQY
         aqLxK+K3wjOUuv8cG8CF8zZ2uMhNRNGoh3p9lotJR8t55SR9jeZhSzOsgs7DVPyJgWl7
         r9sFUaqntn8FvXINBDX/HLtnnmIToHtWkzhvMR3rZVxjzgHwVwVw3wthUbiKauLZZSwS
         Z+lsVyxEYzVa1Isn0UvdmDCoN85K8Yy5tJphQrin32PdrbrwTj5FmcekzfddtXXtElpR
         AInQ==
X-Gm-Message-State: AOAM531Nz9MsdT1PzteeeSLYs+imn4VlerX9OgxxU734ngxXNx2hbgDy
        ST+e9WnVjxHOGisVYEgX19yItg==
X-Google-Smtp-Source: ABdhPJy7koPk5qAygFqkOdbXjul3bcFcEBkr9ljx5A5AkGpaXS6AD6SpRRXflYHZJpeiyi8sek7Xkw==
X-Received: by 2002:aca:3dd7:: with SMTP id k206mr19748236oia.134.1607982618989;
        Mon, 14 Dec 2020 13:50:18 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f201sm4345440oig.21.2020.12.14.13.50.17
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 14 Dec 2020 13:50:18 -0800 (PST)
Date:   Mon, 14 Dec 2020 13:50:16 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yu Zhao <yuzhao@google.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] mm: enlarge the "int nr_pages" parameter of
 update_lru_size()
In-Reply-To: <20201207220949.830352-12-yuzhao@google.com>
Message-ID: <alpine.LSU.2.11.2012141317351.1925@eggly.anvils>
References: <20201207220949.830352-1-yuzhao@google.com> <20201207220949.830352-12-yuzhao@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Dec 2020, Yu Zhao wrote:

> update_lru_sizes() defines an unsigned long argument and passes it as
> nr_pages to update_lru_size(). Though this isn't causing any overflows
> I'm aware of, it's a bad idea to go through the demotion given that we
> have recently stumbled on a related type promotion problem fixed by
> commit 2da9f6305f30 ("mm/vmscan: fix NR_ISOLATED_FILE corruption on 64-bit")
> 
> Note that the underlying counters are already in long. This is another
> reason we shouldn't have the demotion.
> 
> This patch enlarges all relevant parameters on the path to the final
> underlying counters:
> 	update_lru_size(int -> long)
> 		if memcg:
> 			__mod_lruvec_state(int -> long)
> 				if smp:
> 					__mod_node_page_state(long)
> 				else:
> 					__mod_node_page_state(int -> long)
> 			__mod_memcg_lruvec_state(int -> long)
> 				__mod_memcg_state(int -> long)
> 		else:
> 			__mod_lruvec_state(int -> long)
> 				if smp:
> 					__mod_node_page_state(long)
> 				else:
> 					__mod_node_page_state(int -> long)
> 
> 		__mod_zone_page_state(long)
> 
> 		if memcg:
> 			mem_cgroup_update_lru_size(int -> long)
> 
> Note that __mod_node_page_state() for the smp case and
> __mod_zone_page_state() already use long. So this change also fixes
> the inconsistency.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>

NAK from me to this 11/11: I'm running happily with your 1-10 on top of
mmotm (I'll review them n a few days, but currently more concerned with
Rik's shmem huge gfp_mask), but had to leave this one out.

You think you are future-proofing with this, but it is present-breaking.

It looks plausible (though seems random: why these particular functions
use long but others not? why __mod_memcg_state() long, mod_memcg_state()
int?), and I was fooled; but fortunately was still testing with memcg
moving, for Alex's patchset.

Soon got stuck waiting in balance_dirty_pages(), /proc/vmstat showing
nr_anon_pages 2263142822377729
nr_mapped 125095217474159
nr_file_pages 225421358649526
nr_dirty 8589934592
nr_writeback 1202590842920
nr_shmem 40501541678768
nr_anon_transparent_hugepages 51539607554

That last (anon THPs) nothing to do with this patch, but illustrates
what Muchun is fixing in his 1/7 "mm: memcontrol: fix NR_ANON_THPS
accounting in charge moving".

The rest of them could be fixed by changing mem_cgroup_move_account()'s
"unsigned int nr_pages" to "long nr_pages" in this patch, but I think
it's safer just to drop the patch: the promotion of "unsigned int" to
"long" does not work as you would like it to.

I see that mm/vmscan.c contains several "unsigned int" counts of pages,
everything works fine at present so far as I know, and those appeared
to work even with your patch; but I am not confident in my test coverage,
and not confident in us being able to outlaw unsigned int page counts in
future.

Hugh
