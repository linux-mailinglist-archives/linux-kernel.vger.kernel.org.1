Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E562B9A4F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgKSSCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 13:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgKSSCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:02:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B210C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 10:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ma4f4H4dwrdwuSRL3o/wwF+/0TSbqSBTgK3/+Qim5fU=; b=KSvuCQGM/XHs7Bng0bqSoG/dt6
        wxprvYnyDSPXdh2bCrY1y5SSQoA0G/UZR5tM547DtsK92VwttTY2LY+BBhr4KR4AWuYeOuDnxltmw
        PJrilCYpggLAWqTDirQVYHRac/CnEIy8HVLUG2wb9ALNzdTaewpNxHmh8oKjzhP+JQXnPxPJdt2K7
        bUh3x/ERXfZMkqOQEm8bXYjvHbnGGTb1iQOnsqFVoqDWC70GNZ021F8enYaKL7Z49THoGgmnOmfeq
        AXZ8Dx+jFQbeJ12p5VjuNYewVt+saELHRAlNUNvjtaPWxhr1d5Fqcw0ri/sgYG+O4ojLfC+TWizYI
        au35HJgg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfoFy-0006MP-74; Thu, 19 Nov 2020 18:02:06 +0000
Date:   Thu, 19 Nov 2020 18:02:06 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] x86: restore the write back cache of reserved RAM in
 iounmap()
Message-ID: <20201119180206.GA24054@infradead.org>
References: <20201119175902.17394-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119175902.17394-1-aarcange@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 12:59:01PM -0500, Andrea Arcangeli wrote:
> Hello everyone,
> 
> We identified some PCD set on the direct mapping causing hardly
> reproducible performance issues and this patch fixes the ultimate root
> cause.
> 
> The caller for now has been tweaked to avoid triggering this case (now
> that we know about it)

What is the callers?  The whole SetPageReservered + ioremap* thing
you mention in the actual patch is completely bogus.  I think we'll
need to reject that as well and fix the caller.
