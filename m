Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5C9287574
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 15:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbgJHNvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 09:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730390AbgJHNvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 09:51:17 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6759AC061755;
        Thu,  8 Oct 2020 06:51:17 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y14so4038509pfp.13;
        Thu, 08 Oct 2020 06:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BGJxnYOQa3Y8yW+6IGpNbRgbyhmWBF9gOjrbgkWUlUk=;
        b=s0Hn6HSyug6MtbYwXDy5MMovwqe7T9d9Oxc7pEcapI4xBlmdc+UfbrurhqvX2p3DVT
         P6gIbc1MYrJz7DRZSBFi0LxVLvzsymFVV4Tubd4tzaNMmMuSz4ZemKlUZY8K0/dwaN1E
         Uomy+N0udyVzRD8Io3JksLlaEKHnZcfmVxgahJRv4gN9qZJH9ephMfNSJkjiQUkqAItL
         mSx/9kf1MWEDFixqITRwW3RP+3qUWZ8Xi+MZDw2QzxerjkKEVooY0Y4DUw/23LmH1WYo
         Yi7b+8fA0/gspO8RL+Y0ZNYLdaHbNbqROd2qOhq0hDYeVfQYI1a94KYs25fGZ2H/0zAX
         1Y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BGJxnYOQa3Y8yW+6IGpNbRgbyhmWBF9gOjrbgkWUlUk=;
        b=avIrzkSw49Yh42c6ECcAlby6b/RugOcrJKzc/vRY7tJfZiuPUX4Ih/AxUbYO03m/Nk
         nR7HCIsbmy4qYjWloGp9ONJUUJSkahhqUiy4iiG8vF2EGjZNkBy0iJyDwDos2n8yArLb
         TH+Zp5y1l2vdngg2I00HcOIbaizoqzE5iFd1IZ/TD8ebEmx63LZ8kaUlZRBeWPh9KmOY
         1gOdnRZWg+rgs7s4Z2hDGOnhXjYB4cQpbQ0Y0CA+Zbb69fYsiQwPuR4eaWhGfr7DpcTg
         gs9gdjz2A5LREZa4r09sn7WR52GU2zFuPFWHE020S81w6JH+s9mlIrYXL85EB/lqztbI
         oVgg==
X-Gm-Message-State: AOAM530Yu5xgD1mi4E5Tpf7Zf01bBrHmYdLk/gOTMrnsTAsfh2BfrNwt
        Wnhc0J2dcBcXgUuTdkK2TbChKas0m4JCXg2Fg6M=
X-Google-Smtp-Source: ABdhPJwoJblbPsnDYvaj+l/dr0UYzgyYoZiqik+faeg+TPsWqAWZUD95BObOBIIJdRqd9nmuAvelvPPj6Cx4kv1vINU=
X-Received: by 2002:a62:5e81:0:b029:152:2f99:d9e3 with SMTP id
 s123-20020a625e810000b02901522f99d9e3mr7364545pfb.7.1602165076874; Thu, 08
 Oct 2020 06:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201005160307.39201-1-luzmaximilian@gmail.com> <a82e3aff-801d-d116-bbf4-91f3981f713b@redhat.com>
In-Reply-To: <a82e3aff-801d-d116-bbf4-91f3981f713b@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 8 Oct 2020 16:52:06 +0300
Message-ID: <CAHp75VeC+5b16+FOJh8PdCbueB13evDjE8g18+-GS3YZeoRd_A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] platform/surface: Create a platform subdirectory
 for Microsoft Surface devices
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Stephen Just <stephenjust@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 8, 2020 at 2:44 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 10/5/20 6:03 PM, Maximilian Luz wrote:
> > As has come up in the discussion around
> >
> >    [RFC PATCH] Add support for Microsoft Surface System Aggregator Module
> >
> > it may make sense to add a Microsoft Surface specific platform
> > subdirectory. Andy has suggested drivers/platform/surface for that.
> > This series follows said suggestion and creates that subdirectory, as
> > well as moves Microsoft Surface related drivers over to it and updates
> > their MAINTAINERS entries (if available) accordingly.
> >
> > This series does not modify any existing driver code, symbols, or help
> > text.
>
> In case you do not know I'm taking over from any as
> drivers/platform/x86 maintainer.
>
> I'm fine with the concept of this series, but who is going to maintain
> this new drivers/platform/surface directory ?
>
> Ah I see that the first patch answers that question and the plan
> is to keep this part of the pdx86 maintainership.
>
> I would prefer for the new dir to have its own
> MAINTAINERS entry if I'm honest, I would like to try and
> split maintainership for the surface stuff as follows:
>
> 1. Who will review (and add their Reviewed-by or ask for improvements
>     or nack) patches to files in this dir?
>
> 2. Who will gather approved patches apply them to a for-next branch
>     and send them out to Linus during the merge Window?
>
> I can pick up 2. but I could really use some help with 1. So I
> was thinking having a separate MAINTAINERS entry for the new
> dir with you (Maximilian) (and me and Mark Gross) listed as
> MAINTAINERS; and then I'm hoping that you can do the review
> of surface related patches. At least those which you have not
> written yourself.

The idea was exactly like you described, i.e. taking 2 while relying
on 1 done by someone more familiar with that. JFYI: for Mellanox we
required Vadim to Rb their code before us.

-- 
With Best Regards,
Andy Shevchenko
