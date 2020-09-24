Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3CB2774C8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgIXPFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:05:07 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:8161 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgIXPFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600959904; x=1632495904;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=xaBXbX1rlnVMEuR1KW9SiTBfWtcVhG0+cSJ6cqL/7kE=;
  b=luFewmlEixLVLM75UlWhaOppOI/gpLO1/wCTGWW3fW89YmumCPJPZt3h
   mMNSkUJvuWF9Raa8wUdbXEzuM/B20BrMFNoHKcQLGSCggXgxXg9I71EKw
   aOFJVg1uhiTf0LybNn2Kb71uE99HPqTr5FCS5fR9xrpepx87+ejzBbPXP
   0=;
X-IronPort-AV: E=Sophos;i="5.77,298,1596499200"; 
   d="scan'208";a="78970815"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 24 Sep 2020 15:04:49 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id 52855284B91;
        Thu, 24 Sep 2020 15:04:46 +0000 (UTC)
Received: from EX13D12UWC002.ant.amazon.com (10.43.162.253) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 24 Sep 2020 15:04:46 +0000
Received: from [192.168.7.67] (10.43.161.237) by EX13D12UWC002.ant.amazon.com
 (10.43.162.253) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 24 Sep
 2020 15:04:45 +0000
Subject: Re: [PATCH] latency improvement in __smp_call_single_queue
To:     <peterz@infradead.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Xu <peterx@redhat.com>,
        Kaitao Cheng <pilgrimtao@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <281da382-4511-e1df-6917-154a5914dd43@amazon.com>
 <20200924084215.GD1362448@hirez.programming.kicks-ass.net>
From:   George Prekas <prekageo@amazon.com>
Message-ID: <85f7c7c5-2ab0-d5df-45a7-989be1286ef9@amazon.com>
Date:   Thu, 24 Sep 2020 10:04:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200924084215.GD1362448@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.43.161.237]
X-ClientProxiedBy: EX13D27UWB003.ant.amazon.com (10.43.161.195) To
 EX13D12UWC002.ant.amazon.com (10.43.162.253)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/2020 3:42 AM, peterz@infradead.org wrote:
 > On Wed, Sep 23, 2020 at 10:00:41AM -0500, George Prekas wrote:
 >> If an interrupt arrives between llist_add and
 >> send_call_function_single_ipi in the following code snippet, then the
 >> remote CPU will not receive the IPI in a timely manner and subsequent
 >> SMP calls even from other CPUs for other functions will be delayed:
 >>
 >>     if (llist_add(node, &per_cpu(call_single_queue, cpu)))
 >>         send_call_function_single_ipi(cpu);
 >>
 >> Note: llist_add returns 1 if it was empty before the operation.
 >>
 >> CPU 0                           | CPU 1 | CPU 2
 >> __smp_call_single_q(2,f1)       | __smp_call_single_q(2,f2) |
 >>   llist_add returns 1           | |
 >>   interrupted                   |   llist_add returns 0 |
 >>       ...                       |   branch not taken |
 >>       ...                       | |
 >>   resumed                       | |
 >>   send_call_function_single_ipi | |
 >>                                 | | f1
 >>                                 | | f2
 >>
 >> The call from CPU 1 for function f2 will be delayed because CPU 0 was
 >> interrupted.
 >
 > Do you happen to have any actual numbers and a use-case where this was
 > relevant?

Hi Peter,

I encountered this problem while developing a device driver that used 
smp_call_function_single to communicate with other cores. I observed 
latency spikes and after investigation I figured out the problem 
described above.

I have written a simple device driver to validate the above fix. It does 
smp_call_function_single and measures the latency. I can post it here if 
it is appropriate. The latency impact is equal to the duration of the 
CPU 0's interruption.

--
George

