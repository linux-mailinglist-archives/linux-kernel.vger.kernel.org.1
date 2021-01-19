Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C7A2FC0AA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392077AbhASUM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:12:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391385AbhASUL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:11:28 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C211B23107;
        Tue, 19 Jan 2021 20:10:46 +0000 (UTC)
Date:   Tue, 19 Jan 2021 15:10:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Timur Tabi <timur@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        John Ogness <john.ogness@linutronix.de>, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
Message-ID: <20210119151045.15c1fee3@gandalf.local.home>
In-Reply-To: <29122c86-bfea-2f25-d111-00641cc660ba@kernel.org>
References: <20210116220950.47078-1-timur@kernel.org>
        <20210118182635.GD2260413@casper.infradead.org>
        <ed7e0656-9271-3ccf-ef88-153da1ee31c9@kernel.org>
        <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
        <20210119014725.GH2260413@casper.infradead.org>
        <202101191135.A78A570@keescook>
        <29122c86-bfea-2f25-d111-00641cc660ba@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jan 2021 13:55:29 -0600
Timur Tabi <timur@kernel.org> wrote:
> >   		case DUMP_PREFIX_ADDRESS:
> >   			printk("%s%s%p: %s\n",
> > -			       level, prefix_str, ptr + i, linebuf);
> > +			       level, prefix_str, addr + i, linebuf);  
> 
> Well, this is better than nothing, but not by much.  Again, as long as 
> %px exists for printk(), I just cannot understand any resistance to 
> allowing it in print_hex_dump().
> 
> Frankly, I think this patch and my patch should both be added.  During 
> debugging, it's very difficult if not impossible to work with hashed 
> addresses.  I use print_hex_dump() with an unhashed address all the 
> time, either by applying my patch to my own kernel or just replacing the 
> %p with %px.

I'm curious, what is the result if you replaced %p with %pS?

That way you get a kallsyms offset version of the output, which could still
be very useful depending on what you are dumping.

-- Steve
