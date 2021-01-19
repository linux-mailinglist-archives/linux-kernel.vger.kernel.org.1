Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6C52FB7F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390428AbhASLcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:32:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:42146 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388820AbhASLUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:20:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611055205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hWu+DiewVvlL1LmVaj1P5EWMhhS1qD2S88iFimQfQiA=;
        b=u+9iQaqACTIILNUbsmGHGAbTTV7d8oElPwb1A8brtM67ZWjRmamG/cIfHT9MaljRbrWThU
        iNB2/TB6PE8l/K1fWGuMsJf5yOCsFk7lB4TQBTw5cFeNXhTT7vPpprKDn105hVdosXdNrA
        TpVj71TnbBKioWefssKs+RR6CQmqPRo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D501DADE3;
        Tue, 19 Jan 2021 11:20:04 +0000 (UTC)
Date:   Tue, 19 Jan 2021 12:20:04 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix buffer overflow potential for print_text()
Message-ID: <YAbAZGeJSYGw2mgD@alley>
References: <20210114170412.4819-1-john.ogness@linutronix.de>
 <YAGE1O/nG57hyRs4@alley>
 <YAGFebfPNLwjyhcl@alley>
 <YAYriDiAl7lajty9@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAYriDiAl7lajty9@jagdpanzerIV.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-01-19 09:44:56, Sergey Senozhatsky wrote:
> On (21/01/15 13:07), Petr Mladek wrote:
> > On Fri 2021-01-15 13:04:37, Petr Mladek wrote:
> > > On Thu 2021-01-14 18:10:12, John Ogness wrote:
> > > > Before commit b6cf8b3f3312 ("printk: add lockless ringbuffer"),
> > > > msg_print_text() would only write up to size-1 bytes into the
> > > > provided buffer. Some callers expect this behavior and append
> > > > a terminator to returned string. In particular:
> > > > 
> > > > arch/powerpc/xmon/xmon.c:dump_log_buf()
> > > > arch/um/kernel/kmsg_dump.c:kmsg_dumper_stdout()
> > > > 
> > > > msg_print_text() has been replaced by record_print_text(), which
> > > > currently fills the full size of the buffer. This causes a
> > > > buffer overflow for the above callers.
> > > > 
> > > > Change record_print_text() so that it will only use size-1 bytes
> > > > for text data. Also, for paranoia sakes, add a terminator after
> > > > the text data.
> > > > 
> > > > And finally, document this behavior so that it is clear that only
> > > > size-1 bytes are used and a terminator is added.
> > > > 
> > > > Fixes: b6cf8b3f3312 ("printk: add lockless ringbuffer")
> > > > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> 
> John, how did you spot these problems?
> 
> FWIW, Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

The patch has been committed into printk/linux.git, branch
printk-rework.

Best Regards,
Petr
