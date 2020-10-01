Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D3328009C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 15:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732263AbgJAN7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 09:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732380AbgJAN7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:59:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB46C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 06:59:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601560779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XD1o6mzPFDM5v0I7MnbskS3/Z0BeIjhgw5dT/3RikZo=;
        b=gJ9LDmApYL38bFFHh+4+/cO+UYi7UPedmR8F8o2rI5qsBTWqKigmuloBXf6uA5MnJPPncy
        YaPlRZG6dtqUlWWFhTvcSdN9CAzylyoXN0liI2yNWES0SGAOHxqu0gXo4qiiBkMmGUtmPQ
        LJh4LggIE7nSzooslqns+uvRD2esRvRYpK8JPqyombiivipBlkL+MxJEZVBHnwSCvpw1S0
        bdvwNCerRRb3hZFurRhxCVko5WQjWNst4Z5lutF8rll95YlGA8Fypy4Hcb9La/9ACXUbHZ
        iaiBRv86BfxWenDW5L8y4+sw47ioQngYL3tXQZFXfIT77igKeXIfr3hUjRB1Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601560779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XD1o6mzPFDM5v0I7MnbskS3/Z0BeIjhgw5dT/3RikZo=;
        b=lvlM6m6n0gheT3hj//Uakl3wKHTsRNMCX4DsB79ZEpEL1NvvPWl2sgow56jQI7zLuLSbgd
        gE0Ljd8fpJ4t0zAA==
To:     Hillf Danton <hdanton@sina.com>, Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        akpm@linux-foundation.org, Peter Zijlstra <peterz@infradead.org>,
        Zqiang <qiang.zhang@windriver.com>
Subject: Re: [RFC PATCH] kthread: do not modify running work
In-Reply-To: <20201001095151.5640-1-hdanton@sina.com>
References: <20200926040426.11936-1-hdanton@sina.com> <20201001095151.5640-1-hdanton@sina.com>
Date:   Thu, 01 Oct 2020 15:59:38 +0200
Message-ID: <87eemif3n9.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01 2020 at 17:51, Hillf Danton wrote:
> On Wed, 30 Sep 2020 17:01:09 +0200 Petr Mladek wrote:
>> On Sat 2020-09-26 12:04:26, Hillf Danton wrote:
>> > 
>> > It does not make much sense to rearm timer for the delayed work if
>> > it is worker's current work atm because it's good to do work only
>> > once.
>> 
>> Quite typical scenario is to queue delayed work from its own callback.
>> It allows to do the work in regular intervals.
>> 
>> This patch would break it. Or do I miss anything?
>
> It took more than 30 minutes to search kthread_mod_delayed_work for a
> callback at lore.kernel.org and failed, so can you point me to such an
> use case?

Why searching lore.kernel.org and not using git grep?

Aside of that it's pretty irrelevant whether there is a user at the
moment which reschedules work from the callback or not.

It's something which needs to work because its possible from regular
work queues as well and makes a lot of sense.

Thanks,

        tglx
