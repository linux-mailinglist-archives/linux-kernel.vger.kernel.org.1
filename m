Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0951A46B5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 15:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDJNcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 09:32:01 -0400
Received: from mail.efficios.com ([167.114.26.124]:54038 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgDJNcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 09:32:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 69642287070;
        Fri, 10 Apr 2020 09:32:00 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8zDq6RmdRSAs; Fri, 10 Apr 2020 09:32:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0C43228706F;
        Fri, 10 Apr 2020 09:32:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0C43228706F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1586525520;
        bh=HxNd936jAbQYDPORZPc9GCNyGETedD0IRkMjSw3Die8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=UaQAp/3PkmH02kV6n+yKjpKHTRAlvUs3EOqCAIhJ9jF+uJdUF4O5I7Rs9qLBREYqW
         kixlCH6VylRi168MefXEbk1bD7KhVPWKCZznx8WDcxpWbjjXs/c3R5fSvi//wfyjek
         kRYj3oc5mi4CyIz1dCDFvrvIccR8klx6a9bQXsc+zjP+a4b9f5c8AIryrVvMjlCVRX
         xzfw/QHF97VwRZcOIwXtQIVPvSAe3qP8F6Bf+ADkgXMcnwsEf0wC8YEhD7GJCbBx5J
         azIqPUafCZ0iRU6tUZf9Y1BKx0kN5WK3qpsbGHsSBRT0ujavYeIkvaIIQNxx+fslNI
         +QYwIfJ67pmsw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OzO3lND3zpcc; Fri, 10 Apr 2020 09:32:00 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id F046928715B;
        Fri, 10 Apr 2020 09:31:59 -0400 (EDT)
Date:   Fri, 10 Apr 2020 09:31:59 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        K <prasad@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>
Message-ID: <1077145172.30265.1586525519875.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200410063357.GA1663942@kroah.com>
References: <20200409193543.18115-1-mathieu.desnoyers@efficios.com> <20200409193543.18115-9-mathieu.desnoyers@efficios.com> <20200410063357.GA1663942@kroah.com>
Subject: Re: [RFC PATCH 8/9] block: genhd: export-GPL generic disk device
 type
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF74 (Linux)/8.8.15_GA_3895)
Thread-Topic: block: genhd: export-GPL generic disk device type
Thread-Index: tkTxS6MPfaUquYTEpgt/rviPibuaGQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 10, 2020, at 2:33 AM, Greg Kroah-Hartman gregkh@linuxfoundation.org wrote:

> On Thu, Apr 09, 2020 at 03:35:42PM -0400, Mathieu Desnoyers wrote:
>> Iteration on class devices is exported for use by GPL modules, but
>> there is no exported function for getting the generic disk device type
>> which is required to perform iteration on the generic disks.
>> 
>> Export a new getter for disk device type for use by GPL modules. This is
>> useful for tracing a meaningful list of block devices from tracers
>> implemented as GPL modules.
>> 
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>  block/genhd.c         | 9 +++++++++
>>  include/linux/genhd.h | 2 ++
>>  2 files changed, 11 insertions(+)
> 
> I understand your need here, however we do not export things for
> modules, when there are no in-kernel module users, sorry.
> 
> I have your last thread somewhere in my todo pile, to try to respond as
> to how to make this not be an issue for you, sorry I haven't gotten to
> it.

Thanks for taking time to look into this.

Unfortunately, having commit 0bd476e6c6 "kallsyms: unexport kallsyms_lookup_name()
and kallsyms_on_each_symbol()" now merged into mainline before that discussion
was completed now makes it an immediate issue. I would have preferred to have more
time to discuss the possible solutions before seeing that commit upstream.

> Why can't you just add a tracepoint instead of having to dig through
> this mess?  Wouldn't that solve a lot of these issues for block devices?

The problem here is that it's not something which can be exported with "just"
a tracepoint. This is really a "kernel state dumping" facility meant to be
used by kernel tracers. We can indeed use tracepoints as data-export hooking
mechanism (I actually do this already within the LTTng statedump module), but
we need a function symbol which can be called by the tracer to trigger a dump
of the relevant kernel data structures.

I'm very much open to contribute any parts of the LTTng statedump facility
to the kernel, but last time this was discussed (a few years ago), I recall
that dumping kernel state was not deemed useful for the use-cases targeted
by perf and ftrace maintainers. But maybe the situation has changed now ?

For LTTng, this statedump facility is the underlying foundation which allows
doing stateful analyses at post-processing.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
