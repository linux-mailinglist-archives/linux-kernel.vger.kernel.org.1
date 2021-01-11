Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CC02F17AE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388848AbhAKOJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:09:48 -0500
Received: from foss.arm.com ([217.140.110.172]:58844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729847AbhAKOJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:09:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 397631042;
        Mon, 11 Jan 2021 06:08:46 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CE673F719;
        Mon, 11 Jan 2021 06:08:45 -0800 (PST)
Date:   Mon, 11 Jan 2021 14:08:42 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Phil Auld <pauld@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        vincent.donnefort@arm.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
Message-ID: <20210111140842.hwl4qojw3qymzw34@e107158-lin>
References: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
 <20200828102724.wmng7p6je2pkc33n@e107158-lin.cambridge.arm.com>
 <1e806d48-fd54-fd86-5b3a-372d9876f360@arm.com>
 <20200828172658.dxygk7j672gho4ax@e107158-lin.cambridge.arm.com>
 <58f5d2e8-493b-7ce1-6abd-57705e5ab437@arm.com>
 <20200902135423.GB93959@lorien.usersys.redhat.com>
 <20200907110223.gtdgqod2iv2w7xmg@e107158-lin.cambridge.arm.com>
 <20200908131954.GA147026@lorien.usersys.redhat.com>
 <20210104182642.xglderapsfrop6pi@e107158-lin>
 <X/xa1WBqu8ZOl5QD@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/xa1WBqu8ZOl5QD@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/21 15:04, Peter Zijlstra wrote:
> On Mon, Jan 04, 2021 at 06:26:42PM +0000, Qais Yousef wrote:
> 
> > So I have a proper patch for that now, that actually turned out to be really
> > tiny once you untangle exactly what is missing.
> > 
> > Peter, bpf programs aren't considered ABIs AFAIK, do you have concerns about
> > that?
> 
> In order to use these you need to rely on BTF to get anything useful
> done right? And anything that relies on BTF cannot be ABI.

Yes. To decode struct rq for instance one has to either hardcode it in their
program or use BTF to get the definition dynamically.

The worry is if we modify the function signature of the tracepoint. Alexei did
confirm this can't be an ABI and I'm adding additional documentation to make
this crystal clear.

Thanks

--
Qais Yousef
