Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688823048DA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 20:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733069AbhAZFiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:38:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:52142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727677AbhAYK5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:57:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611572144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Xvv1RALPsUeOY2I3xlsjgZ9c/e/BEQxiygLkfo3w44=;
        b=KdS7iELmC4HWCM4gzLhVJfue5TncCkeJzgHsO2pgQFyxHLsggJ2GwIs4o/hzDWmUurPmDW
        tXGsRZr1mH0XklOl2E3MLk4MivwvGNLdok7v/ltPE8DqvI6kNuE2X3+lDiLUKz+EhfcaP+
        xJ4X5XkKh2daWskEZ316A0eVmkPOp+I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4C407AC9B;
        Mon, 25 Jan 2021 10:55:44 +0000 (UTC)
Date:   Mon, 25 Jan 2021 11:55:43 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix string termination for record_print_text()
Message-ID: <YA6jr+Fs2+ozoVwr@alley>
References: <20210124202728.4718-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124202728.4718-1-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2021-01-24 21:33:28, John Ogness wrote:
> Commit f0e386ee0c0b ("printk: fix buffer overflow potential for
> print_text()") added string termination in record_print_text().
> However it used the wrong base pointer for adding the terminator.
> This led to a 0-byte being written somewhere beyond the buffer.
> 
> Use the correct base pointer when adding the terminator.
> 
> Fixes: f0e386ee0c0b ("printk: fix buffer overflow potential for print_text()")
> Reported-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

The patch is pushed in kernel/printk.git, branch printk-rework.

I am going to send pull request for-5.11 later today.

Thanks a lot for the debugging and quick fix. I feel shame that
I did not caught this during the review.

Best Regards,
Petr
