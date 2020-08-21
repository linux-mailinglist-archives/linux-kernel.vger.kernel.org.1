Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B881C24D23E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 12:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgHUKZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 06:25:42 -0400
Received: from mail.jv-coder.de ([5.9.79.73]:49280 "EHLO mail.jv-coder.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgHUKZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:25:39 -0400
Received: from [192.168.178.40] (unknown [188.192.1.13])
        by mail.jv-coder.de (Postfix) with ESMTPSA id 0B8949F8DF;
        Fri, 21 Aug 2020 10:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
        t=1598005534; bh=1mWTmAbl1FHXUkfcwiE4A1L89igwhoE8UwOKzUmeHm8=;
        h=Subject:To:From:Message-ID:Date:MIME-Version;
        b=JEKA7+KcO3fKtqEo0jGbqxfkYjUbzq+axCAEOUn333+lk8RFf2gJ+UmmcVysYYTbM
         4UFP89ssG4JSyg8jsE28E4IUZN5sZ7tq5Va4oYSYEFSU8R618SV2lST02RgGmwUxiF
         W9jntjtQVgpNSCz2IyaZjljSR1F3EJZA0y61OZPA=
Subject: Re: [BUG RT] dump-capture kernel not executed for panic in interrupt
 context
To:     Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Huang Ying <ying.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>
References: <2c243f59-6d10-7abb-bab4-e7b1796cd54f@jv-coder.de>
 <20200528084614.0c949e8d@gandalf.local.home>
 <cbbf7926-148e-7acb-dc03-3f055d73364b@jv-coder.de>
 <20200727163655.8c94c8e245637b62311f5053@linux-foundation.org>
From:   Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <c6b095af-fc92-420f-303f-d2efd9f28873@jv-coder.de>
Date:   Fri, 21 Aug 2020 12:25:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200727163655.8c94c8e245637b62311f5053@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,HELO_MISC_IP,NICE_REPLY_A,RCVD_IN_PBL,
        RCVD_IN_SORBS_DUL,RDNS_NONE autolearn=no autolearn_force=no
        version=3.4.4
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.jv-coder.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew and Others (please read at least the part with @RT developers),

> Yup, mutex_trylock() from interrupt is improper.  Well dang, that's a
> bit silly.  Presumably the 2006 spin_lock_mutex() wasn't taken with
> irqs-off.
>
> Ho hum, did you look at switching the kexec code back to the xchg
> approach?
>
I looked into reverting to the xchg approach, but that seems to be
not a good solution anymore, because the mutex is used in many places,
a lot with waiting locks and I guess that would require spinning now,
if we do this with bare xchg.

Instead I thought about using a spinlock, because they are supposed
to be used in interrupt context as well, if I understand the documentation
correctly ([1]).
@RT developers
Unfortunately the rt patches seem to interpret it a bit different and
spin_trylock uses __rt_mutex_trylock again, with the same consequences as
with the current code.

I tried raw_spinlocks, but it looks like they result in a deadlock at
least in the rt kernel. Thiy may be because of memory allocations in the
critical sections, that are not allowed if I understand it correctly.

I have no clue how to fix it at this point.

Jörg

[1] https://kernel.readthedocs.io/en/sphinx-samples/kernel-locking.html

