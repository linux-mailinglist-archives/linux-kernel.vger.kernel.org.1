Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2820A1CE52A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 22:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbgEKUL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 16:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729215AbgEKUL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:11:58 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59BD3206F5;
        Mon, 11 May 2020 20:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589227916;
        bh=BAT96320Mf+ek7q+6TUr2heEI1ld3mlQvzBygXm4ikE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uPubk21j63Zr9AqxVjUUQOVQXFKVjWUSWJfHwi1uxn3D00X6uBTsfwvupX7tc3PMl
         RTEdBA+0n4PZyJFKM9NPrKn4/wD6EqvnI91oTc2wka/nk7nEpQ024X7GzYEtSWHBXu
         3xtLDutwV9/Oo3DqaGdV/W7ryzxKHu+R4Yb6cz8A=
Date:   Mon, 11 May 2020 13:11:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Charan Teja Reddy <charante@codeaurora.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
Subject: Re: [PATCH] mm, page_alloc: reset the zone->watermark_boost early
Message-Id: <20200511131155.0b40ee443c3367e8f748b16f@linux-foundation.org>
In-Reply-To: <1589204408-5152-1-git-send-email-charante@codeaurora.org>
References: <1589204408-5152-1-git-send-email-charante@codeaurora.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 19:10:08 +0530 Charan Teja Reddy <charante@codeaurora.org> wrote:

> Updating the zone watermarks by any means, like extra_free_kbytes,
> min_free_kbytes, water_mark_scale_factor e.t.c, when watermark_boost is
> set will result into the higher low and high watermarks than the user
> asks. This can be avoided by resetting the zone->watermark_boost to zero
> early.

Does this solve some problem which has been observed in testing?

> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7746,9 +7746,9 @@ static void __setup_per_zone_wmarks(void)
>  			    mult_frac(zone_managed_pages(zone),
>  				      watermark_scale_factor, 10000));
>  
> +		zone->watermark_boost = 0;
>  		zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone) + tmp;
>  		zone->_watermark[WMARK_HIGH] = min_wmark_pages(zone) + tmp * 2;
> -		zone->watermark_boost = 0;
>  
>  		spin_unlock_irqrestore(&zone->lock, flags);
>  	}

This could only be a problem if code is accessing these things without
holding zone->lock.  Is that ever the case?

