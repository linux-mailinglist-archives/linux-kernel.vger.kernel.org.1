Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDA628EDFA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 09:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbgJOHzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 03:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729842AbgJOHzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 03:55:51 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C57CC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 00:55:50 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id d28so2139358ote.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 00:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKpQn0FDypcCkXIOygWWNsNfWX2lsbxOB8uCbMksAIA=;
        b=HQSl5QWfcvPbV2pGTi/CgSYNE6yrm43VcrDZdZgXfpSEZAPIWhWUaC3Z9+19ZGIOT/
         L1FwUAUuyIWjzwGqR/YpO/MiPOAvkTi9v6qcb2Wcm3bTcyjMzBlJxDT1/tZLBuBLm3mU
         NDzd8Hc1lCeymtif5yx0kEE4DAlngk2j4kC84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKpQn0FDypcCkXIOygWWNsNfWX2lsbxOB8uCbMksAIA=;
        b=ssQqAVTdb0W0EeHHmmz17Qcbfc3qRrnytKylK2T/VEifDCA1K3iXhBqtOkclif049M
         M4Tg6LiQ7hGKNW9gkhs0tn8oOLWB5tr39nfxoEC7TxEZRkJpXPWkk0gsrJYRoCrYUALw
         1bFVxEeZGppcr3IAAfSCwFmFJsmG/IZcUOLnHtFtQRM3ciBG5g9CYsdmJPTvqicHq+cc
         7O38O2c6qEMMRa5OqK4191bc66KSSdfJPtFyafUrYegURwUmJK+WAYG6ZM/vk6C/uzIe
         LuEOVHjoY0kt/Jg9TztoZz7oS27OoPY/kG+SkojofEJ6Y+KOwJlBwOmIVOL34XULNc7S
         n8OQ==
X-Gm-Message-State: AOAM531CQL6Z44dU43DvNODX4HZjOqqZ98q01Y2qjwQUUhTvykmaPzy/
        QQNv5lvwMWHkdIn5pHRy2IrN2qPQAA7p48UDxUj6iw==
X-Google-Smtp-Source: ABdhPJxdSyalRqLRcx8/tcfIkmtSxIfRSiuYpFEh1r0/JAJixM8EE3XAGRAgngn5UADgaJioF6PuXkNghwu1P0DfUPk=
X-Received: by 2002:a05:6830:8b:: with SMTP id a11mr1751471oto.303.1602748549701;
 Thu, 15 Oct 2020 00:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-15-daniel.vetter@ffwll.ch> <20201009123109.GO5177@ziepe.ca>
 <CAKMK7uFpPP-Q0jC0vM7vYPEcg0m4NzTw+Ld=swdTF3BgMX5Qug@mail.gmail.com>
 <20201009143209.GS5177@ziepe.ca> <CAPcyv4j54O8ac6WB3LEeNud2r11V26gA0PRKK9bhyEMF67AXtQ@mail.gmail.com>
 <20201015000939.GD6763@ziepe.ca> <CAKMK7uGu8yWRAGZX-dz-sXHsGufXKm003J5zuQr2AwNMG4+DUw@mail.gmail.com>
In-Reply-To: <CAKMK7uGu8yWRAGZX-dz-sXHsGufXKm003J5zuQr2AwNMG4+DUw@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 15 Oct 2020 09:55:38 +0200
Message-ID: <CAKMK7uHwi8_zurd59aX7ZDst+TGFB3TxyzPiWc8fmVvmomskMw@mail.gmail.com>
Subject: Re: [PATCH v2 14/17] resource: Move devmem revoke code to resource framework
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 9:52 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> On Thu, Oct 15, 2020 at 2:09 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Fri, Oct 09, 2020 at 11:28:54AM -0700, Dan Williams wrote:
> > > On Fri, Oct 9, 2020 at 7:32 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Fri, Oct 09, 2020 at 04:24:45PM +0200, Daniel Vetter wrote:
> > > > > On Fri, Oct 9, 2020 at 2:31 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > > >
> > > > > > On Fri, Oct 09, 2020 at 09:59:31AM +0200, Daniel Vetter wrote:
> > > > > >
> > > > > > > +struct address_space *iomem_get_mapping(void)
> > > > > > > +{
> > > > > > > +     return iomem_inode->i_mapping;
> > > > > >
> > > > > > This should pair an acquire with the release below
> > > > > >
> > > > > > > +     /*
> > > > > > > +      * Publish /dev/mem initialized.
> > > > > > > +      * Pairs with smp_load_acquire() in revoke_iomem().
> > > > > > > +      */
> > > > > > > +     smp_store_release(&iomem_inode, inode);
> > > > > >
> > > > > > However, this seems abnormal, initcalls rarely do this kind of stuff
> > > > > > with global data..
> > > > > >
> > > > > > The kernel crashes if this fs_initcall is raced with
> > > > > > iomem_get_mapping() due to the unconditional dereference, so I think
> > > > > > it can be safely switched to a simple assignment.
> > > > >
> > > > > Ah yes I checked this all, but forgot to correctly annotate the
> > > > > iomem_get_mapping access. For reference, see b34e7e298d7a ("/dev/mem:
> > > > > Add missing memory barriers for devmem_inode").
> > > >
> > > > Oh yikes, so revoke_iomem can run concurrently during early boot,
> > > > tricky.
> > >
> > > It runs early because request_mem_region() can run before fs_initcall.
> > > Rather than add an unnecessary lock just arrange for the revoke to be
> > > skipped before the inode is initialized. The expectation is that any
> > > early resource reservations will block future userspace mapping
> > > attempts.
> >
> > Actually, on this point a simple WRITE_ONCE/READ_ONCE pairing is OK,
> > Paul once explained that the pointer chase on the READ_ONCE side is
> > required to be like an acquire - this is why rcu_dereference is just
> > READ_ONCE
>
> Indeed this changed with the sm_read_barrier_depends() removal a year
> ago. Before that READ_ONCE and rcu_dereference where not actually the
> same. I guess I'll throw a patch on top to switch that over too.

Actually 2019 landed just the clean-up, the read change landed in 2017 already:

commit 76ebbe78f7390aee075a7f3768af197ded1bdfbb
Author: Will Deacon <will@kernel.org>
Date:   Tue Oct 24 11:22:47 2017 +0100

   locking/barriers: Add implicit smp_read_barrier_depends() to READ_ONCE()

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
