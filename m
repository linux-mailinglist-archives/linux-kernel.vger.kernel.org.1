Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBABF2160EE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 23:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgGFVV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 17:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFVV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 17:21:57 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B92C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 14:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bvNzU1/i5HWoFHcEdnm+49UroNCpJNDXqIVNrFmzAkA=; b=xJ7t+EAbs3c5bxug+tOGtMf/au
        SHuySTMsBOIMOHnYrHMerQRGhyE+XWYqRkj73GN+Udbpvn3hcpDtrAo+XOaxfuFMH6kfCUwZXRdn2
        sTaN0T5WXA9TXMzIGi7ByozjlaaDUolxvWVYIRX7cj12B3hYnZte/CegPBlrnjy+Ud8w/T9kfZzQ0
        2jf9LBAtSZ/ZecTaqISO5asKJk3IRzI8XB1H4fEE3GGCurUiNMVfrU5MVPcB066nuK2S5sWXisasJ
        nVCtjS7QgCHGSGPmxspilRORy82mvEqCsu0qYmbNwDRikilY+uavamX43NOdGsOcbMKdzHOVorox1
        dh7+ye3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsYYg-0004Ky-Gh; Mon, 06 Jul 2020 21:21:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B02BF980DD2; Mon,  6 Jul 2020 23:21:48 +0200 (CEST)
Date:   Mon, 6 Jul 2020 23:21:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/20] seqlock: Extend seqcount API with associated
 locks
Message-ID: <20200706212148.GE5523@worktop.programming.kicks-ass.net>
References: <20200630054452.3675847-1-a.darwish@linutronix.de>
 <20200630054452.3675847-7-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630054452.3675847-7-a.darwish@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 07:44:38AM +0200, Ahmed S. Darwish wrote:
> +#include <linux/seqlock_types_internal.h>

Why? why not include those lines directly here? Having it in a separate
file actually makes it harder to read.
