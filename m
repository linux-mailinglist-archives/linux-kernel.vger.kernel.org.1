Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8A62783F0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgIYJ1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:27:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgIYJ1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:27:40 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37C0F20738;
        Fri, 25 Sep 2020 09:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601026059;
        bh=uKVo2+xjnMrqEkSD18awjmWEkwFPN07/VkgovTxNUx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3KU8LhZrK1BhkLPLTgRXfndVrB2RE7Cq6t4TquevajpNIf8iImULIwz2OGmvhydW
         P7y0Qsay7e42+bMrWjPOM0a8AfdIssaLh9spTFjvCviqZV7DIBLWC/hZuppQ5ds1ag
         vC77lvGkPrZ9NIEnHi9YNWSUmVcHIwYapI5jIuK4=
Date:   Fri, 25 Sep 2020 11:27:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Prasad Sodagudi <psodagud@codeaurora.org>, rostedt@goodmis.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com,
        linux-kernel@vger.kernel.org, tkjos@google.com,
        Mohammed Khajapasha <mkhaja@codeaurora.org>
Subject: Re: [PATCH 2/2] printk: Make the console flush configurable in
 hotplug path
Message-ID: <20200925092754.GA2508526@kroah.com>
References: <1600906112-126722-1-git-send-email-psodagud@codeaurora.org>
 <1600906112-126722-2-git-send-email-psodagud@codeaurora.org>
 <20200924063352.GB592892@kroah.com>
 <87wo0j6nos.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo0j6nos.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 08:21:07PM +0200, Thomas Gleixner wrote:
> On Thu, Sep 24 2020 at 08:33, Greg KH wrote:
> > On Wed, Sep 23, 2020 at 05:08:32PM -0700, Prasad Sodagudi wrote:
> >> +config CONSOLE_FLUSH_ON_HOTPLUG
> >> +	bool "Enable console flush configurable in hot plug code path"
> >> +	depends on HOTPLUG_CPU
> >> +	def_bool n
> >
> > n is the default, no need to list it.
> >
> >> +	help
> >> +	In cpu hot plug path console lock acquire and release causes the
> >> +	console to flush. If console lock is not free hot plug latency
> >> +	increases. So make console flush configurable in hot plug path
> >> +	and default disabled to help in cpu hot plug latencies.
> >
> > Why would you not want this option?
> >
> > Why isn't this just a bugfix?
> 
> Because it's the normal behaviour of console lock and there are
> gazillion other ways to delay stuff in the hotplug path.
> 
> CPU hotplug is not meant to be a high speed operation and if people
> think they need it to be fast then its pretty much guaranteed that they
> want it for the completely wrong reasons.

Odds are, it's the big/little systems that are trying to use cpu hotplug
for this type of thing :(

> This #ifdef tinkering is just digusting especially as it just tackles an
> obvious way how to delay timer migration, but does not address the
> underlying root cause.

Agreed, thanks for putting it better than I did.

greg k-h
