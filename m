Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2713122AA8E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 10:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgGWITE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 04:19:04 -0400
Received: from verein.lst.de ([213.95.11.211]:59151 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgGWITD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:19:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D73B168AFE; Thu, 23 Jul 2020 10:19:00 +0200 (CEST)
Date:   Thu, 23 Jul 2020 10:19:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "H.J. Lu" <hjl.tools@gmail.com>, x86@kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/dumpstack: Dump user space code correctly again
Message-ID: <20200723081900.GA16138@lst.de>
References: <bug-208655-6666@https.bugzilla.kernel.org/> <87h7tz306w.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7tz306w.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 07:54:15PM +0200, Thomas Gleixner wrote:
> Subject: x86/dumpstack: Dump user space code correctly again
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Wed, 22 Jul 2020 10:39:54 +0200
> 
> H.J. reported that post 5.7 a segfault of a user space task does not longer
> dump the Code bytes when /proc/sys/debug/exception-trace is enabled. It
> prints 'Code: Bad RIP value.' instead.
> 
> This was broken by a recent change which made probe_kernel_read() reject
> non-kernel addresses.
> 
> Update show_opcodes() so it retrieves user space opcodes via
> copy_from_user_nmi().
> 
> Fixes: 98a23609b103 ("maccess: always use strict semantics for probe_kernel_read")
> Reported-by: H.J. Lu <hjl.tools@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Looks good, and also cleans up the code nicely:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But one question below:

> +	/*
> +	 * Make sure userspace isn't trying to trick us into dumping kernel
> +	 * memory by pointing the userspace instruction pointer at it.
> +	 */
> +	if (__chk_range_not_ok(src, nbytes, TASK_SIZE_MAX))
> +		return -EINVAL;
> +
> +	return copy_from_user_nmi(buf, (void __user *)src, nbytes);

copy_from_user_nmi already contains a:

	if (__range_not_ok(from, n, TASK_SIZE))
		return n;

what is the reason it checks for TASK_SIZE vs TASK_SIZE_MAX, and why
do we need both checks?
