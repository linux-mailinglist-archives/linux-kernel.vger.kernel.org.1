Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7722F3341
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbhALOwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbhALOwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:52:36 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35219C061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=qAI7LcOIC5xUJzcIeCZEp5waTvdXBfe+qtlYgS/mTdE=; b=Oe02yKpMixU8ukY6lmMvSUysnm
        3StVUysKL2rdR5ZtN6v5qdMPiiOYpgEKHWE3TlKimkJpoayO6BYruwDkQijVOsKEga1KwL4BZn9aE
        xF/1XRbdoN0mj80xvyxyVdo20OBY5NG0c6Q8DzB03fkYxMKVK8Mp4Zrur5ROKwzSy2rFjt5Pb/giT
        NHKtPUfpsRp0sos4yRTLt4vsPIePiJtuxFSJK/ORM4pBKe3bEhi18gTy+g+45RGCPeJgxCvFGmOQV
        SquMuUldNkzV5lNi9UxzXW8WQBsd17lhJviYdGE4TyBCsLjk12A9u5Fwj/JTc1/dxy9yrbwl6SafS
        NMSPxOrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzL1I-0000cb-GS; Tue, 12 Jan 2021 14:51:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BDE533010C8;
        Tue, 12 Jan 2021 15:51:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9FB3420C228D5; Tue, 12 Jan 2021 15:51:38 +0100 (CET)
Message-ID: <20210112144344.850850975@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 12 Jan 2021 15:43:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org,
        peterz@infradead.org
Subject: [PATCH 0/4] sched: Fix hot-unplug regressions
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These 4 patches are the simplest means (barring a revert) of fixing the CPU
hot-unplug problems introduced by commit:

  1cf12e08bc4d ("sched/hotplug: Consolidate task migration on CPU unplug")

Testing here, any by Paul, indicate they survive a pounding.

They restore the previous behaviour of forced affinity breaking for the class
of kernel threads that happen to have single CPU affinity, but are not strictly
a per-cpu kthread.


