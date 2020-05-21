Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2621A1DC466
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 03:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgEUBAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 21:00:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbgEUBAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 21:00:31 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1F1720756;
        Thu, 21 May 2020 01:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590022829;
        bh=YOyt1iDZVUUF5ekq+tL2O9qk5txddvwGrHYhkwkU7Xk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mlD0NWP7mOFXhfGd7hLIoNkhNthShxdnvrcRNTfrEhZvUhqLd4P8uDMwUQYOa96TD
         nnCrSNKSIUyMutss4d4RUOgcUKKysOTZ85Do0XbIjZYwnbiPioXc9rL79jOl9NazdK
         QPKlRbrSbSStWW6j40BI+vDAZp+OgHyLGZ3zM4b8=
Date:   Wed, 20 May 2020 18:00:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Chenggang Wang <wangchenggang@vivo.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 2/2] init: Allow multi-line output of kernel command
 line
Message-Id: <20200520180028.8fc1b7890774c6f92a6c2623@linux-foundation.org>
In-Reply-To: <19a8c717f8d9dc76f2b09e6dd19f3fbb71bf29c5.camel@perches.com>
References: <cover.1589916689.git.joe@perches.com>
        <2b3832fed9370f0f8dfd1ea33dddb1d05a36e265.1589916689.git.joe@perches.com>
        <20200520044127.GB938@jagdpanzerIV.localdomain>
        <ae3aff79301c130aa15b3fe0ff801804bb019384.camel@perches.com>
        <20200520121000.GF520@jagdpanzerIV.localdomain>
        <19a8c717f8d9dc76f2b09e6dd19f3fbb71bf29c5.camel@perches.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020 13:36:45 -0700 Joe Perches <joe@perches.com> wrote:

> On Wed, 2020-05-20 at 21:10 +0900, Sergey Senozhatsky wrote:
> > On (20/05/19 21:58), Joe Perches wrote:
> > [..]
> > > >  Maybe we can
> > > > use here something rather random and much shorter instead. E.g.
> > > > 256 chars. Hmm. How 
> > > 
> > > 	min(some_max like 132/256, PRINTK_LOG_LINE_MAX)
> > > 
> > > would work.
> > 
> > An alternative approach would be to do what we do in the
> > print_modules() (the list of modules which can definitely
> > be longer than 1K chars).
> > 
> > We can split command line in a loop - memchr(pos, ' ') - and
> > pr_cont() parts of the command line. pr_cont() has overflow
> > control and it flushes cont buffer before it overflows, so
> > we should not lose anything.
> 
> It doesn't matter much here, but I believe
> there's an 8k max buffer for pr_cont output.
> 
> include/linux/printk.h:#define CONSOLE_EXT_LOG_MAX      8192
> 
> Anyway, no worries, it simplifies the loop if
> done that way.

I'm wondering if we shold add a kernel puts() (putsk()?  yuk) which can
puts() a string of any length.

I'm counting around 150 instances of printk("%s", ...) and pr_foo("%s",
...) which could perhaps be converted, thus saving an argument.
