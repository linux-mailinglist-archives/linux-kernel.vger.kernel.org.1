Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D731C27FA3B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 09:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731294AbgJAH1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 03:27:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:56600 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgJAH1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 03:27:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601537221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/DdPn8/0D9cVPFvfVWWxhIfhkRLREKRFBF5KqMdMiR8=;
        b=IFSrztJlrjYB2gbPf1zPwjaqiYDGplr04hx4dwMofjTpCybjIuMwBG3RVkuP/4no6Xh2tq
        tRYKrKDH5S8jgmWgC39PAAwwqX7YZI0n8TqCguF7KVwD9I3XCmm+v0LtsiVz9uQs3yKZU/
        UemcXIMUYwljZDP4McyZ6bHRdG1j1ig=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 00EF6B214;
        Thu,  1 Oct 2020 07:27:01 +0000 (UTC)
Date:   Thu, 1 Oct 2020 09:26:59 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Perches <joe@perches.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 1/2] printk: avoid and/or handle record truncation
Message-ID: <20201001072659.GB17717@alley>
References: <20200930090134.8723-1-john.ogness@linutronix.de>
 <20200930090134.8723-2-john.ogness@linutronix.de>
 <b4c2ea7ec34aaf05d53264b19a6c40245ed361c0.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4c2ea7ec34aaf05d53264b19a6c40245ed361c0.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-09-30 08:25:24, Joe Perches wrote:
> On Wed, 2020-09-30 at 11:07 +0206, John Ogness wrote:
> > If a reader provides a buffer that is smaller than the message text,
> > the @text_len field of @info will have a value larger than the buffer
> > size. If readers blindly read @text_len bytes of data without
> > checking the size, they will read beyond their buffer.
> > 
> > Add this check to record_print_text() to properly recognize when such
> > truncation has occurred.
> > 
> > Add a maximum size argument to the ringbuffer function to extend
> > records so that records can not be created that are larger than the
> > buffer size of readers.
> > 
> > When extending records (LOG_CONT), do not extend records beyond
> > LOG_LINE_MAX since that is the maximum size available in the buffers
> > used by consoles and syslog.
> 
> I still think it better to support backspace by rewinding
> the buffer rather than truncation of the output.

IMHO, backspace support is not worth the complexity. It might do
some fancy animation on console but it does not bring any advantage
in static logs (dmesg, journalctl).

It is possible that it worked in the past when the log buffer was
just an array of characters that were pushed to the console when
they appeared.

But I am pretty sure that it has stopped working many years ago when
the buffer 7ff9554bb578 ("printk: convert byte-buffer to
variable-length record buffer").

Best Regards,
Petr
