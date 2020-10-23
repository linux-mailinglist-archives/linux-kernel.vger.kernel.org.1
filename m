Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72C6296F4B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 14:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463858AbgJWMe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 08:34:28 -0400
Received: from mail.efficios.com ([167.114.26.124]:53472 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463842AbgJWMe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 08:34:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 826C2246363;
        Fri, 23 Oct 2020 08:34:27 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NXlJ-vLad1wH; Fri, 23 Oct 2020 08:34:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D88172460E5;
        Fri, 23 Oct 2020 08:34:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D88172460E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1603456466;
        bh=ch77wYpJGj+xKDw42oYytjMTLpX30QJkcDlt5DPKGFg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=jGsxJHfw3V83Tif4oBl2x+dwsrtTaduc7uqWCFPWpMKVAwRmEFQUx0c44gJd6Wfvy
         7BdR61nI5J6xpjzz5032FAApTf6e1XDQYJ3Frv7PLZBw9F9Z4E+wm/PVMGhOHjOW9U
         RQAZ8rHkLV+pqoebMx5uqlxEx0/PhgtXt89TPWm2DB6LwByra+qScOOTYeuzSpUtBr
         GaL392/RHMSN4kXelVKcJQUKC4MQkxNV/+7DZuR7CH/8e2vieGyk2aEN0WBqEBK3fP
         8TuTNc4dCRHMp1WBcMwFEWlViiqxlK2AUa8TJQhUBbbvdKvw9c5qB+eBh05tgqzkgt
         xwHSz8xJ2Evcg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id L33YLcaXSbxK; Fri, 23 Oct 2020 08:34:26 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id C48432463CA;
        Fri, 23 Oct 2020 08:34:26 -0400 (EDT)
Date:   Fri, 23 Oct 2020 08:34:26 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Anton Blanchard <anton@au.ibm.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Rong Chen <rong.a.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        0day robot <lkp@intel.com>, lkp <lkp@lists.01.org>,
        zhengjun xing <zhengjun.xing@intel.com>,
        aubrey li <aubrey.li@linux.intel.com>,
        yu c chen <yu.c.chen@intel.com>
Message-ID: <496552467.36567.1603456466778.JavaMail.zimbra@efficios.com>
In-Reply-To: <61ff00c3-4f55-e186-3ba7-93f96340ebd0@linux.intel.com>
References: <20201002083311.GK393@shao2-debian> <1183082664.11002.1602082242482.JavaMail.zimbra@efficios.com> <7131f8f9-68d1-0277-c770-c10f98a062ec@linux.intel.com> <510309749.29852.1603199662203.JavaMail.zimbra@efficios.com> <e2eb8ed0-1075-3c5d-207e-d218a59c2a9f@linux.intel.com> <1597497813.35294.1603372755111.JavaMail.zimbra@efficios.com> <61ff00c3-4f55-e186-3ba7-93f96340ebd0@linux.intel.com>
Subject: Re: [LKP] Re: [sched] bdfcae1140: will-it-scale.per_thread_ops
 -37.0% regression
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF81 (Linux)/8.8.15_GA_3968)
Thread-Topic: bdfcae1140: will-it-scale.per_thread_ops -37.0% regression
Thread-Index: rhmNlAztKdeSxSwYWzOLoLVoSunRvw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 23, 2020, at 1:37 AM, Xing Zhengjun zhengjun.xing@linux.intel.com wrote:

> On 10/22/2020 9:19 PM, Mathieu Desnoyers wrote:
>> ----- On Oct 21, 2020, at 9:54 PM, Xing Zhengjun zhengjun.xing@linux.intel.com
>> wrote:
>> [...]
>>> In fact, 0-day just copy the will-it-scale benchmark from the GitHub, if
>>> you think the will-it-scale benchmark has some issues, you can
>>> contribute your idea and help to improve it, later we will update the
>>> will-it-scale benchmark to the new version.
>> 
>> This is why I CC'd the maintainer of the will-it-scale github project, Anton
>> Blanchard.
>> My main intent is to report this issue to him, but I have not heard back from
>> him yet.
>> Is this project maintained ? Let me try to add his ozlabs.org address in CC.
>> 
>>> For this test case, if we bind the workload to a specific CPU, then it
>>> will hide the scheduler balance issue. In the real world, we seldom bind
>>> the CPU...
>> 
>> When you say that you bind the workload to a specific CPU, is that done
>> outside of the will-it-scale testsuite, thus limiting the entire testsuite
>> to a single CPU, or you expect that internally the will-it-scale context-switch1
>> test gets affined to a single specific CPU/core/hardware thread through use of
>> hwloc ?
>> 
> The later one.

Yeah, that's not currently true due to the affinity issue I pointed out. Both threads
used in that test-case are free to be scheduled either on the same HW thread, or of
two distinct HW threads on the same core.

Depending on the choice made by the scheduler for each individual test run,
this can lead to very large variation in the benchmark results.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
