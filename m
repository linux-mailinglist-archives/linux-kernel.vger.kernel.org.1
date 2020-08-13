Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0F7243AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 15:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHMNU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 09:20:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:38950 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgHMNU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 09:20:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B38E3B12F;
        Thu, 13 Aug 2020 13:20:48 +0000 (UTC)
Date:   Thu, 13 Aug 2020 15:20:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] printk: reduce LOG_BUF_SHIFT range for H8300
Message-ID: <20200813132025.GJ6215@alley>
References: <20200812073122.25412-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812073122.25412-1-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-08-12 09:37:22, John Ogness wrote:
> The .bss section for the h8300 is relatively small. A value of
> CONFIG_LOG_BUF_SHIFT that is larger than 19 will create a static
> printk ringbuffer that is too large. Limit the range appropriately
> for the H8300.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

This patch is committed in printk/linux.git, branch printk-rework.

Best Regards,
Petr
