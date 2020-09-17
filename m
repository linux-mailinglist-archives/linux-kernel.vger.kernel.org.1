Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AEC26DC4D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgIQNAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgIQMw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:52:59 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D19C061788
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 05:52:56 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bg9so1087662plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 05:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8r2W5ugtK9caMpjnS4eY21V02JS4a1fk6SkCIi43SQU=;
        b=ZganT4NnPW+YT/mcICT/ttID3D+P4tslVZy5FHlEJa5XmVbVq7NxcMtF3KPJXHjHRi
         5bvyaR1FV72putfR1BAoJ3sW9T5sX1rHs9/m2vhz2Lgzg5O6IOZz/n+cyuX5ZgM0QbjS
         powxnjHQEIia/bSfHG9ihbNmUIctalbqR/G7ZFoClhYDSIRjIJHEHPc+dLTRuejN3JEB
         B+Tdt5zCWtCu9pNf3myyAOeD7U/Lo8jdl9LA0xAcG6lrNcZNeWSplBAgHqzwEWfhVSRz
         /c5bdMM+PejIbELT2kx9zdsgUtMVM32LBppO/1yNMO6c5cTbZ77yYsTtwvluHoGAqCRU
         Xl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8r2W5ugtK9caMpjnS4eY21V02JS4a1fk6SkCIi43SQU=;
        b=dAue3uvxqv+xsxME9jbnsQ+KXh7WDRSet5Ngx6ce4Cqsl8IdrpkcDN2LHL7Es/FCeD
         BpcjPoCAm5/k3iuGb4gIzbQBWnXnmAVj32kbnhT+VaRwXWGpkUHr/pUvdssYbsVzKabf
         y3F3pn3z8QbOucbOR+zQaWXlon0dLhLPvQvZ2oByrzodt71tsaLgAIzGTHuO8YuhKyVt
         Y4L8tg7D5TQvfCMMmssbJt+rq6PnnNXaklCdWt/OnVNEWsTsHqWZWpjSyAfCYCJKVte2
         ln96nmQK/UXwDSqz02sMZSIcsbDNs1dZlC5F+nLs3UTPH0xeHXaNJeBiwEpngK6kL7ty
         dSDg==
X-Gm-Message-State: AOAM532blIacTsyLi6aeDU7zO3h4yysbXSCigY8jykpsQuRPe1FT6Dor
        KRaHAzpgL1CS0EOl/mYMnA40Pg==
X-Google-Smtp-Source: ABdhPJy3oI3H4XEMYD6/9IZe1EzBQKyrfIum9IoJh0QneN+UTJHIhS1pkrhM0Nm+ERmAhGon9KAXvQ==
X-Received: by 2002:a17:902:7c83:b029:d1:e603:af74 with SMTP id y3-20020a1709027c83b02900d1e603af74mr10646316pll.82.1600347175474;
        Thu, 17 Sep 2020 05:52:55 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id 126sm7044154pfg.192.2020.09.17.05.52.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Sep 2020 05:52:54 -0700 (PDT)
Date:   Thu, 17 Sep 2020 20:52:46 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
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
Message-ID: <20200917125246.GF12548@leoy-ThinkPad-X240s>
References: <20200917003645.689665-1-sergey.senozhatsky@gmail.com>
 <20200917100950.GC12548@leoy-ThinkPad-X240s>
 <20200917101219.GD12548@leoy-ThinkPad-X240s>
 <652f10660f09bd608b825233713f775a@kernel.org>
 <20200917114231.GE12548@leoy-ThinkPad-X240s>
 <ca309fcda71944455a8c6c1b308886ba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca309fcda71944455a8c6c1b308886ba@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 12:53:02PM +0100, Marc Zyngier wrote:
