Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964202D2C97
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgLHOFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:05:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:37196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729521AbgLHOFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:05:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607436268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=10SyrdXgUrRdGAnh5WvPbKIV8pyNLoc3QTTb/TrnexM=;
        b=RfqM41Uoo3BDdJegOLAbRpfKZeaGPHScJLBjg2eLxnshLcpE63sJXTUBZV5PeOKUb+MxEx
        S4IgQxEn9BlS6hRiNNXn3UTXMzcn4qIyAfAbnuA9c2RDj9gEwP7201egn1CZaASKpURatW
        LG+a7uy3FqyLDGPQW5O2QtyCbE+QeZ0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0EC7FAC94;
        Tue,  8 Dec 2020 14:04:28 +0000 (UTC)
Date:   Tue, 8 Dec 2020 15:04:27 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v3 2/3] printk: define CONSOLE_LOG_MAX in printk.h
Message-ID: <X8+H6xG+eTyOJ3nu@alley>
References: <20201207222020.2923-1-john.ogness@linutronix.de>
 <20201207222020.2923-3-john.ogness@linutronix.de>
 <87k0tsd9q6.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0tsd9q6.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-12-08 08:48:57, John Ogness wrote:
> On 2020-12-07, John Ogness <john.ogness@linutronix.de> wrote:
> > CONSOLE_EXT_LOG_MAX for extended console messages is already defined
> > in printk.h. Define CONSOLE_LOG_MAX there as well so that future
> > changes can make use of the constant for non-extended console
> > messages.
> 
> Actually this patch is not necessary for this series. Also, this patch
> should probably modify all the "LOG_LINE_MAX + PREFIX_MAX" calls as
> well.

+1

Best Regards,
Petr
