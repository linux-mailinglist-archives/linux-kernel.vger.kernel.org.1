Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB042FC21A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbhASVRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:17:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731769AbhASVQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 16:16:09 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5352122D08;
        Tue, 19 Jan 2021 21:15:26 +0000 (UTC)
Date:   Tue, 19 Jan 2021 16:15:24 -0500
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
Message-ID: <20210119161524.31c695d3@gandalf.local.home>
In-Reply-To: <184ab5eb-2508-0761-36c6-061d509fe104@kernel.org>
References: <20210116220950.47078-1-timur@kernel.org>
        <20210118182635.GD2260413@casper.infradead.org>
        <ed7e0656-9271-3ccf-ef88-153da1ee31c9@kernel.org>
        <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
        <20210119014725.GH2260413@casper.infradead.org>
        <202101191135.A78A570@keescook>
        <29122c86-bfea-2f25-d111-00641cc660ba@kernel.org>
        <20210119151045.15c1fee3@gandalf.local.home>
        <184ab5eb-2508-0761-36c6-061d509fe104@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jan 2021 14:49:17 -0600
Timur Tabi <timur@kernel.org> wrote:

> On 1/19/21 2:10 PM, Steven Rostedt wrote:
> > I'm curious, what is the result if you replaced %p with %pS?
> > 
> > That way you get a kallsyms offset version of the output, which could still
> > be very useful depending on what you are dumping.  
> 
> 	%pS	versatile_init+0x0/0x110
> 
> The address is question is often not related to any symbol, so it 
> wouldn't make sense to use %pS.

When it's not related to any symbol, doesn't it still produce an offset
with something close by, that could still give you information that's
better than a hashed number.

> 
> Maybe you meant %pK?  I'm okay with that instead of %px.

If others are OK with that, perhaps that should be the compromise then?

-- Steve
