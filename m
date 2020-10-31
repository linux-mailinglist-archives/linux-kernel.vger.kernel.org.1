Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD112A156F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 12:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgJaLYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 07:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgJaLYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 07:24:02 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87C6C0613D5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 04:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aaTUzBXwQO/J+bu+h7OsQYjG1VKL1fScy4nkM4KuPEE=; b=PjPdXcSFJ2Wh+KYW8WE6N9bnb0
        6zz1U21T50+3VR2iwJqNwrPWHpGKrKIGzM669nzk47yytJ3PqKoZGffs/OmYwT7+tDnn0PA/l+45K
        gKx9KYfx2gJf+Pwycla+W4EC+RZwpRW/8J+dFONQFNMNFXHfOMn8fsmGJ47qXt/+Q/Aqw3grKY7Ee
        Zp7HeS4UjiAow/FozMNOPrBCEoq4lnIya7yHlP4JIWIouPC54juL6evuXLYvg2XPPNs/xhAM/mqDd
        JGFF/7CMjbn7bcXoqcmI01AXbdWrQUFVSKINIlTRk0bFIOh3xxyd5uN7kQfwceMi5gEzWaiVqOeXh
        0bO10IKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYoz1-0004Ep-M0; Sat, 31 Oct 2020 11:23:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8004730377D;
        Sat, 31 Oct 2020 12:23:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43F522BE225BB; Sat, 31 Oct 2020 12:23:40 +0100 (CET)
Date:   Sat, 31 Oct 2020 12:23:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, eranian@google.com
Subject: Re: [PATCH 4/6] perf: Optimize get_recursion_context()
Message-ID: <20201031112340.GU2594@hirez.programming.kicks-ass.net>
References: <20201030151345.540479897@infradead.org>
 <20201030151955.187580298@infradead.org>
 <20201030181138.215b2b6a@carbon>
 <20201030162248.58e388f0@oasis.local.home>
 <87v9erl5tx.fsf@nanos.tec.linutronix.de>
 <20201030193124.7a1ba64e@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030193124.7a1ba64e@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 07:31:24PM -0400, Steven Rostedt wrote:

> Note, I thought that in_nmi() and friends was in interrupt.h, but is
> really in preempt.h. All the values used in Peter's code is also
> defined in preempt.h, so why not have something like that there?
> 
> I take back adding it to interrupt.h but have it in preempt.h, as it's
> not defining anything new there.

Yeah, preempt.h is the right place for it.
