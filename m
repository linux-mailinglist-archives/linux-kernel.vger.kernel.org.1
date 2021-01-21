Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4806B2FE393
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbhAUHOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbhAUHMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:12:46 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D66CC061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 23:12:00 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id d81so2110405iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 23:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OZsWazF4dYZC98wDHpd0ubD48NULfRdKE5OyG6sJFcU=;
        b=neIL2EfnYVasG+0/pAyXJfR/iIhhTdgEiw4bw+WlLk+JKZmBQET9JcfliErYor0xdm
         U2h17CF63f9tqBFK8870j5tn/MkFtNYlIK7MZ6qhFdJR0nEXMapF+37aoA/gzq03CCtx
         bSkXYk7WnFgvKaVF7/IGRX7CqDAL7dKjX3ou0LUFqTjUp5AJ58ki/NHnI13ezUxHJ7TV
         v+fBJk3DTFb5bDMJZSTn7ULg2b1XaQDJKQUjy0vZYUswE9afhLmcrEAYXPIL6L5/lvLG
         fsZ5RzFX7DBWUz7ad/iKMNg7xLpykzWcoSdah6KYCwMxihPw1gtoVIxxJE6LDbJ8G2J8
         g55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OZsWazF4dYZC98wDHpd0ubD48NULfRdKE5OyG6sJFcU=;
        b=piZc8q3eThHN5FoVBg3SGc0EFZm/cGYLOgEvQc33EpgYyWJN0ZMtGp5OXpxA5TGal4
         SCGUgnFLdvl/iJKdSoABrP2B2RYfGWiSCN+RuJdpE6GIlQGzSC/a9X6+rzYPdbvnw6xg
         D7Mlv/1RXIzvwdtSwkMVw4PGIVfCiDNO1dO5wQQE0BWfNLlLc7NrCO2UHHOG59MkcaVu
         NeDraoH1w/FhK238kNJuATvLiYlJvcBGY+qTpHUczSTe/IVqchjsfOPbvHtz34Po4isw
         rKVKKWUxwhWoOz+wo2Di43L2jwQKndFFd4fEUCpHaQcwTdZjXE8xG6K14Xrl+OTftkQM
         Claw==
X-Gm-Message-State: AOAM531YlWj1XXphihFaxM8m5JG29e9MUqL9GAa4Za4S6kyTlsXXZHI8
        gCDyy3MLp0+qH6F+ehu+XkfzaXvRHPv3oRvMXSI=
X-Google-Smtp-Source: ABdhPJyJKdG0Gx122QH0/Kk/9iNZ6eTm68QHP/ojGwW8Aci3AtTeJvR+gThK8saWcRiqUngbf4Fki7IaErP52K+A2kQ=
X-Received: by 2002:a92:cd81:: with SMTP id r1mr11070047ilb.252.1611213119750;
 Wed, 20 Jan 2021 23:11:59 -0800 (PST)
MIME-Version: 1.0
References: <20210106004850.GA11682@paulmck-ThinkPad-P72> <CAAH8bW95nyx6PEnPiBPoHMLoduvgU9KO7N=K7mhLORkA+zzhDw@mail.gmail.com>
In-Reply-To: <CAAH8bW95nyx6PEnPiBPoHMLoduvgU9KO7N=K7mhLORkA+zzhDw@mail.gmail.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Wed, 20 Jan 2021 23:11:48 -0800
Message-ID: <CAAH8bW8-q-2LaTC5DE0PnUBqs3V_69EAefLvwdZoeFSow8NYZA@mail.gmail.com>
Subject: Re: [PATCH RFC cpumask] Allow "all", "none", and "last" in cpumask strings
To:     paulmck@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        kernel-team@fb.com, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 12:49 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> On Tue, Jan 5, 2021 at 4:48 PM Paul E. McKenney <paulmck@kernel.org> wrot=
e:
> >
> > Hello!
> >
> > This series allows "all", "none", and "last" to be used in cpumask
> > strings.  This allows these strings to be less dependent on the underly=
ing
> > system.  For example, currently a string specifying all but the first
> > CPU must be "1-7" on an eight-CPU system and "1-15" on a 16-CPU system.
> > With this series, the single string "1-last" can be used regardless of =
the
> > number of CPUs (at least assuming that each system has at least one CPU=
).
>
> 'none' may be implemented as an empty string or string with separators on=
ly,
> but I have nothing against explicit 'none'. See other comments inline.
>
> Thanks,
> Yury.
>
> > 1.      Un-inline cpulist_parse for SMP; prepare for ascii helpers,
> >         courtesy of Paul Gortmaker.
> >
> > 2.      Make "all" alias global and not just RCU, courtesy of Paul
> >         Gortmaker.
> >
> > 3.      Add a "none" alias to complement "all", courtesy of Paul
> >         Gortmaker.
> >
> > 4.      Add "last" alias for cpu list specifications, courtesy of Paul
> >         Gortmaker.
> >
> > 5.      Use "all" and "last" in "nohz_full" and "rcu_nocbs".
> >
> >                                                 Thanx, Paul

Hi Paul,

Today I found this series in linux-next despite downsides discovered during
the review. This series introduces absolutely unneeded cap on the number of
cpus in the system (9999), and also adds unsafe and non-optimal code.

In addition to that, I observe this warning on powerpc:
  CC      lib/cpumask.o
lib/cpumask.c: In function =E2=80=98cpulist_parse=E2=80=99:
lib/cpumask.c:222:17: warning: cast from pointer to integer of
different size [-Wpointer-to-int-cast]
  222 |   memblock_free((phys_addr_t)cpulist, len);
      |                 ^

Can you please revert this series unless all the problems will be fixed?

Thanks,
Yury
