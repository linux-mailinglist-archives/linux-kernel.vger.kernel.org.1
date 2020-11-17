Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF252B6C22
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgKQRrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgKQRrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:47:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA024C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LoYIqtE2uArlhd3t+oFaPxRtBOcfWW3ruKCeiAsN3WI=; b=UeoIWr+Cys8QMHfERbA/soqOj/
        xKMiowp3J7R140jplcIf1kcvU4zmPDfT3qGz75OYGOrh97GbZiEzJ7rU4wVGMCJZ642YMONhtbr14
        F/RCDd4o7wglwECBtGx0QjwKyvxJ0KHiNfBZ5I5NsKLAp9++LAnnQi3swbVsrerj2VkL5QF5U//GC
        LmflvnKqQcOrR4F1+E5yrniSDDbOrdQBw86Ph4/7T3SYLJ2OcwmzcBoO1EAPJ3bJYX+Ex8qbLBF5S
        we1p7YEmG+rgthuRTml0UFUOaPTMvZO5B8rx5TlvS+UACGCktojNyooAeCRDqubnqX74dTM83fiaC
        gVUe+AiA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf54h-0007Bf-6H; Tue, 17 Nov 2020 17:47:27 +0000
Date:   Tue, 17 Nov 2020 17:47:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hui Su <sh_def@163.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/lru: simplify is_file_lru() and is_active_lru()
Message-ID: <20201117174727.GR29991@casper.infradead.org>
References: <20201117171242.GA120587@rlk>
 <20201117174117.GQ29991@casper.infradead.org>
 <20201117174633.GA158014@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117174633.GA158014@rlk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 01:46:33AM +0800, Hui Su wrote:
> On Tue, Nov 17, 2020 at 05:41:17PM +0000, Matthew Wilcox wrote:
> > On Wed, Nov 18, 2020 at 01:12:42AM +0800, Hui Su wrote:
> > > lru_list lru bit 0 can tell whether the list is
> > > avtive lru-list or not.
> > > lru_list lru bit 1 can tell whether the list is
> > > file lru-list or not.
> > > 
> > > And fix some define type in shrink_active_list()
> > > and get_scan_count().
> > > 
> > > v1->v2:
> > > correct the commit message, and fix the define type.
> > 
> > No, still incorrect.
> 
> I am a little confused, can you tell in detail?

Have you booted a kernel with this change?  Have you run any kind of
tests on it?
