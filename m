Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1ECB2ADE96
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbgKJSmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJSmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:42:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4344C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RlvumwFFqtHHTtqgXiiCCmpECmDemzXqXgYQ9Vk4WBw=; b=RkBCGrtqgxR5MwtIwJ7MABW3TI
        AjONZMSKrcdRtT06jWDpO73w2mbRWkvVywabhoWVQPGuGsvEnkjKlsofAnDFVnJ+R69qpKA6Gwnh5
        vvR0L+DVDIJcPnYNSW3FIa42EcQ5ty8XXXARL2tHT55wqjQNMNkrASal1SB7mK9X/EKk2m18Y6XL4
        p45LENjHF8RSDd+71xAPqsSRCownFFpae4+kYuIZO3GD8J9FDMU+BMwjH2754N6Y3KgF82rjRIYQz
        TEpmLiKGZeK6GJ451hAWDBiszx5b5TzJuenpoGwOZh7OyEVjWZzErjzKsE5e/zdgJjEDIBQ4qj7vn
        JEYKKn4A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcYat-00031m-Be; Tue, 10 Nov 2020 18:42:15 +0000
Date:   Tue, 10 Nov 2020 18:42:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm: simplify follow_pte{,pmd}
Message-ID: <20201110184215.GM17076@casper.infradead.org>
References: <20201029101432.47011-1-hch@lst.de>
 <20201029101432.47011-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029101432.47011-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 11:14:32AM +0100, Christoph Hellwig wrote:
> Merge __follow_pte_pmd, follow_pte_pmd and follow_pte into a single
> follow_pte function and just pass two additional NULL arguments for
> the two previous follow_pte callers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I'm not entirely convinced this is the right interface, but your patch
makes things better, so I approve.
