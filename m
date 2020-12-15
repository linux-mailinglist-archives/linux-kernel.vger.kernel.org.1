Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D312DAECC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgLOOUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgLOOU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:20:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E530C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 06:19:49 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608041987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mcFbaIcU6BSLcvdJu6SGSMjuFCLfNK0qtr0KoiR4Ers=;
        b=CwRVNprbYLMiM3xpCbKsBAYdqOKpQM/qWbKVNeFt1tSIsDu3ZrgpQbEPz+A8Hpw2ySlDlV
        Fe12fdJSe8O4/TaZ2P/XIj28KBGP7924KuCyHAJmazxuvvubUzL6X2p0QERR7fGf/WX1W6
        AsF48WY9hFBLd9Pv2S4u+sFKvCDfDaAT2p0pl007knG5z1zsTrIUbXexiikMG8F4XZhYd/
        t6GGCgNv+0CaSctcEfCZyRigkPR2FcMP8gNQ0/zNzMXo+A7zjDeUaGvrZV7WGe9G2S5oxs
        RMMHhJblPOc4EIWg8a5Gpg0sNtmxVxXZbZYPF6vtv+RFfATkl7PzL3NhaAOYxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608041987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mcFbaIcU6BSLcvdJu6SGSMjuFCLfNK0qtr0KoiR4Ers=;
        b=669Or7c+GSkIuXR5piycMk3bBXvnDUG7JVNKDIveLmkg+LjCubVdj71ZIH8Z482+SQU4bO
        eDQc8Z8c3CmfttBQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] irq/core for v5.11-rc1
In-Reply-To: <CAHk-=wh-Br8BKJ3rfdq54HVYv30wjQeV63-k_9Q-j2FfwyzTHg@mail.gmail.com>
References: <160797732939.10793.9152151866806316627.tglx@nanos> <160797733303.10793.16327860918275449762.tglx@nanos> <CAHk-=wh-Br8BKJ3rfdq54HVYv30wjQeV63-k_9Q-j2FfwyzTHg@mail.gmail.com>
Date:   Tue, 15 Dec 2020 15:19:47 +0100
Message-ID: <87lfdzup6k.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14 2020 at 18:02, Linus Torvalds wrote:
> On Mon, Dec 14, 2020 at 12:25 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-12-14
>
> What?
>
> This is completely broken, and doesn't even build.
>
> In particular, look at commit a07d244f00de ("genirq: Move
> irq_set_lockdep_class() to core"). Look at the EXPORT_SYMBOL_GPL().
>
> How did this happen? Usually the -tip pull requests don't have glaring
> problems like this.

I really don't know how that happened. I screwed that up at least 5
times in a row. Sorry for that.

Thanks,

        tglx
