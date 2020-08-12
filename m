Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2511724309C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 23:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHLVjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 17:39:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbgHLVjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 17:39:04 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1110C20781;
        Wed, 12 Aug 2020 21:39:02 +0000 (UTC)
Date:   Wed, 12 Aug 2020 17:39:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] printk: reduce LOG_BUF_SHIFT range for H8300
Message-ID: <20200812173901.54708d9a@oasis.local.home>
In-Reply-To: <20200812073122.25412-1-john.ogness@linutronix.de>
References: <20200812073122.25412-1-john.ogness@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020 09:37:22 +0206
John Ogness <john.ogness@linutronix.de> wrote:

> The .bss section for the h8300 is relatively small. A value of
> CONFIG_LOG_BUF_SHIFT that is larger than 19 will create a static
> printk ringbuffer that is too large. Limit the range appropriately
> for the H8300.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
