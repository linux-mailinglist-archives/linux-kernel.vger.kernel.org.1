Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BDE20A02C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 15:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405191AbgFYNmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 09:42:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:56474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404923AbgFYNmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:42:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F0BFFAEF6;
        Thu, 25 Jun 2020 13:42:48 +0000 (UTC)
Date:   Thu, 25 Jun 2020 15:42:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH] hvc: unify console setup naming
Message-ID: <20200625134248.GI6156@alley>
References: <20200619172240.754910-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619172240.754910-1-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-06-20 02:22:40, Sergey Senozhatsky wrote:
> Use the 'common' foo_console_setup() naming scheme. There are 71
> foo_console_setup() callbacks and only one foo_setup_console().
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

This patch is commited in printk/linux.git, branch
for-5.9-console-return-codes.

Best Regards,
Petr
