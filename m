Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0CE288988
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 15:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388067AbgJINDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 09:03:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:39384 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732468AbgJINDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 09:03:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602248624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GK3coka4JKr5h6VaBUij/uP3o5nU+N7gnzjAysRtMAw=;
        b=nrLxba9acrofSSN+o5K83yWYPgEkHW3hdUV/3YAAvgLYcq3w4XOPyoRe3DxxtscpIck6Ao
        DIvIHdArLkj6o718W5GiXqyg4TQ2BpUGeNerMRDR03ldRRjSecHQISCL8L2/9TOPps1mIn
        fo+S3+/M3WDYKgb9c9smVuw9UW6koC0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C5574AC6C;
        Fri,  9 Oct 2020 13:03:44 +0000 (UTC)
Date:   Fri, 9 Oct 2020 15:03:44 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/5] allow overriding default preempt mode from
 command line
Message-ID: <20201009130344.GN4967@dhcp22.suse.cz>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201009122926.29962-1-mhocko@kernel.org>
 <20201009125056.GN2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009125056.GN2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-10-20 14:50:56, Peter Zijlstra wrote:
> 
> Can you please not thread the new series onto the old one? That's some
> seriously annoying behaviour that I see more and more... It makes me
> loose whole patch-sets.

Sure, no problem. This is not really unusual in mm and I personally
prefer to have discussion in a single thread rather than separated in
two or more. But I definitely do not insist of course. It is surprising
that you are losing the whole patchset as the threading seems to be done
properly. Mutt doesn't seem to have problems with that.

Anyway, let me know if I should repost.

-- 
Michal Hocko
SUSE Labs
