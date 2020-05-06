Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC8C1C6FAC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 13:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgEFLxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 07:53:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:35260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgEFLxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 07:53:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EF8DBAD2C;
        Wed,  6 May 2020 11:53:39 +0000 (UTC)
Date:   Wed, 6 May 2020 13:53:36 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V4 part 1 05/36] x86/entry: Flip _TIF_SIGPENDING and
 _TIF_NOTIFY_RESUME handling
In-Reply-To: <20200505134058.560059744@linutronix.de>
Message-ID: <alpine.LSU.2.21.2005061352050.20724@pobox.suse.cz>
References: <20200505131602.633487962@linutronix.de> <20200505134058.560059744@linutronix.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 May 2020, Thomas Gleixner wrote:

> Make sure task_work runs before any kind of userspace -- very much
> including signals -- is invoked.

I might be missing something, but isn't this guaranteed by 
do_signal()->get_signal()->task_work_run() path?

Miroslav
