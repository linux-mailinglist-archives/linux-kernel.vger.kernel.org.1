Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562EF2C40A0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgKYMyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:54:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:50392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728937AbgKYMyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:54:54 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71666206E5;
        Wed, 25 Nov 2020 12:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606308893;
        bh=NcE3+dgsaNxNTH+nxSaJa3qEfL3YRFoQ6AH2Z6VFQHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a7gjzeaQw8gqaRBaUyZOy5sUR2J1ue2BgtT8wiWE7vpNVO1bp6IDwU1JTPZRkI5fs
         twyAOO0XzXM1sucrjL22kkzADF4AGdwR5y6k6C5eXgzZ/XyZYqkR2l4h5+EmFr3WSF
         yiadG3vU7vSo8WZwowyoPcQDIgOs6udvyYjH4zqE=
Date:   Wed, 25 Nov 2020 14:54:40 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Baoquan He <bhe@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] microblaze: Remove noMMU code
Message-ID: <20201125125440.GP8537@kernel.org>
References: <caa5c3cbe6253d67fed83c4351d85224f8cf226c.1606303816.git.michal.simek@xilinx.com>
 <20201125120739.GO8537@kernel.org>
 <7217421a-c4de-0bd1-3231-17563e51e3c9@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7217421a-c4de-0bd1-3231-17563e51e3c9@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Wed, Nov 25, 2020 at 01:14:49PM +0100, Michal Simek wrote:
> Hi Mike,
> 
> On 25. 11. 20 13:07, Mike Rapoport wrote:
> > On Wed, Nov 25, 2020 at 12:30:32PM +0100, Michal Simek wrote:
> >> This configuration is obsolete and likely none is really using it. That's
> >> why remove it to simplify code.
> >>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >> ---
> > 
> > Looks ok to me except several leftovers:
> > 
> > $ git grep CONFIG_MMU arch/microblaze/
> > arch/microblaze/kernel/hw_exception_handler.S: * STACK FRAME STRUCTURE (for CONFIG_MMU=n)
> > 
> > $ git grep -E 'MICROBLAZE_(64|16)K_PAGES'
> > arch/microblaze/include/asm/page.h:#if defined(CONFIG_MICROBLAZE_64K_PAGES)
> > arch/microblaze/include/asm/page.h:#elif defined(CONFIG_MICROBLAZE_16K_PAGES)
> > arch/microblaze/kernel/hw_exception_handler.S:#ifdef CONFIG_MICROBLAZE_64K_PAGES
> > arch/microblaze/kernel/hw_exception_handler.S:#elif CONFIG_MICROBLAZE_16K_PAGES
> > drivers/net/Kconfig:                 IA64_PAGE_SIZE_64KB || MICROBLAZE_64K_PAGES || \
> > 
> > 
> 
> I left it there intentionally. First one because there is description in
> that comment which references noMMU. If this should be removed the whole
> comment should be tuned to make sense. It is better to do it in separate
> patch.

Makes sense, I just grepped without actually opening the files :)

> And second part. I know I removed that Kconfig macros for it but maybe
> good to talk about what needs to change to support different page size
> for systems with MMU.

I'd add a sentence about it to the changelog.

> Thanks,
> Michal

-- 
Sincerely yours,
Mike.
