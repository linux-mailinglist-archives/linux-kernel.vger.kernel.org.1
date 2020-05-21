Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CA51DC658
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 06:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgEUEkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 00:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgEUEkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 00:40:02 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED286C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 21:40:01 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n24so7285006ejd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 21:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eBtX1BhIv6H5u1g/wTf+6clz1KbfAgNzGVcttWA373A=;
        b=bftlGrpvKHRdXHGqy/T11STSBYEvsL9Nzi8XjA2bsjOrn3/TudxMpKocwcZsOsuTUi
         CqLLTV5gtv+CG+2rVQpfvK/GOBJ0pj8PnU/iNahj1zIvd3pSAi+qkJOFuQfftdHPV0BB
         e9YJ8OrV9UTP0L2AqSnqgx2Af1Vut9xzhhruuEslYbJTI+89Upy5QVT6H6rlETW/ORE5
         g6m4gFKWEvz52Nwqb5EA+PAd7SYmxqPcCn2BkpM1J6ze76jLyQKSpIhQ+/P7evvsqz9J
         nAj6CNysgHeWsOWSJf+XenI0GIGdfoaF4CwfC6WJFhOZBVgzkL08wPcGtH9/1vA2ls8f
         VqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eBtX1BhIv6H5u1g/wTf+6clz1KbfAgNzGVcttWA373A=;
        b=bLRX8DErXRhK4wldxYkVaAXRWUgjK02zBFxkep5yiAjbPjE+5NHEsfHnXw+bLiozLN
         0l6lChsHzDLhNHL1/5NXVKtpq17EZNlNBO11yd31hIIaZ/9MbLmc808QEqpfdk/Vwq/e
         WU8EZC/kFwVpMbcZf3Zw1fT6iR9L4D7C7OPXfKQsWb2oEl8IzFldNq04OtYQ7+/QBghV
         LyTkZsZBZeQ//ysiEFyl/Q6C7mZ5REhoVf9VAPCS2RhFgYD7mLxtzjdE3I4C2x464wha
         vKD+UwO66h/1hFRBR4Ogp5U7CmaC1Q35T4RGYCvBL7nfhMKK+4zjwLfyUA/jeF4VFB22
         JqyQ==
X-Gm-Message-State: AOAM5334x23eSlWZ8/MT2Eh8uUOgG2y7ylI7+yQfRwTRILKw6F2D9atq
        WhP5fftpd5GpPNbFfQ7QIhFjOTKl6wh8qvt83L7KPA==
X-Google-Smtp-Source: ABdhPJy2NESD9tmrr3HTnOZP8LoZsyEivlyXTVc6ZGaMysFZHe9qj/CNd6KGxvOcX+mFudxqATX0a57vQI5RWYSzg58=
X-Received: by 2002:a17:906:379b:: with SMTP id n27mr1890840ejc.432.1590036000594;
 Wed, 20 May 2020 21:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <159002475918.686697.11844615159862491335.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200521022628.GE16070@bombadil.infradead.org> <CAPcyv4jpKo7s-bqM2TN2BS73ssOVfhdNaooziZMs2zULH6xs-g@mail.gmail.com>
In-Reply-To: <CAPcyv4jpKo7s-bqM2TN2BS73ssOVfhdNaooziZMs2zULH6xs-g@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 May 2020 21:39:49 -0700
Message-ID: <CAPcyv4hvCYF7wCtYwAXi-Okpxm-W+W=nRRJkmSHFg0p+Z2p17A@mail.gmail.com>
Subject: Re: [PATCH v3] /dev/mem: Revoke mappings when a driver claims the region
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 9:37 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, May 20, 2020 at 7:26 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, May 20, 2020 at 06:35:25PM -0700, Dan Williams wrote:
> > > +static struct inode *devmem_inode;
> > > +
> > > +#ifdef CONFIG_IO_STRICT_DEVMEM
> > > +void revoke_devmem(struct resource *res)
> > > +{
> > > +     struct inode *inode = READ_ONCE(devmem_inode);
> > > +
> > > +     /*
> > > +      * Check that the initialization has completed. Losing the race
> > > +      * is ok because it means drivers are claiming resources before
> > > +      * the fs_initcall level of init and prevent /dev/mem from
> > > +      * establishing mappings.
> > > +      */
> > > +     smp_rmb();
> > > +     if (!inode)
> > > +             return;
> >
> > But we don't need the smp_rmb() here, right?  READ_ONCE and WRITE_ONCE
> > are a DATA DEPENDENCY barrier (in Documentation/memory-barriers.txt parlance)
> > so the smp_rmb() is superfluous ...
>
> Is it? I did not grok that from Documentation/memory-barriers.txt.
> READ_ONCE and WRITE_ONCE are certainly ordered with respect to each
> other in the same function, but I thought they still depend on
> barriers for smp ordering?
>
> >
> > > +     /*
> > > +      * Use a unified address space to have a single point to manage
> > > +      * revocations when drivers want to take over a /dev/mem mapped
> > > +      * range.
> > > +      */
> > > +     inode->i_mapping = devmem_inode->i_mapping;
> > > +     inode->i_mapping->host = devmem_inode;
> >
> > umm ... devmem_inode->i_mapping->host doesn't already point to devmem_inode?
>
> Not if inode is coming from:
>
>      mknod ./newmem c 1 1
>
> ...that's the problem that a unified inode solves. You can mknod all
> you want, but mapping and mapping->host will point to a common
> instance.
>
> >
> > > +
> > > +     /* publish /dev/mem initialized */
> > > +     smp_wmb();
> > > +     WRITE_ONCE(devmem_inode, inode);
> >
> > As above, unnecessary barrier, I think.
>
> Well, if you're not sure, how sure should I be?

I'm pretty sure they are needed, because I need the prior writes to
initialize the inode to be fenced before the final write to publish
the inode. I don't think WRITE_ONCE() enforces that prior writes have
completed.
