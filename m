Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E48F2FAC8E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 22:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbhARVXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 16:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389649AbhARKLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:11:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603EEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nFKAUCWrek4ATN0kUUcq76KLTyBcFv0f0+VspmkLRQs=; b=BzQ9cW0VSonjlzajMqim2vuYZo
        1A55EYoOGkphlDgYBQYliI+xAWl02oxHQFeG2PQT9nNLz91BVerdujNlFhiS5tyjIKYYIYScLPNGE
        xtOKeiR0emcguzIKVXlahCF9jKajn9vJSzg0PC1sQG5hwvMKSI0ac6pxJr1Gj9/GTljcZGVmVakZx
        3eZgZLHNZKEuz3RoM9HJ3gkARl4aYbVIJ4ITacXt9o50K6VKDJOKKAt5p+pcMC+XC+oFgMn43tqiZ
        vLkePepsm2Jk6Vb5UJtRfEdub4DPATT4+FhrxfxBfgO+rUyXIP3JoNYgwyvsOyfvzc0aR3k6i9f3t
        CWuZIxTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l1RUa-00CeNF-NW; Mon, 18 Jan 2021 10:10:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E8F3630015A;
        Mon, 18 Jan 2021 11:10:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C95C720291083; Mon, 18 Jan 2021 11:10:33 +0100 (CET)
Date:   Mon, 18 Jan 2021 11:10:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/perf: Use static_call for x86_pmu.guest_get_msrs
Message-ID: <YAVembO7LBuLpAKE@hirez.programming.kicks-ass.net>
References: <20210118072151.44481-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118072151.44481-1-like.xu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 03:21:51PM +0800, Like Xu wrote:
> Clean up that CONFIG_RETPOLINE crud and replace the
> indirect call x86_pmu.guest_get_msrs with static_call().
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>

Thanks!
