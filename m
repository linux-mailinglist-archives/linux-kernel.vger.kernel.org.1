Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672191DEEE7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 20:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbgEVSIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 14:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgEVSIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 14:08:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F5FC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 11:08:49 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jcC5e-0002PA-2O; Fri, 22 May 2020 20:08:14 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 9DEB6100F17; Fri, 22 May 2020 20:08:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [patch V9 00/39] x86/entry: Rework leftovers (was part V)
In-Reply-To: <878shjsvz2.fsf@nanos.tec.linutronix.de>
References: <20200521200513.656533920@linutronix.de> <0f9e4601-0d7c-728a-ecaf-a98d1826b5ec@oracle.com> <878shjsvz2.fsf@nanos.tec.linutronix.de>
Date:   Fri, 22 May 2020 20:08:11 +0200
Message-ID: <874ks7sv04.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> Boris Ostrovsky <boris.ostrovsky@oracle.com> writes:
>> On 5/21/20 4:05 PM, Thomas Gleixner wrote:
>>>
>>> The full series is available from:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v9-the-rest
>>
>>
>> Did you mean noinstr-v9-the-rest? I don't see entry-v9-the-rest tag.
>
> Bah. Yes.
>
>> (Also, this series as posted probably won't build. At least based on
>> definition of get_and_clear_inhcall() in patch 13)
>
> Darn. I'm very sure that I built this and then did some final cleanups.

Just figured out why i did not notice: The final test had preemption
enabled ...

Fixed and pushed and the tag is now correct

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v9-the-rest

/me goes and rumages in the brown paperbag supply stash.

Thanks,

        tglx
