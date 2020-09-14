Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83731268A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 13:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgINLpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 07:45:22 -0400
Received: from foss.arm.com ([217.140.110.172]:35062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgINLlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 07:41:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE8AF106F;
        Mon, 14 Sep 2020 04:41:14 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5361C3F68F;
        Mon, 14 Sep 2020 04:41:13 -0700 (PDT)
Date:   Mon, 14 Sep 2020 12:41:11 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     John Dias <joaodias@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, qianjun.kernel@gmail.com,
        tglx@linutronix.de, will@kernel.org, luto@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, laoar.shao@gmail.com,
        urezki@gmail.com, Wei Wang <wvw@google.com>,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH V6 1/1] Softirq:avoid large sched delay from the pending
 softirqs
Message-ID: <20200914114110.esjlzcukfx5emkke@e107158-lin.cambridge.arm.com>
References: <20200909090931.8836-1-qianjun.kernel@gmail.com>
 <20200911164644.eqjqjucvqfvrmr67@e107158-lin.cambridge.arm.com>
 <20200911182832.GL1362448@hirez.programming.kicks-ass.net>
 <CA+njcd3HFV5Gqtt9qzTAzpnA4-4ngPBQ7T0gwgc0Fm9_VoJLcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+njcd3HFV5Gqtt9qzTAzpnA4-4ngPBQ7T0gwgc0Fm9_VoJLcQ@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/20 12:14, John Dias wrote:
> I agree that the rt-softirq interaction patches are a gross hack (and I
> wrote the original versions, so it's my grossness). The problem is that
> even a 1ms delay in executing those low-latency audio threads is enough to
> cause obvious glitching in audio under very real circumstances, which is
> not an acceptable user experience -- and some softirq handlers run for >1ms
> on their own. (And 1ms is a high upper bound, not a median target.)

AFAIK professional audio apps have the toughest limit of sub 10ms. 120MHz
screens impose a stricter limit on display pipeline too to finish its frame in
8ms.

1ms is too short and approaches PREEMPT_RT realm.

Is it possible to expand on the use case here? What application requires this
constraint?

Thanks

--
Qais Yousef
