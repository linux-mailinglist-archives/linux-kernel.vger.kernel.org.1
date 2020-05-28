Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38D01E6088
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 14:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388678AbgE1MO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 08:14:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:48088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388549AbgE1MO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:14:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4982BAC22;
        Thu, 28 May 2020 12:14:56 +0000 (UTC)
Date:   Thu, 28 May 2020 14:14:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] twist: allow converting pr_devel()/pr_debug() into
 printk(KERN_DEBUG)
Message-ID: <20200528121455.GD11286@linux-b0ei>
References: <20200524145034.10697-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200525084218.GC5300@linux-b0ei>
 <20200525091157.GF755@jagdpanzerIV.localdomain>
 <f02a71bc-0867-be60-182b-10d7377b2b04@i-love.sakura.ne.jp>
 <20200527083747.GA27273@linux-b0ei>
 <35d76737-8d23-9fb2-8e55-507109317f44@i-love.sakura.ne.jp>
 <20200527155504.GD3529@linux-b0ei>
 <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
 <20200528105942.GB11286@linux-b0ei>
 <945213f4-a2c3-b25e-35e4-7c55f836e11c@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <945213f4-a2c3-b25e-35e4-7c55f836e11c@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-05-28 20:33:10, Tetsuo Handa wrote:
> On 2020/05/28 19:59, Petr Mladek wrote:
> > 2. Add twist into vprintk_store(). In the current, implementation
> >    it would do:
> > 
> >   #if TWIST
> > 	return text_len;
> >   #endif
> > 
> > 	return log_output(facility, level, lflags,
> > 			  dict, dictlen, text, text_len);
> 
> This part could be possible. But
> 
> > 1. Add twist into ddebug_add_module() and enable all newly added
> >    entries by default. For example, by calling
> >    ddebug_exec_query("*:+p", const char *modname) or what is the syntax.
> > 
> >    This will cause that any pr_devel() variant will always get called.
> 
> how to handle
> 
> >>   #define no_printk(fmt, ...)                             \
> >>   ({                                                      \
> >>           if (0)                                          \
> >>                   printk(fmt, ##__VA_ARGS__);             \
> >>           0;                                              \
> >>   })
> 
> part used by e.g. pr_devel() ? Since this macro is not using dynamic debug
> interface, vprintk_store() will not be called from the beginning. Are you
> suggesting that we should convert no_printk() to use dynamic debug interface ?

OK, this is one more path that would need special handling. Two paths
are much better than 15.


> I don't know whether enabling only in linux-next makes sense. Since not all tests
> are equally done on each git tree, available only in linux-next will not be able
> to cover all callers. Just using CONFIG_TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS=y
> and CONFIG_DYNAMIC_DEBUG=n is the simplest.

I hope that tests done on linux-next would be enough to trigger some
bugs. If you do not see problems in linux-next then this twist
probably is not worth the effort and code complications.

Best Regards,
Petr
