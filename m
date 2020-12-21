Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190422DFC53
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 14:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgLUNcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 08:32:39 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9234 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgLUNcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 08:32:39 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D00jD2GFHzksVK;
        Mon, 21 Dec 2020 21:30:56 +0800 (CST)
Received: from [10.174.178.52] (10.174.178.52) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Mon, 21 Dec 2020 21:31:42 +0800
Subject: Re: [PATCH] kretprobe: avoid re-registration of the same kretprobe
 earlier
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>, <naveen.n.rao@linux.ibm.com>,
        <anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <huawei.libin@huawei.com>,
        <cj.chengjian@huawei.com>
References: <20201124115719.11799-1-bobo.shaobowang@huawei.com>
 <20201130161850.34bcfc8a@gandalf.local.home>
 <20201202083253.9dbc76704149261e131345bf@kernel.org>
 <9dff21f8-4ab9-f9b2-64fd-cc8c5f731932@huawei.com>
 <20201215123119.35258dd5006942be247600db@kernel.org>
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <c584f7e2-1d95-4f6a-7e36-4ff2d610bc78@huawei.com>
Date:   Mon, 21 Dec 2020 21:31:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20201215123119.35258dd5006942be247600db@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.52]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi steven, Masami,
We have encountered a problem, when we attempted to use steven's suggestion as following,

>>> If you call this here, you must make sure kprobe_addr() is called on rp->kp.
>>> But if kretprobe_blacklist_size == 0, kprobe_addr() is not called before
>>> this check. So it should be in between kprobe_on_func_entry() and
>>> kretprobe_blacklist_size check, like this
>>>
>>> 	if (!kprobe_on_func_entry(rp->kp.addr, rp->kp.symbol_name, rp->kp.offset))
>>> 		return -EINVAL;
>>>
>>> 	addr = kprobe_addr(&rp->kp);
>>> 	if (IS_ERR(addr))
>>> 		return PTR_ERR(addr);
>>> 	rp->kp.addr = addr;

//there exists no-atomic operation risk, we should not modify any rp->kp's information, not all arch ensure atomic operation here.

>>>
>>> 	ret = check_kprobe_rereg(&rp->kp);
>>> 	if (WARN_ON(ret))
>>> 		return ret;
>>>
>>>           if (kretprobe_blacklist_size) {
>>> 		for (i = 0; > > +	ret = check_kprobe_rereg(&rp->kp);

it returns failure from register_kprobe() end called by register_kretprobe() when
we registered a kretprobe through .symbol_name at first time(through .addr is OK),
kprobe_addr() called at the begaining of register_kprobe() will recheck and
failed at following place because at this time we symbol_name is not NULL and addr is also.

   static kprobe_opcode_t *_kprobe_addr(const char *symbol_name,
                          unsigned int offset)
    {
          if ((symbol_name && addr) || (!symbol_name && !addr))  //we failed here


So we attempted to move this sentence rp->kp.addr = addr to __get_valid_kprobe() like this to
avoid explict usage of rp->kp.addr = addr in register_kretprobe().

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index dd5821f753e6..ea014779edfe 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1502,10 +1502,15 @@ static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
  static struct kprobe *__get_valid_kprobe(struct kprobe *p)
  {
         struct kprobe *ap, *list_p;
+       void *addr;

         lockdep_assert_held(&kprobe_mutex);

-       ap = get_kprobe(p->addr);
+       addr = kprobe_addr(p);
+       if (IS_ERR(addr))
+               return NULL;
+
+       ap = get_kprobe(addr);
         if (unlikely(!ap))
                 return NULL;

But it also failed when we second time attempted to register a same kretprobe, it is also
becasue symbol_name and addr is not NULL when we used __get_valid_kprobe().

So it seems has no idea expect for modifying _kprobe_addr() like following this, the reason is that
the patch 0bd476e6c671 ("kallsyms: unexport kallsyms_lookup_name() and kallsyms_on_each_symbol()")
has telled us we'd better use symbol name to register but not address anymore.

-static kprobe_opcode_t *_kprobe_addr(kprobe_opcode_t *addr,
-                       const char *symbol_name, unsigned int offset)
+static kprobe_opcode_t *_kprobe_addr(const char *symbol_name,
+                       unsigned int offset)
  {
-       if ((symbol_name && addr) || (!symbol_name && !addr))
+       kprobe_opcode_t *addr;
+       if (!symbol_name)
                 goto invalid;

For us, this modification has not caused a big impact on other modules, only expects a little
influence on bpf from calling trace_kprobe_on_func_entry(), it can not use addr to fill in
rp.kp in struct trace_event_call anymore.

So i want to know your views, and i will resend this patch soon.

thanks,
Wang Shaobo

>>>
>
