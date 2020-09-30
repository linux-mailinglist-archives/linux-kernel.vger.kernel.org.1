Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571C027E9F6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbgI3Na6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:30:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:43042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728043AbgI3Na6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:30:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601472656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w5l3298h/W9/vnTUaZ61CRdnwpEmCubNJa9uFrQVNgI=;
        b=Pztg8LU1pXMAeUTodDs+P1OjYWPTevX8KIF4wRSsw8fngOVMg5ZSP4X/1tMFdTS3E+jBdz
        4/tfgEYzcLu0vp5wKM6Vmi6XPfVuatZ2jslTPCSH3zIBL1s35Cp9ErhCq2qo8dJDFTebYl
        hmOF0swva3Csjzcm0GMFAPaqrgBNZj8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 39EA2ABCC;
        Wed, 30 Sep 2020 13:30:56 +0000 (UTC)
Date:   Wed, 30 Sep 2020 15:30:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 0/2] printk: fix reading beyond buffer
Message-ID: <20200930133055.GG29288@alley>
References: <20200930090134.8723-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930090134.8723-1-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-09-30 11:07:32, John Ogness wrote:
> Hello,
> 
> Marek Szyprowski reported [0] a problem with a particular printk
> usage. This particular usage performs thousands of LOG_CONT calls.
> The printk.c implementation was only limiting the growing record by
> the maximum size available in the ringbuffer, thus creating a record
> that was several kilobytes in size. This in and of itself is not
> a problem.
> 
> However, the various readers used buffers that were about 1KB in
> size. The ringbuffer would only fill the reader's 1KB buffer, but the
> meta data stated that the message was actually much larger. The
> reader code was not checking this and assumed its buffer contained
> the full message.
> 
> I have solved this problem by adding the necessary check to the
> functions where the situation can occur and also adding an argument
> when extending records so that a maximum size is specified. This
> will prevent the records from growing beyond the size that we know
> our readers are using.
> 
> I did not add the check where it is certain that the reader's
> buffer is large enough to contain the largest possible message.
> 
> The 2nd patch in this series reduces the size of the initial setup
> buffer. I noticed it was too big while verifying all the sizes for
> this series.
> 
> John Ogness
> 
> [0] https://lkml.kernel.org/r/f1651593-3579-5820-6863-5f4973d2bfdc@samsung.com
> 
> John Ogness (2):
>   printk: avoid and/or handle record truncation
>   printk: reduce setup_text_buf size to LOG_LINE_MAX

The patchset is committed in printk/linux.git, branch printk-rework.

Best Regards,
Petr
