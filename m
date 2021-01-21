Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F462FF141
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387809AbhAURAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388287AbhAUQ7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:59:52 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C73C061786
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 08:59:12 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id a8so3480334lfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 08:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsc.edu; s=ucsc-google-2018;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wlC8jXsMe1HIuwZiVJ+3vAtunYXGcJMzh+yYd+DdBME=;
        b=TheRvIxPi3twaM1+OG/+oewoB/tUMjA8hzpYfCPxtI2yKHER/D8+BzqHXNBqbRzmSW
         Up0YyXLqtbFKlowz5YuO/LPUHMqtKlUGVstdI73+vdoMuQckEMlck34fetxGj3DMQJfd
         rQZNHm2vdV+4wNHejgurPIKJ24SUvGor6ZklOU12R4lSXdzN9X4xRrqX+qb+bAbWauwr
         WF/XtBDCgSllLg4DIPcjR6a9lfQE3u0GxQiph6q2HrXUoHWQtRNqnkGrl0xwB+ta9amV
         M3Pp3xLVqgxF0JH552Jz2DALPjF1Cz9PIalIlRCilUSJNsp/rKvH/j+zrAdT/ssRA+Be
         sc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wlC8jXsMe1HIuwZiVJ+3vAtunYXGcJMzh+yYd+DdBME=;
        b=Gztjic6dQKEYucMWpf5RnYQJRQOrfedq/S+o73gWFtfGHy4hqbXA26VyBy+oUZ2w19
         0NhFm8vxWXQU4o0Xr6c2n5rOZcdLupRNXW+zoafp+Nz+4RvpQt3rQNL7o/+yBQ8lrpil
         4nH1LYpsnHqgXFb6dFX2SOn0f1MO0TctdIyu4C1g4xcvigjfuS2ClWH8vhxGMAC93uCu
         ePQujUhEEG+72sMQc4s1okFRehto7Go96Sq5dQQNywIRv6z87pjlhdL4AmbMG9axt1qd
         UIhW6qidTLdgFLRmptsgvFb7KNuO4LvkSY4GcG1BfMyDshgMlKxl/CiaZDjaR+xWU0BI
         mFUA==
X-Gm-Message-State: AOAM531dh6LrmVLtzG24/4TQ2S6k82sbdpRInfDL+E20vQ8LniNzGg+i
        daA9otR+l6O3ySsYZqpLnwQ9QZHbONMLPS12xfEm+w==
X-Google-Smtp-Source: ABdhPJxftuch7sATRvzaCLPmYLdgyQX0HyB1LAh7L3aD8SCIly8XBPIRllhm863QyqbI+lzhvDJsSUaHTIDHdShweDM=
X-Received: by 2002:a05:6512:488:: with SMTP id v8mr46056lfq.457.1611248349473;
 Thu, 21 Jan 2021 08:59:09 -0800 (PST)
MIME-Version: 1.0
References: <20210121072202.120810-1-bianpan2016@163.com> <55045608-01cb-d5af-682b-5a213944e33d@kernel.dk>
 <474055ad-978a-4da5-d7f0-e2dc862b781c@lightnvm.io>
In-Reply-To: <474055ad-978a-4da5-d7f0-e2dc862b781c@lightnvm.io>
From:   Heiner Litz <hlitz@ucsc.edu>
Date:   Thu, 21 Jan 2021 08:58:58 -0800
Message-ID: <CAJbgVnWxmwfmdgk-e290kcMfhUNAjP9uO2k45rx7R=x8jBdJcw@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: fix memory leak when submit fails
To:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Cc:     Jens Axboe <axboe@kernel.dk>, Pan Bian <bianpan2016@163.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think that ZNS supersedes OCSSD. OCSSDs provide much more
flexibility and device control and remain valuable for academia. For
us, PBLK is the most accurate "SSD Emulator" out there that, as
another benefit, enables real-time performance measurements.
That being said, I understand that this may not be a good enough
reason to keep it around, but I wouldn't mind if it stayed for another
while.

On Thu, Jan 21, 2021 at 5:57 AM Matias Bj=C3=B8rling <mb@lightnvm.io> wrote=
:
>
> On 21/01/2021 13.47, Jens Axboe wrote:
> > On 1/21/21 12:22 AM, Pan Bian wrote:
> >> The allocated page is not released if error occurs in
> >> nvm_submit_io_sync_raw(). __free_page() is moved ealier to avoid
> >> possible memory leak issue.
> > Applied, thanks.
> >
> > General question for Matias - is lightnvm maintained anymore at all, or
> > should we remove it? The project seems dead from my pov, and I don't
> > even remember anyone even reviewing fixes from other people.
> >
> Hi Jens,
>
> ZNS has superseded OCSSD/lightnvm. As a result, the hardware and
> software development around OCSSD have also moved on to ZNS. To my
> knowledge, there is not anyone implementing OCSSD1.2/2.0 commercially at
> this point, and what has been deployed in production does not utilize
> the Linux kernel stack.
>
> I do not mind continuing to keep an eye on it, but on the other hand, it
> has served its purpose. It enabled the "Open-Channel SSD architectures"
> of the world to take hold in the market and thereby gained enough
> momentum to be standardized in NVMe as ZNS.
>
> Would you like me to send a PR to remove lightnvm immediately, or should
> we mark it as deprecated for a while before pulling it?
>
> Best, Matias
>
>
