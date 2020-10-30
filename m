Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780D92A099F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgJ3PVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbgJ3PVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:21:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E6FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=C+NMDJMujZJ3KX+YseGQHydLQrgfF2pQ41zKS+C9IeQ=; b=hrVNeBS2LxUa80OoJLrImiBlG9
        SVA36NyZ4A0eB5JNP2ca7LawD5lTniKopVYFVB/Q5MKLz5BoQsp05AMme0cuG8pe7spnNKuatJrje
        e0MaS/yw7mqwAxRES+7w9y2YJYBBWEdtVmoOfW/Z2yxpdIiLz6EfqyF6rn1ZLk8KR30reroxcPG+W
        uyA5VZGl4OAFsxCdCj/YlWmni/Pwnd3Lnl7I/lvBtQ04euj+EkxCQZw3w4NhXAk1GSt7lCoUa/ib2
        iPAnEivZUEGzgnbbvLZ2gGzRUvcFZWcJRUd+42uNQSnWy1QMKflD3qBbKfhLCAb6g4z6VE23NAzCd
        lTGgBn2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYWDK-0002ka-IT; Fri, 30 Oct 2020 15:21:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0AB60307691;
        Fri, 30 Oct 2020 16:21:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E31B32B708567; Fri, 30 Oct 2020 16:21:11 +0100 (CET)
Message-ID: <20201030151345.540479897@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 30 Oct 2020 16:13:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, eranian@google.com,
        peterz@infradead.org
Subject: [PATCH 0/6] perf: Reduce stack usage (and misc bits)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Steve reported an NMI stack overflow when running perf and function tracing
together. Thomas found that we had 4 copies of struct perf_sample_data
on-stack.

These here patches reduce that to 2 copies and half the size of it.

So just for perf_sample_data we go from 4*384=1536 to 2*192=384 bytes of stack.
Also remove one struct pt_regs instance from __intel_pmu_pebs_event(); it has
another instance in struct x86_perf_regs which I haven't yet managed to
offload.

Perf seems to still work... :-)

