Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919E52FF572
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbhAUUHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbhAUSq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 13:46:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363BFC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 10:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JZOhFWi1HKv4/X49K74fHnpIPZZHVP2pvZjLlxMfY+0=; b=GkBhNYx9WzDjbpwFcOk7yQug3Y
        9D0fF5W6JiZpR9m/bmCWU2OiMb5QGUkhrnb9s7H3eVSr/n4tZb8rnXkXNJAnA6RKjnvNMMpdbU7tU
        fQeI5MLYEap4XbVnjnHiPb5sS5f0Cj9rlT4HVG48Qz7Ku2tOff4PBO5PghnEqz6CiPabwQ9rhu8Sk
        zv5FO2QQxaPoX3zZ90lMUY3B/uzfwHrqE5bbQSt09+kiMCFRaWhfqQyzYQRxFh+PoFGt55HqVQqdg
        ixe//YzDv55Ff+CjHl6TYIazeUJtEcJpLoE8fCiAmLa6/OZMjhaf1/py82cbP8U/IX6Ze8vQKpZmB
        3VzWZ3JQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2ewy-00HOGx-Vl; Thu, 21 Jan 2021 18:44:58 +0000
Date:   Thu, 21 Jan 2021 18:44:56 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] swap: Check nrexceptional of swap cache before being
 freed
Message-ID: <20210121184456.GB4127393@casper.infradead.org>
References: <20210120072711.209099-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120072711.209099-1-ying.huang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 03:27:11PM +0800, Huang Ying wrote:
> To catch the error in updating the swap cache shadow entries or their count.

I just resent a patch that removes nrexceptional tracking.

Can you use !mapping_empty() instead?

>  void exit_swap_address_space(unsigned int type)
>  {
> -	kvfree(swapper_spaces[type]);
> +	int i;
> +	struct address_space *spaces = swapper_spaces[type];
> +
> +	for (i = 0; i < nr_swapper_spaces[type]; i++)
> +		VM_BUG_ON(spaces[i].nrexceptional);
> +	kvfree(spaces);
>  	nr_swapper_spaces[type] = 0;
>  	swapper_spaces[type] = NULL;
>  }
> -- 
> 2.29.2
> 
> 
