Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209382B6C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgKQRlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgKQRlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:41:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12233C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pmBYhBP5We7GHGzGu7owER3LNkD4Ikjk91kiljzGJ1A=; b=Ly0DsO0Od8hd/O0w73TWUTZ4OL
        KLc9lwwwMr/shGjFc79zunjo56JgO3xLEIUrfL3/V4hb2roYpW/MwSYmqkfWnyzS3v4YlTxLEDU+h
        PL50OnLgRzvoDo3wk34eVivQ2J0aaUxJQ4xkRpbBrLEhlAKApI+7lkyf+xMQABT8eEocrf1mzNlEt
        cfRrtlLM/D1tFbBP87Pk7CTHGCCqoNAmgyLWaZT2Lmd/qqI2RRj29hib8Lk6UizBvbG2KmP+xVaBM
        zA34VcYBEmorDo4fOsmkjB2jxEOhJQTavW3wEMOsvY9iP4w4p8DCXdL307hr32yGFJ+QY8NJTqadK
        3p8QLkuw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf4yj-0006oy-DL; Tue, 17 Nov 2020 17:41:17 +0000
Date:   Tue, 17 Nov 2020 17:41:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hui Su <sh_def@163.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/lru: simplify is_file_lru() and is_active_lru()
Message-ID: <20201117174117.GQ29991@casper.infradead.org>
References: <20201117171242.GA120587@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117171242.GA120587@rlk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 01:12:42AM +0800, Hui Su wrote:
> lru_list lru bit 0 can tell whether the list is
> avtive lru-list or not.
> lru_list lru bit 1 can tell whether the list is
> file lru-list or not.
> 
> And fix some define type in shrink_active_list()
> and get_scan_count().
> 
> v1->v2:
> correct the commit message, and fix the define type.

No, still incorrect.
