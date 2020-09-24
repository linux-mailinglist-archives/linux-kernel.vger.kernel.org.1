Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8389F276BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgIXIXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbgIXIXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:23:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314E4C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 01:23:34 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600935812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JZTmrEhF94tTpAzcznU17tH7F+Pkuoo4kJb8xylKuEc=;
        b=TO3zo7xHA0YfgQf9adnSbJMvebNu9SUqTA0sTUpjWZa+4n7rPH5KHVeLJkHuKebbl+2DMl
        xHquRqwX3wMPPLntKVuv6crtHzqRO611zoQ3GjstmfX02hgge940LsiigIhRWwpsuYguQ5
        fxT411Fh1blJurQpkL9QVc6nqqhIUMa7JpEXmX/w7O3AuUF3uLx3cGJUwKbEv3Qer3oYuA
        FFkiCpO2/KBnfK7GYROMyc1zxEyy+EBtiZXL5Rk9egDt2ylNUjvGJQeH71+Zg+HFoZ5yuq
        e/F234jKVoMGD0IVYdQ3Lu9VkRXwt0fzSYHl7ibHvUcyobqPdpqBxW/xEX8CWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600935812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JZTmrEhF94tTpAzcznU17tH7F+Pkuoo4kJb8xylKuEc=;
        b=sbXhIKk+Iu+GuTcpd62ZQsv7YYXvIkjHSD0ldyaq1b/ajj7ThyRA7K5QBhirECrMkPD1CR
        ca36UeZOsESqVbBw==
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prarit Bhargava <prarit@redhat.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Changki Kim <changki.kim@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] printk: Add more information about the printk caller
In-Reply-To: <20200924021756.GD577@jagdpanzerIV.localdomain>
References: <20200923135617.27149-1-pmladek@suse.com> <20200923135617.27149-3-pmladek@suse.com> <20200924021756.GD577@jagdpanzerIV.localdomain>
Date:   Thu, 24 Sep 2020 10:29:31 +0206
Message-ID: <87k0wj7fcs.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-24, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> A question. Suppose we have a task which does
>
> 	CPU0
>
> 	pr_err(...);
>
> 	preempt_disable();
> 	pr_err(...);
> 	preempt_enable();
>
> 	pr_err(...);
>
> 	rcu_read_lock();
> 	pr_info(...);
> 	rcu_read_unlock();
>
> Should we distinguish those as 3 different contexts?
>
> - normal printk
> - printk under disabled preemption (affects scheduling)
> - printk under RCU read side lock (affects RCU grace periods)

The internal purpose of the printk_info's @caller_id is to support
_some_ sanity with LOG_CONT. True LOG_CONT sanity will not be available
until we provide a context API like we previously talked about [0]. But
for now it is good enough (even if it is not good).

We can also store various flags and counters to describe the current
context. But these would only exist to provide the user with information
rather than because printk itself needs it. I only mention this so that
we don't get things mixed up. We can add as much information as want,
but LOG_CONT will only be interested in a subset of that.

John Ogness
