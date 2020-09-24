Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACD7277A28
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgIXUZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:25:41 -0400
Received: from mail.efficios.com ([167.114.26.124]:42232 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXUZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:25:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 594102D8AD5;
        Thu, 24 Sep 2020 16:25:39 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LHhl6wuY2O7m; Thu, 24 Sep 2020 16:25:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1B6A52D8F00;
        Thu, 24 Sep 2020 16:25:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1B6A52D8F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1600979139;
        bh=9qP9LZF8ULzw711fz24KyU37d2yeb0aqYee00FSFgeY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=TAtF/dk34XCpbBTek1ItKhEaLcT6PKToglElHdG+J+wopv41T1s0R0PKR16rGWnoH
         Wc84WdKiNYBZQIE63Lvk8Zf0JRBH6q1E8MikhQJ+21uJ8TQWphfb9Ww/i/B5jYVM1A
         0HW0v8SO+TV3lxQ+T8UxgtuvWdWrxw2YwrDc8rII92B2Wqy1Q79r4ZuOC8nxQzlwOf
         Aj+a6deWHpmV6rzfNqnosyMbzCXMCCiurXfQDEY7Dv2AbqjPE1VXfdDY8EtXY+0MqF
         DxlGDLIUo/DEbizTSpqJ8SVUdzgX/4uk3Xe4VC6KGjlqYBhNMyStOtJTWBBqEEqcZK
         uCkUYfew1Yb1g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uOC-VpRcyvvA; Thu, 24 Sep 2020 16:25:39 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 059962D8AD4;
        Thu, 24 Sep 2020 16:25:39 -0400 (EDT)
Date:   Thu, 24 Sep 2020 16:25:38 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
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
Message-ID: <1676229796.69080.1600979138922.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200924154009.4b45d56e@oasis.local.home>
References: <20200924170928.466191266@goodmis.org> <20200924171846.993048030@goodmis.org> <2006335081.68212.1600969345189.JavaMail.zimbra@efficios.com> <20200924143025.58dc3c1f@gandalf.local.home> <166273261.68446.1600974510284.JavaMail.zimbra@efficios.com> <20200924153517.73f5f257@oasis.local.home> <20200924154009.4b45d56e@oasis.local.home>
Subject: Re: [PATCH 1/2] tracepoints: Add helper to test if tracepoint is
 enabled in a header
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3965 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3963)
Thread-Topic: tracepoints: Add helper to test if tracepoint is enabled in a header
Thread-Index: 78LRJNuS3GaFV58uE9BR0KXLBrgDKg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 24, 2020, at 3:40 PM, rostedt rostedt@goodmis.org wrote:

> On Thu, 24 Sep 2020 15:35:17 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> > I'm ok with tracepoint_enabled(). However, I would have placed it in
>> > tracepoint.h rather than tracepoint-defs.h, and we should figure out
>> > why people complain that tracepoint.h is including headers too
>> > eagerly.
>> 
>> I could see if it would work in tracepoints.h.
>> 
>> It might. I was just being extra cautious.
> 
> Well that blew up quick!
> 
> Try using tracepoint.h in include/linux/page_ref.h and
> arch/x86/include/asm/msr.h and see what happens.

Indeed, msr.h is an issue. So having tracepoint_enabled() in
include/linux/tracepoints-defs.h and going through a function
would make sense for this kind of core use-case I guess.

I tried including tracepoint.h from include/linux/page_ref.h
and did not notice any compile issue. Am I missing something
to trigger an issue related to that scenario ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
