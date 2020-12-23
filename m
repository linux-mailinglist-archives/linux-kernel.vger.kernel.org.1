Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3952E1A00
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgLWIcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgLWIcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:32:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A753C06179C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 00:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5KgO6lhF5pn70RmnWP3mgdnYQI9chgeQRRpQQA021Bs=; b=j3w0eoLzM93oRvHraVazbRpELP
        VwpNbwnUgj0IkX6dLggTpijlpmIIXKq+A8ww9jlrCCuDyF/92Te1uEQxrir85L/5kPDg/am8FDxNs
        DDJCEL3n5s/798j9NQyC7jc3C6+1IfnCtIADNgHpzTLKeDKplwUXBgCvGgOSqpcJZuhvz9ujEg4G1
        GM6xN5yCqFBbuIxfvdTcJRQ4bHY3XVCk1cw9NJCWLeNcvFOLkt/Nr2lnNMcEnlqoWk4lGp11dYv+2
        JSkZSsJddYZqM8vCH9FamTHUP9MDaJYuzeCdSOEBud8bpoAiIDV9uRL/70jHRv95DcXm/nk1pEmyX
        ecDQu6fQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krzYM-00075c-4r; Wed, 23 Dec 2020 08:31:26 +0000
Date:   Wed, 23 Dec 2020 08:31:26 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Alex Shi <alex.shi@linux.alibaba.com>
Subject: Re: [PATCH] mm: add prototype for __add_to_page_cache_locked()
Message-ID: <20201223083126.GA27049@infradead.org>
References: <1608646792-29073-1-git-send-email-jrdr.linux@gmail.com>
 <20201222204000.GN874@casper.infradead.org>
 <20201222155345.e7086ad37967c9b7feae29e4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222155345.e7086ad37967c9b7feae29e4@linux-foundation.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can we please make the eBPF code stop referencing this function instead
of papering over this crap?  It has no business poking into page cache
internals.
