Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E418529E663
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 09:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgJ2I13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 04:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgJ2I13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 04:27:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20EEC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 01:27:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603960047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x8LDy5M/rxt2BJdbZmw1nw2xthchI5y7N+A3InWBsU8=;
        b=uTjd46qB4knJzR85Tja4SEf09vaZDjJCOXHoq0B+4iYqU3wBUagANQLB+5Fyho7e/IN8S4
        r4nPUExwWcsClZoaN5M6st4U5I+NO/YZmU6O+Orq9guZ5pKvcJdo5RQu7P6rlNmZsWVvMi
        SOGjsEYxhAXyt2dgFiaL6mIO/S+CM0we9OGEtkYappDngVoCNqKvzPyUn7I20syfeAWBpn
        9xAh0A2UD+IbrJ9iHcJNGX/o24CVLoxLFnBQe6SSuphgAWYxTY/g/xql9QKjjsW+Nc4oR6
        WDBqhVLsBprrUNHcR1ozVeUMGpQusrnMmDTRBMvBWm0bdjyfT3inXs7Ny5gYNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603960047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x8LDy5M/rxt2BJdbZmw1nw2xthchI5y7N+A3InWBsU8=;
        b=a+0tIpNoHitWMMxktsrXemtOsrof5qg8gzWC2v1U50keS8QZNIBwIeXT1/pld6EpeRibOz
        XaLDR8xq60lU/vCw==
To:     "Zhang\, Qiang" <Qiang.Zhang@windriver.com>,
        "pmladek\@suse.com" <pmladek@suse.com>,
        "tj\@kernel.org" <tj@kernel.org>
Cc:     "akpm\@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm\@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06?= [PATCH v2] kthread_worker:
 re-set CPU affinities if CPU come online
In-Reply-To: <BYAPR11MB2632B18DF7C02B68E758932BFF140@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20201028073031.4536-1-qiang.zhang@windriver.com> <874kme21nv.fsf@nanos.tec.linutronix.de> <BYAPR11MB263255ED056CED38285FC95BFF170@BYAPR11MB2632.namprd11.prod.outlook.com> <871rhi1z7j.fsf@nanos.tec.linutronix.de> <BYAPR11MB2632B18DF7C02B68E758932BFF140@BYAPR11MB2632.namprd11.prod.outlook.com>
Date:   Thu, 29 Oct 2020 09:27:26 +0100
Message-ID: <874kmdfndd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29 2020 at 03:14, Qiang Zhang wrote:
> Really, this patch is not considered that work may be put into the
> queue after the bound CPU is offline.  in addition, when the bound CPU
> goes online again, before restoring the worker's CPU affinity, work
> may be put into the queue.

And how is that supposed to be correct?

> Although int this (powerclamp) way=EF=BC=8Cthat's not a problem, that it =
is
> solved by destroying and creating tasks when the CPU hotplug, in
> addition, when CPU going down , this need call 'cancel_work_sync' func
> in offline callback, this may be blocked long time. these operation is
> expensive.

It does not matter whether it's expensive or not. It's correct and
that's what matters most.

> this patch only just to recover the worker task's affinity when CPU go
> to online again that create by "kthread_create_worker_on_cpu" func ,
> likely per-CPU worker method when CPU hotplug in "workqueue" and
> "io-wq".

I know what this patch just does, but that makes it not any more
correct. It creates a semanticaly ill defined illusion of correctness.

We are not "fixing" a problem by making it work for your particular and
even not explained use case.

The expected semantics of a cpu bound kthread_worker are completely
unclear and undocumented. This needs to be fixed first and once this is
established and agreed on then the gaps in the implementation can be
closed.

Thanks,

        tglx
