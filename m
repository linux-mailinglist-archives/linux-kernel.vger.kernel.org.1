Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7262026DADE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgIQL4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:56:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbgIQLxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:53:16 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FCAD2072E;
        Thu, 17 Sep 2020 11:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600343584;
        bh=LgHVyCnfHVJpVCFssZUccF8/Y4bMHlpZUZppm8PrH/w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hRlfO4WvBy0pDog+vP/5Z5LGlkODLpML2T8jDREoCEwPcT6CaiMiFx8+iLYJWdEBn
         zCJJULGnYYMyDgyuXIzTYuk2b103CaDJEgRZBNgEPlhsPkayxhId+L6jxdlWo4bvRG
         d5DtsmaANCQ+scgeEzGjt9TpT037OORaMPD2v9IE=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kIsTG-00CcmC-Hf; Thu, 17 Sep 2020 12:53:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 17 Sep 2020 12:53:02 +0100
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
In-Reply-To: <20200917114231.GE12548@leoy-ThinkPad-X240s>
References: <20200917003645.689665-1-sergey.senozhatsky@gmail.com>
 <20200917100950.GC12548@leoy-ThinkPad-X240s>
 <20200917101219.GD12548@leoy-ThinkPad-X240s>
 <652f10660f09bd608b825233713f775a@kernel.org>
 <20200917114231.GE12548@leoy-ThinkPad-X240s>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <ca309fcda71944455a8c6c1b308886ba@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: leo.yan@linaro.org, sergey.senozhatsky@gmail.com, acme@kernel.org, mark.rutland@arm.com, peterz@infradead.org, will@kernel.org, john.garry@huawei.com, mathieu.poirier@linaro.org, namhyung@kernel.org, suleiman@google.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-17 12:42, Leo Yan wrote:
> On Thu, Sep 17, 2020 at 11:21:15AM +0100, Marc Zyngier wrote:
> 
> [...]
> 
>> > > > +const char *vcpu_id_str = "id";
>> > >
>> > > On Arm64, ftrace tracepoint "kvm_entry" doesn't contain the field "id"
>> > > or field "vcpu_id", thus it always reads out the "id" is 0 and it is
>> > > recorded into Perf's structure vcpu_event_record::vcpu_id and assigned
>> > > to perf thread's private data "thread::private".
>> > >
>> > > With current code, it will not mess up different vcpus' samples
>> > > because
>> > > now the samples are analyzed based on thread context, but since all
>> > > threads' "vcpu_id" is zero, thus all samples are accounted for
>> > > "vcpu_id=0" and cannot print out correct result with option "--vcpu":
>> > >
>> > >
>> > >   $ perf kvm stat report --vcpu 4
>> > >
>> > >   Analyze events for all VMs, VCPU 4:
>> > >
>> > >              VM-EXIT    Samples  Samples%     Time%    Min Time
>> > > Max Time         Avg time
>> > >
>> > >   Total Samples:0, Total events handled time:0.00us.
>> > >
>> > >
>> > > This is an issue I observed, if we want to support option "--vcpu",
>> > > seems we need to change ftrace event for "kvm_entry", but this will
>> > > break ABI.
>> > >
>> > > Essentially, this issue is caused by different archs using different
>> > > format for ftrace event "kvm_entry", on x86 it contains feild
>> > > "vcpu_id" but arm64 only just records "vcpu_pc".
>> > >
>> > > @Marc, @Will, do you have any suggestion for this?  Do you think it's
>> > > feasible to add a new field "vcpu_id" into the tracepoint "kvm_entry"
>> > > for Arm64's version?
>> 
>> The question really is: how will you handle the ABI breackage?
>> I don't see a good solution for it, apart from having a *separate*
>> tracepoint that collects all the information you need. And even that 
>> is
>> really ugly.
> 
> I searched a bit and found in practice it's not impossible to add new
> parameters for existed tracepoint, e.g. [1][2] are two examples to add
> new parameters for existed tracepoints and have been merged into
> mainline kernel.  IIUC, we keep the old parameters for a tracepoint
> so this can avoid to break ABI if any apps have used this tracepoint,
> and adding a new parameter for the tracepoint should be safe.
> 
> If you agree with this, I'd like to suggest to apply below change.
> How about you think for this?
> 
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 46dc3d75cf13..d9f9b8e1df77 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -736,7 +736,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  		/**************************************************************
>  		 * Enter the guest
>  		 */
> -		trace_kvm_entry(*vcpu_pc(vcpu));
> +		trace_kvm_entry(vcpu->vcpu_id, *vcpu_pc(vcpu));
>  		guest_enter_irqoff();
> 
>  		ret = kvm_call_hyp_ret(__kvm_vcpu_run, vcpu);
> diff --git a/arch/arm64/kvm/trace_arm.h b/arch/arm64/kvm/trace_arm.h
> index 4691053c5ee4..e1d3e7a67e8b 100644
> --- a/arch/arm64/kvm/trace_arm.h
> +++ b/arch/arm64/kvm/trace_arm.h
> @@ -12,18 +12,20 @@
>   * Tracepoints for entry/exit to guest
>   */
>  TRACE_EVENT(kvm_entry,
> -	TP_PROTO(unsigned long vcpu_pc),
> -	TP_ARGS(vcpu_pc),
> +	TP_PROTO(unsigned int vcpu_id, unsigned long vcpu_pc),
> +	TP_ARGS(vcpu_id, vcpu_pc),
> 
>  	TP_STRUCT__entry(
> +		__field(	unsigned int,	vcpu_id		)
>  		__field(	unsigned long,	vcpu_pc		)
>  	),
> 
>  	TP_fast_assign(
> +		__entry->vcpu_id		= vcpu_id;
>  		__entry->vcpu_pc		= vcpu_pc;
>  	),
> 
> -	TP_printk("PC: 0x%08lx", __entry->vcpu_pc)
> +	TP_printk("vcpu: %u, PC: 0x%08lx", __entry->vcpu_id, 
> __entry->vcpu_pc)
>  );
> 
>  TRACE_EVENT(kvm_exit,
> 

How is that not breaking the ABI? You are adding a new field, and 
anything
that expect to read 'PC: 0x.....' at the beginning of the line now 
fails.
The examples you give are also blatant ABI breakages. because it is done
somewhere else doesn't make it valid.

Anything that can be parsed by userspace is ABI. If you don't believe 
me,
please read the entertaining discussion we had when we tried to drop
Bogomips from /proc/cpuinfo.

So unless you get me Linus' stamp of approval for this, it's not 
happening.
Feel free to add a *new* tracepoint instead.

         M.
-- 
Jazz is not dead. It just smells funny...
