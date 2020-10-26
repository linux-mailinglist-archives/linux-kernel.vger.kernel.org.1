Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA452993AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787643AbgJZRXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:23:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403954AbgJZRXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:23:04 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6FE321D7B;
        Mon, 26 Oct 2020 17:23:02 +0000 (UTC)
Date:   Mon, 26 Oct 2020 13:23:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
        Petr Mladek <pmladek@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seq_buf: avoid type mismatch for seq_buf_init
Message-ID: <20201026132300.6b175028@gandalf.local.home>
In-Reply-To: <20201026161108.3707783-1-arnd@kernel.org>
References: <20201026161108.3707783-1-arnd@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Oct 2020 17:10:58 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building with W=2 prints a number of warnings for one function that
> has a pointer type mismatch:
> 
> linux/seq_buf.h: In function 'seq_buf_init':
> linux/seq_buf.h:35:12: warning: pointer targets in assignment from 'unsigned char *' to 'char *' differ in signedness [-Wpointer-sign]

I've always hated the warning about char * and unsigned char *, as they are
mostly meaningless. Yes, bugs happen with int to unsigned int conversions,
but this is dealing with strings, where unsigned char * and char * are
basically equivalent, except when it comes to one thing, which is why I
prefer unsigned char * over char *, and that is printing out the numerical
values of a buffer, if they go above 177, the char * prints the negative
value, but unsigned char * keeps printing what you would expect.

As this is just an annoyance (extra warnings), and not really a "fix", I'll
queue it up for the next merge window.

-- Steve

> 
> Change the type in the function prototype according to the type in
> the structure.
> 
> Fixes: 9a7777935c34 ("tracing: Convert seq_buf fields to be like seq_file fields")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
