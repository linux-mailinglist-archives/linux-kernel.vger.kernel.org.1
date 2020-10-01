Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1693A27FADE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 09:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbgJAHzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 03:55:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:44520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731566AbgJAHy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 03:54:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601538895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O0GzEqK1IoDLkQJH9xpDe3707t9F4ttJyks4zmnT/98=;
        b=CYWlSVnBiRd5RlW5rWRfeyat8XfuOCmt67ydYk5me7ToyLv7VNE2d1fImeH2m5ofHsXIpu
        9TWTcgZeyc/pk4CXcBi1vmi+VgeoQbfd04BMXOAwncUW62ViyUSiQq5MaH7G1cZwK99Wuk
        fYQjNdPVwMtvELgVasmgO6xPdwQQGf8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F2CADAD0B;
        Thu,  1 Oct 2020 07:54:54 +0000 (UTC)
Date:   Thu, 1 Oct 2020 09:54:53 +0200
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
Message-ID: <20201001075453.GC17717@alley>
References: <20200930090134.8723-1-john.ogness@linutronix.de>
 <20200930090134.8723-2-john.ogness@linutronix.de>
 <b4c2ea7ec34aaf05d53264b19a6c40245ed361c0.camel@perches.com>
 <20201001072659.GB17717@alley>
 <873100a17ac1a9fc1c435ff7957b63d2540ce7fc.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873100a17ac1a9fc1c435ff7957b63d2540ce7fc.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-10-01 00:39:31, Joe Perches wrote:
> On Thu, 2020-10-01 at 09:26 +0200, Petr Mladek wrote:
> > On Wed 2020-09-30 08:25:24, Joe Perches wrote:
> > > On Wed, 2020-09-30 at 11:07 +0206, John Ogness wrote:
> > > > If a reader provides a buffer that is smaller than the message text,
> > > > the @text_len field of @info will have a value larger than the buffer
> > > > size. If readers blindly read @text_len bytes of data without
> > > > checking the size, they will read beyond their buffer.
> > > > 
> > > > Add this check to record_print_text() to properly recognize when such
> > > > truncation has occurred.
> > > > 
> > > > Add a maximum size argument to the ringbuffer function to extend
> > > > records so that records can not be created that are larger than the
> > > > buffer size of readers.
> > > > 
> > > > When extending records (LOG_CONT), do not extend records beyond
> > > > LOG_LINE_MAX since that is the maximum size available in the buffers
> > > > used by consoles and syslog.
> > > 
> > > I still think it better to support backspace by rewinding
> > > the buffer rather than truncation of the output.
> > 
> > IMHO, backspace support is not worth the complexity. It might do
> > some fancy animation on console but it does not bring any advantage
> > in static logs (dmesg, journalctl).
> > 
> > It is possible that it worked in the past when the log buffer was
> > just an array of characters that were pushed to the console when
> > they appeared.
> > 
> > But I am pretty sure that it has stopped working many years agl
> > variable-length record buffer").
> 
> It's more that spinner or timer dots could fill the
> buffer and any message after the spinner/dots like
> success or failure is lost via truncation.

Yeah, pushing existing parts of continuous lines on the console
would be nice. It would help to see that the system died in
the middle of a risky operation.

But it requires an extra code in the record based log buffer.
It actually has been there and it was removed later because it
complicated the code and did not really worked.

It will be even more complicated with the lockless ringbuffer
and console handled in kthreads.

It might be added when there is a big demand for it. But it does
not make sense to support looong lines full of spinners or dots.


> There aren't many spinners/dots, perhaps it's better
> to find and delete them.

Yeah, that would be nice cleanup.

Best Regards,
Petr
