Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01392518A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 14:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgHYMft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 08:35:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:54598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbgHYMfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:35:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C521BAF8A;
        Tue, 25 Aug 2020 12:36:14 +0000 (UTC)
Date:   Tue, 25 Aug 2020 14:35:42 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        John Ogness <john.ogness@linutronix.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2][next] update gdb scripts for lockless printk
 ringbuffer
Message-ID: <20200825123542.GU4353@alley>
References: <20200814212525.6118-1-john.ogness@linutronix.de>
 <20200821080813.GM4353@alley>
 <d81e8b0d-fa7f-1da1-671f-0541b94ad349@siemens.com>
 <a5f4c178-9b3c-6ccd-9ea1-24d8fdc13273@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5f4c178-9b3c-6ccd-9ea1-24d8fdc13273@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-08-24 10:20:53, Kieran Bingham wrote:
> Hi Petr,
> 
> On 21/08/2020 09:55, Jan Kiszka wrote:
> > On 21.08.20 10:08, Petr Mladek wrote:
> >> On Fri 2020-08-14 23:31:23, John Ogness wrote:
> >>> Hi,
> >>>
> >>> When we brought in the new lockless printk ringbuffer, we overlooked the gdb
> >>> scripts. Here are a set of patches to implement gdb support for the new
> >>> ringbuffer.
> >>>
> >>> John Ogness (2):
> >>>   scripts/gdb: add utils.read_ulong()
> >>>   scripts/gdb: update for lockless printk ringbuffer
> >>
> >> I am not fluent in the gdb macros and python so I did not try any
> >> deep review. But both patches work for me:
> >>
> >> Tested-by: Petr Mladek <pmladek@suse.com>
> >>
> >> I am going to give it few more days before pushing just in case there is
> >> another feedback.
> 
> Before 'pushing' ?
> 
> What context do you mean here? These patches go through AKPM don't they?
> Did I miss some update to procedures?

Both patches should go into mainline together with the lockless printk
ring buffer. It is already in linux-next via printk/linux.git,
branch printk-rework.

The plan is to get it into mainline when pr_cont() handling is solved.
It is more complicated than we hoped for, see
https://lore.kernel.org/r/20200824103538.31446-1-john.ogness@linutronix.de
It is still not clear whether it will be ready for 5.10.

Andrew, would you mind when I take the three gdb/lockless-printk
related changes via printk tree to avoid synchronization problems?

Best Regards,
Petr
