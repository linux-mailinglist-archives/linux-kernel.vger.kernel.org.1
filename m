Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A07304E50
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390558AbhA0AZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:25:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389426AbhAZROr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:14:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFF2D230FC;
        Tue, 26 Jan 2021 17:14:05 +0000 (UTC)
Date:   Tue, 26 Jan 2021 12:14:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Timur Tabi <timur@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        keescook@chromium.org, John Ogness <john.ogness@linutronix.de>,
        linux-mm@kvack.org, Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
Message-ID: <20210126121404.016117fd@gandalf.local.home>
In-Reply-To: <cd9e7a31-e4f6-69d3-0648-c6228108b592@kernel.org>
References: <20210116220950.47078-1-timur@kernel.org>
        <20210118182635.GD2260413@casper.infradead.org>
        <ed7e0656-9271-3ccf-ef88-153da1ee31c9@kernel.org>
        <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
        <20210119014725.GH2260413@casper.infradead.org>
        <YAa2oCNWjExWlQTu@jagdpanzerIV.localdomain>
        <09c70d6b-c989-ca23-7ee8-b404bb0490f0@suse.cz>
        <cd9e7a31-e4f6-69d3-0648-c6228108b592@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 10:59:12 -0600
Timur Tabi <timur@kernel.org> wrote:

> The only drawback to this idea is: what happens if distros start 
> enabling CONFIG_PRINTK_NEVER_HASH by default, just because it makes 
> debugging easier?

I do believe distros should be more concerned about security than using
this for making debugging easier.

Perhaps we should add the same banner print if that config is set as
trace_printk() has if it is detected in the kernel or a module:

 **********************************************************
 **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
 **                                                      **
 ** trace_printk() being used. Allocating extra memory.  **
 **                                                      **
 ** This means that this is a DEBUG kernel and it is     **
 ** unsafe for production use.                           **
 **                                                      **
 ** If you see this message and you are not debugging    **
 ** the kernel, report this immediately to your vendor!  **
 **                                                      **
 **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
 **********************************************************

But have:

 **********************************************************
 **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
 **                                                      **
 ** CONFIG_PRINTK_NEVER_HASH enabled                     **
 **                                                      **
 ** This means that this is a DEBUG kernel and it is     **
 ** unsafe for production use.                           **
 **                                                      **
 ** If you see this message and you are not debugging    **
 ** the kernel, report this immediately to your vendor!  **
 **                                                      **
 **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
 **********************************************************

The above appears to keep people from using trace_printk(), I don't see why
it wouldn't work for this config ;-)

-- Steve
