Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF3D2A02EC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgJ3Kcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgJ3Kcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:32:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7987CC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kC/iXaDnkViO/EwRpn2Zres8ZBb6cXxROXB9UOEHSbs=; b=hNjlIC5tcT5H8d3IRZGvnYIri0
        le5yP2DFrM+Fk3q01mXPY1O7RkVARmyeasyWb9MjOFAUjYLdxVdi9WQZihB9e+Ch9R8jK01qtX3Xn
        nBqXtHS88ToUbgOsjSuyraM9pTaTyX2UWZmXuYA14n7tGDYFreBiW2U8Ree64zBM9PKQXCE/HiPd/
        E6gKRCtGkvhf0BJUcTx2HmCxBpa6rNY+TYs2DW7bR8fszuncD3kO4NxAv6tXFDVKhC2vVaDcz8i2w
        BGi9sYhXvITH2Gi9Vs9Ys1tkr7gAmlTwafEoqTc/8BKp8ypC9kMyelq/41t6xvzgszRlKbkXKtAG4
        xEe0yR3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYRhl-0001Lw-DN; Fri, 30 Oct 2020 10:32:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9C4A83012C3;
        Fri, 30 Oct 2020 11:32:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 521CA203F0EC3; Fri, 30 Oct 2020 11:32:20 +0100 (CET)
Date:   Fri, 30 Oct 2020 11:32:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, kan.liang@linux.intel.com,
        like.xu@linux.intel.com
Subject: Re: [BUG] Stack overflow when running perf and function tracer
Message-ID: <20201030103220.GH2611@hirez.programming.kicks-ass.net>
References: <20201030002722.766a22df@oasis.local.home>
 <20201030090037.GZ2628@hirez.programming.kicks-ass.net>
 <877dr8nh6u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dr8nh6u.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 11:26:01AM +0100, Thomas Gleixner wrote:

> > The only thing I can come up with in a hurry is that that dummy_iregs
> > thing really should be static. That's 168 bytes of stack out the window
> > right there.
> 
> What's worse is perf_sample_data which is 384 bytes and is 64 bytes aligned.

Urgh, that thing just keeps on growing :/

I'll try and have a look if we can both shrink the thing and move it off
stack.
