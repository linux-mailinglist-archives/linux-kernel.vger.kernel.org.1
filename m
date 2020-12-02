Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37682CB240
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 02:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgLBBY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 20:24:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8548 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbgLBBY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 20:24:26 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cm1SQ0g6jzhl1s;
        Wed,  2 Dec 2020 09:23:18 +0800 (CST)
Received: from [10.174.178.52] (10.174.178.52) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 2 Dec 2020 09:23:37 +0800
Subject: Re: [PATCH] kretprobe: avoid re-registration of the same kretprobe
 earlier
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <huawei.libin@huawei.com>, <cj.chengjian@huawei.com>
References: <20201124115719.11799-1-bobo.shaobowang@huawei.com>
 <20201130161850.34bcfc8a@gandalf.local.home>
 <20201202083253.9dbc76704149261e131345bf@kernel.org>
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <9dff21f8-4ab9-f9b2-64fd-cc8c5f731932@huawei.com>
Date:   Wed, 2 Dec 2020 09:23:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20201202083253.9dbc76704149261e131345bf@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.52]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi steve, Masami,

Thanks for your works, i will check code again and modify properly 
according to steve's suggestion.

-- ShaoBo

ÔÚ 2020/12/2 7:32, Masami Hiramatsu Ð´µÀ:
> On Mon, 30 Nov 2020 16:18:50 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> Masami,
>>
>> Can you review this patch, and also, should this go to -rc and stable?
>>
>> -- Steve
> Thanks for ping me!
>
>> On Tue, 24 Nov 2020 19:57:19 +0800
>> Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:
>>
>>> Our system encountered a re-init error when re-registering same kretprobe,
>>> where the kretprobe_instance in rp->free_instances is illegally accessed
>>> after re-init.
> Ah, OK. Anyway if re-register happens on kretprobe, it must lose instances
> on the list before checking re-register in register_kprobe().
> So the idea looks good to me.
>
>
>>> Implementation to avoid re-registration has been introduced for kprobe
>>> before, but lags for register_kretprobe(). We must check if kprobe has
>>> been re-registered before re-initializing kretprobe, otherwise it will
>>> destroy the data struct of kretprobe registered, which can lead to memory
>>> leak, system crash, also some unexpected behaviors.
>>>
>>> we use check_kprobe_rereg() to check if kprobe has been re-registered
>>> before calling register_kretprobe(), for giving a warning message and
>>> terminate registration process.
>>>
>>> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
>>> Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
>>> ---
>>>   kernel/kprobes.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>>> index 41fdbb7953c6..7f54a70136f3 100644
>>> --- a/kernel/kprobes.c
>>> +++ b/kernel/kprobes.c
>>> @@ -2117,6 +2117,14 @@ int register_kretprobe(struct kretprobe *rp)
>>>   		}
>>>   	}
>>>   
>>> +	/*
>>> +	 * Return error if it's being re-registered,
>>> +	 * also give a warning message to the developer.
>>> +	 */
>>> +	ret = check_kprobe_rereg(&rp->kp);
>>> +	if (WARN_ON(ret))
>>> +		return ret;
> If you call this here, you must make sure kprobe_addr() is called on rp->kp.
> But if kretprobe_blacklist_size == 0, kprobe_addr() is not called before
> this check. So it should be in between kprobe_on_func_entry() and
> kretprobe_blacklist_size check, like this
>
> 	if (!kprobe_on_func_entry(rp->kp.addr, rp->kp.symbol_name, rp->kp.offset))
> 		return -EINVAL;
>
> 	addr = kprobe_addr(&rp->kp);
> 	if (IS_ERR(addr))
> 		return PTR_ERR(addr);
> 	rp->kp.addr = addr;
>
> 	ret = check_kprobe_rereg(&rp->kp);
> 	if (WARN_ON(ret))
> 		return ret;
>
>          if (kretprobe_blacklist_size) {
> 		for (i = 0; > > +	ret = check_kprobe_rereg(&rp->kp);
>
>
> Thank you,
>
>
