Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365F22FF51B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 20:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbhAUTup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 14:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbhAUTuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:50:17 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010ABC061756
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 11:49:37 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o13so4265013lfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 11:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsc.edu; s=ucsc-google-2018;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z+Z/Wt6rvVADhJswHCD/Dni8asWlloYwHnyximWQy4E=;
        b=peSQ1IOqT8FS1WUCZOwAjIq2KsEjEDMKMoLYCDbRLrh5REIxJJSZ1RlMZVeYAEp7b5
         8O+/wDIGnFotBWeuZe5Q7yLjnM3RWMG8H2XWcHgsfVOnzsTogUDBZIJ5wDk8d8c+bOhM
         KwpvRamNLsjrGUcR0nCXLzD31GLUS8ud0JHnjI2k5aGL0qrG0MghNoKENtEu0SxxojC7
         e/tsyIGmIWRais8Nw4T8OXiqLz2iM7oUcVNbdGQUh8df1wkylYsSNj2la2JidI0IjAs4
         yDeQZKgo8b9+Mc3Lvd0SPVDsD3jg41Ez+LOi3Q+74/1aIhfrPOOHBq6AhpjpB8cCmdtk
         dhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z+Z/Wt6rvVADhJswHCD/Dni8asWlloYwHnyximWQy4E=;
        b=CoZ6YFHoJxC+LQwK6YsK/qGlqT9Cjgwj98Ba2mQ2W7yQAj5VRUXk3bIYw78tJGZAfT
         v3zItTeWwN7g9d/Ul8Ens43rTh93lkSPxrT7cYvZkHebT7svkKPfhcikHp3kyAjALYV9
         p/soAj0ic2UvgvFDooRGpblDWlgUmGkDMB4fRS8VIolT9feDZ/+1eOXXbTxpCSNVKkoq
         wGvgN+pdlOWlFT16OU+sa7CZAif0/EcYvtGMTzMhbu2h+l+eP///GzsjkrFRaIWUwOua
         VlB742XvPJy2XLf2OJPLeSJeLAjm2vZludEHEUuWlOP3QbhvYoiIwobwYZotUtl/hxW+
         kbPw==
X-Gm-Message-State: AOAM531TuWDILJ4Io/ZZxrLCo5BCQh/ozMlCeGTvZPuhh4BlQgW1BvUo
        lZ2EK2HfKKQvF4oMPOBZzrneQXflM910/dvJgKKhUA==
X-Google-Smtp-Source: ABdhPJwAYHU9v6UjcqSueLcHrhvoptrHtkmEXl8gtTcnpEMVPNkoAekanUQXfR796oJxN6utL/21Z57mi2HaH046/CM=
X-Received: by 2002:a19:810c:: with SMTP id c12mr408496lfd.244.1611258575483;
 Thu, 21 Jan 2021 11:49:35 -0800 (PST)
MIME-Version: 1.0
References: <20210121072202.120810-1-bianpan2016@163.com> <55045608-01cb-d5af-682b-5a213944e33d@kernel.dk>
 <474055ad-978a-4da5-d7f0-e2dc862b781c@lightnvm.io> <CAJbgVnWxmwfmdgk-e290kcMfhUNAjP9uO2k45rx7R=x8jBdJcw@mail.gmail.com>
 <59a735f0-9fef-5e6d-f7eb-851e14a2883e@lightnvm.io>
In-Reply-To: <59a735f0-9fef-5e6d-f7eb-851e14a2883e@lightnvm.io>
From:   Heiner Litz <hlitz@ucsc.edu>
Date:   Thu, 21 Jan 2021 11:49:24 -0800
Message-ID: <CAJbgVnW40qrYBdsM6dC5uhDFZJJDc9kwvCWtK24Rg5GWCHpb2g@mail.gmail.com>
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

there are a couple more, but again I would understand if those are
deemed not important enough to keep it.

device emulation of (non-ZNS) SSD block device
die control: yes endurance groups would help but I am not aware of any
vendor supporting it
finer-grained control: 1000's of open blocks vs. a handful of
concurrently open zones
OOB area: helpful for L2P recovery

On Thu, Jan 21, 2021 at 10:25 AM Matias Bj=C3=B8rling <mb@lightnvm.io> wrot=
e:
>
> On 21/01/2021 17.58, Heiner Litz wrote:
> > I don't think that ZNS supersedes OCSSD. OCSSDs provide much more
> > flexibility and device control and remain valuable for academia. For
> > us, PBLK is the most accurate "SSD Emulator" out there that, as
> > another benefit, enables real-time performance measurements.
> > That being said, I understand that this may not be a good enough
> > reason to keep it around, but I wouldn't mind if it stayed for another
> > while.
>
> The key difference between ZNS SSDs, and OCSSDs is that wear-leveling is
> done on the SSD, whereas it is on the host with OCSSD.
>
> While that is interesting in itself, the bulk of the research that is
> based upon OCSSD, is to control which dies are accessed. As that is
> already compatible with NVMe Endurance Groups/NVM Sets, there is really
> no reason to keep OCSSD around to have that flexibility.
>
> If we take it out of the kernel, it would still be maintained in the
> github repository and available for researchers. Given the few changes
> that have happened over the past year, it should be relatively easy to
> rebase for each kernel release for quite a while.
>
> Best, Matias
>
>
>
> >
> > On Thu, Jan 21, 2021 at 5:57 AM Matias Bj=C3=B8rling <mb@lightnvm.io> w=
rote:
> >> On 21/01/2021 13.47, Jens Axboe wrote:
> >>> On 1/21/21 12:22 AM, Pan Bian wrote:
> >>>> The allocated page is not released if error occurs in
> >>>> nvm_submit_io_sync_raw(). __free_page() is moved ealier to avoid
> >>>> possible memory leak issue.
> >>> Applied, thanks.
> >>>
> >>> General question for Matias - is lightnvm maintained anymore at all, =
or
> >>> should we remove it? The project seems dead from my pov, and I don't
> >>> even remember anyone even reviewing fixes from other people.
> >>>
> >> Hi Jens,
> >>
> >> ZNS has superseded OCSSD/lightnvm. As a result, the hardware and
> >> software development around OCSSD have also moved on to ZNS. To my
> >> knowledge, there is not anyone implementing OCSSD1.2/2.0 commercially =
at
> >> this point, and what has been deployed in production does not utilize
> >> the Linux kernel stack.
> >>
> >> I do not mind continuing to keep an eye on it, but on the other hand, =
it
> >> has served its purpose. It enabled the "Open-Channel SSD architectures=
"
> >> of the world to take hold in the market and thereby gained enough
> >> momentum to be standardized in NVMe as ZNS.
> >>
> >> Would you like me to send a PR to remove lightnvm immediately, or shou=
ld
> >> we mark it as deprecated for a while before pulling it?
> >>
> >> Best, Matias
> >>
> >>
>
