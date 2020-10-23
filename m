Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4314E296968
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 07:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370905AbgJWFh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 01:37:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:8143 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S370836AbgJWFh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 01:37:57 -0400
IronPort-SDR: OH715KUCfU3PDZ1oxg1569f5rYOPbptynFie4vgjZ5WNnxBDJYoXjmeTLa3r3FDw057gWzKVKO
 DhcBayGX5raA==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="146923343"
X-IronPort-AV: E=Sophos;i="5.77,407,1596524400"; 
   d="scan'208";a="146923343"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 22:37:56 -0700
IronPort-SDR: cBUkH5ZNuqrRWZ0oxuHj/ni25fGHv9pgtL/Erg7Co0xmGii1mds65AngQ0ZyjQBqrtWIxH6IyI
 ur9DsRMw5tkA==
X-IronPort-AV: E=Sophos;i="5.77,407,1596524400"; 
   d="scan'208";a="534266914"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.68]) ([10.238.4.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 22:37:52 -0700
Subject: Re: [LKP] Re: [sched] bdfcae1140: will-it-scale.per_thread_ops -37.0%
 regression
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Anton Blanchard <anton@au.ibm.com>, anton@ozlabs.org
Cc:     Rong Chen <rong.a.chen@intel.com>,
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
References: <20201002083311.GK393@shao2-debian>
 <1183082664.11002.1602082242482.JavaMail.zimbra@efficios.com>
 <7131f8f9-68d1-0277-c770-c10f98a062ec@linux.intel.com>
 <510309749.29852.1603199662203.JavaMail.zimbra@efficios.com>
 <e2eb8ed0-1075-3c5d-207e-d218a59c2a9f@linux.intel.com>
 <1597497813.35294.1603372755111.JavaMail.zimbra@efficios.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <61ff00c3-4f55-e186-3ba7-93f96340ebd0@linux.intel.com>
Date:   Fri, 23 Oct 2020 13:37:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1597497813.35294.1603372755111.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/22/2020 9:19 PM, Mathieu Desnoyers wrote:
> ----- On Oct 21, 2020, at 9:54 PM, Xing Zhengjun zhengjun.xing@linux.intel.com wrote:
> [...]
>> In fact, 0-day just copy the will-it-scale benchmark from the GitHub, if
>> you think the will-it-scale benchmark has some issues, you can
>> contribute your idea and help to improve it, later we will update the
>> will-it-scale benchmark to the new version.
> 
> This is why I CC'd the maintainer of the will-it-scale github project, Anton Blanchard.
> My main intent is to report this issue to him, but I have not heard back from him yet.
> Is this project maintained ? Let me try to add his ozlabs.org address in CC.
> 
>> For this test case, if we bind the workload to a specific CPU, then it
>> will hide the scheduler balance issue. In the real world, we seldom bind
>> the CPU...
> 
> When you say that you bind the workload to a specific CPU, is that done
> outside of the will-it-scale testsuite, thus limiting the entire testsuite
> to a single CPU, or you expect that internally the will-it-scale context-switch1
> test gets affined to a single specific CPU/core/hardware thread through use of
> hwloc ?
> 
The later one.

> Thanks,
> 
> Mathieu
> 

-- 
Zhengjun Xing
