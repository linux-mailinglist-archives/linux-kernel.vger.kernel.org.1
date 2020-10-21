Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FF32950AF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437760AbgJUQYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437724AbgJUQYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:24:19 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB608C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:24:18 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o26so4099733ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3gOwLOinKxfS8Q7pKCJNt4sF+c6ZgP4dy5YmMvKFVL4=;
        b=qAnN66PpKcpHn9YzLKihJgVOkQ9RiPSnoahXPav8UFjfvTvYdnOJugMx+Fd4ph9kHp
         Oro5Qq1x7si+5H+KJWJevoJW2PHn8HhJAqRLzFSXOSgl79BDmY2AGJXBq0iiIUil78+M
         QysAFxNAXgaq/Mfg5kA/0QDMB4VRDlGFuK1DSc+fErnKb3L0gfZ+4VEFg0V7CyQQ7Myx
         qeo8gGSTenyT+jW3xqn8pKqyQzwMS+8RqvOWuqowUB5/1uULNeDD9IyXJHsQOwlNL0h6
         4SoyROAEGF6wAKzdCiIMKhtkonzXdK+mP6RB+X4yyJd9uj4fp1tIq731Z14sHGErjeC2
         4AlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3gOwLOinKxfS8Q7pKCJNt4sF+c6ZgP4dy5YmMvKFVL4=;
        b=Gum+kbdDZlbDCLsEwrTjBjWpLdsPs35Meri/tC/u1Zm8/dCshY3il7wLvr9/rqloiM
         c9YECUQW8XVaeqSb7r3fAEMbOLxJHRnID2RCGUEbbXN48G3i8BPA6QXZ6GqTB4woUFDK
         Fw1N19E40xBuDxVrVkhxXJjcunqECnuOBUl+uvYtC9MXVv63F0kqMr1xIgylZZvxlEUF
         BQY0NDbZ74jW4POeAjhTygufpivnkpdmmnD5pWvDeOQUJZa8HPKFyD6jkRN7P+JacVui
         eCHDJEf0l4YPOFGOgSW9tAif/Ef/20+l9oenF/JkF072Z4fPp9UuDnBECbyvJlCdkuoK
         9Ixg==
X-Gm-Message-State: AOAM531SfBCu6n5Lx7k23ZcnqaNBVpmDtKWcWNYiAvZMYHxyJu/TOf7U
        Pvwl1aG6ByW9hB9lqr9vEwUQTu8JcIOWhFqSjSrGYQ==
X-Google-Smtp-Source: ABdhPJxdbZlz7qjHcsJyG3VwrTEzzzv1Xnm7a3x75REVedoliNewQfm4hBXe15u3vhqNhzOv2lGigBFvNc+AOMCjKO4=
X-Received: by 2002:a17:906:c20f:: with SMTP id d15mr4164002ejz.341.1603297457480;
 Wed, 21 Oct 2020 09:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201015080254.GA31136@infradead.org> <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
 <CAPcyv4j7a0gq++rL--2W33fL4+S0asYjYkvfBfs+hY+3J=c_GA@mail.gmail.com> <CAMM=eLf+2VYHB6vZVjn_=GA5uXJWKL-d6PuCpHEBPz=_Loe58A@mail.gmail.com>
In-Reply-To: <CAMM=eLf+2VYHB6vZVjn_=GA5uXJWKL-d6PuCpHEBPz=_Loe58A@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 21 Oct 2020 09:24:06 -0700
Message-ID: <CAPcyv4hj2iPmf4YNdJLZqHMh2B10hbkSnk_9BAAACbG_LFKfBQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     "Nabeel Meeramohideen Mohamed (nmeeramohide)" 
        <nmeeramohide@micron.com>, Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Steve Moyer (smoyer)" <smoyer@micron.com>,
        "Greg Becker (gbecker)" <gbecker@micron.com>,
        "Pierre Labat (plabat)" <plabat@micron.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        device-mapper development <dm-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 7:24 AM Mike Snitzer <snitzer@redhat.com> wrote:
>
> Hey Dan,
>
> On Fri, Oct 16, 2020 at 6:38 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Oct 16, 2020 at 2:59 PM Nabeel Meeramohideen Mohamed
> > (nmeeramohide) <nmeeramohide@micron.com> wrote:
> >
> > > (5) Representing an mpool as a /dev/mpool/<mpool-name> device file provides a
> > > convenient mechanism for controlling access to and managing the multiple storage
> > > volumes, and in the future pmem devices, that may comprise an logical mpool.
> >
> > Christoph and I have talked about replacing the pmem driver's
> > dependence on device-mapper for pooling.
>
> Was this discussion done publicly or private?  If public please share
> a pointer to the thread.
>
> I'd really like to understand the problem statement that is leading to
> pursuing a pmem native alternative to existing DM.
>

IIRC it was during the hallway track at a conference. Some of the
concern is the flexibility to carve physical address space but not
attach a block-device in front of it, and allow pmem/dax-capable
filesystems to mount on something other than a block-device.

DM does fit the bill for block-device concatenation and striping, but
there's some pressure to have a level of provisioning beneath that.

The device-dax facility has already started to grow some physical
address space partitioning capabilities this cycle, see 60e93dc097f7
device-dax: add dis-contiguous resource support, and the question
becomes when / if that support needs to extend across regions is DM
the right tool for that?
