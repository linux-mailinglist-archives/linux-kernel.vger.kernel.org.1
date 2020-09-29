Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8590227C969
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731683AbgI2MKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:10:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:35170 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730237AbgI2MKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:10:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601381417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z4lbCBkD9u0QTwO1EvR/PP7ZMkc8zCFTfP2jUjFJnWw=;
        b=TOaQYph0bWqhd2RuxIu8nZ5wdP3RN/HUuoeCgmVhWffelErziW2h5FND2A9IwRKRTxOVi4
        Sfqh3pi/4aykxiKrDBCS6apNySuob+NfSmSVW+KsTogAH7QALFDGleOhXcn4wG7ZrnrYku
        gLt9o67O99KYzJZVxvLhGlndIqhQjB0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 102BFADC5;
        Tue, 29 Sep 2020 12:10:17 +0000 (UTC)
Date:   Tue, 29 Sep 2020 14:10:16 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: KASAN: global-out-of-bounds in console_unlock
Message-ID: <20200929121016.GR6442@alley>
References: <CACT4Y+a8yAm2HFJkz+pgYDm4QV+5S8K5FH3wVn4e8kgbMzcXdg@mail.gmail.com>
 <20200928020752.GA871730@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928020752.GA871730@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-09-28 11:07:52, Sergey Senozhatsky wrote:
> Cc-ing John and Steven
> 
> On (20/09/27 11:12), Dmitry Vyukov wrote:
> > Hi printk maintainers,
> > 
> > I've got the following out-of-bounds in printk code.
> > This is on next-20200925. Config is attached.
> > This is just on pr_cont("\n"). Something overreads the string.
> > 
> > ==================================================================
> > BUG: KASAN: global-out-of-bounds in memchr+0x65/0x80 lib/string.c:1058
> > Read of size 1 at addr ffffffff8c68c860 by task swapper/0/0
> 
> Thanks for the report. I think this should be fixed by
> https://lore.kernel.org/lkml/20200926015526.8921-1-john.ogness@linutronix.de/

I agree with Sergey. This looks very much like the same problem.

Best Regards,
Petr
