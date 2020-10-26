Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDE42992E9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786507AbgJZQuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:50:24 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:32915 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781117AbgJZQtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:49:13 -0400
Received: by mail-vs1-f67.google.com with SMTP id s15so5190428vsm.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 09:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8CJoPZK3FZxkobczGeE8UDqMx1VKja273HxXnYFa678=;
        b=CLMZLzYvyD/VGNT2nyMLT1+WR4CfKTL+shPMh6FbQJUrlYWUg0TAQn3CvDxZtiuxRT
         J4hLpu0OObGKzs1Sx61QZeEB/ylmBFZ94vm/YAF0kNIOyQYwHeXFgnPZSUehK24yv6BM
         EcgEvN25MyDB/i/1+UUf2EVbib7DGA6EoT0C+G4pNRmMdSCegdM7r8SOxN1aIe3w5pxC
         EvzGvROmWSjstEiOwV7A20fdT2g0Ohi6P0nlWa1UMwDCIclmBIvhklrJC3koiEyENX6w
         jObcErL+X09kgadeaFxeoENbVWAOPBO/9JNfMUiOGnRKdOXozcDqMPdfg1Bn4rILJdvU
         alQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8CJoPZK3FZxkobczGeE8UDqMx1VKja273HxXnYFa678=;
        b=g2NAODyT4+ePWLgN+Tz09rB1uOHA8XU5VY0zFsnNYrZHykdtpRfmAkf5zu6asMvwPJ
         De34oiMoDFZ0rzN+zBy5VglJ11dwBJLkZ2F+aPQ/wotFo3tl5JCz7QG+IJKRyLuAahtV
         HbLAQw4/HfKQDI3E6KicNDaaH2bt3G/qaNsyZVLjz0z3EcHWIF4zQ46F+nMlHAwjvLER
         KNBb8NCw3wqY94aaGn1fYG5qOj1okV8YRTLb9mXlucvGVWgvfQQVh3y/YLuU/vCRJ2f1
         0LzKJSTufxYN9oY2BqTppXswZIgeGNqLmV/LxrvZnetieP8TM8SMUvJQv7uRMOGHDDc/
         XkRA==
X-Gm-Message-State: AOAM531lCj9M6Jq4c3Rxqr5ECqrJghTTZVsck+TFSUZ7r/s/pMDovKq7
        jLkQCSOq29O1ie0wAXiqqzpROPwLBPA=
X-Google-Smtp-Source: ABdhPJxR6evGjN+sMoPyHPq173LvROnYdrzjRu0KTPiG0mFWWlGGyqPa5ZucJGFif4YWozw8mkZRoQ==
X-Received: by 2002:a67:c11d:: with SMTP id d29mr18134416vsj.23.1603730951173;
        Mon, 26 Oct 2020 09:49:11 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id g10sm1496565vsi.7.2020.10.26.09.49.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 09:49:10 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id s6so5096166vss.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 09:49:05 -0700 (PDT)
X-Received: by 2002:a05:6102:2f8:: with SMTP id j24mr9482033vsj.13.1603730944917;
 Mon, 26 Oct 2020 09:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201026150913.2485171-1-willemdebruijn.kernel@gmail.com> <20632c6d-fbc6-f857-bee3-872a8500a442@intel.com>
In-Reply-To: <20632c6d-fbc6-f857-bee3-872a8500a442@intel.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 26 Oct 2020 12:48:28 -0400
X-Gmail-Original-Message-ID: <CA+FuTScL9bwxmKKSvPmUaN+Kmo_cwMocHURZt4u9EqjMJ0_kfw@mail.gmail.com>
Message-ID: <CA+FuTScL9bwxmKKSvPmUaN+Kmo_cwMocHURZt4u9EqjMJ0_kfw@mail.gmail.com>
Subject: Re: [PATCH] x86/resctrl: Fix memory leak on kernfs dir removal
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, HPA <hpa@zytor.com>,
        Xiaochen Shen <xiaochen.shen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 12:24 PM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> +Xiaochen
>
> Hi Willem,
>
> As you described in the report you sent directly to us there are indeed
> more issues than the one described here surrounding the kernfs node
> reference counting in resctrl. Xiaochen is actively working on patch(es)
> for all the issues and you could continue working with him ... now
> externally?

Great to hear. I wasn't aware of that. Of course. Externally or
off-list first, whichever you prefer.

For reference, one other issue occurs on mount/umount:

    for i in {1..200000}; do
        mount -t resctrl resctrl /sys/fs/resctrl;
        umount /sys/fs/resctrl;
    done

> On 10/26/2020 8:09 AM, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> >
> > Resctrl takes an extra kernfs ref on directory entries, to access
> > the entry on cleanup in rdtgroup_kn_unlock after removing the entire
> > subtree with kfree_remove.
> >
> > But the path takes an extra ref both on mkdir and on rmdir.
> >
>
> On resource group (control as well as monitoring) creation via a mkdir
> an extra kernfs node reference is obtained to ensure that the rdtgroup
> structure remains accessible for the rdtgroup_kn_unlock() calls where it
> is removed on deletion. This symmetry ties the resource group's lifetime
> with the kernfs node. The extra kernfs node reference count is dropped
> by kernfs_put() in rdtgroup_kn_unlock() as is documented in the comment
> removed by this patch.
>
> As you state there is an extra reference obtained in rmdir, that is
> unnecessary.
>
> > The kernfs_get on mkdir causes a memleak in the unlikely exit with
> > error in the same function, as no extra kernfs_put exists and no extra
> > rdtgroup_kn_unlock occurs.
>
> This is a bug.
>
> >
> > More importantly, essentially the same happens in the normal path, as
> > this simple program demonstrates:
> >
> >      for i in {1..200000}; do
> >        mkdir /sys/fs/resctrl/task1
> >        rmdir /sys/fs/resctrl/task1
> >      done
> >      slabtop
> >
> > When taking an extra ref for the duration of kernfs_remove, it is
> > easiest to reason about when holding this extra ref as short as
> > possible. For that, the refcnt on error reason and free on umount
> > (rmdir_all_sub), remove the first kernfs_get on mkdir, leaving the
> > other on rmdir.
>
> rmdir_all_sub() may be prevented from just removing the resource group
> if there are any waiters. In this case the resource group would be
> removed by rdtgroup_kn_unlock() by the last waiter at which point a
> reference would be dropped. With this patch there would be no reference
> to drop.

Ah, indeed. It would be easier to reason about if rdtgroup_kn_lock_live
takes an extra ref that rdtgroup_kn_unlock releases? But either way.
I had certainly missed that path.

> Indeed, there is another issue where the kfree(rdtgrp) in
> rmdir_all_sub() (the case when there are no waiters) is missing a
> kernfs_put(). Xiaochen is meticulously working through all of this.
>
> >
> > As the caller of rdtgroup_rmdir, kernfs_iop_rmdir, itself takes a
> > reference on the kernfs object, the extra reference is possibly not
> > needed at all.
>
> This is not obvious to me. Are you referring to
> kernfs_iop_rmdir()->kernfs_get_active(kn)? That is a different reference
> (kn->active as opposed to kn->count)?

I thought that would have the same effect of ensuring that kn can
be dereferenced safely throughout rdtgroup_rmdir. But judging from the
WARN_ONCE in kernfs_put the rules on count vs active are not quite that
simple.
