Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD03298852
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 09:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771754AbgJZIba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 04:31:30 -0400
Received: from casper.infradead.org ([90.155.50.34]:33838 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1771712AbgJZIb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:31:29 -0400
X-Greylist: delayed 1222 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 04:31:29 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zkQv6PP/jqP7JpBqkyIwYWH1C5UcJlu2KgKr/pNdSNs=; b=K/Ee07W7BXL26gQPzNcZFTdGaE
        idve07W5yNIGZ5ZVQg6P6GBgsyCS/e7I3oISmp0Pa5mojhAFma72JdjztC9fN2EyT1pFygN7gwZyF
        dhHxivnLlozdFPbSq8x1dQUkw2EYwaBo1mVzy38AjDhxlhukMmLlhEy7HTr7xrUCKFeJFz5WfO3lC
        UybBh8L1Rjs839EuclWBjgIhjm2WHzR9npIErGCO0HtosTjyvXDscnDzqWeSDBVdDOeoB+ZruRU6v
        6H6O1yalKplcxq2O9s4nY5lVhumRQEJDZnaHcLjx7C+68fRw/ZcW+sb13qfWKWmWxlDR58R3HAtsS
        FyqUbY7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWxan-000481-3r; Mon, 26 Oct 2020 08:11:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC7353010D2;
        Mon, 26 Oct 2020 09:10:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CAD6520325EC8; Mon, 26 Oct 2020 09:10:59 +0100 (CET)
Date:   Mon, 26 Oct 2020 09:10:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 49/56] refcount.h: fix a kernel-doc markup
Message-ID: <20201026081059.GB2628@hirez.programming.kicks-ass.net>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <fd94a95cfe01b97190b6ffb9e942cb4bbeeaa6bf.1603469755.git.mchehab+huawei@kernel.org>
 <202010231039.DE05B63@keescook>
 <20201023193907.GI2974@worktop.programming.kicks-ass.net>
 <20201023134757.628f91b7@lwn.net>
 <20201024082827.08ad3010@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201024082827.08ad3010@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 24, 2020 at 08:28:27AM +0200, Mauro Carvalho Chehab wrote:
> If the intent is to document the struct and its internal fields,
> this kernel-doc should work:
> 
> 	/**
> 	 * struct refcount_struct - variant of atomic_t specialized for reference counts
> 	 * @refs: atomic_t counter field
> 	 *
> 	 * The counter saturates at REFCOUNT_SATURATED and will not move once
> 	 * there. This avoids wrapping the counter and causing 'spurious'
> 	 * use-after-free bugs.
> 	 */
> 
> Which produces this result:

Who cares... :-(

> If you want both, then you would either split struct and typedef, e. g.
> with something like:
> 
> 	/**
> 	 * struct refcount_struct - variant of atomic_t specialized for reference counts
> 	 * @refs: atomic_t counter field
> 	 *
> 	 * The counter saturates at REFCOUNT_SATURATED and will not move once
> 	 * there. This avoids wrapping the counter and causing 'spurious'
> 	 * use-after-free bugs.
> 	 */
> 	struct refcount_struct {
> 	        atomic_t refs;
> 	};
> 
> 	/**
> 	 * typedef refcount_t - variant of atomic_t specialized for reference counts
> 	 * @refs: atomic_t counter field
> 	 *
> 	 * The counter saturates at REFCOUNT_SATURATED and will not move once
> 	 * there. This avoids wrapping the counter and causing 'spurious'
> 	 * use-after-free bugs.
> 	 */
> 	typedef struct refcount_struct refcount_t;
> 
> Or, you could add the member at the description field. E. g. something
> like this:
> 
> 	/**
> 	 * typedef refcount_t - variant of atomic_t specialized for reference counts
> 	 *
> 	 * The counter saturates at REFCOUNT_SATURATED and will not move once
> 	 * there. This avoids wrapping the counter and causing 'spurious'
> 	 * use-after-free bugs.
> 	 *
> 	 * Members:
> 	 *   ``refs``
> 	 *        atomic_t counter field
> 	 */
> 	typedef struct refcount_struct {
> 	        atomic_t refs;
> 	} refcount_t;
> 
> If you want to test it, you can run kernel-doc directly, to see how
> it will parse it. For ReST output, that's the syntax:
> 
> 	./scripts/kernel-doc --sphinx-version 3 include/linux/refcount.h

I'll just go ahead and remove the superfluous * from the comment... It's
trivially clear what is meant. If the stupid tool can't deal with that,
I don't care.

All this wanking about docs and making perfectly fine comments bloody
unreadable shit has to stop.
