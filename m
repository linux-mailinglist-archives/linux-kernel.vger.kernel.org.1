Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7553D2A10B8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 23:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgJ3WOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 18:14:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45198 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgJ3WOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 18:14:20 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604096058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zIgCECG34REYC6LVslxI9xTCHzmaTLZn/hPr5Sb937w=;
        b=fmkzs5zeistuEEaSiqJ7Si0xIKCi6xAmGfatgNh5gT61d7GCU6gnc0d5ZWZK43U2DW6KWz
        DLkQQBilHiCvne6fjAglx8cTbPsfyJKpHbAgnAeftPZrOZdkI17ZmatWX8RqholfCIVYhq
        Ckl1mKPWtcCzBJEO9LAqnstgIGHWAyQaVf+IurX/X9bTte1/J2aJ290G9JrrOZQWmY19Cf
        DI5pQqt7z6EjPuKm+I7vNTINAITvARUuXT/Bc/SltExU7lJZeUyf9eQ99IiBIWJSig5tua
        kCzR2/QKA/384PVJlmpF5BQys4PheMTZV8ic2QXLgt9WDXJLUwGe/a/xj4cMgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604096058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zIgCECG34REYC6LVslxI9xTCHzmaTLZn/hPr5Sb937w=;
        b=GJHn9ma1EEKdVbV3fRB4+lpol/Xsxp/1f8Yx2BH0c8bCV5uNZBaoYM4dqy8/9GWopuPz+O
        QBstph6pRJdp9YDQ==
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, eranian@google.com
Subject: Re: [PATCH 4/6] perf: Optimize get_recursion_context()
In-Reply-To: <20201030162248.58e388f0@oasis.local.home>
References: <20201030151345.540479897@infradead.org> <20201030151955.187580298@infradead.org> <20201030181138.215b2b6a@carbon> <20201030162248.58e388f0@oasis.local.home>
Date:   Fri, 30 Oct 2020 23:14:18 +0100
Message-ID: <87v9erl5tx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30 2020 at 16:22, Steven Rostedt wrote:
> As this is something that ftrace recursion also does, perhaps we should
> move this into interrupt.h so that anyone that needs a counter can get

Not in interrupt.h please. We should create kernel/include/ for stuff
which really should only be available in the core kernel code.

Thanks,

        tglx


