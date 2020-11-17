Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DCC2B673C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbgKQOSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbgKQOSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:18:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7EAC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 06:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d94pWItf06chTJyUlOmy1+HuG1Hxc8kKaH3OKG1w9rM=; b=jTrJHoZfwOrZ37BlfJHjn1UidY
        Jn/1foLUH6QeLtBKOUelM2UQPr/IDHyI6YcUcpM2hqMGLWYaVnrGpp/3YqJjhSXciO2OAphPjtWdv
        IRDjiKLgutnTQmMTRbrIRWrysz1zhKIx2HHN1AlEgwG/pN65zuwJWjJ+J9Fn2b0T+bKHh1c9Fqywa
        RXMtwXaTZE0lx4rInlQQSXjBiO0PdaGgpaKfJekBLLKT0kSPHiya/WDYJuf4ms9UZDL+JKuDjDE16
        EaHpZdtLTysbofN7+0kOVZlgo9jkmUVEFTxfXY8RmMUHHWIvGCXm6lMN9C8h2/TJ+avAsE6pvpb8q
        pSPUdbQg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf1oF-0000uO-NN; Tue, 17 Nov 2020 14:18:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 867F53079AD;
        Tue, 17 Nov 2020 15:18:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 66C6F2B834021; Tue, 17 Nov 2020 15:18:14 +0100 (CET)
Date:   Tue, 17 Nov 2020 15:18:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 3/3] sched/numa: Limit the amount of imbalance that can
 exist at fork time
Message-ID: <20201117141814.GN3121392@hirez.programming.kicks-ass.net>
References: <20201117134222.31482-1-mgorman@techsingularity.net>
 <20201117134222.31482-4-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117134222.31482-4-mgorman@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 01:42:22PM +0000, Mel Gorman wrote:
> -			if (local_sgs.idle_cpus)
> +			if (local_sgs.idle_cpus >= (sd->span_weight >> 2))
>  				return NULL;

Is that the same 25% ?
