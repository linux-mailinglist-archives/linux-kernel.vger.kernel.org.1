Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CE62885CC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 11:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733037AbgJIJMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 05:12:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:54708 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732712AbgJIJMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 05:12:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602234739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tFEwM9P+2Pgk3Bpz9/Ar38HVU3AgqZXMl54cBXbjv8o=;
        b=qSU5CqC+xWE7VQU/xG9shjjgjNJbtbp7K0xONm1bzOeyiOaPSomwtre7hK3xMPNEJUY7v/
        XUqrDFhVOitju5mowGEhjMpobEcggrp9Yv5ICwH7q3oRCcDZTgj+A5O8Ihn6E8XesV38mp
        yfu5mi2OgHIbWybw4/f6KbeZZK1Z1Ac=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4ECE5ACF6;
        Fri,  9 Oct 2020 09:12:19 +0000 (UTC)
Date:   Fri, 9 Oct 2020 11:12:18 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Frederic Weisbecker <fweisbecker@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH] kernel: allow to configure PREEMPT_NONE,
 PREEMPT_VOLUNTARY on kernel command line
Message-ID: <20201009091218.GF4967@dhcp22.suse.cz>
References: <20201007120401.11200-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007120401.11200-1-mhocko@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07-10-20 14:04:01, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Many people are still relying on pre built distribution kernels and so
> distributions have to provide mutliple kernel flavors to offer different
> preemption models. Most of them are providing PREEMPT_NONE for typical
> server deployments and PREEMPT_VOLUNTARY for desktop users.
> 
> Having two different kernel binaries differing only by the preemption
> mode seems rather wasteful and inflexible. Especially when the difference
> between PREEMPT_NONE and PREEMPT_VOLUNTARY is really minimal. Both only
> allow explicit scheduling points while running in the kernel and it is
> only might_sleep which adds additional preemption points for
> PREEMPT_VOLUNTARY.
> 
> Add a kernel command line parameter preempt_mode=[none, voluntary] which
> allows to override the default compile time preemption mode
> (CONFIG_PREEMPT_NONE resp. CONFIG_PREEMPT_VOLUTARY). Voluntary preempt
> mode is guarded by a jump label to prevent any potential runtime overhead.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
> 
> Hi all,
> this is sent as an RFC because it still needs some work. E.g. move jump
> label changes into their own patch. They are needed mostly to get rid of
> header files dependencies (seen for CONFIG_JUMP_LABEL=n via atomic.h ->
> bug.h).
> 
> I wanted to make sure that the idea is sound for maintainers first. The
> next step would be extending the command line to support full preemption
> as well but there is much more work in that area. Frederic has promissed
> to look into that.
> 
> Thoughts?

Is there any additional feedback? Should I split up the patch and repost
for inclusion?
-- 
Michal Hocko
SUSE Labs
