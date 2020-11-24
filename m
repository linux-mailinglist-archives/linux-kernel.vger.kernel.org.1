Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1732C2962
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388873AbgKXOXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731656AbgKXOXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:23:12 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5927FC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+Y3Hzccj3kNWKA+Fq9a4rpUhCDRfohJChJu1uJl6Seg=; b=RgNIne4l9wuC60z2fu3qXgNqcH
        FZTMUCHC3N8oCnMaprN0X5+4we+QC23CMXd3MOKrSiHoKcqLDHpv4xiMPJs3bQFTxi3id1lSa8lJb
        S9b0M0WR8m3guGciSqOEV+XplQ22XPtjedPg8KKvIFpo+QohoqOVJsKvf4j0qW6ClNeL06avn+emy
        rkI/gz16MZPgG1x/H5gCY+nxejQ/TFKta8db2s3dgv9d97V/hPmQ8klaxtsQNBKqrPHVh2h8vmEEK
        aW820X/AQWl+yj7y8AbFFz33PkekoEUgu7FsY3z2xxAekvZofjhZNUJTxnrLt2GZziejnx0ZBBQYX
        yyJ0g4fQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khZDk-00072H-Pt; Tue, 24 Nov 2020 14:23:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9CA41306E56;
        Tue, 24 Nov 2020 15:23:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E3CD20222D7E; Tue, 24 Nov 2020 15:23:03 +0100 (CET)
Date:   Tue, 24 Nov 2020 15:23:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, mingo@kernel.org,
        x86@kernel.org, mark.rutland@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] More RCU vs idle fixes
Message-ID: <20201124142303.GF3092@hirez.programming.kicks-ass.net>
References: <20201120114145.197714127@infradead.org>
 <yt9dv9du7tow.fsf@linux.ibm.com>
 <20201124141853.GG2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124141853.GG2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 03:18:53PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 24, 2020 at 02:47:27PM +0100, Sven Schnelle wrote:
> > Peter Zijlstra <peterz@infradead.org> writes:
> > 
> > > Both arm64 and s390 are tripping over arch_cpu_idle() RCU,tracing,lockdep
> > > interaction. While looking at that I also found fail in inte_idle.
> > >
> > > Please consider for this cycle.
> > 
> > Is anyone taking this patchset?
> 
> I think I'll stuff it in x86/urgent for lack of a better place.

Ah, locking/urgent might be a better place I suppose.
