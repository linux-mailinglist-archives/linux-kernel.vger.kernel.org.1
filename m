Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A2F2008B8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 14:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732233AbgFSM3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 08:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730934AbgFSM3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:29:22 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13B45206C3;
        Fri, 19 Jun 2020 12:29:20 +0000 (UTC)
Date:   Fri, 19 Jun 2020 08:29:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     kernel test robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>,
        kbuild-all@lists.01.org, Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] printk: _printk_rb_static_dict can be static
Message-ID: <20200619082919.5d604e58@oasis.local.home>
In-Reply-To: <871rmbim8e.fsf@vostro.fn.ogness.net>
References: <20200618144919.9806-4-john.ogness@linutronix.de>
        <20200618182323.GA72993@4e49555bcca1>
        <871rmbim8e.fsf@vostro.fn.ogness.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 08:49:21 +0200
John Ogness <john.ogness@linutronix.de> wrote:

> > +++ b/kernel/printk/printk.c
> > @@ -434,7 +434,7 @@ static u32 log_buf_len = __LOG_BUF_LEN;
> >   */
> >  #define PRB_AVGBITS 5	/* 32 character average length */
> >  
> > -_DECLARE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
> > +static _DECLARE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
> >  		  PRB_AVGBITS, PRB_AVGBITS, &__log_buf[0]);  
> 
> _DECLARE_PRINTKRB declares multiple variables, so this patch will not
> work as intended. I would like to declare the variables static but am
> not sure how best to go about it.
> 
> In the Linux source I see examples of macros just desclaring the
> variables static. And I see examples of the macros providing a parameter
> where the "static" keyword can be specified.
> 
> Since the ringbuffer was created exclusively to serve printk, I would
> prefer to just have _DECLARE_PRINTKRB (and DECLARE_PRINTKRB) declare all
> the variables as static.

Haven written macros that do such things, I agree with your last
statement. Just have the macro declare all the variables static.

-- Steve
