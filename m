Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7282E1EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 16:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgLWPxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 10:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgLWPxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 10:53:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F32CC061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 07:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZzbHBDfwrLQXFpf8glXNdNep4b6to1I3c9fdVvbb1Rs=; b=LlAfVZ832CeCQX4WS/8e9Xf542
        fq6syhLmhblRiPAq27ncYBnNMRz0gxp4abk3jaGqVkgM4tFkZ+h0MYyPbDT2xIZyukR0yGNKU+IJz
        iqUL3SFNRNALIzi1a3baXE7OfCEGizF9XiczWvjVWg9z91W0hndB5/9l/drrAJZ8dF3Oe6eNsevO1
        bKxQaiy93pQ9Cg1QqSbkZhFpiWU95Dol283GyrEhxyFkw8bzmjL1+GeQqrE0KJKtoKayKXSQK21uR
        C4jbqUgqtAlX3ud0TFj6sAn7I6ZwWI48rlMJC1CxzJtv+6RMjPVqFFdHJcwnO8rrOThH+SN7Xk824
        fz9Hftbg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ks6Ra-0001f9-KX; Wed, 23 Dec 2020 15:52:54 +0000
Date:   Wed, 23 Dec 2020 15:52:54 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Alex Shi <alex.shi@linux.alibaba.com>
Subject: Re: [PATCH] mm: add prototype for __add_to_page_cache_locked()
Message-ID: <20201223155254.GA6138@infradead.org>
References: <1608646792-29073-1-git-send-email-jrdr.linux@gmail.com>
 <20201222204000.GN874@casper.infradead.org>
 <20201222155345.e7086ad37967c9b7feae29e4@linux-foundation.org>
 <20201223083126.GA27049@infradead.org>
 <20201223121136.GP874@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223121136.GP874@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 12:11:36PM +0000, Matthew Wilcox wrote:
> On Wed, Dec 23, 2020 at 08:31:26AM +0000, Christoph Hellwig wrote:
> > Can we please make the eBPF code stop referencing this function instead
> > of papering over this crap?  It has no business poking into page cache
> > internals.
> 
> The reference from the BPF code is simply "you can inject errors here".
> And I think we want to be able to inject errors to test the error paths,
> no?

Something that expects a symbol to be global is just pretty broken.
I think it need to change so that whatever instrumentation is done can
coexist with a static function.
