Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE333278CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 17:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbgIYPaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 11:30:08 -0400
Received: from mail.efficios.com ([167.114.26.124]:50836 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgIYPaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 11:30:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 368942DFACE;
        Fri, 25 Sep 2020 11:30:07 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OCjBehbYhpGi; Fri, 25 Sep 2020 11:30:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CCE472DFBCA;
        Fri, 25 Sep 2020 11:30:06 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CCE472DFBCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1601047806;
        bh=ZTIgHlXIg4bMbM+tBA7kQRmF5WQUPvRnucjBVhBprdE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=bCvx2Va6LtGy4jrCwk4u3nN5wvpNDV+A4jYbHzggsX3XZgSEPxjLUNKHl5LSBQQ/P
         IO0YC+kYT7KIY9I4i4Ep+MzGXYrj9b4xA+edQvKYH7z5ALhn+Pr2byvLXkmyMXvTsr
         Csd1H1t8QJvXNIdOhWagx0u8sh3wEtcU5wprbPzAr4Y8TTAMz/AwWigbVcuRN3Thki
         MG89MXYt/cryTkSCqIpZpIixc+xgxNKlurJjUz4DeKw9pVzPOS+0bemzwDqK70o+3p
         oUlo8oQ+A0bFLqkGchrWweki+mv1qrBwoB9W9WNC+VDNf4CnkN66zBweV7A7ppc2CK
         Fz1eScBwWK59Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9UcCWVMyEZi9; Fri, 25 Sep 2020 11:30:06 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id BA4592DF9E3;
        Fri, 25 Sep 2020 11:30:06 -0400 (EDT)
Date:   Fri, 25 Sep 2020 11:30:06 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     paulmck <paulmck@kernel.org>,
        Michael Jeanson <mjeanson@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        linux-mm <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Message-ID: <965650354.69699.1601047806662.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200925111415.60f5334c@oasis.local.home>
References: <20200924170928.466191266@goodmis.org> <20200924153517.73f5f257@oasis.local.home> <221547373.69067.1600977935633.JavaMail.zimbra@efficios.com> <20200924161328.760f5e79@oasis.local.home> <1430794518.69084.1600979254425.JavaMail.zimbra@efficios.com> <20200924163331.0080b943@oasis.local.home> <176393901.69671.1601044916547.JavaMail.zimbra@efficios.com> <20200925111415.60f5334c@oasis.local.home>
Subject: Re: [PATCH 1/2] tracepoints: Add helper to test if tracepoint is
 enabled in a header
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3965 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3963)
Thread-Topic: tracepoints: Add helper to test if tracepoint is enabled in a header
Thread-Index: h4JYdWJ6WuvcLRqJKfgha1TFdJNSUQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 25, 2020, at 11:14 AM, rostedt rostedt@goodmis.org wrote:

> On Fri, 25 Sep 2020 10:41:56 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> With the current dependencies of tracepoint.h, I would argue that we should
>> only do the trampoline work-around for cases where there is an unavoidable
>> circular dependency, like the case of msr.h. For other headers which don't
>> have circular dependency issues with tracepoint.h, we should use the usual
>> tracepoint instrumentation because not having the trampoline provides better
>> tracing (on) speed and reduces (slightly) code size.
> 
> Well, for now, I'm going to add the helper function and have the header
> use cases use that.
> 
> A while back ago I had patches that moves the DO_TRACE() work into a
> separate function and with that we probably could have let all
> tracepoints be in headers (as they would all just do a function call to
> the trace algorithm that does the rest of the work). But you balked at
> that because of the added overhead with tracing on.
> 
> Anyway, I don't see any issues with the current patch set as is
> (besides the documentation fix, which I already updated locally). And
> will add this to my queue for linux-next.

The only thing I would change in the documentation is to word this as
"here is a trampoline trick which can be used to work-around rare cases
of tracepoint header circular dependency issues" rather than "always use
this when instrumenting a header".

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
