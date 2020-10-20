Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949142935A6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404952AbgJTHUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404903AbgJTHUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:20:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F654C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 00:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V26RKGTKti0cwodJGjCiwbw1YW/BQt8FoqD6Wmry+hk=; b=f664xSn/uIW00dqvpxBCFeCYNN
        nH2OOqlvpCKMNu8CgjxbLEFpBoUxB0pnq0zj88W5usnjOqUdyptqWggm559zu/n60vEdzhssbzk2T
        CfQ+O1397no1HjJaeJNjKfoun4TcwHiw7lW1yBjD0dcKpq02K1+lUYaAxnWbRCQLqBL3UINSWqBGy
        WCEECaPzWRQP2XMEI/LOeOBbEHPCrAYHt3aaFHnf/ZDJ00TIaNqoHtW9BMXFKV/2AuPyXD48a2lTW
        dvk4iB+YzE6GZZvPxwA7RZCp4wTrYdF3h4T/rw9wkGQVMsNJgxmBuM+Jt6epiqfFBqb3FsVC27+5X
        0EbhXUGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUlvu-0002oH-Nn; Tue, 20 Oct 2020 07:19:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A15F53012C3;
        Tue, 20 Oct 2020 09:19:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 852B32038FA06; Tue, 20 Oct 2020 09:19:45 +0200 (CEST)
Date:   Tue, 20 Oct 2020 09:19:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Will Deacon <will@kernel.org>, kan.liang@linux.intel.com,
        mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH V9 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20201020071945.GW2611@hirez.programming.kicks-ass.net>
References: <20201001135749.2804-1-kan.liang@linux.intel.com>
 <20201001135749.2804-2-kan.liang@linux.intel.com>
 <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
 <20201009093750.GD29594@willie-the-truck>
 <20201009095300.GI2628@hirez.programming.kicks-ass.net>
 <20201020024925.GB13630@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020024925.GB13630@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 10:49:25AM +0800, Leo Yan wrote:
> I can see there have another potentail customer to use page-size is
> Arm SPE, but Arm SPE is hardware trace based sample but not interrupt
> based sample.  For this case, I think this patch set cannot be
> directly applied to the AUX trace data.

IIRC SPE is decoded in userspace, at which point we simply cannot access
this data.
