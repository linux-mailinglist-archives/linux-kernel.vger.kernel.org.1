Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C8B26D8C5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgIQKVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:21:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbgIQKVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:21:20 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1A9B2083B;
        Thu, 17 Sep 2020 10:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600338079;
        bh=C+KplrEy19xRRUCzs59Jn7lzDV7YqtFzKMiyU9gK+yI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i8WVr5yZwKpsZGvL6XrCYnezlOKdPRuzdzLPVWVxY5sziJImifxeRFbKncXjR3ZYh
         hDQ3x08AKoF+glZUzcoFjBZ6H1GZl79IqOmnHvH98MzOeDgn+BjiE3BCg/1EMPNVJE
         Z3j+d9BzQduY+6RaFUmB6PZRL3HVHyP5YPqcPa6Q=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kIr2S-00CbMs-0V; Thu, 17 Sep 2020 11:21:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 17 Sep 2020 11:21:15 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv3] perf kvm: add kvm-stat for arm64
In-Reply-To: <20200917101219.GD12548@leoy-ThinkPad-X240s>
References: <20200917003645.689665-1-sergey.senozhatsky@gmail.com>
 <20200917100950.GC12548@leoy-ThinkPad-X240s>
 <20200917101219.GD12548@leoy-ThinkPad-X240s>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <652f10660f09bd608b825233713f775a@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: leo.yan@linaro.org, sergey.senozhatsky@gmail.com, acme@kernel.org, mark.rutland@arm.com, peterz@infradead.org, will@kernel.org, john.garry@huawei.com, mathieu.poirier@linaro.org, namhyung@kernel.org, suleiman@google.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-17 11:12, Leo Yan wrote:
> Add Marc at this time, sorry for spamming.
> 
> On Thu, Sep 17, 2020 at 06:09:50PM +0800, Leo Yan wrote:
>> [ + Marc ]
>> 
>> On Thu, Sep 17, 2020 at 09:36:45AM +0900, Sergey Senozhatsky wrote:
>> 
>> [...]
>> 
>> > diff --git a/tools/perf/arch/arm64/util/kvm-stat.c b/tools/perf/arch/arm64/util/kvm-stat.c
>> > new file mode 100644
>> > index 000000000000..32e58576f186
>> > --- /dev/null
>> > +++ b/tools/perf/arch/arm64/util/kvm-stat.c
>> > @@ -0,0 +1,86 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +#include <errno.h>
>> > +#include <memory.h>
>> > +#include "../../util/evsel.h"
>> > +#include "../../util/kvm-stat.h"
>> > +#include "arm64_exception_types.h"
>> > +#include "debug.h"
>> > +
>> > +define_exit_reasons_table(arm64_exit_reasons, kvm_arm_exception_type);
>> > +define_exit_reasons_table(arm64_trap_exit_reasons, kvm_arm_exception_class);
>> > +
>> > +const char *kvm_trap_exit_reason = "esr_ec";
>> > +const char *vcpu_id_str = "id";
>> 
>> On Arm64, ftrace tracepoint "kvm_entry" doesn't contain the field "id"
>> or field "vcpu_id", thus it always reads out the "id" is 0 and it is
>> recorded into Perf's structure vcpu_event_record::vcpu_id and assigned
>> to perf thread's private data "thread::private".
>> 
>> With current code, it will not mess up different vcpus' samples 
>> because
>> now the samples are analyzed based on thread context, but since all
>> threads' "vcpu_id" is zero, thus all samples are accounted for
>> "vcpu_id=0" and cannot print out correct result with option "--vcpu":
>> 
>> 
>>   $ perf kvm stat report --vcpu 4
>> 
>>   Analyze events for all VMs, VCPU 4:
>> 
>>              VM-EXIT    Samples  Samples%     Time%    Min Time    Max 
>> Time         Avg time
>> 
>>   Total Samples:0, Total events handled time:0.00us.
>> 
>> 
>> This is an issue I observed, if we want to support option "--vcpu",
>> seems we need to change ftrace event for "kvm_entry", but this will
>> break ABI.
>> 
>> Essentially, this issue is caused by different archs using different
>> format for ftrace event "kvm_entry", on x86 it contains feild
>> "vcpu_id" but arm64 only just records "vcpu_pc".
>> 
>> @Marc, @Will, do you have any suggestion for this?  Do you think it's
>> feasible to add a new field "vcpu_id" into the tracepoint "kvm_entry"
>> for Arm64's version?

The question really is: how will you handle the ABI breackage?
I don't see a good solution for it, apart from having a *separate*
tracepoint that collects all the information you need. And even that is
really ugly.

         M.
-- 
Jazz is not dead. It just smells funny...
