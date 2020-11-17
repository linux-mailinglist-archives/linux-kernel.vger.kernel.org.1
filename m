Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956D72B6C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgKQRkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729942AbgKQRkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:40:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB61CC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ViLhUA4I08HwLcRLKTVqoaxN2XTRXddkPrqS8u4JVe8=; b=n/wGVSYG+i1gtrLPGWWPkW91mP
        NDgz82iPzYPOA4Q+ALWIVCmMdmhS9cx9/h9DWeDjwD/mLeeVms1Ib9MybL+aVC0jjM60c3sc08GzK
        cB7SNP1YIbl71uaH5MDOc9jTXb3UT0++LyyfdhUCYasUo+kiqEZtvJc+UvYXLG7xZKse53E8TlKiG
        SuM/b2zJFJhWLmRU7jMc23mwJWcCbj54LaC3HQwjJpOaNERM9IxqzyjIyYbzY9Vm1YMGc3HHkdCM7
        54P+LQNfyT6VETbWEkvx1KVlsqbQht4L8/vXbJ8SwYVJ9bKKYM4rdyqHHN8ny2scGZqM9voNp6FY2
        Q8KlGirA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf4y9-0006kF-8h; Tue, 17 Nov 2020 17:40:41 +0000
Date:   Tue, 17 Nov 2020 17:40:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hui Su <sh_def@163.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/lru: simplify is_file_lru() and is_active_lru()
Message-ID: <20201117174041.GP29991@casper.infradead.org>
References: <20201117164919.GA82821@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117164919.GA82821@rlk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 12:49:19AM +0800, Hui Su wrote:
> page->lru bit 0 can tell whether the page is
> avtive page or not.
> page->lru bit 1 can tell whether the page is
> file page or not.

This is wrong.  I'll let you figure out why.
