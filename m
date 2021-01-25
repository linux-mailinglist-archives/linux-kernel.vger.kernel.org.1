Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A32B30213C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 05:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbhAYEi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 23:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbhAYEiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 23:38:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AE3C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 20:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xMmeTEE8ptZCzzbZIq/NKquhH9jAY0AxkiD6MhxMEp8=; b=OiU+5XolupbJY810m7pNSuvz4e
        1mWu7t9XVHUzEpJhM0DXZmYhKUrfYP5exJxcxJntHwZEhhtKT20wFGXsRsOQgCoSaRAqVDtFK/cgx
        Vge7XIJjjEpGfqdFf6Vaued4VHrzBbBFrI+Ml/nP4mCVY5rvSbzF8a40Dg5QRbTJ+v2nTnbNnS54B
        UBg3f9ap7s+fCHp3KtwYU/3LRMFASj/z6MlwjpwtLeDwWmvzIk9mbcblgyMuyBZ6uo0QJ1O5de5Ne
        Do/+M9weIsbtNLSbB10RGgZrwX9MRTGOVnhB7AX3QOEF7kRMAqQKbDBLcX5d0O3GNH6OHDbgF4Rb+
        DFL4HDnw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l3tc7-003lv3-9t; Mon, 25 Jan 2021 04:36:53 +0000
Date:   Mon, 25 Jan 2021 04:36:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alex Shi <alex.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: Adding missing mem_cgroup_uncharge() to
 __add_to_page_cache_locked()
Message-ID: <20210125043631.GD308988@casper.infradead.org>
References: <20210125042441.20030-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125042441.20030-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 24, 2021 at 11:24:41PM -0500, Waiman Long wrote:
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 5c9d564317a5..aa0e0fb04670 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -835,6 +835,7 @@ noinline int __add_to_page_cache_locked(struct page *page,
>  	XA_STATE(xas, &mapping->i_pages, offset);
>  	int huge = PageHuge(page);
>  	int error;
> +	bool charged = false;

I don't think we need this extra bool.

> @@ -896,6 +898,8 @@ noinline int __add_to_page_cache_locked(struct page *page,
>  
>  	if (xas_error(&xas)) {
>  		error = xas_error(&xas);
> +		if (charged)
> +			mem_cgroup_uncharge(page);
>  		goto error;
>  	}

Better:

-		goto error;
+		goto uncharge;
...
+uncharge:
+	if (!huge)
+		mem_cgroup_uncharge(page);
 error:
...
