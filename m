Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E332AD6DB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgKJMwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJMwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:52:55 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9371C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 04:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fjO/zFB7/b6+HD++iJAqEAGrYP3+U1iWSRMKNNU+/n0=; b=2giEvA9yoRQ2tfNdDKZhp5zRjy
        mNvCMlhUSkgTdv1Y4wGdFaXwPh0nCm+wHfuAKya65mGlYRwGZiQ0kv5T1Gt4J1kVdtFuVXTgd+21A
        VHLSe9Fi+pq/egqx9W9gXcuc33/Bt66zsab4MgOWxzvIggQELBiJiUDRQ0vXqBsuF20czqDD0W+i5
        bNpuhio7ZZ+UHQiy0hA5xjrtby0Wkzlq8nxdtKvHPnn6XsFogKMOCmxvFJeaxVXz/pabTLMFIDZW4
        8ZjQJqZvP9VGj5luHHsLfjAiwXJtR9URt7HKTVYI5AMGoQtyy5KLSZH3qJroJrGk/FC32+kE/udY1
        Ac32TZyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcT8e-0000Xz-6i; Tue, 10 Nov 2020 12:52:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C3D0A300455;
        Tue, 10 Nov 2020 13:52:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AC2282BA1DD26; Tue, 10 Nov 2020 13:52:42 +0100 (CET)
Date:   Tue, 10 Nov 2020 13:52:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v4 0/3] sched: Get rid of select_task_rq()'s sd_flag
 parameter
Message-ID: <20201110125242.GI2594@hirez.programming.kicks-ass.net>
References: <20201102184514.2733-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184514.2733-1-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:45:11PM +0000, Valentin Schneider wrote:
> Hi folks,
> 
> This is v4 of that one series I've had stashed for a while [1]. I haven't
> revisited the outstanding discussion bits, the most interesting part being that
> we could get rid of the for_each_domain() loop in select_task_rq_fair() (or at
> the very least simplify it). In any case, the first few patches are IMO a decent
> cleanup on their own, hence me resubmitting them. 

Thanks!
