Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204F82CB687
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgLBIOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbgLBIOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:14:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3E3C0613CF;
        Wed,  2 Dec 2020 00:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m7XGXo5FAAEugLV1u88NkGUPs9D51UU3stXF21wYGQk=; b=V3dl9hKMTVfSag3GGg76k3tfto
        bLzhhJJPUjKSU13erPPs+Oqo9MvHzpFfaWCtfi2COpw9rVS7O9/ckFmtV11tk5ccaHR3m6pMICP4V
        Qr/xDMMBDefV/unGtdy/twwryZkNvk7yYBJL0oCZUJ9idCwAkxKWNc+krgSMLPti6oZLsHL6GWopU
        VrR3FPyWBsbQVIpoDtbu3fi+vqK8yVsWlIrI9vLuYmqkVVbNOMLBhbVf6UaY4Wu3gAyKAZnxXBGV0
        KkRpGevMd0wZa884lInRXeHYM5yTHH7tKVYgpMAdoZnoAaPYOAOIkO/BW0Na9iwrxN+/MCCMdurL9
        p6LYXBTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkNGq-0004wk-50; Wed, 02 Dec 2020 08:13:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6D5B73035D4;
        Wed,  2 Dec 2020 09:13:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B1872C87A739; Wed,  2 Dec 2020 09:13:51 +0100 (CET)
Date:   Wed, 2 Dec 2020 09:13:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 13/16] sched: fix kernel-doc markup
Message-ID: <20201202081351.GF3021@hirez.programming.kicks-ass.net>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
 <50cd6f460aeb872ebe518a8e9cfffda2df8bdb0a.1606823973.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50cd6f460aeb872ebe518a8e9cfffda2df8bdb0a.1606823973.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 01:09:06PM +0100, Mauro Carvalho Chehab wrote:
> Kernel-doc requires that a kernel-doc markup to be immediately
> below the function prototype, as otherwise it will rename it.
> So, move sys_sched_yield() markup to the right place.
> 
> Also fix the cpu_util() markup: Kernel-doc markups
> should use this format:
>         identifier - description
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks!
