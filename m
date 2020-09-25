Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7692278B14
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 16:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgIYOl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 10:41:58 -0400
Received: from mail.efficios.com ([167.114.26.124]:36042 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgIYOl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:41:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3D5282DF81C;
        Fri, 25 Sep 2020 10:41:57 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id etln7-sBXN62; Fri, 25 Sep 2020 10:41:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B1E4C2DF818;
        Fri, 25 Sep 2020 10:41:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B1E4C2DF818
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1601044916;
        bh=SicV3rSpZim8FrS0ZVWzj64HWG1Cjm6QTjzvGKj+iXY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Cz3UfFGIG5hDBAsz7lSM8j/fAS2zwaCojsJHR1qvgdAdH+heNRjmuFpAkUUpbqVPr
         b9JiF54uyuz5mzrgFqJ1irHbjq4iEUYBZ+P5Eb03Pp26stu9qva3hw6ibTToAB//YW
         E2Cqv6Rg7gV0A6JITiX3Z987gcPcivCSu9+b3ptBSyZypRQICKVsQZYoafxMDx9xvO
         slbqKZ3X2bVn7btL8QuZQ4Z8jmt50Otux3DJFWnMAM1Fkqa0pCuFv8km4A4vLwfaGf
         kdXLTppWYYsI73nJ4OcNdEM3AXK0Ryk0oEBHOnavymHTa0bIte7wrQhbPV9ZfhlPUm
         b1WZzvwudBItA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id h-uiFheZSZnz; Fri, 25 Sep 2020 10:41:56 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 9F49A2DF643;
        Fri, 25 Sep 2020 10:41:56 -0400 (EDT)
Date:   Fri, 25 Sep 2020 10:41:56 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>, paulmck <paulmck@kernel.org>,
        Michael Jeanson <mjeanson@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        linux-mm <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Message-ID: <176393901.69671.1601044916547.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200924163331.0080b943@oasis.local.home>
References: <20200924170928.466191266@goodmis.org> <20200924143025.58dc3c1f@gandalf.local.home> <166273261.68446.1600974510284.JavaMail.zimbra@efficios.com> <20200924153517.73f5f257@oasis.local.home> <221547373.69067.1600977935633.JavaMail.zimbra@efficios.com> <20200924161328.760f5e79@oasis.local.home> <1430794518.69084.1600979254425.JavaMail.zimbra@efficios.com> <20200924163331.0080b943@oasis.local.home>
Subject: Re: [PATCH 1/2] tracepoints: Add helper to test if tracepoint is
 enabled in a header
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3965 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3963)
Thread-Topic: tracepoints: Add helper to test if tracepoint is enabled in a header
Thread-Index: p+VyZlWM1Y67JbKk42e0MfEaE3JsoQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 24, 2020, at 4:33 PM, rostedt rostedt@goodmis.org wrote:

> On Thu, 24 Sep 2020 16:27:34 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> I'd be a bit more specific: so far, the msr.h use-case requires to include
>> directly tracepoint-defs.h and use a tracepoint_enabled() macro defined there.
>> 
>> Other less "core" header use-cases could still include tracepoint.h, as long as
>> there is no circular dependency.
> 
> Well, I'll keep tracepoint-defs.h for the msr.h case, and I could see
> if tracepoint.h is good enough for the other cases.
> 
> But does it really matter, if we only need what is in
> tracepoint-defs.h?  Why add something that may cause issues in the
> future?

The trade-off here is tracing (on) speed and code size vs header instrumentation
coverage.

Adding the trampoline as is done in msr.h adds the overhead of an extra
function call when tracing is active. It also slightly increases the code
size. This is why we don't have that extra trampoline in the common case.

The main limitation with respect to tracepoint instrumentation coverage is
header dependencies of RCU read-side synchronization. Currently, tracepoint.h
uses rcu-sched and SRCU. Moving that synchronization into a trampoline
is one way to work-around circular dependency issues.

Note that I have plans to make tracepoint.h use Tasks Trace RCU as well,
so some probes can take pages faults (especially useful for sys enter/exit).
Michael Jeanson has been working on a prototype implementing this, and
he should be able to post a RFC patch publicly soon.

That being said, I suspect that Tasks Trace RCU has fewer header dependencies
than rcu-sched and SRCU. Maybe one idea worth considering is replacing
tracepoint's use of rcu-sched and SRCU by Tasks Trace RCU altogether, if the
latter has read-side performance close to rcu-sched. This could be another way
to minimize the amount of tracepoint.h header dependencies.

With the current dependencies of tracepoint.h, I would argue that we should
only do the trampoline work-around for cases where there is an unavoidable
circular dependency, like the case of msr.h. For other headers which don't
have circular dependency issues with tracepoint.h, we should use the usual
tracepoint instrumentation because not having the trampoline provides better
tracing (on) speed and reduces (slightly) code size.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
