Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574DD278EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgIYQi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:38:56 -0400
Received: from foss.arm.com ([217.140.110.172]:49522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbgIYQi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:38:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F95B101E;
        Fri, 25 Sep 2020 09:38:55 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4799B3F718;
        Fri, 25 Sep 2020 09:38:52 -0700 (PDT)
Subject: Re: [PATCH 3/9] sched/hotplug: Ensure only per-cpu kthreads run
 during hotplug
To:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, valentin.schneider@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com
References: <20200921163557.234036895@infradead.org>
 <20200921163845.520504267@infradead.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <b357302d-4a8c-aa2e-f31d-4501fce890b6@arm.com>
Date:   Fri, 25 Sep 2020 18:38:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200921163845.520504267@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2020 18:36, Peter Zijlstra wrote:

[...]

> This replaces the unlikely(rq->balance_callbacks) test at the tail of
> context_switch with an unlikely(rq->balance_work), the fast path is

While looking for why BALANCE_WORK is needed:

Shouldn't this be unlikely(rq->balance_callback) and
unlikely(rq->balance_flags)?
