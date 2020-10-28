Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C815829D8FE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388173AbgJ1Wld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:41:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57646 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733291AbgJ1Wj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:39:26 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603873812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VCmEsSIGXzvsi9jAbfyuG98+Fx4+fgb6AA6gSwGEIa4=;
        b=LP13nQGV0S1l2VQjphFpxdo4d2AqSpdD39POMDckcJH5iqRRnqbEh8VDQZ51APLoOjADEo
        m4l3NOSqV+QlAYPBlVKGa3HZkKXgUzWCbkW8y04Heu7YF9ZEmfqrFGnlKDFxk1m8rryzJ4
        7Ji0itY8bqGMBDuDsq4XvVmf3j1FoZv0/1EF8KewH95rdMncTToeFzWld8DLeX9tHchKLh
        EvU/5XO3kL4qALJhVqk6lpk6Y1FddLz7J2bP/jrYziwW+gZoftiU/0DiBa0BHGiap/bKUL
        DyQ6nd0QOe3CHchmpH+QIOWkoezI3PDq4SSSfxjjhgQUHKTVtG3arbxvL7Eg2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603873812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VCmEsSIGXzvsi9jAbfyuG98+Fx4+fgb6AA6gSwGEIa4=;
        b=cNQ8tTA1FEzeSetii7henu2O3D+SumSLHI5KCVyxFBTXTb5iTCIVJLycHLMh5z72lYf+MQ
        wGkC67n9xiQCO8Aw==
To:     qiang.zhang@windriver.com, pmladek@suse.com, tj@kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kthread_worker: re-set CPU affinities if CPU come online
In-Reply-To: <20201028073031.4536-1-qiang.zhang@windriver.com>
References: <20201028073031.4536-1-qiang.zhang@windriver.com>
Date:   Wed, 28 Oct 2020 09:30:12 +0100
Message-ID: <874kme21nv.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28 2020 at 15:30, qiang zhang wrote:
> From: Zqiang <qiang.zhang@windriver.com>
>
> When someone CPU offlined, the 'kthread_worker' which bind this CPU,
> will run anywhere, if this CPU online, recovery of 'kthread_worker'
> affinity by cpuhp notifiers.
>
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>  v1->v2:
>  rename variable kworker_online to kthread_worker_online.
>  add 'cpuhp_node' and 'bind_cpu' init in KTHREAD_WORKER_INIT.
>  add a comment explaining for WARN_ON_ONCE.

How is that addressing any of the comments I made on V1 of this?

Thanks,

        tglx


