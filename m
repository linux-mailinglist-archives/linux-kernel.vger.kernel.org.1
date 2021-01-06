Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415682EBBE0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 10:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbhAFJvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 04:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbhAFJvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 04:51:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F93C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 01:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W0OTywhWfbLTNxAki2N8MQFvTOCjHX4ICZyvkpyBfr0=; b=Lhh+7CLTBFOALHM6dnNlkoW6wh
        L6hHVGZ4TVOJfmRetubHGjqsnn82leLcLVMExJhwjG1MXx4/B6/FIMa0GH7qQb3N2BC1DifyCMgal
        wvanuKAZhXh1Y1hRXIlUqxStgsob0tVxnyZs0g8W1wbHJZDLNGkMcTfrfcw68ply1BOW3ipl557P4
        cMHlFoARI783btX2uzVqwzSnIW2kucdKuJDnlPgIm5I5Wcdp6sXPdfvdLrQ0WSuvuv39T7uNihwDd
        xxsxmpJS1g+dxgPC/Gd9s7jT2NABLad+aCnoDEqB4VSX/ey/bHLQ4JKaUnDNLZm/Wsb4pq0uBlIy+
        /YK9alpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kx5RG-002CkE-PZ; Wed, 06 Jan 2021 09:49:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 72BDF3060AE;
        Wed,  6 Jan 2021 10:49:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 352092029F4C3; Wed,  6 Jan 2021 10:49:07 +0100 (CET)
Date:   Wed, 6 Jan 2021 10:49:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        kernel-team@fb.com, Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH RFC cpumask 4/5] cpumask: Add "last" alias for cpu list
 specifications
Message-ID: <X/WHk1hY3cmMAXQz@hirez.programming.kicks-ass.net>
References: <20210106004850.GA11682@paulmck-ThinkPad-P72>
 <20210106004956.11961-4-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106004956.11961-4-paulmck@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 04:49:55PM -0800, paulmck@kernel.org wrote:
> From: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> It seems that a common configuration is to use the 1st couple cores
> for housekeeping tasks, and or driving a busy peripheral that generates
> a lot of interrupts, or something similar.
> 
> This tends to leave the remaining ones to form a pool of similarly
> configured cores to take on the real workload of interest to the user.
> 
> So on machine A - with 32 cores, it could be 0-3 for "system" and then
> 4-31 being used in boot args like nohz_full=, or rcu_nocbs= as part of
> setting up the worker pool of CPUs.
> 
> But then newer machine B is added, and it has 48 cores, and so while
> the 0-3 part remains unchanged, the pool setup cpu list becomes 4-47.
> 
> Deployment would be easier if we could just simply replace 31 and 47
> with "last" and let the system substitute in the actual number at boot;
> a number that it knows better than we do.
> 
> No need to have custom boot args per node, no need to do a trial boot
> in order to snoop /proc/cpuinfo and/or /sys/devices/system/cpu - no
> more fencepost errors of using 32 and 48 instead of 31 and 47.
> 
> A generic token replacement is used to substitute "last" with the
> number of CPUs present before handing off to bitmap processing.  But
> it could just as easily be used to replace any placeholder token with
> any other token or value only known at/after boot.

Aside from the comments Yury made, on how all this is better in
bitmap_parselist(), how about doing s/last/N/ here? For me something
like: "4-N" reads much saner than "4-last".

Also, it might make sense to teach all this about core/node topology,
but that's going to be messy. Imagine something like "Core1-CoreN" or
"Nore1-NodeN" to mean the mask all/{Core,Node}0.

And that is another feature that seems to be missing from parselist,
all/except.
