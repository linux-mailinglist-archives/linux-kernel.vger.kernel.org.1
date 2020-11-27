Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5862C681F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 15:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbgK0Op6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 09:45:58 -0500
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:55567 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730573AbgK0Op6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 09:45:58 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id 3EED1BAAAB
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 14:45:56 +0000 (GMT)
Received: (qmail 22099 invoked from network); 27 Nov 2020 14:45:56 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Nov 2020 14:45:55 -0000
Date:   Fri, 27 Nov 2020 14:45:54 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpuidle: Allow configuration of the polling interval
 before cpuidle enters a c-state
Message-ID: <20201127144554.GQ3371@techsingularity.net>
References: <20201126171824.GK3371@techsingularity.net>
 <CAJZ5v0hz4dBzUcvoyLoJf8Fmajws-uP3MB-_4dmzEYvMDJwEwQ@mail.gmail.com>
 <20201127140811.GA39892@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201127140811.GA39892@fuller.cnet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 11:08:11AM -0300, Marcelo Tosatti wrote:
> > It requires the admin to know how cpuidle works and why this
> > particular polling limit is likely to be suitable for the given
> > workload.  And whether or not the default polling limit should be
> > changed at all.
> 
> KVM polling (virt/kvm/kvm_main.c grow_halt_poll_ns/shrink_halt_poll_ns)
> tries to adjust the polling window based on poll success/failure. 
> 
> The cpuidle haltpoll governor (for KVM guests) uses the same adjustment
> logic.
> 
> Perhaps a similar (or improved) scheme can be adapted to baremetal.
> 
> https://www.kernel.org/doc/Documentation/virtual/kvm/halt-polling.txt

I'm aware of the haltpoll governor and why it makes sense for KVM. As
adaptive polling would increase the exit latency, I assumed it would be
an unpopular approach on bare metal. If that is not the case, then it
would make more sense that the haltpoll adaptive logic would simply be
part of the core and not a per-governor decision.

-- 
Mel Gorman
SUSE Labs
