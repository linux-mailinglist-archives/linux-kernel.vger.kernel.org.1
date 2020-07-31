Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F273C234C7A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 22:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgGaUs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 16:48:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727782AbgGaUs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:48:56 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0DA221744;
        Fri, 31 Jul 2020 20:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596228535;
        bh=elZ7jFKgpFkWMbV1KRjrT+FjJS91ZdURYAtaGpL93Yk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=A4QxSM6r2iS01SktdZEI60jaKQrVoiE9k0IOY3pq6MwnB0dylHqBq0zzbCPxTlTs9
         5bf15Bj6Ru178MsC6SAyvWvScSnLsI7WAV4hDFqCV6xi/8KkoEXI2q0HuUSt2D3x7T
         Ze2Iq7kf/l6Y2CVCvRrHIK7uaI/rpHwrDTkqyo8E=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9006C35231D2; Fri, 31 Jul 2020 13:48:55 -0700 (PDT)
Date:   Fri, 31 Jul 2020 13:48:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, hannes@cmpxchg.org, willy@infradead.org,
        urezki@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Raw spinlocks and memory allocation
Message-ID: <20200731204855.GR9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200730231205.GA11265@paulmck-ThinkPad-P72>
 <20200731133834.517fdfee99b7ed2239f576aa@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731133834.517fdfee99b7ed2239f576aa@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 01:38:34PM -0700, Andrew Morton wrote:
> On Thu, 30 Jul 2020 16:12:05 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > So, may we add a GFP_ flag that will cause kmalloc() and friends to return
> > NULL when they would otherwise need to acquire their non-raw spinlock?
> > This avoids adding any overhead to the slab-allocator fastpaths, but
> > allows callback invocation to reduce cache misses without having to
> > restructure some existing callers of call_rcu() and potential future
> > callers of kfree_rcu().
> 
> We have eight free gfp_t bits so that isn't a problem.

Whew!!!  ;-)

> Adding a test-n-branch to the kmalloc() fastpath may well be a concern.
> 
> Which of mm/sl?b.c are affected?

None of them, it turns out.  The initial patch will instead directly
invoke __get_free_page().  So we could just leave sl?b.c alone.

> A doesnt-need-to-really-work protopatch would help us understand the
> potential cost?

Makes sense!  My guess is that Uladzislau Rezki (CCed) will be sending
one along by the middle of next week.

							Thanx, Paul
