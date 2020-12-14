Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DF72D9B44
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 16:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408236AbgLNPiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 10:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408193AbgLNPie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 10:38:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBED1C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 07:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vBkMgwaqWgQzk6LNY3bQmv2SpphXlzsTKuwdqwDXN5Y=; b=hwJmrK/wYyrqRWb1HhPkCHqkOR
        rMisqRRYxowr56LslKGbG60AeXVw1DeI7IefzkqJUDkLgPpeze2pAol6GZwYbLB6OxEHcyrwV/qXM
        OQB3LE1mOnJ81gjYQI4f6yxEO5yhVg/ALTNdJkwLQudn630zNQARDcEZVLNiRo/6mjb1Cs9rHOi+P
        k/FSSM01NJMyxB6W14FM8dURIqAo49nyY8V2VrQ5i2/lQQPt5L7LU9Tu6G2tU9mFdI6mUUQFe5Nml
        WBpWpZY1W/0mUsE3Q3rtyUcqc6FiHXtZZYAVKWtCnplFqXAFnPoJ5YVIoGeL+ghx0785mNLk7k2or
        NYLQxDwA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kopv0-0003Fa-9s; Mon, 14 Dec 2020 15:37:46 +0000
Date:   Mon, 14 Dec 2020 15:37:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc: Fix unlock order in s_stop()
Message-ID: <20201214153746.GK2443@casper.infradead.org>
References: <20201213180843.16938-1-longman@redhat.com>
 <20201213183936.GA20007@pc636>
 <20201213215134.GI2443@casper.infradead.org>
 <20201214151128.GA2094@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214151128.GA2094@pc638.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 04:11:28PM +0100, Uladzislau Rezki wrote:
> On Sun, Dec 13, 2020 at 09:51:34PM +0000, Matthew Wilcox wrote:
> > If we need to iterate the list efficiently, i'd suggest getting rid of
> > the list and using an xarray instead.  maybe a maple tree, once that code
> > is better exercised.
>
> Not really efficiently. We need just a full scan of it propagating the
> information about mapped and un-purged areas to user space applications.
> 
> For example RCU-safe list is what we need, IMHO. From the other hand i
> am not sure if xarray is RCU safe in a context of concurrent removing/adding
> an element(xa_remove()/xa_insert()) and scanning like xa_for_each_XXX().

It's as RCU safe as an RCU-safe list.  Specifically, it guarantees:

 - If an element is present at all times between the start and the
   end of the iteration, it will appear in the iteration.
 - No element will appear more than once.
 - No element will appear in the iteration that was never present.
 - The iteration will terminate.

If an element is added or removed between the start and end of the
iteration, it may or may not appear.  Causality is not guaranteed (eg
if modification A is made before modification B, modification B may
be reflected in the iteration while modification A is not).
