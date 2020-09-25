Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F05278F54
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 19:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgIYRFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 13:05:46 -0400
Received: from mail.efficios.com ([167.114.26.124]:49634 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbgIYRFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 13:05:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0311C2D0649;
        Fri, 25 Sep 2020 13:05:45 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UWotcFCy9elo; Fri, 25 Sep 2020 13:05:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8B6232D083C;
        Fri, 25 Sep 2020 13:05:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8B6232D083C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1601053544;
        bh=9u5etktlFhErqPQLUUxkrQhVKY8cRDGh0UhHCb7uXno=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=rkuhom2RCZyD3mtKD/vF1qrzRbKitcRKV3xVAkorSFr0FETXYRypacQNKrGy2P2HV
         Ykoj7CwObLsLPezZOPww7NkkZhOnzhCXNJ9tlOdTnENORuBNZxy0vdWfOiQ2SnPBgh
         gwqUnhOgMxvJ+XJnFf8LH7wCU73JrrIPGXxYAQoBxsaCaupiDocNFIEHSXGeVa45Ym
         n7CWdRTMI/zwkqXxrDyhmLR5Fgu4563jveizvzQERF326my8GS2kR6PMXxGYzQ7YuW
         aiqgWeLZuK8X0eUDIEkfZloCv41oN8w5ihwS2iKBlSl2Ib5JxE8vBodsxSVcXb5UqS
         29ja6JU9cXg+A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KYOSqdHR5bZP; Fri, 25 Sep 2020 13:05:44 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 7A49D2D0533;
        Fri, 25 Sep 2020 13:05:44 -0400 (EDT)
Date:   Fri, 25 Sep 2020 13:05:44 -0400 (EDT)
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
Message-ID: <897050665.69743.1601053544373.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200925122647.230decde@oasis.local.home>
References: <20200924170928.466191266@goodmis.org> <20200924161328.760f5e79@oasis.local.home> <1430794518.69084.1600979254425.JavaMail.zimbra@efficios.com> <20200924163331.0080b943@oasis.local.home> <176393901.69671.1601044916547.JavaMail.zimbra@efficios.com> <20200925111415.60f5334c@oasis.local.home> <965650354.69699.1601047806662.JavaMail.zimbra@efficios.com> <20200925122647.230decde@oasis.local.home>
Subject: Re: [PATCH 1/2] tracepoints: Add helper to test if tracepoint is
 enabled in a header
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3965 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3963)
Thread-Topic: tracepoints: Add helper to test if tracepoint is enabled in a header
Thread-Index: OfP6K53urTP5+emvUDcmbH1lEHoGnA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 25, 2020, at 12:26 PM, rostedt rostedt@goodmis.org wrote:

> On Fri, 25 Sep 2020 11:30:06 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> > Anyway, I don't see any issues with the current patch set as is
>> > (besides the documentation fix, which I already updated locally). And
>> > will add this to my queue for linux-next.
>> 
>> The only thing I would change in the documentation is to word this as
>> "here is a trampoline trick which can be used to work-around rare cases
>> of tracepoint header circular dependency issues" rather than "always use
>> this when instrumenting a header".
>> 
> 
> I rather not have tracepoints in headers. Period!
> 
> It's not just about circular dependencies, it also bloats the code.

Fair enough. We could indeed argue that having a tracepoint in a header's
static inline function will end up replicating that tracepoint at every
site where the function is used. So in terms of code size, it's better
to use the trampoline approach.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
