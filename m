Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D9630190D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 01:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbhAXAUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 19:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbhAXAUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 19:20:13 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59948C061786
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 16:19:33 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id j138so4905030vsd.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 16:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gqojlmdONECs4eHvvUDkwp6TSunCOtW2jlVrU1HsYSw=;
        b=WrID38WFY3Kl4vdm5ExYcrwrwKP9kg3pQxlmAwIm9EFWV3Qn18BW8O9957j9rWFvPE
         r1KbVX+ztzxWT6t0auZu702NUKMClae6AslebMZNy7Bu8V0IZ6JyO0Y+CiQwMKlywiGD
         jSnQVY7hW+y1CCyyqc/eGfoFNyt+LLLIFumRK/GPR1GUGbTTcikxcTzDPtVmyqfuSIgf
         Mmu1BV6qWiNGSxBz36U50+Fgg8ZcYV2d0M416vl0gUqBf5jObj/UwedCOQaBsu4ezwF8
         7Onm9TSYPP6BTDBEDZ4Rcsd8zNw1n7liCmuQziaxU3IP3mVNwG7/FqtaIz8nje1TpstQ
         Aakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gqojlmdONECs4eHvvUDkwp6TSunCOtW2jlVrU1HsYSw=;
        b=NY3FyEDQfTTEjkZTu4u3jo9iu5umS61vVQrCk1Nm+S1Dhj3FkNmn+dSovFjnXX9o4j
         fBPCFgN85ttkEwPMQiCofNDxHRLsU4opxRE8u0w6J/9QAdTdjcu0CT4sT8O9qdMKQYiB
         axdop9KZsaiqayVwUZ48XKq9EdhyQqUEBMiM6ZuUAWqtTnC9wOZ2xB191LcoZYBZlxYK
         Z/oz9GZtbmlGz9UztrVf00HAAbpOzVAG63f/URlSgfO8kOgcuIL76D+fPP8wy+jEyugd
         e0TC3yl7uA6lP24D+yCVxQW2sOLSifxDETZoC0qOryfv93nfrRq5zgwHVwJCchaYym06
         R80w==
X-Gm-Message-State: AOAM533NhiJa0JsgGOBDT86kbyoISc10YI0Ab1iAcGKix7cTCrKNnFl1
        6F0qqBwcYa1ppkW64FOC1Ih3WTpCAXGvNrLhRi9XBg==
X-Google-Smtp-Source: ABdhPJxWXbSoeCQXL2gzdTjGYVCoKu+u2qVcYnhT9QGKUtTVhjFyrYf+goC1NWH4UF8UgL96y8oorEcu6KHGohfsvLI=
X-Received: by 2002:a67:e195:: with SMTP id e21mr169364vsl.16.1611447570734;
 Sat, 23 Jan 2021 16:19:30 -0800 (PST)
MIME-Version: 1.0
References: <20210122191306.GA99540@localhost.localdomain> <20210122174325.269ac329@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210123022823.GA100578@localhost.localdomain> <20210122183424.59c716a1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210123024534.GB100578@localhost.localdomain>
In-Reply-To: <20210123024534.GB100578@localhost.localdomain>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Sat, 23 Jan 2021 19:19:13 -0500
Message-ID: <CADVnQy=zzrFf=sF+oMwjm+Pp-VJ-veC93poVp0XUPFKRoiGRUQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: make TCP_USER_TIMEOUT accurate for zero window probes
To:     Enke Chen <enkechen2020@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 9:45 PM Enke Chen <enkechen2020@gmail.com> wrote:
>
> Hi, Jakub:
>
> On Fri, Jan 22, 2021 at 06:34:24PM -0800, Jakub Kicinski wrote:
> > On Fri, 22 Jan 2021 18:28:23 -0800 Enke Chen wrote:
> > > Hi, Jakub:
> > >
> > > In terms of backporting, this patch should go together with:
> > >
> > >     9d9b1ee0b2d1 tcp: fix TCP_USER_TIMEOUT with zero window
> >
> > As in it:
> >
> > Fixes: 9d9b1ee0b2d1 tcp: fix TCP_USER_TIMEOUT with zero window
> >
> > or does it further fix the same issue, so:
> >
> > Fixes: 9721e709fa68 ("tcp: simplify window probe aborting on USER_TIMEOUT")
> >
> > ?
>
> Let me clarify:
>
> 1) 9d9b1ee0b2d1 tcp: fix TCP_USER_TIMEOUT with zero window
>
>    fixes the bug and makes it work.
>
> 2) The current patch makes the TCP_USER_TIMEOUT accurate for 0-window probes.
>    It's independent.

Patch (2) ("tcp: make TCP_USER_TIMEOUT accurate for zero window
probes") is indeed conceptually independent of (1) but its
implementation depends on the icsk_probes_tstamp field defined in (1),
so AFAICT (2) cannot be backported further back than (1).

Patch (1) fixes a bug in 5.1:
    Fixes: 9721e709fa68 ("tcp: simplify window probe aborting on USER_TIMEOUT")

So probably (1) and (2) should be backported as a pair, and only back
as far as 5.1. (That covers 2 LTS kernels, 5.4 and 5.10, so hopefully
that is good enough.)

neal
