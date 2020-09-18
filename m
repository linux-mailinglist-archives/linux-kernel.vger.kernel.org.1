Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F3526FBAB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgIRLjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:39:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:46046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgIRLji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:39:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600429177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2jvoV3T0DNvxIqduEwEv/1Z+E87kmvm0/1gv8+KDKPY=;
        b=T7urXVhgNbAAdGLZm4khcsi2uSoPOb8WZWlwy90Hl1Vgn8wxIx90Jj8q4UyMP7fvtBPXhy
        4H9ZC2sSV50CmQ5RyHTsjV7AWXe1ioqAzC05ENL2kmyMhixw201gVbXKxpNBwgfGiyTZPZ
        MekesWmvKOZGYG333G/n8YQOAUO1FjQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8EBDEABF4;
        Fri, 18 Sep 2020 11:40:11 +0000 (UTC)
Date:   Fri, 18 Sep 2020 13:39:36 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 2/3] printk: move dictionary keys to
 dev_printk_info
Message-ID: <20200918113936.GC14605@alley>
References: <20200917131644.25838-1-john.ogness@linutronix.de>
 <20200917131644.25838-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917131644.25838-3-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-09-17 15:22:43, John Ogness wrote:
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

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
