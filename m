Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841CC2B5CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgKQKX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgKQKX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:23:57 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9430EC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PLCbxDMS9aH1+jeBjl8bCvZMuB8m7dHd9PEmMMXu8mA=; b=FHnvN/09tjB32H+Q7VrF35DxXx
        R096DNEsCmE7ZrpgdUB3fb5yYKPW2vGpuXQRKxQ+E4nvBaT25Bm0gBqV9Hr1IxY7/5eJDFJAubU4d
        AAph/t/Y1PexJGlTWSNGJZ4rGUPZrIsf1WOHQ6PPN8n5PGyhWdKhEC/jx168V9y+PzDCCMlYf3H1s
        K/rdtJpzrKAR+w1ZIszcgw2y3PNeMhYj1e3qQZ69mQaixnMIttRoSUUuvhNN2zNGZesj79gTmmjOb
        rV9oFRoYzOVqkXz/Ns+TpY0mTQIgryIVD0tcvmSvclcTL4vyYLGMbDUwi4l8p9fO/cBcv4t60YoNC
        MJ2yaQ8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1key9M-0006ZG-2g; Tue, 17 Nov 2020 10:23:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CAF57304D28;
        Tue, 17 Nov 2020 11:23:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA4EA200C6541; Tue, 17 Nov 2020 11:23:46 +0100 (CET)
Date:   Tue, 17 Nov 2020 11:23:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yun Hsiang <hsiang023167@gmail.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2] sched/uclamp: Allow to reset a task uclamp constraint
 value
Message-ID: <20201117102346.GF3121406@hirez.programming.kicks-ass.net>
References: <20201113113454.25868-1-dietmar.eggemann@arm.com>
 <20201115050521.GA1390370@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115050521.GA1390370@ubuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 15, 2020 at 01:05:21PM +0800, Yun Hsiang wrote:
> Hi Dietmar,
> On Fri, Nov 13, 2020 at 12:34:54PM +0100, Dietmar Eggemann wrote:
> > In case the user wants to stop controlling a uclamp constraint value
> > for a task, use the magic value -1 in sched_util_{min,max} with the
> > appropriate sched_flags (SCHED_FLAG_UTIL_CLAMP_{MIN,MAX}) to indicate
> > the reset.
> > 
> > The advantage over the 'additional flag' approach (i.e. introducing
> > SCHED_FLAG_UTIL_CLAMP_RESET) is that no additional flag has to be
> > exported via uapi. This avoids the need to document how this new flag
> > has be used in conjunction with the existing uclamp related flags.
> > 
> > The following subtle issue is fixed as well. When a uclamp constraint
> > value is set on a !user_defined uclamp_se it is currently first reset
> > and then set.
> > Fix this by AND'ing !user_defined with !SCHED_FLAG_UTIL_CLAMP which
> > stands for the 'sched class change' case.
> > The related condition 'if (uc_se->user_defined)' moved from
> > __setscheduler_uclamp() into uclamp_reset().
> 
> I think this is great, thanks!
> Reviewed-by: Yun Hsiang <hsiang023167@gmail.com>

Thanks!
