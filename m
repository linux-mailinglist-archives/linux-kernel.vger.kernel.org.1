Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3515A275B32
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgIWPLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:11:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:46106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWPLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:11:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600873890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E83v/ucSMhfwTfzb6+rCLz1IyffRCv3VxbYq7yyWQFA=;
        b=o7SaWIcurg5lg7DJWZDVtpbqkcPhHlyKzFMtsbc5vWBM5uwvEmV25hy6eZV2eEp7B3IvBs
        r37XILVPHv7rWt0fNk88kei0U1F4TT996aWYVyq+8mD7doBDKIk2eAq4RY9M9g0BFBluwS
        xbNfRESUqKZUdcOnYoWfljIlouSqtSI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6EFE3AB54;
        Wed, 23 Sep 2020 15:12:07 +0000 (UTC)
Date:   Wed, 23 Sep 2020 17:11:29 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
Message-ID: <20200923151129.GC6442@alley>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
 <20200922153816.5883-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922153816.5883-4-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-09-22 17:44:14, John Ogness wrote:
> vprintk_store() is using a single static buffer as a temporary
> sprint buffer for the message text. This will not work once
> @logbuf_lock is removed. Replace the single static buffer with a
> pool of buffers.

The buffer is used because we do not know the length of the
formatted message to reserve the right space in the ring buffer
in advance.

There was the idea to call vsprintf(NULL, fmt, args) to count
the length in advance.

AFAIK, there is one catch. We need to use va_copy() around
the 1st call because va_format can be proceed only once.
See, va_format() in lib/vsprintf.c as an example.

Is there any other problem, please?

Best Regards,
Petr
