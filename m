Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57EB28B3AC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388134AbgJLLVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387992AbgJLLVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:21:37 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8C4C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 04:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/2aTZMV+2S4NyMORmTfPJ7G20RSywvvEejTMHJJTKvU=; b=e8lgh9G9EYf39tvYlcs2jYDCZ9
        6DgKjdDcFZesLpoKDn0UE+pVYS9vryG1SXdAHOaSw3oS4x+a0VtLYpeis8r0EQsEn8TM32FoSWz9d
        +QcJeh4sS4tYpirJ+v2/+wRSpWK6YHmVRIh3X+8EtPMrbGqJ0FW1ooZZhGy+z5ibxj/4rcqE1G8z7
        Clcadjuu5Kc3PUEQ5rxZRg5Hp+pPnrNMnrNDD8hYlsU5YLXkef4dTWhPp7aE2eaChM2XLgW0itOSo
        7GLAvm/Dp0bUvkry5riz6ToqY57mmumulXEMMNwLsMiGR/9fuVTITb7sAEiLYL3kv0CHCB4gYweKb
        HqMeSfcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kRvtP-0006XN-PJ; Mon, 12 Oct 2020 11:21:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B8D09304B90;
        Mon, 12 Oct 2020 13:21:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9A2D920116727; Mon, 12 Oct 2020 13:21:24 +0200 (CEST)
Date:   Mon, 12 Oct 2020 13:21:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: SD_LOAD_BALANCE
Message-ID: <20201012112124.GT2628@hirez.programming.kicks-ass.net>
References: <alpine.DEB.2.22.394.2009031605190.2496@hadrien>
 <jhj7dtaokxe.mognet@arm.com>
 <alpine.DEB.2.22.394.2010101740290.2691@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2010101740290.2691@hadrien>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 06:14:23PM +0200, Julia Lawall wrote:
> Prior to v5.8 on my machine this was a rare event, because there were not
> many of these background processes.  But in v5.8, the default governor for
> Intel machines without the HWP feature was changed from intel_pstate to
> intel_cpufreq.  The use of intel_cpufreq triggers very frequent kworkers on
> all cores, which makes it much more likely that cores that are currently
> idle, and are overall not at all overloaded, will have a higher load
> average even with the waking thread deducted, than the core managing the
> wakeup of the threads.

Rafael, any idea what those kworkers are for, and can we get rid of
them?
