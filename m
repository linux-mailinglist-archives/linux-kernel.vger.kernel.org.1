Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3862FDB19
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 21:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388763AbhATUnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387687AbhATUjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 15:39:15 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5098BC061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 12:38:35 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id dj23so24787145edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 12:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=taqAFeRUQ5Sjt3EdHzAPYZnDjLEK6RrWOo7hBOLa+Sg=;
        b=PxT/MciD/bQOrAoYDG5MJeMscifA2EBpPuvloQWYSjqCrVUuPnBmcDKHzop6AdMa5K
         nlAPDqqhC+S4BW9l7ZucY2SAGu7e8pl9jKiMQwCsS1RVWOuOQ6CSan2sgHp1edWibmqZ
         ciU5hfW2EQWDbCAaRowlAqeuRlEi5NSqhC3fdlD5TdgNmEZZJallLzz78JnldgXc2tuG
         cB6dPye5VJUs6g94AdHr+YaiQDp2ufpn0KeuWNYjxzPCyJygQbmNJe5iDbXOEkTqvyOF
         CPxKm60QcR3iglo//vxuGYP1nStSOk664Jo4ts3xLx8uqbbCNCXlGETXixT0gLv7X6Ig
         gNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=taqAFeRUQ5Sjt3EdHzAPYZnDjLEK6RrWOo7hBOLa+Sg=;
        b=e/2PSAlbngUwGf6vLG8f/1JU/o7zTk9T1WPYUSfBm+fZEYX06kFqfetVr9sKszjUpG
         tkWmPFq4I2p5FzsjfZyg+U1YifGD03z3yRBsl7x9BfDQlhruFVCh17W6AtFJSNEOysp0
         3RscLa7IUyc1JosMzfBDHdguDlq5Q9on5oGZGc1pK6k3bQQPmclKf8uj//QBeYL/X/Nh
         JDPt5xNH2H+xohgEei7Vr7EFlGdh+J1HIblk5DwfInMkzGRZYfSveKq9fLMJO3bvGIhm
         wnuBlZCTMh8IfMlJjFq3CMFtAgXzLyUvD7fSLICWV+98kiZORukmKii2yvFlwfLfpQIl
         zDJA==
X-Gm-Message-State: AOAM532iURxNzdDasxtawMnWSwCYhWtAXRs3r3gRYBmuw6J0IsXHMKSI
        mgGVKzf3YxdoVQ9E2L3JUXl5OO+wKZ0SyWVfYk5c+g==
X-Google-Smtp-Source: ABdhPJyNR+rXufJ4s/zf89FiZMZJimyeH3wrtWsvAnZeKKLnx5i7oNVz0lTe4jR6VcPeG3cgx1wz9KgZyqc+4dSBP98=
X-Received: by 2002:a05:6402:160f:: with SMTP id f15mr8613540edv.348.1611175114060;
 Wed, 20 Jan 2021 12:38:34 -0800 (PST)
MIME-Version: 1.0
References: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161117153776.2853729.6944617921517514510.stgit@dwillia2-desk3.amr.corp.intel.com>
 <809823fb-6eb6-8ce9-c49a-d85b03897fc7@deltatee.com>
In-Reply-To: <809823fb-6eb6-8ce9-c49a-d85b03897fc7@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 Jan 2021 12:38:27 -0800
Message-ID: <CAPcyv4j8nfFT5=0T5U7rpNnD29XpTaAmNU5fkaA1--CrmWfRUw@mail.gmail.com>
Subject: Re: [PATCH 1/3] cdev: Finish the cdev api with queued mode support
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 11:51 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
>
> On 2021-01-20 12:38 p.m., Dan Williams wrote:
> > ...common reference count handling scenarios were addressed, but the
> > shutdown-synchronization problem was only mentioned as something driver
> > developers need to be aware in the following note:
> >
> >     NOTE: This guarantees that associated sysfs callbacks are not running
> >     or runnable, however any cdevs already open will remain and their fops
> >     will still be callable even after this function returns.
> >
> > Remove that responsibility from driver developers with the concept of a
> > 'queued' mode for cdevs.
>
> I find the queued name confusing. What's being queued?

Yeah, as I mentioned to Christoph, a bit too much inspiration from
q_usage_count. Perhaps "managed" makes more sense.

>
> > +static const struct file_operations cdev_queued_fops = {
> > +     .owner = THIS_MODULE,
> > +     .open = cdev_queued_open,
> > +     .unlocked_ioctl = cdev_queued_ioctl,
> > +     .compat_ioctl = compat_ptr_ioctl,
> > +     .llseek = noop_llseek,
> > +};
>
> Why do we only protect these fops? I'd find it a bit confusing to have
> ioctl protected from use after del, but not write/read/etc.

More ops can certainly be added over time, I didn't want to go do the
work to wrap all file_operations before getting consensus on the idea
that the cdev core should provide managed ops at all.

The other question I'm posing with cdev_operations is whether the cdev
core should take away some of the flexibility from end drivers in
favor of adding more type safety. For example, mandate that all ioctls
take a pointer argument not an integer argument? The question of
whether wrapping cdev file_operations around a new cdev_operations is
a good idea can be deferred after finalizing a mechanism for managed
cdev file_operations.
