Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F56922B1D6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 16:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgGWOw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 10:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgGWOw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:52:29 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDA0C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 07:52:29 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 281AF7DD; Thu, 23 Jul 2020 16:52:26 +0200 (CEST)
Date:   Thu, 23 Jul 2020 16:52:20 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Regression on todays tip/master (commit 16f70beccf43)
Message-ID: <20200723145219.GP27672@8bytes.org>
References: <20200723133743.GA30716@8bytes.org>
 <871rl2xpar.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rl2xpar.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 04:46:04PM +0200, Thomas Gleixner wrote:
> Joerg Roedel <joro@8bytes.org> writes:
> > while testing the SEV-ES patches on todays tip/master I triggered the BUG
> > below:
> >
> > [  137.629660] ------------[ cut here ]------------
> > [  137.630769] kernel BUG at kernel/signal.c:1917!
> > [  137.631796] invalid opcode: 0000 [#1] SMP NOPTI
> > [  137.632822] CPU: 3 PID: 28596 Comm: test_syscall_vd Not tainted 5.8.0-rc6-tip+ #3
> > [  137.634495] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> > [  137.636236] RIP: 0010:do_notify_parent+0x25c/0x290
> > The guest had 4 VCPUs and ran 4 instances of the in-kernel x86-selftests
> > in a loop, together with 'perf top -e cycles:k'. As you can see in the
> > time-stamps, the issue triggered pretty quickly.
> >
> > Please let me know if you need more information or testing from my side.
> 
> Any chance to bisect this?

Yes, will try. I am currently testing plain -rc6, it seems to be fine.
Bisecting is next.

