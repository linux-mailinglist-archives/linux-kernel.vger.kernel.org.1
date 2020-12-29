Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0542E7092
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 13:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgL2MOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 07:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgL2MOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 07:14:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E13C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 04:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PkExMLV9c9lZCtCXh3APiHVKga9LqLmI/zBDquxhRIg=; b=FU0l6SLeoylsCNKzA9NGEHOwI6
        wT04xGHwNLlexyLowbXq0KdQLQNhvd3tR91P+lJ78LS1w5b7783zrFYnjBCUOq9ddSfb6SQWMdExi
        3gSjB5aN5FbqDlafKXXYN3lTVlsFzdjB40n5twC2sDR5ygbhEnvxvQcp1Mah5fSVocKQb/nscQFJy
        yIF9SLLfTYOgbjosLHBOjRky6GsSZNb4Pz7qbsN9HH8WIBYPldtal3kULGB6gdNdApWWmAocKUdgY
        RQq6cHfVnmD7XTHqX/7ZTgnwVj7u4ULJv0GRsyp87vC6mv6eiE63HCP4vpGeHliqYitfSFLfZd9e1
        VYCLcbkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kuDsv-0006F6-2X; Tue, 29 Dec 2020 12:13:56 +0000
Date:   Tue, 29 Dec 2020 12:13:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: rectify a page bad reason
Message-ID: <20201229121353.GB28221@casper.infradead.org>
References: <20201229031156.3861-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229031156.3861-1-rongwei.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 11:11:56AM +0800, Rongwei Wang wrote:
> When I was doing some memory-related projects, it always reported error
> "nonzero mapcount", but its judgment condition was that _mapcount was not equal
> to -1, so I felt the original string was a bit inappropriate, so I tried to
> update it.

But '_mapcount' of -1 _is_ a mapcount of 0.  If we need to improve the
documentation somewhere, that'd be better than changing this message.

I do wonder if we want to add:

	if (unlikely(page_has_type(page))
		bad_reason = "page still typed";

It's covered by the non-zero mapcount case, but is slightly misleading.

>  	if (unlikely(atomic_read(&page->_mapcount) != -1))
> -		bad_reason = "nonzero mapcount";
> +		bad_reason = "non-(-1) _mapcount";
>  	if (unlikely(page->mapping != NULL))
>  		bad_reason = "non-NULL mapping";
>  	if (unlikely(page_ref_count(page) != 0))
> -- 
> 1.8.3.1
> 
> 
