Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804DF2DA8C6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 08:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgLOHvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 02:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgLOHvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 02:51:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7167C06179C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 23:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T9Z9dav8OBy3YrDwSr+jZfoQ7XL/6/FhY0/QmV8BmJM=; b=n8Nn6u/Zon/79/Y9NT1stOvfZE
        zo2cHmNiLjfcXJM6zEm+hiC2/drZrO+w+YUF8jXcx041Q2OsuZK4zR1nRaHi5mMYfpIq/TQxdwCbA
        HLJ2VUl0nTTVOSO0RUQGWFTGfaZtRnMABiAkW2Ux1XE28OOrFMPAH/G0E2dqGFHUS1pAtoZEp89no
        lX40T85JmtcvQ+knbcWVjb1VlrN+wMkbpYFHibMiovrNg52O+F5tn8DMocAtAJ008qkkuxB0QNnNx
        KpaX3I+uH1lKMb5IxOeMV1BS4YWADxxQf//0PuUYxOCB1TeCVCoplgFcPQmnL2HdlMVvbwj0MTBaz
        r0zoIzSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kp56c-00010W-Jz; Tue, 15 Dec 2020 07:50:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3397302753;
        Tue, 15 Dec 2020 08:50:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C1FF220D21018; Tue, 15 Dec 2020 08:50:44 +0100 (CET)
Date:   Tue, 15 Dec 2020 08:50:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Hillf Danton <hdanton@sina.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 00/10] workqueue: break affinity initiatively
Message-ID: <20201215075044.GZ3040@hirez.programming.kicks-ass.net>
References: <20201214155457.3430-1-jiangshanlai@gmail.com>
 <X9eirnnrD/+VqqEo@hirez.programming.kicks-ass.net>
 <CAJhGHyDYbU2=dQyiyx-AC+wu9=B7mTvsbU=QYPyV4xTE8PFPog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyDYbU2=dQyiyx-AC+wu9=B7mTvsbU=QYPyV4xTE8PFPog@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 01:44:53PM +0800, Lai Jiangshan wrote:
> I don't know how the scheduler distinguishes all these
> different cases under the "new assumption".

The special case is:

  (p->flags & PF_KTHREAD) && p->nr_cpus_allowed == 1


