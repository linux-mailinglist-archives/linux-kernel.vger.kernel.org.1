Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF1E2596F8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 18:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbgIAQJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 12:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731703AbgIAQJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:09:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F36C061244;
        Tue,  1 Sep 2020 09:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oBkq3glCAHtvOG8UIAGHt/0r5y1zdNiyvtDIVrqUvHM=; b=Z6sUr62WUfxGIitZ30fveIfF6A
        sXIe5ryrpygTcH3h/5Hsf2cIPUx68XYgdr1wFENvDfHzFtag1rQ0MY/9ppQfHdCl8y/BnIDYcp5wI
        RBC6+NlQ5XYuEQVFUoGTXVDfdA2zGcLyuEZs5S5Y3wWjtH1ONvJtNJcVwH3XQrX22wULSvWOcg/HB
        chXB6vq1s8wF5ObT20ymr0uIGz5ZWmNYQSDj3SD50dKASxH6mw0ml+hP3OLN1pTxK1EIy1rIek2rp
        Lu6zdD0DyOOZ9FBHCWKbrKagsxKLP/8ttJeZFgWGI5Iv23cfUhpYZGlSHi/dIDrVGtSKFUIzujpGX
        bkWsYFYA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kD8qH-0005hT-H0; Tue, 01 Sep 2020 16:09:05 +0000
Date:   Tue, 1 Sep 2020 17:09:05 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Fix potential page reference leak in
 __bio_iov_iter_get_pages()
Message-ID: <20200901160905.GA21372@infradead.org>
References: <20200901120006.9545-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901120006.9545-1-linmiaohe@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 08:00:06AM -0400, Miaohe Lin wrote:
> When bio is full, __bio_iov_iter_get_pages() would return error directly
> while left page reference still held in pages. Release these references.
> Also advance the iov_iter according to what we have done successfully.
> 
> Fixes: 576ed9135489 ("block: use bio_add_page in bio_iov_iter_get_pages")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

The WARN_ON means something is fundamentally wrong here.  I think a few
leaked pages are the least of our problems in this case.
