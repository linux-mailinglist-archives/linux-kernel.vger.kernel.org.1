Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019882CAB27
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbgLAS4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLAS4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:56:43 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F42C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 10:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dP2aCGWV/QSuw3IqWekjEcVu6Gni8QIpKfoVcyJye9g=; b=0KTLGIr+J0voSyZKVgGtj/P7CP
        tTiyqemcQV5lMmwn/kvNMH97gkEv8jO2dxJyX3u1AHDXqkwuW0ksbtGmQkZvemfakBXQnEVMkEcJM
        idKQeRsgEtkrfLbm5wa+qzVJ6JM436Rmwqkv06+XBm0PlHpHzgSHKFoOtOikyq2EMPcG6O0cjb4wA
        fTxDzULqFRFKfFd/HWL1VarYB8jGTdqES09e213+o6zH83N7L2U5gtzANdPL64+97KYuL6XzFTDTz
        mUnx8Bgbh5PlueuZVqq7+wTf49z0NrJlRuzPRymhoo53ncvN41LK4oFbQ61FmnPVo4maw+oae0n8g
        ISzYb6hg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkAog-0000dn-I9; Tue, 01 Dec 2020 18:55:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F2E2D30018A;
        Tue,  1 Dec 2020 19:55:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DDF3E2BF16C04; Tue,  1 Dec 2020 19:55:56 +0100 (CET)
Date:   Tue, 1 Dec 2020 19:55:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anton Blanchard <anton@ozlabs.org>
Subject: Re: [PATCH 3/3] membarrier: Propagate SYNC_CORE and RSEQ actions
 more carefully
Message-ID: <20201201185556.GV3040@hirez.programming.kicks-ass.net>
References: <cover.1606758530.git.luto@kernel.org>
 <5495e4c344dc09011ff57756c7e0a1330830eafc.1606758530.git.luto@kernel.org>
 <20201201101637.GU2414@hirez.programming.kicks-ass.net>
 <CALCETrUZHWvjO8otEWat6SDwDFRdV0iSp=RZDaHnyytJ=4a6cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUZHWvjO8otEWat6SDwDFRdV0iSp=RZDaHnyytJ=4a6cg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 10:09:22AM -0800, Andy Lutomirski wrote:
> > smp_call_function_single(.wait=1) already orders against completion of
> > the IPI. Do we really need more?
> 
> What kind of order does it provide?  A quick skim of the code suggests
> that it's an acquire barrier, but I think we need a full sequential
> consistency barrier, at least on sufficiently weakly ordered
> architectures.  On x86, loads are ordered and this is probably
> irrelevant.  Also, this barrier was already there (it's the one I
> deleted below), and I think that removing it should be its own patch
> if we want to go that route.

	smp_mb()
	raise-IPI ---->
			<IPI>
			  /* do crud */
			  STORE-RELEASE csd->lock, 0;
			</IPI/

	LOAD-ACQUIRE csd->lock


