Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A01124B936
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 13:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbgHTLlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 07:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730588AbgHTLk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:40:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879BEC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 04:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SMfh1yOZqJYcuIo5QqgcDZ8p/aIMYyftWY3o8WxJnu8=; b=nk9w2AeAg9hLKCsi++5FQvlS2S
        dmRHbDnodhrea9B39OGzzvGElK9iCaSczuybI+aubEWuhO3UC8Y51Z0cTasWqjfnSE85As9QmXLql
        HV2t6oyUnufzWBbxwFKPz+XRCeud7faNkJK7n8Pvo6BDSBdOvGSVr1DnXaNXqpMGlRvhzQibCLeOE
        1T1KN5JdRbM3O5laNebu5wfIj4Ivtj0TWv48xre7Ukivtp8rOFgcetC7TeCHHVoFHCynkPt4NisDv
        MfP4LrPmHhAGVL8y5aQwbtD0wXlH8nf6Mgf0JU7EsE0m6EAA73f2btWdVVif/hGXaSfCtY7RPQhC1
        X/sdCk9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8ivu-0002mo-Ii; Thu, 20 Aug 2020 11:40:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DB105306099;
        Thu, 20 Aug 2020 13:40:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C914E200F9DF2; Thu, 20 Aug 2020 13:40:36 +0200 (CEST)
Date:   Thu, 20 Aug 2020 13:40:36 +0200
From:   peterz@infradead.org
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, tglx@linutronix.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH] lockdep: Do no validate wait context for novalidate class
Message-ID: <20200820114036.GQ2674@hirez.programming.kicks-ass.net>
References: <20200629201529.1017485-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629201529.1017485-1-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 10:15:29PM +0200, Sebastian Andrzej Siewior wrote:
> The novalidate class is ignored in the lockchain validation but is
> considered in the wait context validation.
> If a mutex and a spinlock_t is ignored by using
> lockdep_set_novalidate_class() then both locks will share the same lock
> class. From the wait validation point of view the mutex will then appear
> like a spinlock_t and the validator will complain if another mutex will
> be acquired.
> 
> Ignore the nonvalidate locks from wait context checking.

Hurmph.. but how? There was only a single user... /me greps.

drivers/base/core.c:    lockdep_set_novalidate_class(&dev->mutex);
drivers/md/bcache/btree.c:      lockdep_set_novalidate_class(&b->lock);
drivers/md/bcache/btree.c:      lockdep_set_novalidate_class(&b->write_lock);

Urgh.. there's more now :-(

So write_lock, like dev->mutex is a mutex.

Kent, what's the story with b->lock? It appears to have lockdep
annotations, but then is also the novalidate class. Also neither of
these lockdep_set_novalidate_class() thingies have a comment.

Anyway, all 3 users should have the same wait context, so where is the
actual problem?
