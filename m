Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD901D04A8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 04:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbgEMCKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 22:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728514AbgEMCKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 22:10:23 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41906206CC;
        Wed, 13 May 2020 02:10:21 +0000 (UTC)
Date:   Tue, 12 May 2020 22:10:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 3 08/29] x86/entry/64: Provide sane error
 entry/exit
Message-ID: <20200512221019.5527f92f@oasis.local.home>
In-Reply-To: <20200505134904.058904490@linutronix.de>
References: <20200505134354.774943181@linutronix.de>
        <20200505134904.058904490@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 May 2020 15:44:02 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> +	.if \sane == 0
>  	TRACE_IRQS_OFF

Are you implying that TRACE_IRQS_OFF is insane?

-- Steve
