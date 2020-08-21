Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B7D24D059
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 10:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgHUIIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 04:08:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:36158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgHUIIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:08:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DB78BAEEF;
        Fri, 21 Aug 2020 08:08:42 +0000 (UTC)
Date:   Fri, 21 Aug 2020 10:08:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kieran Bingham <kbingham@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2][next] update gdb scripts for lockless printk
 ringbuffer
Message-ID: <20200821080813.GM4353@alley>
References: <20200814212525.6118-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814212525.6118-1-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-08-14 23:31:23, John Ogness wrote:
> Hi,
> 
> When we brought in the new lockless printk ringbuffer, we overlooked the gdb
> scripts. Here are a set of patches to implement gdb support for the new
> ringbuffer.
> 
> John Ogness (2):
>   scripts/gdb: add utils.read_ulong()
>   scripts/gdb: update for lockless printk ringbuffer

I am not fluent in the gdb macros and python so I did not try any
deep review. But both patches work for me:

Tested-by: Petr Mladek <pmladek@suse.com>

I am going to give it few more days before pushing just in case there is
another feedback.

Best Regards,
Petr

BTW: Are you aware of https://github.com/crash-python/crash-python project?
     The ambition is to implement "crash" features and even more into
     gdb using python extensions. It similar approach like
     scripts/gdb/

     crash-python is being developed sporadically in waves. It is
     mostly during a week that is dedicated for such projects
     at SUSE. It would be great to get more contributors.
