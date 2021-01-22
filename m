Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CBB30041E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbhAVNZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbhAVNZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:25:35 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFB3C061786
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sRwfarFZhTVmYWlK+o1dwCJ5oB22u7WyS+Fsj57dY/E=; b=qX10gDxRLKfC6rMgJ4yoKJDEpg
        4OiEmMu1tTNKpKSczctiuiYEMUfrnc2coFzamYPZZRQfXZASy4dOm4LZ8kK3PQ9JzvXsQ/X2+IXDv
        Jj7r2GZnnSPbZJm+llYhvq67znfUJZRc1K1AO1z/AQ4qU/zvlX4nr6YIZflRjWHlRONuUPvAeoIIG
        NesJokBQZcRBThMGfyp7yTTTpTFKh4sspOalLeFYsioNQ3V9ogFwfTslWf0Cn5DPpb0XdNEhbi7hU
        7iOToOYPH4DmeLkp+Oj+SGcYTvOp8fGldL/b0KIsCaUKvXVz+1IOZ/hyVm6iSvzVqmYspSB0t+aXD
        eacaK9Ng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2wQi-0004uF-TC; Fri, 22 Jan 2021 13:24:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 39FDB3007CD;
        Fri, 22 Jan 2021 14:24:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE306200D6ED2; Fri, 22 Jan 2021 14:24:43 +0100 (CET)
Date:   Fri, 22 Jan 2021 14:24:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCHv2] lockdep: report broken irq restoration
Message-ID: <YArSGwEI0xqBncrv@hirez.programming.kicks-ass.net>
References: <20210111153707.10071-1-mark.rutland@arm.com>
 <20210122110625.GA29868@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122110625.GA29868@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 11:06:25AM +0000, Mark Rutland wrote:
> Hi all,
> 
> Any thoughts on this? I'd like to get this in soon if we could as it'll
> help to flush out any remaining issues that are liable to get in the way
> of planned rework for arm64 and x86.
> 

Ah, I actually have it queued, I'll try and push it out to locking/core
later today.
