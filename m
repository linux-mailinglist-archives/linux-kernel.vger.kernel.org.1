Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8622CBF34
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgLBOLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:11:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34248 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgLBOLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:11:07 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606918224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=laNf2sIhNkUADdBI8V7T00rnatL7Qu70dn5WJMC3hJc=;
        b=a4kXOw7FMRylLzhob+Ac4Q/iPYMaMdC6mf8fdgtgBBeq/qg8xQ8wYYulUUwSpQLBxFXdrP
        9mttzGnGsF5+hk+0gMXxPaxeJXZba3KZtCkSBEDWxWGYQErl1QHWHdZjwMeLPrYdHq9g0Z
        0wPLkBG7zlqJACxx/4R8O6JwWvYf9He9bcE/MOO8d5FxgwEp5L312p96Qe3Sfbi9G7WbLP
        27laX+uDEPO1pPhC3rS1hD3V/BqmTTotXE43wqGDRWP3c3BaV4O42sWtNmsr3tQBXauC+P
        IQAVdM0qQ4QnZr6LFRSykfvMrcOfyIvfChAldIv7PIH4sP8z34qWIwRUeIyAFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606918224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=laNf2sIhNkUADdBI8V7T00rnatL7Qu70dn5WJMC3hJc=;
        b=9ucGiQ79Elv+XOkf6KYA3tF5s/iuJcipu0ffPG+zXMIraMUbBvsq/1dJFB33xqKOwpYqkp
        +8h8ooLmEFwcxgCg==
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 13/16] sched: fix kernel-doc markup
In-Reply-To: <50cd6f460aeb872ebe518a8e9cfffda2df8bdb0a.1606823973.git.mchehab+huawei@kernel.org>
References: <cover.1606823973.git.mchehab+huawei@kernel.org> <50cd6f460aeb872ebe518a8e9cfffda2df8bdb0a.1606823973.git.mchehab+huawei@kernel.org>
Date:   Wed, 02 Dec 2020 15:10:24 +0100
Message-ID: <87k0u0e1tb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01 2020 at 13:09, Mauro Carvalho Chehab wrote:

> Kernel-doc requires that a kernel-doc markup to be immediately
> below the function prototype, as otherwise it will rename it.

below?
