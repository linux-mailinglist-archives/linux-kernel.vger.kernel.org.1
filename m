Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C3E26FAFF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgIRK4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:56:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgIRK4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:56:00 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB64920789;
        Fri, 18 Sep 2020 10:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600426559;
        bh=7sSABL4QXD65HEVDA8nFrm0LnOHh9FEw+n+ZJ1+kPFc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sRDOp1/9yOLNEi29b+JJcJ52Q7jUzVPZLjpNib2KO5E87TJFMrinc8UwjMYA8OGF3
         4v4Z7LLlMsoMjrsX/BQs/Q6Bk/Bpkp9OlvSxdyd4hiYNeeDkJN/eu9MqVrMpWhAMIz
         rsBjnKK9ePgyU+CCes9trR0VMpClnv4maQsh9sMo=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kJE3Y-00CyDX-UZ; Fri, 18 Sep 2020 11:55:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Sep 2020 11:55:56 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
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
In-Reply-To: <20200918103521.GE3049@jagdpanzerIV.localdomain>
References: <20200917003645.689665-1-sergey.senozhatsky@gmail.com>
 <20200917100950.GC12548@leoy-ThinkPad-X240s>
 <20200917101219.GD12548@leoy-ThinkPad-X240s>
 <652f10660f09bd608b825233713f775a@kernel.org>
 <20200917114231.GE12548@leoy-ThinkPad-X240s>
 <ca309fcda71944455a8c6c1b308886ba@kernel.org>
 <20200918003219.GC3049@jagdpanzerIV.localdomain>
 <f60758eeacb4e94db698d98d6d447939@kernel.org>
 <20200918103521.GE3049@jagdpanzerIV.localdomain>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <06c3e5d907d1145bf3a7a03de63170ae@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sergey.senozhatsky@gmail.com, leo.yan@linaro.org, acme@kernel.org, mark.rutland@arm.com, peterz@infradead.org, will@kernel.org, john.garry@huawei.com, mathieu.poirier@linaro.org, namhyung@kernel.org, suleiman@google.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-18 11:35, Sergey Senozhatsky wrote:
> On (20/09/18 09:20), Marc Zyngier wrote:
>> On 2020-09-18 01:32, Sergey Senozhatsky wrote:
>> > On (20/09/17 12:53), Marc Zyngier wrote:
>> > > Feel free to add a *new* tracepoint instead.
>> >
>> > Wouldn't we want a whole bunch of new tracepoints in this case?
>> 
>> Yes. I don't have a better solution as long as tracepoints are ABI.
> 
> Well, no one does.
> 
>> Get someone to sign-off on it, and I'll happily change them.
> 
> Sorry, I'm not sure I understand this sentence.

What I meant is that the only way to make changes to existing 
tracepoints
would be to get someone like Linus to approve them.

It's all rhetorical anyway, so let's move on.

> 
>> > (almost all of the existing ones with the extra vcpu_id field).
>> > Right now we have 3 types of events:
>> > - events with no vcpu at all        // nil
>> > - events with vcpu_pc               // "0x%016lx", __entry->vcpu_pc
>> > - events with (void *)vcpu          // "vcpu: %p", __entry->vcpu
>> >
>> > It might be helpful if we could filter out events by vcpu_id.
>> > But this, basically, doubles the number of events in the ringbuffer.
>> 
>> Only if you enable them both, right?
> [..]
>> How would that double the number of events in the buffer?
> 
> Yes. I assume that many scripts do something like "capture kvm:* 
> events",
> so new and old events are enabled. Unless we want to keep new events in
> something like kvm2:* namespace (which is unlikely to happen, I guess).

I really don't mind. I actually like the namespacing, as it gives us
a notion of versioning, something tracepoints lack.. And it gives an
opportunity to argue about the name of the namespace.

> 
> And `sudo ./perf stat -e 'kvm:*'` is not unseen. In fact, this is
> literally the first thing mentioned at
> https://www.linux-kvm.org/page/Perf_events
> 
> So if we'll have something like
> 
> 	trace_kvm_foo(vcpu);
> +	trace_kvm_foo2(vcpu->id, vcpu);
> 
> for all arm64 kvm events, then we double the number of arm64 kvm:* 
> events
> in the ringbuffer, don't we? Maybe this is not a gigantic issue, but 
> who
> knows.

I don't think it's a problem, but I'm more in favour of the namespace
approach.

         M.
-- 
Jazz is not dead. It just smells funny...
