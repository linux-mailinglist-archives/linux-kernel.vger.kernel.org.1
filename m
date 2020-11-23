Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196192C0CE4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbgKWOGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729562AbgKWOGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:06:06 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC9DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qaqWmswva0Ac2dKQfCICz2b5VfKAsUa/VEE2k3X6Nk4=; b=Cs3JxcwkxSBLa2fXuNhKR2uVXa
        b8rvsuF9PtOqr17zCAGhMT13BlePqrJzixsQLvd9Q6S87ejH+O1/01Hu/9uxEhWkiQD1dIp4U11n3
        W1OKtzO4edh37UCIlrvoxAh4VlhOEnunwlMK9/TxOjxieWTogDZStbLJNsTcKAWiCYDIwGSzvs9K5
        zThVkoWAXp7MBrVXCrtBC0m4AfbrYYMtbUKci6JYRjQqCk6KnofYEU6VwUFEjzSmqAphvHvIZav6Y
        3TWLDMk+TmHL7vYLRBMZxHdsanvqTjb/fczo84e8JbvrKEQ3rs5KMtEHtiSZYzi83zvX+zXKa/KR3
        AOLO0D6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khCTa-0002yJ-BV; Mon, 23 Nov 2020 14:05:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B470D306E0C;
        Mon, 23 Nov 2020 15:05:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 98D53200DF1B9; Mon, 23 Nov 2020 15:05:52 +0100 (CET)
Date:   Mon, 23 Nov 2020 15:05:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Omar Sandoval <osandov@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org
Subject: Re: [PATCH 1/2] events/core: introduce perf_pmu_disable_all() to
 turn off all PMU
Message-ID: <20201123140552.GN3021@hirez.programming.kicks-ass.net>
References: <1606109846-13688-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606109846-13688-1-git-send-email-kernelfans@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 01:37:25PM +0800, Pingfan Liu wrote:

> +/* When crashed, other cpus hang in idle loop, so here do an emergency job under no lock */

-ENOPARSE, -ETOOLONG

> +void perf_pmu_disable_all(void)
> +{
> +	struct pmu *pmu;
> +
> +	list_for_each_entry(pmu, &pmus, entry)
> +		if (pmu->pmu_disable)
> +			pmu->pmu_disable(pmu);
> +}

This violates both locking rules and coding style.
