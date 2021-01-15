Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FF92F8039
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 17:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbhAOQFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 11:05:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:54258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbhAOQFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 11:05:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610726670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=APlSiMxy880//SPeahM9qVbyxXBUGC7W6ghrfxK1EXQ=;
        b=dC+8P8J+I05cbCmgte+TUiaPwRHu+cUCW3stSm1drUPXKjorEwbFIYottd869tEHz1zwJG
        1Aj+33CWt0XUuflSJNVn8IRtYSL7WdRwoi3X4FQMC8Sdcd+uYdceTe022skxDqpi3aaBbX
        3TCpYyv7L52IaBZZXVlGUnwtGm+GtYs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B82AAC95;
        Fri, 15 Jan 2021 16:04:30 +0000 (UTC)
Date:   Fri, 15 Jan 2021 17:04:29 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix buffer overflow potential for print_text()
Message-ID: <YAG9Df7ctLPLwucS@alley>
References: <20210114170412.4819-1-john.ogness@linutronix.de>
 <878s8ujnfg.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s8ujnfg.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-01-15 15:22:03, John Ogness wrote:
> Hi Petr,
> 
> I noticed some minor errors in the commit log and comments...
> 
> On 2021-01-14, John Ogness <john.ogness@linutronix.de> wrote:
> > Before commit b6cf8b3f3312 ("printk: add lockless ringbuffer"),
> > msg_print_text()
> 
> Can you fixup the patch for the commit or do you need a v2?

I could fix these when pushing ;-)

Best Regards,
Petr
