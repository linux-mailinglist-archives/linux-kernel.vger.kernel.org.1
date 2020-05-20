Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D641DC1FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 00:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgETWUt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 May 2020 18:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgETWUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 18:20:48 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D423AC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:20:47 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbX4J-0004yy-Uc; Thu, 21 May 2020 00:20:08 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 649C8100C2D; Thu, 21 May 2020 00:20:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <JGross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [patch V6 04/37] x86: Make hardware latency tracing explicit
In-Reply-To: <CF349A31-C401-4684-BA34-CD3359AF34E7@amacapital.net>
References: <87imgqv055.fsf@nanos.tec.linutronix.de> <CF349A31-C401-4684-BA34-CD3359AF34E7@amacapital.net>
Date:   Thu, 21 May 2020 00:20:07 +0200
Message-ID: <87blmiuu3s.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@amacapital.net> writes:
>> On May 20, 2020, at 1:10 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> ﻿Peter Zijlstra <peterz@infradead.org> writes:
>>> We probably have to anyway. But I can do that later I suppose.
>> 
>> Second thoughts. For #DB and #INT3 we can just keep nmi_enter(), needs
>> just annotation in nmi_enter() around that trace muck.
>> 
>> For #NMI and #MCE I rather avoid the early trace call and do it once we
>> have reached "stable" state, i.e. avoid it in the whole nested NMI mess.
>
> What’s the issue?  The actual meat is mostly in the asm for NMI, and
> for MCE it’s just the sync-all-the-cores thing. The actual
> simultaneous NMI-and-MCE case is utterly busted regardless, and I’ve
> been thinking about how to fix it. It won’t be pretty, but nmi_enter()
> will have nothing to do with it.

The issue is that I want to avoid anything which is not essential just
for pure paranoia reasons.

I can drop that and just move the trace muck after RCU is safe and
annotate it properly.

