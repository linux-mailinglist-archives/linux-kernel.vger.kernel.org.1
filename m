Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3F92A93EF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgKFKSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:18:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:60212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgKFKS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:18:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604657908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i5pd9y1DhAnumDSXsWEX/QIlfmRQSZlMbotmJn1sddU=;
        b=LniMUmampiODWFsOSBnFLULJH+mZcsF1vINqQ7qjxNVunRZLdHu3bcFLVR3fnJqI7Eksuq
        hJ6xUmzV+38j20tWjdYvFceXm3yx/LiVhfCYHquIODnJioTxQ1EJTYSeOqpyNzT03nomJr
        7EhhlugQ265Zy/o6lpq8s8ZswA+3YOM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2DC05AD0B;
        Fri,  6 Nov 2020 10:18:28 +0000 (UTC)
Date:   Fri, 6 Nov 2020 11:18:27 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Robin Holt <robinmholt@gmail.com>,
        Fabian Frederick <fabf@skynet.be>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 2/3] reboot: fix overflow parsing reboot cpu number
Message-ID: <20201106101827.GK1602@alley>
References: <20201103214025.116799-1-mcroce@linux.microsoft.com>
 <20201103214025.116799-3-mcroce@linux.microsoft.com>
 <20201105180900.GH1602@alley>
 <CAFnufp3O5GHPdAuY8tm3jGWfSJXnziinTkiKV5ak7nAYWEnOdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFnufp3O5GHPdAuY8tm3jGWfSJXnziinTkiKV5ak7nAYWEnOdw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-11-05 19:14:27, Matteo Croce wrote:
> On Thu, Nov 5, 2020 at 7:09 PM Petr Mladek <pmladek@suse.com> wrote:
> > > +                     if (reboot_cpu >= num_possible_cpus()) {
> > > +                             pr_err("Ignoring the CPU number in reboot= option. "
> > > +                                    "CPU %d exceeds possible cpu number %d\n",
> >
> > ./scripts/checkpatch.pl used to complain that printk() format parameter should stay
> > on a single line (ignoring 80 char limit). It helps when people are
> > trying to find which code printed a particular message.
> >
> > It is not a big deal here because %d does not allow to search the
> > entire message anyway.
> >
> > I am not sure if Andrew would like to get this fixed. In both cases:
> >
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> >
> 
> Yes, I saw this warning, but to suppress it I had to write a 133 char
> line, much beyond even the new 100 char limit.
> I expect a smart user to just grep the first half of the string, like
> "Ignoring the CPU number in reboot="

I agree with checkpatch in this case. IMHO, the more reliable way to
grep the string is more important than the 80 or 100 chars per-line.

That said, it is not a big deal in this case because of the %d.
It requires to search only part of the string anyway.

I am perfectly fine with keeping it as is.

Best Regards,
Petr
