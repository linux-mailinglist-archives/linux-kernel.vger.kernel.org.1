Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251BD27C7AD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 13:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbgI2Lzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 07:55:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:47482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731404AbgI2Lzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:55:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601380537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r2CIiQyvk9UAcQCoBJZfE1u1FP9kbhkdGmCFajeOJbU=;
        b=nzlJYyLvgVTqM4U8TtpARxY3J35qHucWvQ05yYOuSaN2P8lUEn9sCcZXvzrf0B0V6L8x+5
        rusfAl+nqD8LGrGc2G1vEPzESiOQ9wT1PbT7ItLsta/3o0nERvEJeOlijudbkp/39acWo5
        ruJZI1Dyvr6Figzk1yg1YZKAtOgvptA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 727D9ACB8;
        Tue, 29 Sep 2020 11:55:37 +0000 (UTC)
Date:   Tue, 29 Sep 2020 13:55:36 +0200
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
Subject: Re: [PATCH next 2/2] printk: reduce setup_text_buf size to
 LOG_LINE_MAX
Message-ID: <20200929115536.GP6442@alley>
References: <20200926015526.8921-1-john.ogness@linutronix.de>
 <20200926015526.8921-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926015526.8921-3-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-09-26 04:01:26, John Ogness wrote:
> @setup_text_buf only copies the original text messages (without any
> prefix or extended text). It only needs to be LOG_LINE_MAX in size.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
