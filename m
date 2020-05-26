Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23F81D6C16
	for <lists+linux-kernel@lfdr.de>; Sun, 17 May 2020 21:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgEQTHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 May 2020 15:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQTHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 15:07:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F6CC061A0C;
        Sun, 17 May 2020 12:07:31 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jaOcU-0004pA-9C; Sun, 17 May 2020 21:06:42 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A7297100F17; Sun, 17 May 2020 21:06:41 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     paulmck@kernel.org
Cc:     "Joel Fernandes \(Google\)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>, frextrite@gmail.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        madhuparnabhowmik04@gmail.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        peterz@infradead.org, Petr Mladek <pmladek@suse.com>,
        rcu@vger.kernel.org, rostedt@goodmis.org, vpillai@digitalocean.com
Subject: Re: [PATCH v3 0/5] RCU dyntick nesting counter cleanups for rcu -dev
In-Reply-To: <20200517161531.GR2869@paulmck-ThinkPad-P72>
References: <20200504120505.89351-1-joel@joelfernandes.org> <20200504171532.GR2869@paulmck-ThinkPad-P72> <20200504174413.GA8883@paulmck-ThinkPad-P72> <20200516171223.GC2639@paulmck-ThinkPad-P72> <87wo5adfh8.fsf@nanos.tec.linutronix.de> <20200517161531.GR2869@paulmck-ThinkPad-P72>
Date:   Sun, 17 May 2020 21:06:41 +0200
Message-ID: <87blmmz8hq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

"Paul E. McKenney" <paulmck@kernel.org> writes:
> On Sun, May 17, 2020 at 12:26:43PM +0200, Thomas Gleixner wrote:
>>  objtool check -fal $BUILDIR/vmlinux.o
>
> The conflict was trivial, but for future reference, where should I be
> getting the proper objtool from?

It's in the objtool/core branch of tip and targeted for 5.8 upstream.

Thanks,

        tglx
