Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CCA1C0203
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 18:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgD3QSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 12:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgD3QSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:18:22 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE94220873;
        Thu, 30 Apr 2020 16:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588263501;
        bh=5R1P59XWFriRjxe5e4BwtfyFc/8B5tCSKlTVbm120WY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FWbHYicdfPDjjYeJPc0wx5uyaSBePyMtYHG2jq9/y3Rlj3rPkum04ZiSQO0BYAPhV
         G23qhA6RGP/lsaiuQobgqfndHcI8FOhOFgn7t8uKNyIQHmNPGohnUTGMARV8YBFbd6
         Cvzu10wcz3BXUOIM4uUTYofcgbV5A4wsexskA3rI=
Date:   Thu, 30 Apr 2020 17:18:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marc Zyngier <maz@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Al Grant <Al.Grant@arm.com>, James Clark <James.Clark@arm.com>,
        tglx@linutronix.de
Subject: Re: [PATCH] arm64: perf_event: Fix time_offset for arch timer
Message-ID: <20200430161815.GE25258@willie-the-truck>
References: <20200320093545.28227-1-leo.yan@linaro.org>
 <20200430145823.GA25258@willie-the-truck>
 <4d924f705245c797a19d3a73eb0c1ba0@kernel.org>
 <20200430160436.GC13575@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430160436.GC13575@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 06:04:36PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 30, 2020 at 04:29:23PM +0100, Marc Zyngier wrote:
> 
> > I wonder if we could/should make __sched_clock_offset available even when
> > CONFIG_HAVE_UNSTABLE_SCHED_CLOCK isn't defined. It feels like it would
> > help with this particular can or worm...
> 
> Errrgh. __sched_clock_offset is only needed on x86 because we transition
> from one clock device to another on boot. It really shouldn't exist on
> anything sane.

I think we still transition from jiffies on arm64, because we don't register
with sched_clock until the timer driver probes. Marc, is that right?

> Let me try and understand your particular problem better.

I think the long and short of it is that userspace needs a way to convert
the raw counter cycles into a ns value that can be compared against values
coming out of sched_clock. To do this accurately, I think it needs the
cycles value at the point when sched_clock was initialised.

Will
