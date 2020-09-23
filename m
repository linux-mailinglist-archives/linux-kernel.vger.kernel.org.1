Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB86275E46
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 19:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgIWRI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 13:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgIWRI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:08:27 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54170C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sxnYwak8DIWStnPUO/Jr70PPBMVMVI0+DKQ+9tS2nh0=; b=ZcAKUHA37509MGqZnOxOOsh3x1
        rOnlrIrWYeM6uz6R2WpNkYbKBH0Fv+qMmsRNjH78xPpM5XuGqMW8TPINQMep/iQP4eE9mu6l8+7cb
        HsLRFpm8C53aUC/Iquw6UvDVvD+OU2ugQ84vDjd562FEGk5G9Ln56HdzFQ6dubGUfkY+Z4nQRdqzX
        Br7cw3FUY7a73fwiDf1jNnStsDo4gORvp4VR7+BgKg6MAoRJwhLAAKIoV1RLXBG/qQUelPaaLH9Qg
        YTyjncTWDBo+2st4pHpUqfdbpEB5uOY8q0TtWyYVu8MOxExGK9SCe2F3he525PJC7T/YD86PXkspZ
        4AjDj2rw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kL8FY-0001nQ-A4; Wed, 23 Sep 2020 17:08:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9C8CE3050F0;
        Wed, 23 Sep 2020 19:08:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 637A22B88AD30; Wed, 23 Sep 2020 19:08:09 +0200 (CEST)
Date:   Wed, 23 Sep 2020 19:08:09 +0200
From:   peterz@infradead.org
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, valentin.schneider@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vincent.donnefort@arm.com
Subject: Re: [PATCH 7/9] sched: Add migrate_disable()
Message-ID: <20200923170809.GY1362448@hirez.programming.kicks-ass.net>
References: <20200921163557.234036895@infradead.org>
 <20200921163845.769861942@infradead.org>
 <87v9g7aqjd.fsf@nanos.tec.linutronix.de>
 <86929eee-36da-93a5-5280-00e6df1ef496@redhat.com>
 <87v9g4ao8h.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9g4ao8h.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 10:31:10AM +0200, Thomas Gleixner wrote:
>    In practice migrate disable could be taken into account on placement
>    decisions, but yes we don't have anything like that at the moment.

I think at the very least we should do some of that.

The premise is wanting to run the M highest priority tasks, when a CPU
drops priority, it tries to PULL a higher priority task towards itself.
If this PULL selects a migrate_disable() tasks, it means the task is in
the M highest prio tasks.

Since obviously that task cannot get pulled, we should then pull the
current running task of that CPU, this would then allow the
migrate_disable() task to resume execution.

I'll go try and cook up something along those lines...


