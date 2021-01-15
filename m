Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DE02F77AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 12:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbhAOLbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 06:31:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:34474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbhAOLbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 06:31:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610710261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3GHz8S+62EVlouf3aCzWVck64PnR00Hq4PvSyTaWKW8=;
        b=n26BaUW3wpEbyCAcOmUAJLIHtBqYO1mLmPuRM387wc9pLOC1ebtXfeNwSTFuRHas/AkOxh
        e+RFHz4+nticbLh7EuygbHmmwzxK2KoqIqxCSb+jk5LCVvNVTfSZZb5YYJ9u86LxH6JqHT
        m6tr3Nu/9k26Uzx6SoUMhk2cPhxK4i0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 72544B80E;
        Fri, 15 Jan 2021 11:31:01 +0000 (UTC)
Date:   Fri, 15 Jan 2021 12:31:00 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix kmsg_dump_get_buffer length calulations
Message-ID: <YAF89EEA1cQK6HJV@alley>
References: <20210113164413.1599-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113164413.1599-1-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-01-13 17:50:13, John Ogness wrote:
> kmsg_dump_get_buffer() uses @syslog to determine if the syslog
> prefix should be written to the buffer. However, when calculating
> the maximum number of records that can fit into the buffer, it
> always counts the bytes from the syslog prefix.
> 
> Use @syslog when calculating the maximum number of records that can
> fit into the buffer.
> 
> Fixes: e2ae715d66bf ("kmsg - kmsg_dump() use iterator to receive log buffer content")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

The patch is committed in printk/linux.git, branch printk-rework.

I plan to send it for-5.11 the following week after it spends
few days in linux-next.

Best Regards,
Petr
