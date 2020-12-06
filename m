Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901862CFFF4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 01:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgLFAd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 19:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgLFAd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 19:33:27 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE43C061A4F
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 16:32:46 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id b73so9794777edf.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 16:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gsJTnuBIKurvy5/BWkf4XzEJ7IPXfR3rghfxKMIdv5A=;
        b=XJKdb70pzE/zlzt49Fah0BHTuoQI/1gp0ANorpuSlhGDe5lvKDxwj1nV++iduDrHZO
         5egN+IeYeOoixDnwHTi+ErwlWJ+Vl+DXaKxjuuG3F/u9C+kgikt9jpCoUPiQQ1mk0GIt
         pBAXWYgQJ1gEgASRAC53JsKxZYF+LILb7PRheMEEHWH1ulEM1oA7Rc1amBxJiy/fw4JZ
         neU2YHasQLwYOvA7dz6DDjUocijcqE5kYh3+tTwKzYMoSu3Q35cXR08a5d22e4q4of7L
         ULTmY6TebcajaaxeAZrLRPeqJTkHVyBHaJyFwu6L6IYSGC272/5HyZK8l8KYXknxFPxa
         8P7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gsJTnuBIKurvy5/BWkf4XzEJ7IPXfR3rghfxKMIdv5A=;
        b=hWtSN14Sy6/JQ0cxipDD9NdCljx5RmINOXC6sDqUqBy5j7yqXavv1Yiqf3sud+P2k9
         GgqB1MslVkEp5XXNyHsjeVl5xB09cLWEuTcUV7hSEpJbdBZ6JVf6eU/zdESqMowxFxOZ
         lyBohSxq4IKRan2XTFwdh9qXaug5h+0bPpaiaQZfjTaikdwEvZb0q7k7PyluJrr0+y1d
         8uS7o1wf6BAXRY9cdZ2swnppIfXyuTcL/WQ6Ya/Ob00AJbR+JUJqmWdCNQtdeJ9Up6vW
         /kz6Yntw8Q2xzMPMROt8ccbK1l9Lo9b9ge5AXWleGB5KVhjXkH/pCajNZ4aYebyOUVcX
         3JXg==
X-Gm-Message-State: AOAM531mpPbzgRY0p03MX1XMq/+TqUv3dHSJxbAhv9uSZAAWeonk2rjV
        0pW7/mkf7rm/r/LcybuRhOiMtiBQEXqomEvRUMcoJA==
X-Google-Smtp-Source: ABdhPJyfTHBvHCXuS7GMkDJKmo6ZL65D889ZDN8Fij1tzRHq9IWIaeeueUQ0KTEr9lBaBh47xr9YPay4K9BanZOMcCg=
X-Received: by 2002:a50:e0ce:: with SMTP id j14mr14231534edl.18.1607214765241;
 Sat, 05 Dec 2020 16:32:45 -0800 (PST)
MIME-Version: 1.0
References: <160695681289.505290.8978295443574440604.stgit@dwillia2-desk3.amr.corp.intel.com>
 <a24b3044-1379-6331-c171-be8d95f21353@gmail.com>
In-Reply-To: <a24b3044-1379-6331-c171-be8d95f21353@gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 5 Dec 2020 16:32:41 -0800
Message-ID: <CAPcyv4iM=_MhhpKKA9ihWAq_c43kKjRwGKzhvKEYHYJ+FiAVJA@mail.gmail.com>
Subject: Re: [resend/standalone PATCH v4] Add auxiliary bus support
To:     David Ahern <dsahern@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kiran Patil <kiran.patil@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Dave Ertman <david.m.ertman@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Parav Pandit <parav@mellanox.com>,
        Martin Habets <mhabets@solarflare.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, alsa-devel@alsa-project.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 5, 2020 at 4:24 PM David Ahern <dsahern@gmail.com> wrote:
>
> On 12/2/20 5:54 PM, Dan Williams wrote:
> > diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> > index 8d7001712062..040be48ce046 100644
> > --- a/drivers/base/Kconfig
> > +++ b/drivers/base/Kconfig
> > @@ -1,6 +1,9 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  menu "Generic Driver Options"
> >
> > +config AUXILIARY_BUS
> > +     bool
> > +
> >  config UEVENT_HELPER
> >       bool "Support for uevent helper"
> >       help
>
> Missing a description and without it does not appear in menuconfig or in
> the config file.
>
> Could use a blurb in the help as well.

It doesn't have a description or help because it is a select-only
symbol, but a comment to that effect and a pointer to the
documentation would help.
