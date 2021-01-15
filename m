Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90012F77A9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 12:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbhAOLbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 06:31:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:33982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbhAOLbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 06:31:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610710219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4FnXQPdB7XkD25XWGkZfjD7tnnHBnBRZzLYJB35qua8=;
        b=h2w+xeXR3pig4Ms0UCND1/JD594nxWlHhzN5JklZQK1RbofB0kguxnsZKpziDgRdAs5LWU
        n8Jb6TUtlNWBpIQTsNRIuZHuEcIaDI/Nydo81FUF9OsijNYYljfTyQt8mLGkKqcH18JWW/
        Vw9yBVKoLE9M6oZE9PWU6eLeraouTZk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0EBFACB0;
        Fri, 15 Jan 2021 11:30:19 +0000 (UTC)
Date:   Fri, 15 Jan 2021 12:30:19 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: ringbuffer: fix line counting
Message-ID: <YAF8y82mITK5RgD8@alley>
References: <20210113144234.6545-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113144234.6545-1-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-01-13 15:48:34, John Ogness wrote:
> Counting text lines in a record simply involves counting the number
> of newline characters (+1). However, it is searching the full data
> block for newline characters, even though the text data can be (and
> often is) a subset of that area. Since the extra area in the data
> block was never initialized, the result is that extra newlines may
> be seen and counted.
> 
> Restrict newline searching to the text data length.
> 
> Fixes: b6cf8b3f3312 ("printk: add lockless ringbuffer")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

The patch is committed in printk/linux.git, branch printk-rework.

I plan to send it for-5.11 the following week after it spends
few days in linux-next.

Best Regards,
Petr
