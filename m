Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5336B29EC7A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgJ2NIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:08:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:59432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgJ2NIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:08:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603976899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qW8sAaNoNwfxzYhk+EkdOmpVblS2Sq1VgsLtN6wfi/U=;
        b=qB5H84Ro4kMRHNMfnMv0jg/PKVI4gMgv8QZJU+uFc7jqamugdPOHIFKYqNTKKuNiNbFoRF
        OO47fBqgC/Yo9GR+wLIiKMDJj+SifNWtVTNUHHlIH28feimEdIQP3MULwTm4s9up4YCGLs
        uagj0sYwd14Pyi3E+38Rhnzzu6JwVOo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7D36B8F3;
        Thu, 29 Oct 2020 13:08:19 +0000 (UTC)
Date:   Thu, 29 Oct 2020 14:08:18 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kthread_worker: re-set CPU affinities if CPU come
 online
Message-ID: <20201029130818.GC16774@alley>
References: <20201028073031.4536-1-qiang.zhang@windriver.com>
 <874kme21nv.fsf@nanos.tec.linutronix.de>
 <BYAPR11MB263255ED056CED38285FC95BFF170@BYAPR11MB2632.namprd11.prod.outlook.com>
 <871rhi1z7j.fsf@nanos.tec.linutronix.de>
 <BYAPR11MB2632B18DF7C02B68E758932BFF140@BYAPR11MB2632.namprd11.prod.outlook.com>
 <874kmdfndd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kmdfndd.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-10-29 09:27:26, Thomas Gleixner wrote:
> The expected semantics of a cpu bound kthread_worker are completely
> unclear and undocumented. This needs to be fixed first and once this is
> established and agreed on then the gaps in the implementation can be
> closed.

I thought about some sane semantic and it goes down to
the following problem:

The per-CPU kthread workers are created by explicitly calling
kthread_create_worker_on_cpu() on each CPU.

The API does _not_ store the information how to start the worker.
As a result, it is not able to start a new one when the CPU
goes online "for the first time". I mean when the CPU was offline
when the API user created the workers.

It means that the API user is responsible for handling CPU hotplug
on its own. We probably should just document it and do nothing else [*]


Alternative solution would be to extend the API and allow to create
kthread_worker on each online CPU. It would require to store
parameters needed to create the kthread only new online CPUs.
Then we might think about some sane semantic for CPU hotplug.

Well, it might be hard to define a sane semantic unless there are
more users of the API. So, I tend to keep it simple and just
document the status quo.

Any ideas?


[*] IMHO, it does not even make sense to manipulate the affinity.
    It would just give a false feeling that it is enough.

Best Regards,
Petr
