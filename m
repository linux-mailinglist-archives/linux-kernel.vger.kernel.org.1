Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9868F1F5663
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 16:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgFJOBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 10:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgFJOBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:01:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615C9C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 07:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GMi0Ua9JFHNIpwJn7G9f0a/rz8HG6okhtAeQWlJlfsA=; b=h8dINkly+hV2jecp86Jdq3QEF+
        3kFYzY2nVg4KaCPFx77KC2mVEv8dZyUULOwxxI465ELnKXsss6YaOskkLecz+GDp/VK2Cd3itJv3F
        gxI+pkh4mTvVwYwbssF2V5UTSViAFSAI2Qi5qtrlWedJGF/QjBS5j/OHPDCckGl5MpJgH/XG9mmSY
        MusfIRVDD2szibvTUMDd/JyvjxmSzKWRTWxcOcGAXjhsBzozeUxiZAVfzUmc2DNLaEZwPkS5fM7WL
        yWMK/W9IgMXzeFNP6ww/rWqzEkSeab3Hs0vgj8YFyV+iOMz9/zDvgiWVnM7omZMcVaI9prQCtmcJh
        CQ7s0H2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj1IK-0006z1-IR; Wed, 10 Jun 2020 14:01:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D85FF302753;
        Wed, 10 Jun 2020 16:01:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C5CCF2040BC3C; Wed, 10 Jun 2020 16:01:29 +0200 (CEST)
Date:   Wed, 10 Jun 2020 16:01:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Morton <Eric.Morton@amd.com>
Subject: Re: [PATCH 3/3] x86/msr: Add an MSR write callback
Message-ID: <20200610140129.GF2514@hirez.programming.kicks-ass.net>
References: <20200610110037.11853-1-bp@alien8.de>
 <20200610110037.11853-4-bp@alien8.de>
 <20200610123226.GC2497@hirez.programming.kicks-ass.net>
 <20200610132131.GG14118@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610132131.GG14118@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 03:21:31PM +0200, Borislav Petkov wrote:
> On Wed, Jun 10, 2020 at 02:32:26PM +0200, Peter Zijlstra wrote:
> > We cache a whole bunch of MSRs in kernel. Why is this one special?
> 
> If the others need the post-write handling, they should be added there
> too. I did it with this one only as a start.

Still, this is really weird. The msr device is per cpu (because MSRs are
per cpu), but this shadow value is global (because we keep the same
value on all CPUs), so you then have to broadcast IPI around to fix up
the other CPUs, which, with a bit of bad luck will also get written by
userspace, causing O(n^2) IPIs.

Also, this gives some MSRs radically different behaviour from other
MSRs.

Why not create a sane sysfs interface for this LS_CFG muck in cpu/bugs.c
or so? A simple sysfs file should not me much more lines than all this.
