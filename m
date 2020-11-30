Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACEFA2C8F0B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388413AbgK3UWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388401AbgK3UWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:22:03 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73F9C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:21:17 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id z188so12139510qke.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gQQl36bXbclaKmYcyW6UZ4zFh+yStxJW/hv74bT5Djw=;
        b=VVHdgPlRXPjsdbqs5gCcCgE8hcY8metarP3X7+/uf9GM+Ko/Tc9SglDgnMNSBY2P3b
         by6Na/JFIpSUAQDRrw3MJJCVxSpqDZbIKuVG2JTEnHrc6+cUJRpZCwjZQJki/FNFCNEQ
         CMZWLaYGkfo+R/7a+DVidSUSU/wBAYqaF235YAMgogBmLHDx7g08hNTQqZ58l1wEz28O
         W4bv+QXOtAKLhylZyN0zXfSU1xukXbYa+jHDK1QLF59cKDo9zc90zUPqk5+Dr/Bk61pN
         d3+QkPBpShLjargpQP72wKy32/UcNOCjoiJb0fk7E1w021eRX0szWxPESlglmv3plU4l
         EZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gQQl36bXbclaKmYcyW6UZ4zFh+yStxJW/hv74bT5Djw=;
        b=E5jyt3rCK5PLO5sOJoUFlKttAfQnppM/CqgDLxCpBVeFWuV+EPpYgFleIvA/amcf2C
         QalHp1d8qOaG1/XsoKJtRURgOai5eJsX97DxIZ++/V5f42Lo3HKyslqWIFW9hqflPBhI
         ya+Vv+H92qRHJgaR3VCeYlkzo2cgnlI7tUS4Ha4rq2R+d7f4XjvPpBnw24BJsL+KSpZB
         tbnEkKFiRzeEp2v4rwVxa/TNHQtvb4CNyyUFzBKxuJdi/DUw3Yn4/bOU6Ugrfm5wbpPb
         2lPWG51JKaz4h7+XD+Yk9YwdpYoxr+tLznJ8j3XKC4mENcJwZd7zSIDVt25R7MbYIw4P
         F4iA==
X-Gm-Message-State: AOAM530j4A2GOHtmM5dXbS1LjqCf1trUUPmJybaOaf4gHYcNvhMdU4MI
        1lMGCxMyjA8U93B2pdSSqqUQTUmQGuUHXw==
X-Google-Smtp-Source: ABdhPJx9wyf4xusg06LfP6yiei1fwWA0412KhJR+Nt4TedyjjjcVx3oaFOXwIXEnjmnLaG+qAWewFw==
X-Received: by 2002:a37:e215:: with SMTP id g21mr7736404qki.91.1606767676845;
        Mon, 30 Nov 2020 12:21:16 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:a2bc])
        by smtp.gmail.com with ESMTPSA id 199sm16701507qkm.62.2020.11.30.12.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 12:21:16 -0800 (PST)
Date:   Mon, 30 Nov 2020 15:19:16 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: memcontrol: account pagetables per node
Message-ID: <20201130201916.GB23216@cmpxchg.org>
References: <20201126005603.1293012-1-shakeelb@google.com>
 <20201126005603.1293012-3-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126005603.1293012-3-shakeelb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 04:56:03PM -0800, Shakeel Butt wrote:
> For many workloads, pagetable consumption is significant and it makes
> sense to expose it in the memory.stat for the memory cgroups. However at
> the moment, the pagetables are accounted per-zone. Converting them to
> per-node and using the right interface will correctly account for the
> memory cgroups as well.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Agreed, this is a useful stat item to have.

Just one trivial issue:

> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -151,7 +151,6 @@ enum zone_stat_item {
>  	NR_ZONE_UNEVICTABLE,
>  	NR_ZONE_WRITE_PENDING,	/* Count of dirty, writeback and unstable pages */
>  	NR_MLOCK,		/* mlock()ed pages found and moved off LRU */
> -	NR_PAGETABLE,		/* used for pagetables */
>  	/* Second 128 byte cacheline */
>  	NR_BOUNCE,
>  #if IS_ENABLED(CONFIG_ZSMALLOC)
> @@ -206,6 +205,7 @@ enum node_stat_item {
>  #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
>  	NR_KERNEL_SCS_KB,	/* measured in KiB */
>  #endif
> +	NR_PAGETABLE,		/* used for pagetables */
>  	NR_VM_NODE_STAT_ITEMS
>  };

You need to update mm/vmstat.c::vmstat_text accordingly or
/proc/vmstat output will be bogus.

With that fixed, please feel free to add:
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
