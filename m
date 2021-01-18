Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFC92FA224
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404642AbhARNjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404494AbhARNgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:36:05 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9A4C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xvb2bA8jC9t3A+BvPDpcUOdOaB4WCZGa538oav7lt1c=; b=DXnI2dGLpur6S3oIRBNPe9eRvf
        9wBJ1K5v2cDKlr4WKcbCx728sjDx55fL7nTx5tJ9On33BP9wQUEMj+7UcY2Qnx1dA5Jbvn2c64SeJ
        //dyAz3s+wzxLKLdxL4VBgShOG9YuGu9JkdQFrMuvmpYTm2WtOA/+OwvFVSu/xj94bVoUFM8nVY1/
        5oqCqfbu8j5e8iMp37iV/ocqJmEm6RLxlXXsdwmBVvYhfNDW3+v8BhM2mYSef4BH8okcPtw6tTALp
        A4XldKeMccE/wHz9K9tRF8QN91kb3HZWyB1o9I7ws2g0TcRYIVcvtVCwDXEOagNGE54w4NEB/OAA4
        lsZcsTiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l1UgU-00028y-VW; Mon, 18 Jan 2021 13:35:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0DEFF30015A;
        Mon, 18 Jan 2021 14:35:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ECF642023AA35; Mon, 18 Jan 2021 14:35:03 +0100 (CET)
Date:   Mon, 18 Jan 2021 14:35:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Jason Baron <jbaron@akamai.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] x86/perf: Use static_call for x86_pmu.guest_get_msrs
Message-ID: <YAWOhxi6Vxiq8JLR@hirez.programming.kicks-ass.net>
References: <20210118072151.44481-1-like.xu@linux.intel.com>
 <202101182008.jQybUDa0-lkp@intel.com>
 <a82754e7-9a2d-7ab4-466d-fc0d51a3b7f2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a82754e7-9a2d-7ab4-466d-fc0d51a3b7f2@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:05:06PM +0800, Like Xu wrote:
> I guess this fix will silence the compiler error,
> and v2 will be sent after the local 0day test passes.

I think there's also a problem where you don't assign a function at all.

I think you want something like

	if (!x86_pmu.guest_get_msr)
		x86_pmu.guest_get_msr = guest_get_msr_nop;

right before x86_pmu_static_call_update();

And then have it be something like:

static void *guest_et_msr_nop(int *nr)
{
	*nr = 0;
	return NULL;
}

and then you can reduce the entire thing to:

struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
{
	return static_call(x86_pmu_guest_get_msrs)(nr);
}
