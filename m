Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC6C2F7848
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbhAOMFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:05:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:57274 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbhAOMFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:05:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610712277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4/61Uo+zlVSdS9m3wBubDsgiAraVweiD6lOY4/ZHTuQ=;
        b=VUXxejLJskK+1kr9KssNyMhEnJE/9aY5YoowNaVo6ieN3RYsotlT0vx/RJ6bgI4o7dXbSp
        BcP+6lku6BvhF8cZbS2dWznCfEi//oQcVmQWps5JTkCbCzKGnUnu8qefK9fNV8rNyBpTL3
        M4606OOBLlGjgSYYYAgL4sG/D2CQst4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8D18CAC63;
        Fri, 15 Jan 2021 12:04:37 +0000 (UTC)
Date:   Fri, 15 Jan 2021 13:04:36 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix buffer overflow potential for print_text()
Message-ID: <YAGE1O/nG57hyRs4@alley>
References: <20210114170412.4819-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114170412.4819-1-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-01-14 18:10:12, John Ogness wrote:
> Before commit b6cf8b3f3312 ("printk: add lockless ringbuffer"),
> msg_print_text() would only write up to size-1 bytes into the
> provided buffer. Some callers expect this behavior and append
> a terminator to returned string. In particular:
> 
> arch/powerpc/xmon/xmon.c:dump_log_buf()
> arch/um/kernel/kmsg_dump.c:kmsg_dumper_stdout()
> 
> msg_print_text() has been replaced by record_print_text(), which
> currently fills the full size of the buffer. This causes a
> buffer overflow for the above callers.
> 
> Change record_print_text() so that it will only use size-1 bytes
> for text data. Also, for paranoia sakes, add a terminator after
> the text data.
> 
> And finally, document this behavior so that it is clear that only
> size-1 bytes are used and a terminator is added.
> 
> Fixes: b6cf8b3f3312 ("printk: add lockless ringbuffer")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
