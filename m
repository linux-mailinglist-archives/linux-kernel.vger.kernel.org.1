Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAEF2CA354
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgLANAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:00:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:40444 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgLANAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:00:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606827577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d9FfBclj08BT/a6NAs1kZbmhLZLgpFAdOCX78dQ2gW0=;
        b=ty09/Jx26xpHWxlnAJgkEKa70Q14vMEEtvwf+/Uld7rqK+Y2AhCAuGjrud5ewo5KAmvV3t
        LZaDw2TEfSjpzdZqcPYeJ6UQKC1SVcgzCZAfUVPvAgD3wBwYbNMqRi97necLKukzzY223m
        9AFEEd7uWnU/tTDdCSvfRkNs80nWDoY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 828CDAC55;
        Tue,  1 Dec 2020 12:59:37 +0000 (UTC)
Date:   Tue, 1 Dec 2020 13:59:37 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 0/3] clear_warn_once: add timed interval resetting
Message-ID: <X8Y+OVaXzAO4AWE2@alley>
References: <20201126063029.2030-1-paul.gortmaker@windriver.com>
 <X8ElwBh9tw+OLHF+@alley>
 <20201127174316.GA11748@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127174316.GA11748@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-11-27 12:43:16, Paul Gortmaker wrote:
> > On Thu 2020-11-26 01:30:26, Paul Gortmaker wrote:
> > + Move clear_warn_once from debugfs to a location that is always
> >   available. For example, into /proc
> 
> I don't have a problem with that, other than won't we have to maintain
> both interfaces forever?

Yes, we would. But this patchset adds a new interface as well.
In addition, it adds also new functionality that might create new
scenarios.

Again, I am not strongly against it. But I have to think more
about it.

Best Regards,
Petr

PS: I did not comment other parts of this mail. They were either
discussed elsewhere in this thread. Or I did not have
anything to add.
