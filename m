Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39052CF5FD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 22:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbgLDVIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 16:08:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49898 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDVIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 16:08:38 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607116077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wN1MZDPo+PRdZbRf2AiQV1temhU20xPUtJVE8trQZXQ=;
        b=jkmjJcINw7Az/Atdwe7NmH3KwN+eBIUnQhsDIsD0zVqm+YyqrMGBk3pTQ6TdTDy0mQge6N
        N3yzkOMBOBngIRoJRLWJz3LmwyK3b6jHGxL8YI8ZYczcywJLrZROr2FcGcQhk5sJgIKQAw
        Xaj97euSYZ0g2lWXowyMcFglgMT1u4ht9P/TsPmN6KW4k5ahxzL8764gskpIV5Egw/DKUP
        +kdrN7XpWecLlP8P6EgujMxf9bm87ATmxW6pOgagva6QutAX2edmNJkP7XQkxHMtjNCJJs
        bRc/pvf2u3A+mSmucERIQmNjww//g0xipjaOu8W4ZuMAb+Sz2aYeCQan9NR8og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607116077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wN1MZDPo+PRdZbRf2AiQV1temhU20xPUtJVE8trQZXQ=;
        b=HiaJWNHIETC47Cx/d9XMobKer8+Vq0uY8/kMLWI3MGP26qkUQ+s6EhKEBM0ARvj3KiZWVk
        FIwIi4KwGyaCboBQ==
To:     Balbir Singh <sblbir@amazon.com>, mingo@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, jpoimboe@redhat.com, tony.luck@intel.com,
        benh@kernel.crashing.org, x86@kernel.org, dave.hansen@intel.com,
        thomas.lendacky@amd.com, torvalds@linux-foundation.org,
        Balbir Singh <sblbir@amazon.com>
Subject: Re: [PATCH v3 1/5] x86/mm: change l1d flush runtime prctl behaviour
In-Reply-To: <20201127065938.8200-2-sblbir@amazon.com>
References: <20201127065938.8200-1-sblbir@amazon.com> <20201127065938.8200-2-sblbir@amazon.com>
Date:   Fri, 04 Dec 2020 22:07:56 +0100
Message-ID: <87r1o59t5f.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27 2020 at 17:59, Balbir Singh wrote:

> Detection of task affinities at API opt-in time is not the best
> approach, the approach is to kill the task if it runs on a
> SMT enable core. This is better than not flushing the L1D cache
> when the task switches from a non-SMT core to an SMT enabled core.
>
> Signed-off-by: Balbir Singh <sblbir@amazon.com>
> ---
>  arch/x86/include/asm/processor.h |  2 ++
>  arch/x86/kernel/smpboot.c        | 11 ++++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)

Subject, changelog match but patch content not so much :)

