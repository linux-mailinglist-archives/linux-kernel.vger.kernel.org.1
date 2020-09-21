Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A55271EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgIUJ2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:28:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:35758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgIUJ2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:28:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600680485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CgeG9wiOK5szi7r4Lx13yhz5oyTZEIEUrg5ioQaQUW0=;
        b=ODigja4H7PRphXqOl3FCAERnJwSCqyfA23sk3xD8uQXXSLyUP+JK2RW2DDjWv801Beqyxm
        tUe+IugEJ438O7pVxX54o9wFNVoY4fcHz2gdVnr6Odb5jJRG50GI+Q/vux+cXbFtAy+MAo
        cZEn9J9V8jt8iLieMVswgEUsCWvOua0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF12AAC83;
        Mon, 21 Sep 2020 09:28:40 +0000 (UTC)
Date:   Mon, 21 Sep 2020 11:28:03 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 1/3] printk: move printk_info into separate
 array
Message-ID: <20200921092803.GG14605@alley>
References: <20200918223421.21621-1-john.ogness@linutronix.de>
 <20200918223421.21621-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918223421.21621-2-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-09-19 00:40:19, John Ogness wrote:
> The majority of the size of a descriptor is taken up by meta data,
> which is often not of interest to the ringbuffer (for example,
> when performing state checks). Since descriptors are often
> temporarily stored on the stack, keeping their size minimal will
> help reduce stack pressure.
> 
> Rather than embedding the printk_info into the descriptor, create
> a separate printk_info array. The index of a descriptor in the
> descriptor array corresponds to the printk_info with the same
> index in the printk_info array. The rules for validity of a
> printk_info match the existing rules for the data blocks: the
> descriptor must be in a consistent state.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
