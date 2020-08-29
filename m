Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3201B256576
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 08:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgH2Gva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 02:51:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgH2Gva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 02:51:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C91B320E65;
        Sat, 29 Aug 2020 06:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598683889;
        bh=n7VC1uvUjKUVDq2UMbjFErf50gQRUMVporBtRadUTTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ON9S5JchC5JCj3pHo/S/cKsHxfWRHRK6OowmWc+3rALYSI5bmiRnfdqqdQgwvmvUl
         praVjMcgKjnr56LxTsCLcWyVudLJekVct+AWWIR5UWhoW30wgIKNIjayTyt8DlK4HY
         rYoxszfZLUAeLPa52db4qzfy1zz/7XMxCQU4t8gI=
Date:   Sat, 29 Aug 2020 08:51:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysfs: Add sysfs_emit to replace sprintf to PAGE_SIZE
 buffers.
Message-ID: <20200829065125.GA94642@kroah.com>
References: <a96cdf07cd136d06c3cc1e10eb884caa7498ba72.1598654887.git.joe@perches.com>
 <20200829062254.GA79296@kroah.com>
 <2acf2dc0945bc7f1ec2617b616808ab3c514067b.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2acf2dc0945bc7f1ec2617b616808ab3c514067b.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 11:41:00PM -0700, Joe Perches wrote:
> On Sat, 2020-08-29 at 08:22 +0200, Greg Kroah-Hartman wrote:
> > On Fri, Aug 28, 2020 at 03:52:13PM -0700, Joe Perches wrote:
> > > sprintf does not know the PAGE_SIZE maximum of the temporary buffer
> > > used for outputting sysfs content requests and it's possible to
> > > overrun the buffer length.
> > > 
> > > Add a generic sysfs_emit mechanism that knows that the size of the
> > > temporary buffer and ensures that no overrun is done.
> > > 
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > > ---
> > >  fs/sysfs/file.c       | 30 ++++++++++++++++++++++++++++++
> > >  include/linux/sysfs.h |  8 ++++++++
> > >  2 files changed, 38 insertions(+)
> > > 
> > > diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> > > index eb6897ab78e7..06a13bbd7080 100644
> > > --- a/fs/sysfs/file.c
> > > +++ b/fs/sysfs/file.c
> > > @@ -707,3 +707,33 @@ int sysfs_change_owner(struct kobject *kobj, kuid_t kuid, kgid_t kgid)
> > >  	return 0;
> > >  }
> > >  EXPORT_SYMBOL_GPL(sysfs_change_owner);
> > > +
> > > +/**
> > > + *	sysfs_emit - scnprintf equivalent, aware of PAGE_SIZE buffer.
> > > + *	@buf:	start of PAGE_SIZE buffer.
> > > + *	@pos:	current position in buffer
> > > + *              (pos - buf) must always be < PAGE_SIZE
> > 
> > sysfs files are always supposed to be "one value per file", so why would
> > you ever need a 'pos' variable to show the location in the buffer?
> 
> I've done treewide conversions using cocci.
> It's used all over the place.
> Especially in loops with arrays.
> 
> Sometimes the output is single line.
> Sometimes multiple lines.
> 
> Look at the sample conversion of mem_sleep_show I posted earlier.
> 
> #ifdef CONFIG_SUSPEND
>  static ssize_t mem_sleep_show(struct kobject *kobj, struct kobj_attribute *attr,
>                               char *buf)
>  {
> -       char *s = buf;
> +       char *pos = buf;
>         suspend_state_t i;
>  
>         for (i = PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++)
>                 if (mem_sleep_states[i]) {
>                         const char *label = mem_sleep_states[i];
>  
>                         if (mem_sleep_current == i)
> -                               s += sprintf(s, "[%s] ", label);
> +                               pos += sysfs_emit(buf, pos, "[%s] ", label);
>                         else
> -                               s += sprintf(s, "%s ", label);
> +                               pos += sysfs_emit(buf, pos, "%s ", label);
>                 }
>  
>         /* Convert the last space to a newline if needed. */
> -       if (s != buf)
> -               *(s-1) = '\n';
> +       if (pos != buf)
> +               *(pos - 1) = '\n';
>  
> -       return (s - buf);
> +       return pos - buf;
>  }

And again, this is the rare exception, not the rule, please do not make
a generic helper function "easy" to do crazy things like this in sysfs.

Heck, make it explicit, call this function sysfs_emit_pos() and the
non-pos version sysfs_emit().  That way I can easily search for the
"offending" users of the sysfs api.

thanks,

greg k-h
