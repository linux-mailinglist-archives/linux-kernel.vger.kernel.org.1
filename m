Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0C82B3001
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 20:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgKNTMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 14:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgKNTMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 14:12:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DC1C0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 11:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WxkHg606XkyvNta0/g/LnAPObU1iotZ1sOfBfOHWffc=; b=jmZpwLSiLutZKV2fkbiPqmxFEn
        iS47AQF/5TyY8mMIqGDEzaBXMaFhv9xBeUePelOl+MiVGz7+pRcdQLzhxCFKY3a0WGGn+wzbzm6Sa
        d9scRAX8mKrEsABz70XIkQbBypiyaL453USpeyrVnG7lDVUVlXB7IwoGAAF1ToIxKUzVpDJjt6ESC
        EiMby6+nEQMurMn9/XHn0p8FBB2NxqB2uLdx3KsMtqxPbsAfJSP4MApvjEx0NUBocUhwQ7EHixsQl
        JHsDi8W57QWbncdnklLQ+RuhvCQeRSChQEiPo4UucxxkMU4y1KpDQxkoD0eyXmL/drkNQ0W9w6eix
        rVtvhY8w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ke0xq-0004sf-75; Sat, 14 Nov 2020 19:11:58 +0000
Date:   Sat, 14 Nov 2020 19:11:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hui Su <sh_def@163.com>, hughd@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pankaj.gupta.linux@gmail.com,
        lkp@intel.com
Subject: Re: [PATCH v2] mm/shmem.c: make shmem_mapping() inline
Message-ID: <20201114191158.GN17076@casper.infradead.org>
References: <20201114055134.GA186011@rlk>
 <20201114105039.4d44e3036e22e10c9a70912c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114105039.4d44e3036e22e10c9a70912c@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 10:50:39AM -0800, Andrew Morton wrote:
> But really, shmem_mapping() isn't worth an out-of-line call from any
> callsite - it would be best to make it inlined everywhere.
> 
> - make shmem_aops global
> - declare shmem_aops in shmem_fs.h
> - export shmem_aops to modules for drivers/dma-buf/udmabuf.c
> - include linux/fs.h in shmem_fs.h for address_space_operations (we already
>   include fs.h via swap.h, but we shouldn't depend on that)
> - make shmem_mapping() a static inline in shmem_fs.h.

... or use an AS_ bit to make shmem_mapping() global inline without
exposing the shmem_aops symbol.  We're not short of AS_ bits, and it's
probably even cheaper than a pointer comparison.

A really good changelog would explain why we need shmem_mapping()
everywhere that we currently use it.  It's not immediately obvious why
so many places need to know.
