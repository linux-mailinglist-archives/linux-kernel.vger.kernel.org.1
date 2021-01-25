Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A32303553
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388059AbhAZFjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbhAYK5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:57:18 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B60C06178C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 02:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tSVMd0mAlQmzss31L3fywYUpzOMWEDoUIO25DXKyPoY=; b=bziIHjbwox/9XclfRRt36f9DpG
        jr8lqfbZRMsDnxNG/n8/VSPzUjihDrzAI70R19fL37VhE0OV+pwGWeQQr7HWEo+DR7d0ytSt1H/7U
        4rSZENlPy2F3CHQDlUrlTRPLWkUzr+ek10uD4oA/NhdnAOFg7QX3x3//LC7arnLNaoKoxaxtJQwgS
        jDxKgup2eYeqg5vh0cLRgY96A68X6LCzxQ8svIJKWKn3icDFrN7DZJ9ItvrX1DkVLCTPProM5tWLp
        gR3KLSpDnas/2XnuC55ttg8Lg6t7iT6+29WFBG2r68qAwVeznEKeu2xtzpuMyFD2yvW66iSdQaNy8
        +dqzdL8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l3zXF-0002v4-Fy; Mon, 25 Jan 2021 10:55:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 682EB300DB4;
        Mon, 25 Jan 2021 11:55:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5025B28B66D19; Mon, 25 Jan 2021 11:55:51 +0100 (CET)
Date:   Mon, 25 Jan 2021 11:55:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/perf: Use static_call for x86_pmu.guest_get_msrs
Message-ID: <YA6jtyrbxCSRk/zD@hirez.programming.kicks-ass.net>
References: <20210122030324.2754492-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122030324.2754492-1-like.xu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 11:03:24AM +0800, Like Xu wrote:
> Clean up that CONFIG_RETPOLINE crud and replace the
> indirect call x86_pmu.guest_get_msrs with static_call().
> 

Looks good in principle, but the robot complains about a missing func
decl. I think you removed a little too much when you killed the inline
thing.
