Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFAA303557
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388088AbhAZFjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbhAYK6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:58:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854E8C06178C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 02:58:04 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611572282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lEO7WoD6DzShicexf0VoynVWGbvCVvQ/Xhb1dgLNrbs=;
        b=e6dc46Vpk7kxXHBrloHfUSIus0s/AUbnwNO126nlP3AHMuLcC5tshz8m9qdiaaTOfh7xBX
        hOX21Wj1To8pEZmkM7RiXUJcNNFF38CshshoNREW1QCv9rsSxo5rybPZ8rfTj5XcshTOl3
        1mLDPyapwGXX6Rod9WC+I9WWtdxb16WY+IF/AyKAyyDWIgyUolX3yBu4M3CKhryjFivyTF
        ejJSlj/fAIOwtOhs8rZgRfmbpEnZjV53h87xIFd5f1XWX8EIrnnd4+pU20Zbt6sAQuQcIt
        4+DjsqjTgHZgJ3W0Y8E5DrOhtJhvxeOEF+MWFybyRbunNCvgKYXnHUW/jjgQUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611572282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lEO7WoD6DzShicexf0VoynVWGbvCVvQ/Xhb1dgLNrbs=;
        b=LWrMN13V6ymU8t2TqLwkyxi2piXrfOulnHGB2x/NSbjziVMJiZ28HNAXm/nEetCKTGK7m5
        LdJLN6rte+E8BDDg==
To:     Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: Add new pr_*_deferred_once() variants
In-Reply-To: <YA6fTuFEaCjFQB3h@hirez.programming.kicks-ass.net>
References: <20210123233741.3614408-1-qais.yousef@arm.com> <20210123233741.3614408-2-qais.yousef@arm.com> <YA6fTuFEaCjFQB3h@hirez.programming.kicks-ass.net>
Date:   Mon, 25 Jan 2021 12:04:01 +0106
Message-ID: <87y2gh2shy.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-25, Peter Zijlstra <peterz@infradead.org> wrote:
> On Sat, Jan 23, 2021 at 11:37:40PM +0000, Qais Yousef wrote:
>> To allow users in code where printk is not allowed.
>> 
>> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
>> ---
>>  include/linux/printk.h | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>> 
>> diff --git a/include/linux/printk.h b/include/linux/printk.h
>> index fe7eb2351610..92c0978c7b44 100644
>> --- a/include/linux/printk.h
>> +++ b/include/linux/printk.h
>> @@ -480,21 +480,45 @@ extern int kptr_restrict;
>>  	printk_once(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
>>  /* no pr_cont_once, don't do that... */
>>  
>> +#define pr_emerg_deferred_once(fmt, ...)				\
>> +	printk_deferred_once(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
>> +#define pr_alert_deferred_once(fmt, ...)				\
>> +	printk_deferred_once(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
>> +#define pr_crit_deferred_once(fmt, ...)					\
>> +	printk_deferred_once(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
>> +#define pr_err_deferred_once(fmt, ...)					\
>> +	printk_deferred_once(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>> +#define pr_warn_deferred_once(fmt, ...)					\
>> +	printk_deferred_once(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
>> +#define pr_notice_deferred_once(fmt, ...)				\
>> +	printk_deferred_once(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
>> +#define pr_info_deferred_once(fmt, ...)					\
>> +	printk_deferred_once(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
>> +/* no pr_cont_deferred_once, don't do that... */
>
> I absolutely detest this.. the whole _deferred thing is an
> abomination.

And it will disappear at some point.

> We should be very close to printk not needing this anymore, printk
> people?

It will disappear once console printing threads are introduced. We
probably still have a few kernel releases until we see that. First we
need to finish merging full lockless access, remove the safe buffers,
and merge the atomic consoles.

John Ogness
