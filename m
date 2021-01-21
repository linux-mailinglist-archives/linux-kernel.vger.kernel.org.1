Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729212FF7E5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 23:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbhAUW0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 17:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbhAUW0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:26:06 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1230C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 14:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NG5KS4OdJNBNSHQTFqtR/Lx/ADjpfnKN/uLlnpd58vI=; b=IkF01Boe4Rs4NtRHf3OBJ3d71t
        H4CD0QdynQd6if3uLsCUWxpZQAm8TFKjZAeirqnhgqb279Eilf+QNiNNYXA7aL07YmapcBSrcLjxb
        sYBPuJDv5yRcyAVmuBPKp6H35+F6/03X3S4ia/G9rthGjTs37K5aBtjF5O7JJsAzp52bpVa6dKMAK
        R13ctjP4GmwTwVQAJwJCm+HcjJOwk0uEtpz3cbyONQ0tQ7wIZpG0cT1G/y7l1n8ER06FvczqwQ9Kv
        7NFyG3sciaSSYrFW6DiZblqCyuk1lBcDXSB/RWriSbObL9ui9siBNH4zyHQrdjZGJMP/+ZtekBXb7
        AV4hf+1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2iOD-0007G8-8D; Thu, 21 Jan 2021 22:25:17 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E164E9841F6; Thu, 21 Jan 2021 23:25:12 +0100 (CET)
Date:   Thu, 21 Jan 2021 23:25:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 6/8] preempt/dynamic: Provide
 preempt_schedule[_notrace]() static calls
Message-ID: <20210121222512.GA21484@worktop.programming.kicks-ass.net>
References: <20210118141223.123667-1-frederic@kernel.org>
 <20210118141223.123667-7-frederic@kernel.org>
 <20210121215826.GB16371@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121215826.GB16371@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 10:58:26PM +0100, Peter Zijlstra wrote:
> I'm thinking the above doesn't build for !PREEMPT_DYNAMIC, given it
> relies on the STATIC_CALL unconditionally, but we only define it for
> PREEMPT_DYNAMIC:

Ooh, I see, x86 cannot get there anymore.
