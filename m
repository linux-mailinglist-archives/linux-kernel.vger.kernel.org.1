Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA982EBA38
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 07:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbhAFGvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 01:51:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbhAFGvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 01:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609915786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mpnSCXynfZDg9JxezxrI3YVJuV9OmtsTh1Ys0ZNSFcs=;
        b=GHTiqaFdu19lIuNdyyGZZXf5wmHZvRSMEQR1gqx7ri/5Q/iowHLbf0R1gaEQuT09zbBm4F
        UwgrPgdWuvIvvn0vsp2/MtJFL82CvkBRqi6B9ZOTwbh4GzqqF2UK363gEIQ3MbGP7FIRIc
        sw3AqU9syOJ5i9hLEfTLQWAczhQ1KaM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-zZL9C3A1ND6CFuicSxuRDQ-1; Wed, 06 Jan 2021 01:49:40 -0500
X-MC-Unique: zZL9C3A1ND6CFuicSxuRDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC6798015C3;
        Wed,  6 Jan 2021 06:49:38 +0000 (UTC)
Received: from localhost (ovpn-12-186.pek2.redhat.com [10.72.12.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E46805D9CD;
        Wed,  6 Jan 2021 06:49:37 +0000 (UTC)
Date:   Wed, 6 Jan 2021 14:49:35 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Hui Su <sh_def@163.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/memcontrol: fix warning in mem_cgroup_page_lruvec()
Message-ID: <20210106064935.GA3338@MiWiFi-R3L-srv>
References: <alpine.LSU.2.11.2101032056260.1093@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2101032056260.1093@eggly.anvils>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/21 at 09:03pm, Hugh Dickins wrote:
> Boot a CONFIG_MEMCG=y kernel with "cgroup_disabled=memory" and you are
> met by a series of warnings from the VM_WARN_ON_ONCE_PAGE(!memcg, page)
> recently added to the inline mem_cgroup_page_lruvec().
> 
> An earlier attempt to place that warning, in mem_cgroup_lruvec(), had
> been careful to do so after weeding out the mem_cgroup_disabled() case;
> but was itself invalid because of the mem_cgroup_lruvec(NULL, pgdat) in
> clear_pgdat_congested() and age_active_anon().
> 
> Warning in mem_cgroup_page_lruvec() was once useful in detecting a KSM
> charge bug, so may be worth keeping: but skip if mem_cgroup_disabled().
> 
> Fixes: 9a1ac2288cf1 ("mm/memcontrol:rewrite mem_cgroup_page_lruvec()")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> 
>  include/linux/memcontrol.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- 5.11-rc2/include/linux/memcontrol.h	2020-12-27 20:39:36.751923135 -0800
> +++ linux/include/linux/memcontrol.h	2021-01-03 19:38:24.822978559 -0800
> @@ -665,7 +665,7 @@ static inline struct lruvec *mem_cgroup_
>  {
>  	struct mem_cgroup *memcg = page_memcg(page);
>  
> -	VM_WARN_ON_ONCE_PAGE(!memcg, page);
> +	VM_WARN_ON_ONCE_PAGE(!memcg && !mem_cgroup_disabled(), page);
>  	return mem_cgroup_lruvec(memcg, pgdat);

Thanks for fixing this. We also encountered this issue in kdump kernel
with the mainline 5.10 kernel since 'cgroup_disable=memory' is added.

Reviewed-by: Baoquan He <bhe@redhat.com>

