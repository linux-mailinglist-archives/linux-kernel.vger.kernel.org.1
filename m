Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB072AF9A0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 21:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgKKUQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 15:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKUQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 15:16:03 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7D3C0613D1;
        Wed, 11 Nov 2020 12:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7LHGTNUf7dey0U0w03Ij+3+eKYy3ed98Q8PXwpusvhI=; b=pDku5hJQ+T4HmJTeDHAP/Mwl3w
        q8j5+NpBxoA5yotRzMh5uCsQh5K3ZPhuR1hLvMOoihO4nlWf6EPibqu2JmCp42M9V3vYbrlabMJE0
        kiyb+0Z/yaMEt8TGmhox0R1r+ZAas/eUyki1fg16ZsbBtR4PB+OV7EWBNBPJKyw7JlOXNebL5u18p
        oMiO2CgU0v8R/u2LcbnjKOxd1yslBFNTQGD01KW4VQFklIGbocZvR7gJZDvCfMnA9X2c1kyVbNgH0
        Jyrrb62Je4+QTtj7mZbZJRh4VuHFLrykokvjr6yKMoKUxoFkU2Yi8Rt6gFVEZy5TCpBMzdNxG9Q3M
        PTKezHFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcwX9-0003l9-BD; Wed, 11 Nov 2020 20:15:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 788A4301A42;
        Wed, 11 Nov 2020 21:15:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64AF52BCE964C; Wed, 11 Nov 2020 21:15:55 +0100 (CET)
Date:   Wed, 11 Nov 2020 21:15:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] seqnum_ops: Introduce Sequence Number Ops
Message-ID: <20201111201555.GN2628@hirez.programming.kicks-ass.net>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <d265685c901ea81c83c18e218a29710317ab7670.1605027593.git.skhan@linuxfoundation.org>
 <20201111082320.GR2611@hirez.programming.kicks-ass.net>
 <7207fad6-6ca4-529b-60a8-63db998d10d9@linuxfoundation.org>
 <20201111160411.GF2628@hirez.programming.kicks-ass.net>
 <3fccb8d5-825a-a283-7b7e-6193e0c90237@linuxfoundation.org>
 <20201111175031.GI2628@hirez.programming.kicks-ass.net>
 <0aed620f-911d-4715-bd41-a6b9a37862b4@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aed620f-911d-4715-bd41-a6b9a37862b4@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 11:28:13AM -0700, Shuah Khan wrote:
> On 11/11/20 10:50 AM, Peter Zijlstra wrote:
> > On Wed, Nov 11, 2020 at 10:34:05AM -0700, Shuah Khan wrote:
> > 
> > > Not sure what to make of the 6080 atomic_read()s and 3413
> > > atomic_inc()s, some of which might be assuming uniqueness
> > > guarantee.
> > 
> > Well, clearly you just did: git grep atimic_{read,inc}() | wc -l and
> > didn't look at the usage. Equally clearly there can be bugs. Also
> > evidently much of those are not in fact sequence numbers.
> > 
> 
> Looking at the usage and classifying which usages are sequence
> numbers is part of may audit and we are covered. Your explanation
> and this discussion helps with do a better audit of these usages.

Auditing is fine, but I still don't see any point in actually having
these wrapping types. It's all a waste of space and compile-time IMO.

Neither this sequence counter, nor stat_t or whatever else bring any
actual differences. They're pure wrappers without change in semantics.

refcount_t is useful because it brought different semantics, it raises
exceptions on invalid usage (wraps). But this is just pointless NOPs.

So do your audit, but only introduce new types for things that actually
have different semantics. If you do a patch and the generated code is
100% identical but you have many more lines of code, you've only made it
worse.
