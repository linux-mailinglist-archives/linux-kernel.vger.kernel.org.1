Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B732F61EC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbhANN0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:26:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:44760 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbhANN0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:26:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610630715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2rqV3Atik93fq6Kwtpsg8uBRgfQnASn9g43Gb5emf70=;
        b=fV682HPHB+PH/Cti9KHglz81L4NWt5r5NSXQqzjw08Hh5wLZJK0TG07WaOXkY4WVYXX4za
        UKo5Ja+wiKsoQNrYC1Q97m4wIcRixPyqI2LYTmVeOXMA3b/dKEOuH509Xv1WPTWCY9HLI2
        nEIze4X/lTnwDZs65QNiWReG2vTCB9s=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2D6A1ACB0;
        Thu, 14 Jan 2021 13:25:15 +0000 (UTC)
Date:   Thu, 14 Jan 2021 14:25:14 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix kmsg_dump_get_buffer length calulations
Message-ID: <YABGOq8Gv00lOPwz@alley>
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

Another great catch!

> Fixes: e2ae715d66bf ("kmsg - kmsg_dump() use iterator to receive log buffer content")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
