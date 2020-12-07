Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42532D1244
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgLGNi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:38:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:39766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgLGNi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:38:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B567FAC90;
        Mon,  7 Dec 2020 13:37:44 +0000 (UTC)
Date:   Mon, 7 Dec 2020 14:37:42 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_alloc: speeding up the iteration of max_order
Message-ID: <20201207133735.GA12191@linux>
References: <20201204155109.55451-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204155109.55451-1-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 11:51:09PM +0800, Muchun Song wrote:
> When we free a page whose order is very close to MAX_ORDER and greater
> than pageblock_order, it wastes some CPU cycles to increase max_order
> to MAX_ORDER one by one and check the pageblock migratetype of that page
> repeatedly especially when MAX_ORDER is much larger than pageblock_order.
> 
> We also should not be checking migratetype of buddy when "order ==
> MAX_ORDER - 1" as the buddy pfn may be invalid, so adjust the condition.
> With the new check, we don't need the max_order check anymore, so we
> replace it.
> 
> Also adjust max_order initialization so that it's lower by one than
> previously, which makes the code hopefully more clear.
> 
> Fixes: d9dddbf55667 ("mm/page_alloc: prevent merging between isolated and other pageblocks")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
