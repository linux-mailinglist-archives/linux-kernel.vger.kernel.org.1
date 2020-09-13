Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5272267FD3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 16:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgIMOzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 10:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgIMOz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 10:55:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14435C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FxMUBqjhqzQag30kB1vCRLwvMGWcO/P6G1bHhegnt8w=; b=mjl/pwv2uwM5/ynAJUW91t8l6j
        pV/J5hlT8/SQl4Ui86urJ3P/Ys/HfeGVJn6k2ncrCbQR7GNPlx3HHsGJAyDNBng4eFVgHJmkOgmL7
        sQo+J/SkHxB2s3FqKov3wSjy+zH5ZTQIjJ08ibr5MqZgkEsdTRtO9nkgxbEHMDlzaHxDcOf3j2Ddj
        4iwCGlibMe/nnXZTEhfvRjbjDAstIGr/nZAYfR/Y5ZPga0G1DZ6P7ShGYxikYwxQkzajdPW1q9UmK
        yNV/CxIcfdSYpJfNY6gi/0jJZrWP5uaUyzRsE3lEwu6Lfec+8j6u3YJy2aynbWSwQtkpljlNbjECa
        DY75PHYA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHTPU-0005tx-Q6; Sun, 13 Sep 2020 14:55:20 +0000
Date:   Sun, 13 Sep 2020 15:55:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] mm/gup.c: Handling ERR within unpin_user_pages()
Message-ID: <20200913145520.GH6583@casper.infradead.org>
References: <1600007555-11650-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600007555-11650-1-git-send-email-jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 08:02:35PM +0530, Souptick Joarder wrote:
> It is possible that a buggy caller of unpin_user_pages()
> (specially in error handling path) may end up calling it with
> npages < 0 which is unnecessary.
> @@ -328,6 +328,9 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
>  {
>  	unsigned long index;
>  
> +	if (WARN_ON_ONCE(npages < 0))
> +		return;

But npages is unsigned long.  So it can't be less than zero.
