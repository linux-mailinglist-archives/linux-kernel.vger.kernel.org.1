Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F456270046
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 16:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgIRO4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 10:56:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:35030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbgIRO4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 10:56:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600440969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lj/uQ/yHIcDL9LH0EVkT8P8HY6TYKLx/IRICOXwqyXQ=;
        b=hlYcVcMc6KIToRxzwAx3i3SabtQLmVI/Qk0jMfRT36iqvMb6ey15vHa/NT7n++WLA/uWB8
        z8AGUEUiUCFpzZfl1LE74AbMlD8I1Hp5cGwzTRq++033kKUzAaMtZj3CRC3S+XeWYBkyaD
        uFoAgzjuEAkr6jDKPSAQfAHqpaFGZrU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 744E1AAC7;
        Fri, 18 Sep 2020 14:56:43 +0000 (UTC)
Date:   Fri, 18 Sep 2020 16:56:08 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 3/3] printk: remove dict ring
Message-ID: <20200918145608.GF14605@alley>
References: <20200917131644.25838-1-john.ogness@linutronix.de>
 <20200917131644.25838-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917131644.25838-4-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-09-17 15:22:44, John Ogness wrote:
> Since there is no code that will ever store anything into the dict
> ring, remove it. If any future dictionary properties are to be
> added, these should be added to the struct printk_info.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

I like the result. It simplified the code and removed some twists.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
