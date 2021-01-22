Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9482FFFAB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbhAVKBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbhAVKAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:00:11 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9805C061352
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 01:51:19 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id by1so6808466ejc.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 01:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6SOZ0cafIsQ2pjxZKEsji3NjTpPSIIGuynZ9xZcUToY=;
        b=ztKqHymKyLAIKP1qDj25Z0vFnV8lkexGar1wlQhZ7Rfg8c4jimASSEu3EMx6QNc9xt
         /UvDVuSdpibwYuUfHMvcomb5tGn1OeKvoi71lF5ZwUl6ePE7Mfc57I4uQf5xNJ8tXEEy
         mOyktrWbjdAv6URUuvt7PwLdEnteAaSEkHPyO8vXOhNbrfQHerbzre3VYp/h/evQYlJB
         fouV9L1yJo/0dB4OCITN92tMCAmOB1RGGoybCsptJuKlo3e3nsyMl5diLyQRC9L816BZ
         BD9BAva69CDiC6VvjgBjZ04DmOq03Vlb5IxAl8CNhdH54iD+BlXZAk6UeQKt99ShdIVL
         dbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6SOZ0cafIsQ2pjxZKEsji3NjTpPSIIGuynZ9xZcUToY=;
        b=cLkZ6xTrYwWfIPkjqTI7kIoZRVsbPLPGooz/s9xIbffn8s1fKDXg6CMYMAGPqIZxmp
         SwM06asOHbIh91OlxESdmd2le5a8YL9Ze5ka6ZsIk1lGpbWW/wq3/QjHs/iK7RBNgJUw
         aEXkOGBwY/zaEyuP4XC7MRuVI/wxpCyW0W926I/dJ/pnRwPwVsGNB2hitWKVv0EKinIl
         c15euZD8mYJq9rfP+ULAVwthhT/PsN+UXgQp5L+XaqRbWPOfA7NPuPw7Jb8pXNUg2XG+
         eNkIwzLJAp3qR522lmK11hDoDHyPO7nZOg5xH/EQcGg850hyaHNGy9AoY90Xin5WU1WC
         v3kQ==
X-Gm-Message-State: AOAM530dUsAQQzkZVNBk/wgaMa7NTu2UuiUclp5XzQZEgGXEneD95MPq
        I55JGT0FfPHpUr+1ZTvt646HFhwaNNeVPKBWxE7RPA==
X-Google-Smtp-Source: ABdhPJzEjn5GEPrffd5+4rTlgY2BHDNhZMRsd9H/LHyaUqgXSrIVK7mTGKR12AKLBujzMON638tkxawvFlPiVqhItq8=
X-Received: by 2002:a17:906:4443:: with SMTP id i3mr2288434ejp.133.1611309078552;
 Fri, 22 Jan 2021 01:51:18 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvV5SZ47M-XpABya11okgR7BJQk-3dDuFWzgVmGN3Lurg@mail.gmail.com>
 <20210121185521.GQ2743@paulmck-ThinkPad-P72> <20210121213110.GB23234@willie-the-truck>
 <20210121214314.GW2743@paulmck-ThinkPad-P72>
In-Reply-To: <20210121214314.GW2743@paulmck-ThinkPad-P72>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 22 Jan 2021 15:21:07 +0530
Message-ID: <CA+G9fYvZ5oE2bAkZqTYE87N0ONWoo2Q6VZBXihu4NQ_+C07qgA@mail.gmail.com>
Subject: Re: rcu-torture: Internal error: Oops: 96000006
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Will Deacon <will@kernel.org>, rcu@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021 at 03:13, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Jan 21, 2021 at 09:31:10PM +0000, Will Deacon wrote:
> > On Thu, Jan 21, 2021 at 10:55:21AM -0800, Paul E. McKenney wrote:
> > > On Thu, Jan 21, 2021 at 10:37:21PM +0530, Naresh Kamboju wrote:
> > > > While running rcu-torture test on qemu_arm64 and arm64 Juno-r2 device
> > > > the following kernel crash noticed. This started happening from Linux next
> > > > next-20210111 tag to next-20210121.
> > > >
> > > > metadata:
> > > >   git branch: master
> > > >   git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> > > >   git describe: next-20210111
> > > >   kernel-config: https://builds.tuxbuild.com/1muTTn7AfqcWvH5x2Alxifn7EUH/config
> > > >
> > > > output log:
> > > >
> > > > [  621.538050] mem_dump_obj() slab test: rcu_torture_stats =
> > > > ffff0000c0a3ac40, &rhp = ffff800012debe40, rhp = ffff0000c8cba000, &z
> > > > = ffff8000091ab8e0
> > > > [  621.546662] mem_dump_obj(ZERO_SIZE_PTR):
> > > > [  621.546696] Unable to handle kernel NULL pointer dereference at
> > > > virtual address 0000000000000008
> >
> > [...]
> >
> > > Huh.  I am relying on virt_addr_valid() rejecting NULL pointers and
> > > things like ZERO_SIZE_PTR, which is defined as ((void *)16).  It looks
> > > like your configuration rejects NULL as an invalid virtual address,
> > > but does not reject ZERO_SIZE_PTR.  Is this the intent, given that you
> > > are not allowed to dereference a ZERO_SIZE_PTR?
> > >
> > > Adding the ARM64 guys on CC for their thoughts.
> >
> > Spooky timing, there was a thread _today_ about that:
> >
> > https://lore.kernel.org/r/ecbc7651-82c4-6518-d4a9-dbdbdf833b5b@arm.com
>
> Very good, then my workaround (shown below for Naresh's ease of testing)
> is only a short-term workaround.  Yay!  ;-)

Paul, thanks for your (short-term workaround) patch.

I have applied your patch and tested rcu-torture test on qemu_arm64 and
the reported issues has been fixed.

- Naresh
