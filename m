Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6990527E9F1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbgI3NaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:30:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:42116 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728232AbgI3NaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:30:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601472599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0aGG+CtqPGJmiOFOGGIQ/c+ZReYi/AbBk1CjcE4dLTQ=;
        b=ut/k+j0qSZgIEIYILuBPWBwhFCjWK/DChunNrFI6SL8nJwwKsf1UPFUYr4c9AFZP0Y7WY4
        K1fXalm3sATwee+57R5egng0bNKov20kRqYps7s71drrHH5IIShCA0QeEnYy/Xa7Nj6Cl5
        Y4cSYmSkqWiLDS2c3qr3QC76ghVP9a4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9330FABCC;
        Wed, 30 Sep 2020 13:29:59 +0000 (UTC)
Date:   Wed, 30 Sep 2020 15:29:58 +0200
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
Subject: Re: [PATCH next v2 1/2] printk: avoid and/or handle record truncation
Message-ID: <20200930132958.GF29288@alley>
References: <20200930090134.8723-1-john.ogness@linutronix.de>
 <20200930090134.8723-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930090134.8723-2-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-09-30 11:07:33, John Ogness wrote:
> If a reader provides a buffer that is smaller than the message text,
> the @text_len field of @info will have a value larger than the buffer
> size. If readers blindly read @text_len bytes of data without
> checking the size, they will read beyond their buffer.
> 
> Add this check to record_print_text() to properly recognize when such
> truncation has occurred.
> 
> Add a maximum size argument to the ringbuffer function to extend
> records so that records can not be created that are larger than the
> buffer size of readers.
> 
> When extending records (LOG_CONT), do not extend records beyond
> LOG_LINE_MAX since that is the maximum size available in the buffers
> used by consoles and syslog.
> 
> Fixes: f5f022e53b87 ("printk: reimplement log_cont using record extension")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
