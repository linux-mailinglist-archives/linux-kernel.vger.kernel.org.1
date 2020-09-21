Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C0527265D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgIUN43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:56:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:39790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbgIUN42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:56:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600696586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cw+yWbNehLrjwgxn0NRewIZjdfKM1nJiepusWDz8M2Q=;
        b=BOeYInkjB8bqQeyA4Qy1IAJx7GjEyTi0off3ajzrntTz9xWVKJEMBXjaCj5yYjwe01y6X5
        loDGLyQPBTba2KeQjxoA62A8P4Fpv/hJZfNS9inasOx4ZYUsDNJ4ifLKT7BLRPnWtynrkc
        eMG2qmrqdNAXGIL1tYxRkM0adQ+Pnu8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 32751AC61;
        Mon, 21 Sep 2020 13:57:02 +0000 (UTC)
Date:   Mon, 21 Sep 2020 15:56:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 2/3] printk: move dictionary keys to
 dev_printk_info
Message-ID: <20200921135625.GC31052@alley>
References: <20200918223421.21621-1-john.ogness@linutronix.de>
 <20200918223421.21621-3-john.ogness@linutronix.de>
 <20200921095557.GH14605@alley>
 <87r1qvl6yc.fsf@jogness.linutronix.de>
 <87mu1jl6ne.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu1jl6ne.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-09-21 13:24:45, John Ogness wrote:
> Dictionaries are only used for SUBSYSTEM and DEVICE properties. The
> current implementation stores the property names each time they are
> used. This requires more space than otherwise necessary. Also,
> because the dictionary entries are currently considered optional,
> it cannot be relied upon that they are always available, even if the
> writer wanted to store them. These issues will increase should new
> dictionary properties be introduced.
> 
> Rather than storing the subsystem and device properties in the
> dict ring, introduce a struct dev_printk_info with separate fields
> to store only the property values. Embed this struct within the
> struct printk_info to provide guaranteed availability.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
>  Sorry. v3 did not include Petr's fixup correctly. @size was wrong.
>  Now it is correct.

I could confirm that the added line and the patch looks fine now.

Best Regards,
Petr
