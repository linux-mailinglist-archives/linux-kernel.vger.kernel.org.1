Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1162CCF8F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388021AbgLCGfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387415AbgLCGfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:35:41 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1898C061A4E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 22:34:54 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id d20so1085732lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 22:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xRDUCcIwu0erQpo/U/ANsbevzGeTn/mtR+I6YgKc1r0=;
        b=pdYqNChkGYRW/KPaTM94Vt8EUAiKQ/YPa8o63ijDDxE3QhG9H9pZk9EkJTveN4Jk7n
         jCmuKM6HC2Wd27WS1uZt3al6jeU9endBVESYgaR29zPryU6iCC0LwyMJg4n3ZEvPCESI
         wkl0nqV298cbt5KRuwh7KJ0I6s/lgd3Td8UH5yWbak8q2GvIMART+2t9Dg6DrM7sDwpc
         KNF6ay3busyF4NU2jE3gKZqxKTG5bvn4JqKEaJ9ec0KSGr5cBd9v4xdqLfyS7mU/tWPQ
         lxzln1QDFMfWVPlgxUUvGRhkk4+V0ThOia/deew8Vx3w9w7TwDkAoUMWlYunYtk4u3MG
         2hEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xRDUCcIwu0erQpo/U/ANsbevzGeTn/mtR+I6YgKc1r0=;
        b=X2vnTJOOo/lTIQJkt0ngqDs7h6YCHuy9jTCNQ9NsdPk8/YBVRrtOnH++54YiH+i4Q9
         kDQ1ofZ+EkKDwLV3fibbo+z+kElINUieX8FU7LR8qn6rR//IhD2YZUuS31mXEoR5NqKh
         zuBs1fp4wec8aigrMgBQmlA1eiZE4HMS2TwOnRgJjpVPEVM1JFZvJq4yhw1eF/LOTQHo
         8N+Ogg3Z/U8oIyHLc0sGoV/BogLN3abSjO7Q1WEK4cN9T5wREhWXSSmGgy2f9MiFeZVD
         CF3yJfq3ZM8A1lUgpyeXLInhVGi+rCUWjRvC3FlNZR1JOjv6tfkBt+EczmlEFACZXUyy
         HS1A==
X-Gm-Message-State: AOAM530dzHQgDYb6NCHVcRMXcTKXRcIqhRlMd8BXUjT+5Ug9Pe8g0PDz
        hqopRR8hI1/V4w6f9BzHiu+5UIRD1J47j4wkQ2Q=
X-Google-Smtp-Source: ABdhPJxSl8LKNiEiBffiwJrO9tFHTMd0aSSUjor1zQTCS12dH3cAxX3WOVSx1hi+E0dxw9JMHUTsEu4BfJJejCgZ7Ys=
X-Received: by 2002:a19:ca1c:: with SMTP id a28mr647314lfg.61.1606977293115;
 Wed, 02 Dec 2020 22:34:53 -0800 (PST)
MIME-Version: 1.0
References: <20201202145837.48040-1-foxhlchen@gmail.com> <20201202145837.48040-2-foxhlchen@gmail.com>
 <X8fe0cmu+aq1gi7O@mtj.duckdns.org>
In-Reply-To: <X8fe0cmu+aq1gi7O@mtj.duckdns.org>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Thu, 3 Dec 2020 14:34:41 +0800
Message-ID: <CAC2o3DKbxSU=XKZ3iVffiT5Fe3_6B6Ao-pzffQQ+fbeNqq10BQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernfs: replace the mutex in kernfs_iop_permission
 with a rwlock
To:     Tejun Heo <tj@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your comments.

> On Wed, Dec 02, 2020 at 10:58:36PM +0800, Fox Chen wrote:
> > @@ -121,7 +121,7 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
> >       if (!kn)
> >               return -EINVAL;
> >
> > -     mutex_lock(&kernfs_mutex);
> > +     write_lock(&kn->iattr_rwlock);
> >       error = setattr_prepare(dentry, iattr);
> >       if (error)
> >               goto out;
> > @@ -134,7 +134,7 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
> >       setattr_copy(inode, iattr);
> >
> >  out:
> > -     mutex_unlock(&kernfs_mutex);
> > +     write_unlock(&kn->iattr_rwlock);
> >       return error;
> >  }
>
> This is putting GFP_KERNEL allocation inside a rwlock. Can you please test
> with debug options including LOCKDEP and DEBUG_ATOMIC_SLEEP turned on?
>

Ok, I will try that.

Allocation is protected by the write_lock, only one thread can enter
this at a time. It should give the same protection as a mutex, right??
Or am I missing something here?? Any caveat?

On Thu, Dec 3, 2020 at 2:37 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Wed, Dec 02, 2020 at 10:58:36PM +0800, Fox Chen wrote:
> > diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> > index 89f6a4214a70..545cdb39b34b 100644
> > --- a/include/linux/kernfs.h
> > +++ b/include/linux/kernfs.h
> > @@ -156,6 +156,7 @@ struct kernfs_node {
> >       unsigned short          flags;
> >       umode_t                 mode;
> >       struct kernfs_iattrs    *iattr;
> > +     rwlock_t                iattr_rwlock;
> >  };
>
> Also, while this might not look like much, kernfs_node is very size
> sensitive. There are systems with huge number of these nodes, so I don't
> think putting a per-node lock like this is a good idea. Either we can use a
> shared iattr protecting lock or play some cmpxchg games when allocating and
> setting ->iattr and put the lock there.
>

Initially, I tried to put rwlock in kn->iattr, but
__kernfs_setattr(kn, iattr) needs lock protection and kn->iattr may
not exist before calling __kernfs_setattr. It's a chicken-egg paradox.
:)
It's hard to solve. cmpxchg can help, but who sets kn->iattr first
should be clearly defined.

What about I used a global shared rwlock to protect all kn->iattr.
It's easier to implement and I think we read sysfs more than write to
it, I guess it won't be that slow compared to one kn per lock?


thanks,
fox
