Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF44234C55
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 22:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgGaUcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 16:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgGaUcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:32:16 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 096772087C;
        Fri, 31 Jul 2020 20:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596227536;
        bh=408Q0Hh+fgrrPI7C/uxjoUhChUZT+B18EfDwFr/6pIQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UN+EYyNBTAK7YK11SGuSdNTJr8UDBGjCxmVTjvaRi93u/RLGBcPhn/GTxvCs2RN+5
         do5QXszzBuQunW/zfSEX0rog61dmQmIl1o4Lame7kXp+gbvN1CwV5x+CnLTLh5XhAd
         0qJwccZ5fjOXm5IeU9B7vRPlH2PD8cgCa7r0cxJs=
Date:   Fri, 31 Jul 2020 13:32:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     qiang.zhang@windriver.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/dmapool.c: add WARN_ON() in dma_pool_destroy
Message-Id: <20200731133215.73cf5ce464e2b894aeac0773@linux-foundation.org>
In-Reply-To: <20200731023858.GO23808@casper.infradead.org>
References: <20200731023939.19206-1-qiang.zhang@windriver.com>
        <20200731023858.GO23808@casper.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020 03:38:58 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Jul 31, 2020 at 10:39:39AM +0800, qiang.zhang@windriver.com wrote:
> > The pool is being destroyed, all page which in the pool,
> > should be free. if some page is still be use by somebody,
> > we should not just output error logs, also should also add
> > a warning message.
> 
> There's already a warning message.  What value does this actually have?

Presumably so we get a backtrace in order to identify the errant
caller.  

I added a bit to the changelog:

: The pool is being destroyed so all pages which are in the pool should be
: free.  If some page is still in use by somebody, we should not just output
: error logs, also should also add a WARN message so the stack backtrace may
: be used to identify the caller.


