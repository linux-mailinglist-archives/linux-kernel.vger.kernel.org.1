Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07FF2348E0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 18:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbgGaQE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 12:04:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbgGaQE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:04:28 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 723E621744;
        Fri, 31 Jul 2020 16:04:27 +0000 (UTC)
Date:   Fri, 31 Jul 2020 12:04:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 3/3] lib/vsprintf: Force type of flags for gfp_t
Message-ID: <20200731120426.6fa1b20d@oasis.local.home>
In-Reply-To: <CAHp75VdSz1ny1pkTMKWMB-Ok_2csoqtaC6zZkCj2aoHew-+NgQ@mail.gmail.com>
References: <20200731123145.22357-1-andriy.shevchenko@linux.intel.com>
        <20200731123145.22357-3-andriy.shevchenko@linux.intel.com>
        <20200731113450.4f31c3e6@oasis.local.home>
        <CAHp75VdSz1ny1pkTMKWMB-Ok_2csoqtaC6zZkCj2aoHew-+NgQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020 18:49:46 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> > > +++ b/lib/vsprintf.c
> > > @@ -1937,7 +1937,7 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
> > >               names = vmaflag_names;
> > >               break;
> > >       case 'g':
> > > -             flags = *(gfp_t *)flags_ptr;
> > > +             flags = (__force typeof(flags))(*(gfp_t *)flags_ptr);  
> >
> > Do we really need to say "typeof(flags)" ? What about simply using
> > flags' type?  
> 
> Whatever you prefer. I actually came with the latter and switched to the former.
> So, I'll switch back for v2.

For this instance, I prefer spelling out the type.

Thanks!

-- Steve
