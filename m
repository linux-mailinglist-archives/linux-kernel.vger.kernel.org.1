Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1104F29EF08
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgJ2PCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgJ2PCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:02:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2CCC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:01:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603983706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pTsyIcVnDD6a7iWer5GKbvGB1SiRAC/OHn/Z/nzgsBM=;
        b=wzbC3+nJdulBhl05Zn6UXjTe+7dRCQC0QsOeeoH655yD/ZusW9UPH3l1lxQvmPTt5xOjm9
        HvuSHjhNY09Be+wx6X3EtVHVwSQglJDnSf3Tk47RGuW/QVcsp7aLe+RoNdYWMWh/FE2fHp
        fK+XhyIvlkrjEAqy6jpMh3OBc40PQDeGwlxoRUapDyIjBBoLaYixpFOnSHdmsgqMZLt+wC
        FoaG7Urk62MYqQ1gRU7UhJugEJx/nkk842XFnnRplvRyY+zaqARvNjDhPkfvQgIdWiIbFS
        UxR65aBWAWqtDzNdG4wuP2DpJmCFTNHKQHJjzXJnaGNdQSfjudi28+mLnY96/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603983706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pTsyIcVnDD6a7iWer5GKbvGB1SiRAC/OHn/Z/nzgsBM=;
        b=ayt7gsTDXllXYCrfopjZCoP2aGe3djg+/6dr3HBdW/DejAF6a4j0c+A2XH7cL08jEXIcMM
        aOFZbQKQK2NeZdBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     "Zhang\, Qiang" <Qiang.Zhang@windriver.com>,
        "tj\@kernel.org" <tj@kernel.org>,
        "akpm\@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm\@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kthread_worker: re-set CPU affinities if CPU come online
In-Reply-To: <20201029130818.GC16774@alley>
References: <20201028073031.4536-1-qiang.zhang@windriver.com> <874kme21nv.fsf@nanos.tec.linutronix.de> <BYAPR11MB263255ED056CED38285FC95BFF170@BYAPR11MB2632.namprd11.prod.outlook.com> <871rhi1z7j.fsf@nanos.tec.linutronix.de> <BYAPR11MB2632B18DF7C02B68E758932BFF140@BYAPR11MB2632.namprd11.prod.outlook.com> <874kmdfndd.fsf@nanos.tec.linutronix.de> <20201029130818.GC16774@alley>
Date:   Thu, 29 Oct 2020 16:01:46 +0100
Message-ID: <87pn51dqjp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29 2020 at 14:08, Petr Mladek wrote:
> On Thu 2020-10-29 09:27:26, Thomas Gleixner wrote:
>> The expected semantics of a cpu bound kthread_worker are completely
>> unclear and undocumented. This needs to be fixed first and once this is
>> established and agreed on then the gaps in the implementation can be
>> closed.
>
> I thought about some sane semantic and it goes down to
> the following problem:
>
> The per-CPU kthread workers are created by explicitly calling
> kthread_create_worker_on_cpu() on each CPU.
>
> The API does _not_ store the information how to start the worker.
> As a result, it is not able to start a new one when the CPU
> goes online "for the first time". I mean when the CPU was offline
> when the API user created the workers.
>
> It means that the API user is responsible for handling CPU hotplug
> on its own. We probably should just document it and do nothing else [*]

> [*] IMHO, it does not even make sense to manipulate the affinity.
>     It would just give a false feeling that it is enough.

Agreed on both.

> Alternative solution would be to extend the API and allow to create
> kthread_worker on each online CPU. It would require to store
> parameters needed to create the kthread only new online CPUs.
> Then we might think about some sane semantic for CPU hotplug.

That facility already exists: smpboot_register_percpu_thread()

So "all" you'd need to do is to provide a kthread_worker variant which
utilizes that. It's straight forward, but not sure whether it's worth
the trouble.

> Well, it might be hard to define a sane semantic unless there are
> more users of the API. So, I tend to keep it simple and just
> document the status quo.

Ack.

Thanks,

        tglx


