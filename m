Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD802AC1A3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbgKIRBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:01:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:58542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730513AbgKIRBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:01:10 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9BED20789;
        Mon,  9 Nov 2020 17:01:08 +0000 (UTC)
Date:   Mon, 9 Nov 2020 12:01:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH RT 2/6] tcp: Remove superfluous BH-disable around
 listening_hash
Message-ID: <20201109120106.4fe828b4@oasis.local.home>
In-Reply-To: <20201109092231.3t2pawkvv7dxasfs@linutronix.de>
References: <20201107020636.598338441@goodmis.org>
        <20201107020727.806739147@goodmis.org>
        <20201109092231.3t2pawkvv7dxasfs@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Nov 2020 10:22:31 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2020-11-06 21:06:38 [-0500], Steven Rostedt wrote:
> > 5.4.74-rt42-rc1 stable review patch.
> > If anyone has any objections, please let me know.  
> 
> Please drop that one. Lockep complains on RT with newer softirq code.
> Older RT and mainline does not complain here unless it observes
> inet_listen_hashbucket::lock in serving-softirq context (which is not
> the case).
> 

Note, I took this because it mentioned:

"Commit
       9652dc2eb9e40 ("tcp: relax listening_hash operations")
    
    removed the need to disable bottom half while acquiring
    listening_hash.lock. There are still two callers left which disable
    bottom half before the lock is acquired."

And that commit was added in 4.10.

I will remove it and release a rc2.

Thanks!

-- Steve
