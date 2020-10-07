Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7102869D4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 23:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgJGVHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 17:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgJGVHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 17:07:32 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940AAC061755;
        Wed,  7 Oct 2020 14:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kp6M9sa3E5EPoQgNd9zsEju6IDJAVemYmPcmfSdh864=; b=uIS3Q6uVslDaqaySF3Y3oIRPpf
        LAKgQQ6OMnRD84pkqiEhu9T6Fv9SiiwDOI4YLYjpi3/InbyqHWxwd0XdiWbnoN2ljNo4N2w0oiFHM
        pZNaiUOSdGjTEqL+xhZX8lpAzEwzNbV2ps3icJq4JFrju6diFe+Y0N7lI/doKhDy7Q2wV4cOA6CsM
        Xf27KjcyMIfPPLidNX+5kwy0PPWOvMybV3wKnm+AU7iQydJZFw35e0ijPMw8S7wi7pKVVQwx2Ch9O
        OZiDBSt/YKpEqGhiu51ULSAD5cDx9uM1MCvcNkZ9iOlwNMRVJ48T7tx5t6JFnW3MUhsV+KxNztlvB
        oLQ1TGvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQGed-0006GJ-TE; Wed, 07 Oct 2020 21:07:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 866843006D0;
        Wed,  7 Oct 2020 23:07:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 74C202B2CAB81; Wed,  7 Oct 2020 23:07:17 +0200 (CEST)
Date:   Wed, 7 Oct 2020 23:07:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        linux-toolchains@vger.kernel.org, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        torvalds@linux-foundation.org
Subject: Re: Control Dependencies vs C Compilers
Message-ID: <20201007210717.GP2628@hirez.programming.kicks-ass.net>
References: <20201006114710.GQ2628@hirez.programming.kicks-ass.net>
 <875z7nm4qm.fsf@oldenburg2.str.redhat.com>
 <20201007093243.GB2628@hirez.programming.kicks-ass.net>
 <87k0w2gww6.fsf@oldenburg2.str.redhat.com>
 <20201007115054.GD2628@hirez.programming.kicks-ass.net>
 <20201007171107.GO29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007171107.GO29330@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 10:11:07AM -0700, Paul E. McKenney wrote:

> Challenges include:
> 
> o	Unmarked accesses.  Compilers are quite aggressive about
> 	moving normal code.

Which is why this thread exists :-) We wants to dis-allow lifting the
stores over our volatile-if.

> o	Separately compiled code.  For example, does the compiler have
> 	unfortunatel optimization opportunities when "volatile if" 
> 	appears in one translation unit and the dependent stores in
> 	some other translation unit?

It can hardly lift anything outside a TU (barring the next point). So I
don't see how it can go wrong here. This is in fact the case with the
perf ringbuffer. The ctrl-dep lives in a different TU from the
stores.

> o	LTO, as has already been mentioned in this thread.

So I would probably advocate the volatile-if to be a full sync point,
and LTO would have to preserve that.