> On 2020-09-17 12:42, Leo Yan wrote:
> > On Thu, Sep 17, 2020 at 11:21:15AM +0100, Marc Zyngier wrote:
> > 
> > [...]
> > 
> > > > > > +const char *vcpu_id_str = "id";
> > > > >
> > > > > On Arm64, ftrace tracepoint "kvm_entry" doesn't contain the field "id"
> > > > > or field "vcpu_id", thus it always reads out the "id" is 0 and it is
> > > > > recorded into Perf's structure vcpu_event_record::vcpu_id and assigned
> > > > > to perf thread's private data "thread::private".
> > > > >
> > > > > With current code, it will not mess up different vcpus' samples
> > > > > because
> > > > > now the samples are analyzed based on thread context, but since all
> > > > > threads' "vcpu_id" is zero, thus all samples are accounted for
> > > > > "vcpu_id=0" and cannot print out correct result with option "--vcpu":
> > > > >
> > > > >
> > > > >   $ perf kvm stat report --vcpu 4
> > > > >
> > > > >   Analyze events for all VMs, VCPU 4:
> > > > >
> > > > >              VM-EXIT    Samples  Samples%     Time%    Min Time
> > > > > Max Time         Avg time
> > > > >
> > > > >   Total Samples:0, Total events handled time:0.00us.
> > > > >
> > > > >
> > > > > This is an issue I observed, if we want to support option "--vcpu",
> > > > > seems we need to change ftrace event for "kvm_entry", but this will
> > > > > break ABI.
> > > > >
> > > > > Essentially, this issue is caused by different archs using different
> > > > > format for ftrace event "kvm_entry", on x86 it contains feild
> > > > > "vcpu_id" but arm64 only just records "vcpu_pc".
> > > > >
> > > > > @Marc, @Will, do you have any suggestion for this?  Do you think it's
> > > > > feasible to add a new field "vcpu_id" into the tracepoint "kvm_entry"
> > > > > for Arm64's version?
> > > 
> > > The question really is: how will you handle the ABI breackage?
> > > I don't see a good solution for it, apart from having a *separate*
> > > tracepoint that collects all the information you need. And even that
> > > is
> > > really ugly.
> > 
> > I searched a bit and found in practice it's not impossible to add new
> > parameters for existed tracepoint, e.g. [1][2] are two examples to add
> > new parameters for existed tracepoints and have been merged into
> > mainline kernel.  IIUC, we keep the old parameters for a tracepoint
> > so this can avoid to break ABI if any apps have used this tracepoint,
> > and adding a new parameter for the tracepoint should be safe.
> > 
> > If you agree with this, I'd like to suggest to apply below change.
> > How about you think for this?
> > 
> > 
> > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > index 46dc3d75cf13..d9f9b8e1df77 100644
> > --- a/arch/arm64/kvm/arm.c
> > +++ b/arch/arm64/kvm/arm.c
> > @@ -736,7 +736,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> >  		/**************************************************************
> >  		 * Enter the guest
> >  		 */
> > -		trace_kvm_entry(*vcpu_pc(vcpu));
> > +		trace_kvm_entry(vcpu->vcpu_id, *vcpu_pc(vcpu));
> >  		guest_enter_irqoff();
> > 
> >  		ret = kvm_call_hyp_ret(__kvm_vcpu_run, vcpu);
> > diff --git a/arch/arm64/kvm/trace_arm.h b/arch/arm64/kvm/trace_arm.h
> > index 4691053c5ee4..e1d3e7a67e8b 100644
> > --- a/arch/arm64/kvm/trace_arm.h
> > +++ b/arch/arm64/kvm/trace_arm.h
> > @@ -12,18 +12,20 @@
> >   * Tracepoints for entry/exit to guest
> >   */
> >  TRACE_EVENT(kvm_entry,
> > -	TP_PROTO(unsigned long vcpu_pc),
> > -	TP_ARGS(vcpu_pc),
> > +	TP_PROTO(unsigned int vcpu_id, unsigned long vcpu_pc),
> > +	TP_ARGS(vcpu_id, vcpu_pc),
> > 
> >  	TP_STRUCT__entry(
> > +		__field(	unsigned int,	vcpu_id		)
> >  		__field(	unsigned long,	vcpu_pc		)
> >  	),
> > 
> >  	TP_fast_assign(
> > +		__entry->vcpu_id		= vcpu_id;
> >  		__entry->vcpu_pc		= vcpu_pc;
> >  	),
> > 
> > -	TP_printk("PC: 0x%08lx", __entry->vcpu_pc)
> > +	TP_printk("vcpu: %u, PC: 0x%08lx", __entry->vcpu_id, __entry->vcpu_pc)
> >  );
> > 
> >  TRACE_EVENT(kvm_exit,
> > 
> 
> How is that not breaking the ABI? You are adding a new field, and anything
> that expect to read 'PC: 0x.....' at the beginning of the line now fails.
> The examples you give are also blatant ABI breakages. because it is done
> somewhere else doesn't make it valid.
> 
> Anything that can be parsed by userspace is ABI. If you don't believe me,
> please read the entertaining discussion we had when we tried to drop
> Bogomips from /proc/cpuinfo.

The discussion thread was too long [1] to read all replies :)

... but I understand we should be very careful for ABI breakage.

> So unless you get me Linus' stamp of approval for this, it's not happening.
> Feel free to add a *new* tracepoint instead.

Okay, thanks for the info and suggestions.

Thanks,
Leo

[1] https://lkml.org/lkml/2015/1/4/132
