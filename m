Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A508126DAA2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgIQLp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgIQLmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:42:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EBAC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:42:41 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b124so1028115pfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tbCk5p7oO2RdlRD/fPrmujkHJKQX4faYoGEB4vvyBms=;
        b=N6ezIbX7shKrOnqKZs2VsSEENkfnpWROILduNXEqk6aNwusO5ZuUood+O/EOp0TFQP
         cKFpng21+37nEo6dF3fOc78ysYYAq2Fnxdmtfe4EyPF5gIUTG8p+Mdd3hzHhITfDSOTi
         sZAyBRy+0NjQAYhauKbJNVr9dwtQJNRA6NnrFXPJM70zyNzbcUJsovDhQdWy4flDAuA8
         H/i9uflGKyHgEXWjM1sUGmLfmG+5AdkqBX4UQYASoMZOEE54TmEPzPUIf6h08wJhMjea
         AvT646ru16L1+3uVpAysBFbGM+cNS6tDFZOB6AQ2lTNcoDrDbbqL7CBCaXcvsiS0MhGC
         6qNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tbCk5p7oO2RdlRD/fPrmujkHJKQX4faYoGEB4vvyBms=;
        b=dSHaqScDjbBjjIrJDU3Q2EEWu1XHV8z+UPRMMN39JdhwrvlAvdBnFR8BtxKLULtaem
         ajVAEGwZAczAwKl7Qp9xUygJpEnRh0ngxSkqAL49ev4ZJJ/rVdleOFNtoezcG/A8lFyx
         VCqmrweaekgbApYwQwmMC1y/aqUAjOdbE2ozPDAdWkbfHQ4BYV7PyVP+ZnOIkYnCKaYN
         yIqpov10jNXBV2MFpmLnpEw1UeMsNCzGK5UxlYFqEOvjyFM7BvOoFNV/Istl7yJyKVx3
         BQ9Jx1I+4pFqeFTo7EK/+Ij1luQLpamZaHdI/A0oC+6K+euUmMvUfYUjAGPaWEeANU9g
         ddsA==
X-Gm-Message-State: AOAM531NrDPVyV3wiX5ptB1FkoywRHKuGa3X6pQ/fZVriYCLRPXEbAu4
        pY55E0qx7OAkCeRVgdbdsh03SQ==
X-Google-Smtp-Source: ABdhPJzg+6AtBlKuvkuo/6mrCHV18a8dk3yL0uRbFFpP1YKIHq6fIYSTHSD9RTT+jhOMnx+Pnd93yg==
X-Received: by 2002:a62:7743:0:b029:13c:1611:658e with SMTP id s64-20020a6277430000b029013c1611658emr26546071pfc.11.1600342961108;
        Thu, 17 Sep 2020 04:42:41 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id z4sm20630791pfr.197.2020.09.17.04.42.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Sep 2020 04:42:40 -0700 (PDT)
Date:   Thu, 17 Sep 2020 19:42:31 +0800
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
Message-ID: <20200917114231.GE12548@leoy-ThinkPad-X240s>
References: <20200917003645.689665-1-sergey.senozhatsky@gmail.com>
 <20200917100950.GC12548@leoy-ThinkPad-X240s>
 <20200917101219.GD12548@leoy-ThinkPad-X240s>
 <652f10660f09bd608b825233713f775a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <652f10660f09bd608b825233713f775a@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:21:15AM +0100, Marc Zyngier wrote:

[...]

> > > > +const char *vcpu_id_str = "id";
> > > 
> > > On Arm64, ftrace tracepoint "kvm_entry" doesn't contain the field "id"
> > > or field "vcpu_id", thus it always reads out the "id" is 0 and it is
> > > recorded into Perf's structure vcpu_event_record::vcpu_id and assigned
> > > to perf thread's private data "thread::private".
> > > 
> > > With current code, it will not mess up different vcpus' samples
> > > because
> > > now the samples are analyzed based on thread context, but since all
> > > threads' "vcpu_id" is zero, thus all samples are accounted for
> > > "vcpu_id=0" and cannot print out correct result with option "--vcpu":
> > > 
> > > 
> > >   $ perf kvm stat report --vcpu 4
> > > 
> > >   Analyze events for all VMs, VCPU 4:
> > > 
> > >              VM-EXIT    Samples  Samples%     Time%    Min Time
> > > Max Time         Avg time
> > > 
> > >   Total Samples:0, Total events handled time:0.00us.
> > > 
> > > 
> > > This is an issue I observed, if we want to support option "--vcpu",
> > > seems we need to change ftrace event for "kvm_entry", but this will
> > > break ABI.
> > > 
> > > Essentially, this issue is caused by different archs using different
> > > format for ftrace event "kvm_entry", on x86 it contains feild
> > > "vcpu_id" but arm64 only just records "vcpu_pc".
> > > 
> > > @Marc, @Will, do you have any suggestion for this?  Do you think it's
> > > feasible to add a new field "vcpu_id" into the tracepoint "kvm_entry"
> > > for Arm64's version?
> 
> The question really is: how will you handle the ABI breackage?
> I don't see a good solution for it, apart from having a *separate*
> tracepoint that collects all the information you need. And even that is
> really ugly.

I searched a bit and found in practice it's not impossible to add new
parameters for existed tracepoint, e.g. [1][2] are two examples to add
new parameters for existed tracepoints and have been merged into
mainline kernel.  IIUC, we keep the old parameters for a tracepoint
so this can avoid to break ABI if any apps have used this tracepoint,
and adding a new parameter for the tracepoint should be safe.

If you agree with this, I'd like to suggest to apply below change.
How about you think for this?


diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 46dc3d75cf13..d9f9b8e1df77 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -736,7 +736,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		/**************************************************************
 		 * Enter the guest
 		 */
-		trace_kvm_entry(*vcpu_pc(vcpu));
+		trace_kvm_entry(vcpu->vcpu_id, *vcpu_pc(vcpu));
 		guest_enter_irqoff();
 
 		ret = kvm_call_hyp_ret(__kvm_vcpu_run, vcpu);
diff --git a/arch/arm64/kvm/trace_arm.h b/arch/arm64/kvm/trace_arm.h
index 4691053c5ee4..e1d3e7a67e8b 100644
--- a/arch/arm64/kvm/trace_arm.h
+++ b/arch/arm64/kvm/trace_arm.h
@@ -12,18 +12,20 @@
  * Tracepoints for entry/exit to guest
  */
 TRACE_EVENT(kvm_entry,
-	TP_PROTO(unsigned long vcpu_pc),
-	TP_ARGS(vcpu_pc),
+	TP_PROTO(unsigned int vcpu_id, unsigned long vcpu_pc),
+	TP_ARGS(vcpu_id, vcpu_pc),
 
 	TP_STRUCT__entry(
+		__field(	unsigned int,	vcpu_id		)
 		__field(	unsigned long,	vcpu_pc		)
 	),
 
 	TP_fast_assign(
+		__entry->vcpu_id		= vcpu_id;
 		__entry->vcpu_pc		= vcpu_pc;
 	),
 
-	TP_printk("PC: 0x%08lx", __entry->vcpu_pc)
+	TP_printk("vcpu: %u, PC: 0x%08lx", __entry->vcpu_id, __entry->vcpu_pc)
 );
 
 TRACE_EVENT(kvm_exit,


Thanks,
Leo

[1] https://lkml.org/lkml/2019/2/26/282
[2] https://lore.kernel.org/linux-mm/20191106080037.GA59367@google.com/t/
